`default_nettype none
//
// FPGA Wrapper for RISC-V Load Processor
// Provides: 1) Power-on reset generation
//           2) LED-based state visualization for debugging
//
module load_wrapper(
    input wire i_clk,
    output reg led_done
);

// Reset generation logic - processor needs proper reset sequence
reg [3:0] reset_counter = 4'h0;  // Initialize to 0 for proper reset
wire rst_n_internal;

// Generate reset for first few cycles after power-up
always @(posedge i_clk) begin
    if (reset_counter < 4'hF) begin
        reset_counter <= reset_counter + 1;
    end
end

// Reset is active (low) for first 15 cycles, then released
assign rst_n_internal = (reset_counter == 4'hF);

// Internal signals to monitor the processor
wire finished_internal;
wire [31:0] result_internal;
wire [2:0] debug_state_internal;
wire processor_led;  // Processor's LED output (unused in wrapper)

// Blink counter for LED timing
reg [25:0] blink_counter = 26'h0;

load load_inst (
    .i_clk(i_clk),
    .i_rst_n(rst_n_internal),
    .finished(finished_internal),
    .result(result_internal),
    .led_done(processor_led),  // Connected but wrapper overrides
    .debug_state(debug_state_internal)
);

// LED state debugging logic (active-low: 0=ON, 1=OFF)
always @(posedge i_clk) begin
    blink_counter <= blink_counter + 1;
    
    // LED patterns to show processor state:
    // S_FETCH_ADDR  (0): Fast blink (bit 20) 
    // S_FETCH_LATCH (1): Medium blink (bit 21)
    // S_EXEC        (2): Slow blink (bit 22)  
    // S_LOAD_LATCH  (3): Very slow blink (bit 23)
    // S_HALT        (4): Show result value
    case (debug_state_internal)
        3'd0: led_done <= ~blink_counter[20];  // FETCH_ADDR - fast blink
        3'd1: led_done <= ~blink_counter[21];  // FETCH_LATCH - medium blink  
        3'd2: led_done <= ~blink_counter[22];  // EXEC - slow blink
        3'd3: led_done <= ~blink_counter[23];  // LOAD_LATCH - very slow blink
        3'd4: begin // HALT - show result based on execution outcome
            if (result_internal == 32'd1337) 
                led_done <= ~blink_counter[23];  // Success: slow blink (~1.4s period) indicates correct execution
            else if (result_internal == 32'd0)
                led_done <= 1'b1;  // Result=0: solid OFF
            else begin
                // Show lower bits of result as blink pattern
                // Use result[3:0] to select blink rate
                case (result_internal[3:0])
                    4'd0: led_done <= 1'b1;                    // 0: OFF
                    4'd1: led_done <= ~blink_counter[15];      // 1: very fast
                    4'd2: led_done <= ~blink_counter[16];      // 2: fast
                    4'd3: led_done <= ~blink_counter[17];      // 3: medium
                    4'd4: led_done <= ~blink_counter[18];      // 4: slow
                    4'd5: led_done <= ~blink_counter[19];      // 5: very slow
                    default: led_done <= blink_counter[15];    // Other: rapid flicker
                endcase
            end
        end
        default: led_done <= 1'b0;  // Unknown state: solid ON
    endcase
end

endmodule