// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VLOAD__SYMS_H_
#define VERILATED_VLOAD__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vload.h"

// INCLUDE MODULE CLASSES
#include "Vload___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES)Vload__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vload* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vload___024root                TOP;

    // CONSTRUCTORS
    Vload__Syms(VerilatedContext* contextp, const char* namep, Vload* modelp);
    ~Vload__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
