// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vload.h for the primary calling header

#include "Vload__pch.h"
#include "Vload___024root.h"

void Vload___024root___eval_act(Vload___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_act\n"); );
}

VL_INLINE_OPT void Vload___024root___nba_sequent__TOP__0(Vload___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___nba_sequent__TOP__0\n"); );
    // Init
    IData/*31:0*/ __Vdly__load__DOT__x31;
    __Vdly__load__DOT__x31 = 0;
    CData/*2:0*/ __Vdly__load__DOT__state;
    __Vdly__load__DOT__state = 0;
    IData/*31:0*/ __Vdlyvval__load__DOT__memory__v0;
    __Vdlyvval__load__DOT__memory__v0 = 0;
    CData/*0:0*/ __Vdlyvset__load__DOT__memory__v0;
    __Vdlyvset__load__DOT__memory__v0 = 0;
    IData/*31:0*/ __Vdly__load__DOT__x7;
    __Vdly__load__DOT__x7 = 0;
    // Body
    __Vdly__load__DOT__x7 = vlSelf->load__DOT__x7;
    __Vdly__load__DOT__state = vlSelf->load__DOT__state;
    __Vdly__load__DOT__x31 = vlSelf->load__DOT__x31;
    __Vdlyvset__load__DOT__memory__v0 = 0U;
    if (vlSelf->rst_n) {
        if (VL_UNLIKELY((0U == (IData)(vlSelf->load__DOT__state)))) {
            VL_WRITEF("Cycle 1: li x31, 1337 -> x31 =        1337\n");
            __Vdly__load__DOT__x31 = 0x539U;
            __Vdly__load__DOT__state = 1U;
        } else if (VL_UNLIKELY((1U == (IData)(vlSelf->load__DOT__state)))) {
            __Vdlyvval__load__DOT__memory__v0 = vlSelf->load__DOT__x31;
            __Vdlyvset__load__DOT__memory__v0 = 1U;
            __Vdly__load__DOT__state = 2U;
            VL_WRITEF("Cycle 2: sw x31, 0(x0) -> memory[0] = %10#\n",
                      32,vlSelf->load__DOT__x31);
        } else if (VL_UNLIKELY((2U == (IData)(vlSelf->load__DOT__state)))) {
            __Vdly__load__DOT__x7 = vlSelf->load__DOT__memory
                [0U];
            __Vdly__load__DOT__state = 3U;
            VL_WRITEF("Cycle 3: lw x7, 0(x0) -> x7 = %10#\n",
                      32,vlSelf->load__DOT__memory[0U]);
        } else if (VL_UNLIKELY((3U == (IData)(vlSelf->load__DOT__state)))) {
            vlSelf->result = vlSelf->load__DOT__x7;
            vlSelf->finished = 1U;
            VL_WRITEF("Load test complete: x7 = %10# (expected 1337)\n",
                      32,vlSelf->load__DOT__x7);
        }
    } else {
        vlSelf->finished = 0U;
        vlSelf->result = 0U;
        __Vdly__load__DOT__x31 = 0U;
        __Vdly__load__DOT__x7 = 0U;
        __Vdly__load__DOT__state = 0U;
    }
    vlSelf->load__DOT__x31 = __Vdly__load__DOT__x31;
    vlSelf->load__DOT__state = __Vdly__load__DOT__state;
    vlSelf->load__DOT__x7 = __Vdly__load__DOT__x7;
    if (__Vdlyvset__load__DOT__memory__v0) {
        vlSelf->load__DOT__memory[0U] = __Vdlyvval__load__DOT__memory__v0;
    }
}

void Vload___024root___eval_nba(Vload___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vload___024root___nba_sequent__TOP__0(vlSelf);
    }
}

void Vload___024root___eval_triggers__act(Vload___024root* vlSelf);

bool Vload___024root___eval_phase__act(Vload___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<1> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vload___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelf->__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
        vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
        Vload___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vload___024root___eval_phase__nba(Vload___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_phase__nba\n"); );
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelf->__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vload___024root___eval_nba(vlSelf);
        vlSelf->__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vload___024root___dump_triggers__nba(Vload___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vload___024root___dump_triggers__act(Vload___024root* vlSelf);
#endif  // VL_DEBUG

void Vload___024root___eval(Vload___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval\n"); );
    // Init
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            Vload___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("rtl/load.v", 1, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                Vload___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("rtl/load.v", 1, "", "Active region did not converge.");
            }
            vlSelf->__VactIterCount = ((IData)(1U) 
                                       + vlSelf->__VactIterCount);
            vlSelf->__VactContinue = 0U;
            if (Vload___024root___eval_phase__act(vlSelf)) {
                vlSelf->__VactContinue = 1U;
            }
        }
        if (Vload___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vload___024root___eval_debug_assertions(Vload___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((vlSelf->rst_n & 0xfeU))) {
        Verilated::overWidthError("rst_n");}
}
#endif  // VL_DEBUG
