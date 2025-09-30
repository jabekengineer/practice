`default_nettype none
module load(
    input wire i_clk,
    input wire i_rst_n,
    output reg finished,
    output reg [31:0] result,
    output reg led_done,
    output wire [2:0] debug_state  // Add state output for debugging
);

(* ram_style = "block" *) reg [31:0] imem [0:1023];  // instruction memory (1K x 32)
(* ram_style = "block" *) reg [31:0] dmem [0:1023];  // data memory (1K x 32)
// IMEM ports
reg [9:0]  imem_addr;     // 1024 words -> 10 bits
reg [31:0] imem_rdata;    // registered read data

// DMEM ports
reg [9:0]  dmem_addr;
reg        dmem_we;
reg [31:0] dmem_wdata;
reg [31:0] dmem_rdata;

reg [31:0] sw_addr;
reg [31:0] lw_addr;

always @(posedge i_clk) begin
  // IMEM read
  imem_rdata <= imem[imem_addr];

  // DMEM write + read
  if (dmem_we) dmem[dmem_addr] <= dmem_wdata;
  dmem_rdata <= dmem[dmem_addr];
end

always @(*) begin
  sw_addr = registers[rs1] + s_imm;
  lw_addr = registers[rs1] + i_imm;
end

reg [31:0] pc; // 32 bit program counter

reg [31:0] instruction;
// decode funct7 for r-types as habit to comply with spec.
wire [6:0] opcode = instruction[6:0]; // identifies instruction class: <opcode>-Type
wire [4:0] rd = instruction[11:7]; // destination register
wire [2:0] funct3 = instruction[14:12]; // identifies instruction within <opcode>-Type
wire [4:0] rs1 = instruction[19:15]; // source register. Base address for S-Type instructions
wire [4:0] rs2 = instruction[24:20];        // For S-type
wire [6:0] funct7 = instruction[31:25];     // For R-type

wire [31:0] i_imm = {{20{instruction[31]}}, instruction[31:20]}; // I-type immediate
wire [31:0] s_imm = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; // S-type immediate
wire [31:0] u_imm = {instruction[31:12], 12'b0}; // U-type upper immediate for lui, auipc

reg [31:0] registers [0:31]; // 32 registers of 32 bits each

reg [2:0] state; // synchronous bram needs a cycle of latency

// Expose state for debugging
assign debug_state = state;
localparam S_FETCH_ADDR  = 3'd0;
localparam S_FETCH_LATCH = 3'd1;
localparam S_EXEC        = 3'd2;
localparam S_LOAD_LATCH  = 3'd3;
localparam S_HALT        = 3'd4;

reg [25:0] blink_counter;
integer i;

initial begin
    $readmemh("load.program.hex", imem); // the hex instructions from disasm qemu

    for ( i = 0; i < 32; i = i + 1) begin
        registers[i] = 32'h0;
    end
    
    // Initialize data memory to zero
    for ( i = 0; i < 1024; i = i + 1) begin
        dmem[i] = 32'h0;
    end

    pc = 32'h0;
    state = S_FETCH_ADDR;
    finished = 1'b0;
    result = 32'h0;
    blink_counter = 26'h0;
end


always @(posedge i_clk) begin
    blink_counter <= blink_counter + 1;
    
    // LED control moved to wrapper - just provide a default
    led_done <= 1'b0;  // Default OFF, wrapper will override
end

always @(posedge i_clk or negedge i_rst_n) begin
    // start with reset
    if (!i_rst_n) begin
        pc <= 32'h0;
        state <= S_FETCH_ADDR;
        finished <= 1'b0;
        result <= 32'h0;
        dmem_we <= 1'b0;
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] <= 32'h0;        
        end
    end else begin
        dmem_we <= 1'b0;
        case (state)
            // fetch stage
            S_FETCH_ADDR: begin
                // load next 32-bit aligned instruction
                imem_addr <= pc[11:2]; // word address >>2
                state <= S_FETCH_LATCH;
                $display("Fetch: PC=0x%08x", pc);
            end
            S_FETCH_LATCH: begin
                instruction <= imem_rdata;
                state <= S_EXEC;
                $display("  Instruction: 0x%08x", imem_rdata);
            end

            S_EXEC: begin
                case (opcode)
                    // i-type instruction class
                    7'b0010011: begin
                        // identify addi instruction, don't write to x0
                        if (funct3 == 3'b000 && rd != 5'h0) begin
                            // add immediate to content of rs1 and store in rd
                            registers[rd] <= registers[rs1] + i_imm;
                            $display("ADDI x%0d, x%0d, %0d -> x%0d = 0x%08x", 
                                rd, rs1, i_imm, rd, registers[rd]);
                        end
                        pc <= pc + 4;
                        state <= S_FETCH_ADDR;
                    end
                    // add upper immediate to pc
                    7'b0010111: begin
                        // don't write to x0
                        if (rd != 5'h0) begin
                            // add upper immediate to pc
                            registers[rd] <= pc + u_imm;
                            $display("AUIPC x%0d, 0x%05x -> x%0d = 0x%08x", 
                                rd, u_imm[31:12], rd, pc + u_imm);
                        end
                        pc <= pc + 4;
                        state <= S_FETCH_ADDR;
                    end
                    // S-Type store word
                    7'b0100011: begin
                        if (funct3 == 3'b010) begin
                            // retrieve memory offset from s_imm and add it to base address in rs1
                            // store value from rs2 into memory at calculated address
                            dmem_addr  <= sw_addr[11:2];
                            dmem_wdata <= registers[rs2];
                            dmem_we    <= 1'b1;  // write happens this clock edge
                            $display("SW x%0d, %0d(x%0d) -> Mem[0x%08x] = 0x%08x", 
                                rs2, $signed(s_imm), rs1, sw_addr, registers[rs2]);
                        end
                        pc <= pc + 4;
                        state <= S_FETCH_ADDR;
                    end
                    // I-type load word
                    7'b0000011: begin
                        if (funct3 == 3'b010 && rd != 5'h0) begin
                            // retrieve memory offset from i_imm and add it to base address in rs1
                            // load value from memory at calculated address into rd
                            dmem_addr <= lw_addr[11:2];
                            state <= S_LOAD_LATCH;
                            $display("LW x%0d, %0d(x%0d) -> starting read from addr 0x%08x", 
                                rd, $signed(i_imm), rs1, lw_addr);
                        end else begin
                            pc <= pc + 4;
                            state <= S_FETCH_ADDR;
                        end
                    end
                    7'b1101111: begin  // J-type: JAL (infinite loop)
                        if (instruction == 32'h0000006f) begin  // jal x0,0
                            finished <= 1'b1;
                            result <= registers[7];  // x7
                            state <= S_HALT;
                            $display("[HALT] Program finished: x7 = %0d, result = %0d", registers[7], registers[7]);
                        end else begin
                            pc <= pc + 4;
                            state <= S_FETCH_ADDR;
                            $display("[JAL] Non-halt JAL instruction, continuing");
                        end
                    end
                    
                    default: begin
                        $display("Unknown opcode: 0x%02x", opcode);
                        pc <= pc + 4;
                        state <= S_FETCH_ADDR;
                    end
                endcase
            end
        S_LOAD_LATCH: begin
            if (rd != 5'h0) begin
            registers[rd] <= dmem_rdata;
            $display("LW -> x%0d = 0x%08x", rd, dmem_rdata);
            end
            pc    <= pc + 4;
            state <= S_FETCH_ADDR;
        end

        S_HALT: begin
            state <= S_HALT; // stay
        end

        default: begin
            state <= S_FETCH_ADDR;
        end
        endcase
    end
    
end

endmodule