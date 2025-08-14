// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vload.h for the primary calling header

#include "Vload__pch.h"
#include "Vload___024root.h"

VL_ATTR_COLD void Vload___024root___eval_static(Vload___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_static\n"); );
}

VL_ATTR_COLD void Vload___024root___eval_initial__TOP(Vload___024root* vlSelf);

VL_ATTR_COLD void Vload___024root___eval_initial(Vload___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_initial\n"); );
    // Body
    Vload___024root___eval_initial__TOP(vlSelf);
    vlSelf->__Vtrigprevexpr___TOP__clk__0 = vlSelf->clk;
    vlSelf->__Vtrigprevexpr___TOP__rst_n__0 = vlSelf->rst_n;
}

VL_ATTR_COLD void Vload___024root___eval_initial__TOP(Vload___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_initial__TOP\n"); );
    // Init
    IData/*31:0*/ load__DOT__i;
    load__DOT__i = 0;
    // Body
    load__DOT__i = 0U;
    while (VL_GTS_III(32, 0x100U, load__DOT__i)) {
        vlSelf->load__DOT__memory[(0xffU & load__DOT__i)] = 0U;
        load__DOT__i = ((IData)(1U) + load__DOT__i);
    }
    vlSelf->load__DOT__state = 0U;
    vlSelf->finished = 0U;
    vlSelf->result = 0U;
    vlSelf->load__DOT__x31 = 0U;
    vlSelf->load__DOT__x7 = 0U;
}

VL_ATTR_COLD void Vload___024root___eval_final(Vload___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_final\n"); );
}

VL_ATTR_COLD void Vload___024root___eval_settle(Vload___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_settle\n"); );
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vload___024root___dump_triggers__act(Vload___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VactTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge clk or negedge rst_n)\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vload___024root___dump_triggers__nba(Vload___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge clk or negedge rst_n)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vload___024root___ctor_var_reset(Vload___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->clk = VL_RAND_RESET_I(1);
    vlSelf->rst_n = VL_RAND_RESET_I(1);
    vlSelf->finished = VL_RAND_RESET_I(1);
    vlSelf->result = VL_RAND_RESET_I(32);
    for (int __Vi0 = 0; __Vi0 < 256; ++__Vi0) {
        vlSelf->load__DOT__memory[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->load__DOT__x31 = VL_RAND_RESET_I(32);
    vlSelf->load__DOT__x7 = VL_RAND_RESET_I(32);
    vlSelf->load__DOT__state = VL_RAND_RESET_I(3);
    vlSelf->__Vtrigprevexpr___TOP__clk__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__rst_n__0 = VL_RAND_RESET_I(1);
}
