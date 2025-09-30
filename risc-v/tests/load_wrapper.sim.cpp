#include <verilated.h>
#include "Vload_wrapper.h"
#include <iostream>
#include <iomanip>

int main(int argc, char **argv)
{
    // Initialize Verilator command line processing
    Verilated::commandArgs(argc, argv);

    // Create the simulation top module
    Vload_wrapper *top = new Vload_wrapper;

    std::cout << "=== RISC-V Load Wrapper Simulation ===" << std::endl;
    std::cout << "Testing the actual FPGA wrapper with LED debugging" << std::endl;
    std::cout << "Expected: LED should show different blink patterns, then slow blink for success" << std::endl;
    std::cout << std::endl;

    top->i_clk = 0; // initial clock state
    top->eval();

    std::cout << "Starting simulation..." << std::endl;

    // Run simulation and monitor LED patterns
    int cycles = 0;
    int led_changes = 0;
    bool last_led = top->led_done;
    int stable_cycles = 0;
    bool reached_halt = false;

    while (cycles < 100000) // Run longer to see bit 16 toggle
    {
        top->i_clk = !top->i_clk;
        top->eval();

        if (top->i_clk) // On rising edge
        {
            cycles++;

            // Check if LED changed
            int current_led = top->led_done;
            if (current_led != last_led)
            {
                led_changes++;
                printf("Cycle %d - LED changed to: %s (change #%d)\n",
                       cycles, current_led ? "OFF" : "ON", led_changes);
                last_led = current_led;
                stable_cycles = 0;
            }
            else
            {
                stable_cycles++;
            }

            // Debug: Print state every 5000 cycles
            if (cycles % 5000 == 0)
            {
                printf("Cycle %d - State: %d, Result: %d, BlinkCtr: 0x%06x, BlinkCtr[16]: %d, LED: %s\n",
                       cycles, top->debug_state_out, top->result_out,
                       top->blink_counter_out & 0xFFFFFF,
                       (top->blink_counter_out >> 16) & 1, current_led ? "OFF" : "ON");
            }

            // Check if we've reached a stable state after initial execution
            if (cycles > 1000 && stable_cycles > 10000 && !reached_halt)
            {
                std::cout << "Cycle " << std::dec << cycles
                          << " - Processor appears to have halted, LED stable at: "
                          << (top->led_done ? "OFF" : "ON") << std::endl;
                reached_halt = true;
                // Continue for more cycles to see if LED starts blinking
            }

            // Report progress every 10k cycles after halt
            if (reached_halt && cycles % 10000 == 0)
            {
                std::cout << "Cycle " << std::dec << cycles
                          << " - LED: " << (top->led_done ? "OFF" : "ON")
                          << " (stable for " << stable_cycles << " cycles)" << std::endl;
            }
        }
    }

    // Check results
    std::cout << std::endl
              << "=== Results ===" << std::endl;
    std::cout << "Simulation completed after " << cycles << " cycles" << std::endl;
    std::cout << "Final LED state: " << (top->led_done ? "OFF" : "ON") << std::endl;
    std::cout << "Total LED changes: " << led_changes << std::endl;

    if (led_changes > 100)
    {
        std::cout << "TEST_RESULT: PASS" << std::endl;
        std::cout << "✅ LED showed activity - processor executed and reached different states!" << std::endl;
    }
    else if (led_changes > 0)
    {
        std::cout << "TEST_RESULT: PARTIAL" << std::endl;
        std::cout << "⚠️ LED showed some activity but may not have completed successfully" << std::endl;
    }
    else
    {
        std::cout << "TEST_RESULT: FAIL" << std::endl;
        std::cout << "❌ LED never changed - processor may be stuck or not executing" << std::endl;
        delete top;
        return 1;
    }

    delete top;
    return 0;
}