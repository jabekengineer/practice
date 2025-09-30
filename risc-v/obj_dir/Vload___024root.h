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
    VL_IN8(i_clk,0,0);
    VL_IN8(i_rst_n,0,0);
    VL_OUT8(finished,0,0);
    VL_OUT8(led_done,0,0);
    VL_OUT8(debug_state,2,0);
    CData/*0:0*/ load__DOT__dmem_we;
    CData/*6:0*/ load__DOT__opcode;
    CData/*4:0*/ load__DOT__rd;
    CData/*2:0*/ load__DOT__funct3;
    CData/*4:0*/ load__DOT__rs1;
    CData/*4:0*/ load__DOT__rs2;
    CData/*2:0*/ load__DOT__state;
    CData/*0:0*/ __Vdlyvset__load__DOT__dmem__v0;
    CData/*2:0*/ __Vdly__load__DOT__state;
    CData/*0:0*/ __Vdlyvset__load__DOT__registers__v0;
    CData/*0:0*/ __Vdlyvset__load__DOT__registers__v1;
    CData/*0:0*/ __Vdlyvset__load__DOT__registers__v2;
    CData/*0:0*/ __Vdlyvset__load__DOT__registers__v3;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__i_clk__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__i_rst_n__0;
    CData/*0:0*/ __VactContinue;
    SData/*9:0*/ load__DOT__imem_addr;
    SData/*9:0*/ load__DOT__dmem_addr;
    SData/*9:0*/ __Vdlyvdim0__load__DOT__dmem__v0;
    SData/*9:0*/ __Vdly__load__DOT__dmem_addr;
    SData/*9:0*/ __Vdly__load__DOT__imem_addr;
    VL_OUT(result,31,0);
    IData/*31:0*/ load__DOT__imem_rdata;
    IData/*31:0*/ load__DOT__dmem_wdata;
    IData/*31:0*/ load__DOT__dmem_rdata;
    IData/*31:0*/ load__DOT__sw_addr;
    IData/*31:0*/ load__DOT__lw_addr;
    IData/*31:0*/ load__DOT__pc;
    IData/*31:0*/ load__DOT__instruction;
    IData/*31:0*/ load__DOT__i_imm;
    IData/*31:0*/ load__DOT__s_imm;
    IData/*31:0*/ load__DOT__u_imm;
    IData/*31:0*/ __Vdlyvval__load__DOT__dmem__v0;
    IData/*31:0*/ __Vdly__load__DOT__pc;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<IData/*31:0*/, 1024> load__DOT__imem;
    VlUnpacked<IData/*31:0*/, 1024> load__DOT__dmem;
    VlUnpacked<IData/*31:0*/, 32> load__DOT__registers;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<2> __VactTriggered;
    VlTriggerVec<2> __VnbaTriggered;

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
