module load (
    input wire clk,
    input wire rst_n,
    output reg finished,
    output reg [31:0] result
);

// Simple memory simulation
reg [31:0] memory [0:255];
reg [31:0] x31, x7;  // Simulate registers
reg [2:0] state;

// Initialize memory to zeros
integer i;
initial begin
    for (i = 0; i < 256; i = i + 1) begin
        memory[i] = 32'h0;
    end
    state = 0;
    finished = 0;
    result = 0;
    x31 = 0;
    x7 = 0;
end

// Simulate the load operation step by step
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        finished <= 0;
        result <= 0;
        x31 <= 0;
        x7 <= 0;
        state <= 0;
    end else begin
        case (state)
            0: begin  // li x31, 1337
                x31 <= 1337;
                state <= 1;
                $display("Cycle 1: li x31, 1337 -> x31 = %d", 1337);
            end
            1: begin  // sw x31, 0(x0)
                memory[0] <= x31;
                state <= 2;
                $display("Cycle 2: sw x31, 0(x0) -> memory[0] = %d", x31);
            end
            2: begin  // lw x7, 0(x0)
                x7 <= memory[0];
                state <= 3;
                $display("Cycle 3: lw x7, 0(x0) -> x7 = %d", memory[0]);
            end
            3: begin  // Complete
                result <= x7;
                finished <= 1;
                $display("Load test complete: x7 = %d (expected 1337)", x7);
            end
        endcase
    end
end

endmodule