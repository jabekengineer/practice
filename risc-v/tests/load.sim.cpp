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

    std::cout << "=== RISC-V Load Operation Simulation ===" << std::endl;
    std::cout << "Testing: li x31,1337; sw x31,0(x0); lw x7,0(x0)" << std::endl;
    std::cout << "Expected result: x7 should contain 1337" << std::endl;
    std::cout << std::endl;

    top->i_rst_n = 0; // active low reset
    top->i_clk = 0;   // initial clock state
    top->eval();

    // drive the clock for a few cycles with reset active to ensure all registers and state elements are properly initialized
    for (int i = 0; i < 4; i++)
    {
        top->i_clk = !top->i_clk;
        top->eval();
    }

    top->i_rst_n = 1; // set reset signal to its inactive state
    std::cout << "Reset complete, starting simulation..." << std::endl;

    // Run simulation
    int cycles = 0;
    while (!top->finished && cycles < 100)
    {
        top->i_clk = !top->i_clk;
        // Evaluate model
        top->eval();

        if (top->i_clk)
        { // Print on rising edge
            cycles++;
            std::cout << "Cycle " << std::dec << cycles << std::endl;
        }
    }

    // Check results
    std::cout << std::endl
              << "=== Results ===" << std::endl;

    if (top->finished)
    {
        std::cout << "Simulation completed in " << cycles << " cycles" << std::endl;
        std::cout << "Final result: " << std::dec << top->result << std::endl;

        if (top->result == 1337)
        {
            std::cout << "TEST_RESULT: PASS" << std::endl;
            std::cout << "✅ Load operation worked correctly!" << std::endl;
            std::cout << "LOADED_VALUE: 1337" << std::endl;
        }
        else
        {
            std::cout << "TEST_RESULT: FAIL" << std::endl;
            std::cout << "❌ Expected 1337, got " << top->result << std::endl;
            delete top;
            return 1;
        }
    }
    else
    {
        std::cout << "SIMULATION_RESULT: TIMEOUT" << std::endl;
        std::cout << "❌ Simulation did not complete" << std::endl;
        delete top;
        return 1;
    }

    delete top;
    return 0;
}