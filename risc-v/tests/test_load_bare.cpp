#include <verilated.h>
#include "Vload.h"
#include <iostream>
#include <iomanip>

int main(int argc, char **argv)
{
    // Initialize Verilator command line processing
    Verilated::commandArgs(argc, argv);

    // Create the simulation top module
    Vload *top = new Vload;

    std::cout << "=== Testing bare load processor ===" << std::endl;

    top->i_rst_n = 0; // active low reset
    top->i_clk = 0;

    // Reset the processor
    for (int i = 0; i < 5; i++)
    {
        top->i_clk = !top->i_clk;
        top->eval();
    }

    // Release reset
    top->i_rst_n = 1;

    int cycles = 0;
    std::cout << "Starting processor execution..." << std::endl;

    // Run for a while and check if it reaches finished state
    while (!top->finished && cycles < 200)
    {
        top->i_clk = !top->i_clk;
        top->eval();

        if (top->i_clk)
        { // On rising edge
            cycles++;
            if (cycles % 20 == 0)
            {
                std::cout << "Cycle " << cycles << ": State=" << (int)top->debug_state;
                if (top->finished)
                {
                    std::cout << ", Result=" << top->result;
                }
                std::cout << std::endl;
            }
        }
    }

    if (top->finished)
    {
        std::cout << "✅ Processor completed successfully!" << std::endl;
        std::cout << "Final result: " << std::dec << top->result << std::endl;

        if (top->result == 1337)
        {
            std::cout << "✅ PASS: Result matches expected value (1337)" << std::endl;
        }
        else
        {
            std::cout << "❌ FAIL: Expected 1337, got " << top->result << std::endl;
        }
    }
    else
    {
        std::cout << "❌ TIMEOUT: Processor didn't complete in " << cycles << " cycles" << std::endl;
        std::cout << "Final state: " << (int)top->debug_state << std::endl;
    }

    delete top;
    return 0;
}