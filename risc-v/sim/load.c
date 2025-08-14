#include "verilated.h"
#include "Vload.h"
#include <iostream>
#include <iomanip>

int main(int argc, char **argv)
{
    Verilated::commandArgs(argc, argv);
    Vload *top = new Vload;

    std::cout << "=== RISC-V Load Operation Simulation ===" << std::endl;
    std::cout << "Testing: li x31,1337; sw x31,0(x0); lw x7,0(x0)" << std::endl;
    std::cout << "Expected result: x7 should contain 1337" << std::endl;
    std::cout << std::endl;

    // Reset sequence
    top->rst_n = 0;
    top->clk = 0;
    top->eval();

    for (int i = 0; i < 4; i++)
    {
        top->clk = !top->clk;
        top->eval();
    }

    top->rst_n = 1;
    std::cout << "Reset complete, starting simulation..." << std::endl;

    // Run simulation
    int cycles = 0;
    while (!top->finished && cycles < 100)
    {
        top->clk = !top->clk;
        top->eval();

        if (top->clk)
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