// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vload.h for the primary calling header

#ifndef VERILATED_VLOAD___024ROOT_H_
#define VERILATED_VLOAD___024ROOT_H_  // guard

#include "verilated.h"


class Vload__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vload___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clk,0,0);
    VL_IN8(rst_n,0,0);
    VL_OUT8(finished,0,0);
    CData/*2:0*/ load__DOT__state;
    CData/*0:0*/ __Vtrigprevexpr___TOP__clk__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__rst_n__0;
    CData/*0:0*/ __VactContinue;
    VL_OUT(result,31,0);
    IData/*31:0*/ load__DOT__x31;
    IData/*31:0*/ load__DOT__x7;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<IData/*31:0*/, 256> load__DOT__memory;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vload__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vload___024root(Vload__Syms* symsp, const char* v__name);
    ~Vload___024root();
    VL_UNCOPYABLE(Vload___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
