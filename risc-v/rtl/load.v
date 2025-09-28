`default_nettype none
module load(
    input wire i_clk,
    input wire i_rst_n,
    output reg finished,
    output reg [31:0] result,
    output led_done
);
reg [31:0] pc; // 32 bit program counter
reg [31:0] registers [0:31]; // 32 registers of 32 bits each
reg [31:0] memory [0:1023]; // 1K words of 32 bits each
reg [2:0] state; // two stage processor pipeline: fetch -> execute
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

reg [25:0] blink_counter;
integer i;

initial begin
    memory[0] = 32'h53900f93;  // addi x31,x0,1337  
    memory[1] = 32'h00000297;  // auipc x5,0x0
    memory[2] = 32'hffc28293;  // addi x5,x5,-4 # 80000000 <__ram_base>
    memory[3] = 32'h01f2a023;  // sw x31,0(x5)
    memory[4] = 32'h0002a383;  // lw x7,0(x5)
    memory[5] = 32'h0000006f;  // jal x0,80000014 <__ram_base+0x14>

    for (i = 6; i < 1024; i = i + 1) begin
        memory[i] = 32'h0;
    end

    for ( i = 0; i < 32; i = i + 1) begin
        registers[i] = 32'h0;
    end

    pc = 32'h0;
    state = 3'h0;
    finished = 1'b0;
    result = 32'h0;
    blink_counter = 26'h0;
end


// LED control logic
always @(posedge i_clk) begin
    blink_counter <= blink_counter + 1;
    
    if (finished) begin
        // Solid ON if result is correct (1337), OFF if wrong
        led_done <= (result == 32'd1337) ? 1'b1 : 1'b0;
    end else begin
        // Fast blink while running (bit 20 gives ~12Hz at 12MHz clock)
        led_done <= blink_counter[20];
    end
end

always @(posedge i_clk or negedge i_rst_n) begin
    // start with reset
    if (!i_rst_n) begin
        pc <= 32'h0;
        state <= 3'h0;
        finished <= 1'b0;
        result <= 32'h0;
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] <= 32'h0;        
        end
    end else begin
            case (state)
                // fetch stage
                3'h0: begin
                    // load next 32-bit aligned instruction
                    instruction <= memory[pc >> 2];
                    // move to execute stage
                    state <= 3'h1;
                    $display("Fetch: PC=0x%08x, Instr=0x%08x", pc, memory[pc >> 2]);
                end

                3'h1: begin
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
                            state <= 3'h0;
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
                            state <= 3'h0;
                        end
                        // S-Type store word
                        7'b0100011: begin
                            if (funct3 == 3'b010) begin
                                // retrieve memory offset from s_imm and add it to base address in rs1
                                // store value from rs2 into memory at calculated address
                                memory[(registers[rs1] + s_imm) >> 2] <= registers[rs2];
                                $display("SW x%0d, %0d(x%0d) -> Mem[0x%08x] = 0x%08x", 
                                   rs2, $signed(s_imm), rs1, registers[rs1] + s_imm, registers[rs2]);
                            end
                            pc <= pc + 4;
                            state <= 3'h0;
                        end
                        // I-type load word
                        7'b0000011: begin
                            if (funct3 == 3'b010 && rd != 5'h0) begin
                                // retrieve memory offset from i_imm and add it to base address in rs1
                                // load value from memory at calculated address into rd
                                registers[rd] <= memory[(registers[rs1] + i_imm) >> 2];
                                $display("LW x%0d, %0d(x%0d) -> x%0d = 0x%08x", 
                                   rd, $signed(i_imm), rs1, rd, memory[(registers[rs1] + i_imm) >> 2]);
                            end
                            pc <= pc + 4;
                            state <= 3'h0;
                        end
                        7'b1101111: begin  // J-type: JAL (infinite loop)
                            if (instruction == 32'h0000006f) begin  // jal x0,0
                                finished <= 1'b1;
                                result <= registers[7];  // x7
                                $display("Program finished: x7 = %0d", registers[7]);
                            end
                            state <= 3'h1;  // Stay in execute state (halt)
                        end
                        
                        default: begin
                            $display("Unknown opcode: 0x%02x", opcode);
                            pc <= pc + 4;
                            state <= 3'h0;
                        end
                    endcase
                end
            default: begin
                $display("Ignored state: 0x%02x", state);
            end
            endcase
    end
    
end

always @(*) begin
    registers[0] = 32'h0;
end

endmodule