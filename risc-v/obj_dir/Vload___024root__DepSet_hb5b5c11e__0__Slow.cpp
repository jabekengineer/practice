// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vload.h for the primary calling header

#include "Vload__pch.h"
#include "Vload___024root.h"

VL_ATTR_COLD void Vload___024root___eval_static(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_static\n"); );
}

VL_ATTR_COLD void Vload___024root___eval_initial__TOP(Vload___024root* vlSelf);

VL_ATTR_COLD void Vload___024root___eval_initial(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_initial\n"); );
    // Body
    Vload___024root___eval_initial__TOP(vlSelf);
    vlSelf->__Vtrigprevexpr___TOP__i_clk__0 = vlSelf->i_clk;
    vlSelf->__Vtrigprevexpr___TOP__i_rst_n__0 = vlSelf->i_rst_n;
}

VL_ATTR_COLD void Vload___024root___eval_initial__TOP(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_initial__TOP\n"); );
    // Init
    IData/*31:0*/ load__DOT__i;
    load__DOT__i = 0;
    // Body
    vlSelf->load__DOT__registers[0U] = 0U;
    vlSelf->load__DOT__memory[0U] = 0x53900f93U;
    vlSelf->load__DOT__memory[1U] = 0x297U;
    vlSelf->load__DOT__memory[2U] = 0xffc28293U;
    vlSelf->load__DOT__memory[3U] = 0x1f2a023U;
    vlSelf->load__DOT__memory[4U] = 0x2a383U;
    vlSelf->load__DOT__memory[5U] = 0x6fU;
    load__DOT__i = 6U;
    while (VL_GTS_III(32, 0x400U, load__DOT__i)) {
        vlSelf->load__DOT__memory[(0x3ffU & load__DOT__i)] = 0U;
        load__DOT__i = ((IData)(1U) + load__DOT__i);
    }
    vlSelf->load__DOT__registers[0U] = 0U;
    vlSelf->load__DOT__registers[1U] = 0U;
    vlSelf->load__DOT__registers[2U] = 0U;
    vlSelf->load__DOT__registers[3U] = 0U;
    vlSelf->load__DOT__registers[4U] = 0U;
    vlSelf->load__DOT__registers[5U] = 0U;
    vlSelf->load__DOT__registers[6U] = 0U;
    vlSelf->load__DOT__registers[7U] = 0U;
    vlSelf->load__DOT__registers[8U] = 0U;
    vlSelf->load__DOT__registers[9U] = 0U;
    vlSelf->load__DOT__registers[0xaU] = 0U;
    vlSelf->load__DOT__registers[0xbU] = 0U;
    vlSelf->load__DOT__registers[0xcU] = 0U;
    vlSelf->load__DOT__registers[0xdU] = 0U;
    vlSelf->load__DOT__registers[0xeU] = 0U;
    vlSelf->load__DOT__registers[0xfU] = 0U;
    vlSelf->load__DOT__registers[0x10U] = 0U;
    vlSelf->load__DOT__registers[0x11U] = 0U;
    vlSelf->load__DOT__registers[0x12U] = 0U;
    vlSelf->load__DOT__registers[0x13U] = 0U;
    vlSelf->load__DOT__registers[0x14U] = 0U;
    vlSelf->load__DOT__registers[0x15U] = 0U;
    vlSelf->load__DOT__registers[0x16U] = 0U;
    vlSelf->load__DOT__registers[0x17U] = 0U;
    vlSelf->load__DOT__registers[0x18U] = 0U;
    vlSelf->load__DOT__registers[0x19U] = 0U;
    vlSelf->load__DOT__registers[0x1aU] = 0U;
    vlSelf->load__DOT__registers[0x1bU] = 0U;
    vlSelf->load__DOT__registers[0x1cU] = 0U;
    vlSelf->load__DOT__registers[0x1dU] = 0U;
    vlSelf->load__DOT__registers[0x1eU] = 0U;
    vlSelf->load__DOT__registers[0x1fU] = 0U;
    load__DOT__i = 0x20U;
    vlSelf->load__DOT__pc = 0U;
    vlSelf->load__DOT__state = 0U;
    vlSelf->finished = 0U;
    vlSelf->result = 0U;
    vlSelf->load__DOT__blink_counter = 0U;
}

VL_ATTR_COLD void Vload___024root___eval_final(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_final\n"); );
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vload___024root___dump_triggers__stl(Vload___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vload___024root___eval_phase__stl(Vload___024root* vlSelf);

VL_ATTR_COLD void Vload___024root___eval_settle(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_settle\n"); );
    // Init
    IData/*31:0*/ __VstlIterCount;
    CData/*0:0*/ __VstlContinue;
    // Body
    __VstlIterCount = 0U;
    vlSelf->__VstlFirstIteration = 1U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        if (VL_UNLIKELY((0x64U < __VstlIterCount))) {
#ifdef VL_DEBUG
            Vload___024root___dump_triggers__stl(vlSelf);
#endif
            VL_FATAL_MT("rtl/load.v", 2, "", "Settle region did not converge.");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
        __VstlContinue = 0U;
        if (Vload___024root___eval_phase__stl(vlSelf)) {
            __VstlContinue = 1U;
        }
        vlSelf->__VstlFirstIteration = 0U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vload___024root___dump_triggers__stl(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ vlSelf->__VstlTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vload___024root___stl_sequent__TOP__0(Vload___024root* vlSelf);

VL_ATTR_COLD void Vload___024root___eval_stl(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_stl\n"); );
    // Body
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        Vload___024root___stl_sequent__TOP__0(vlSelf);
    }
}

VL_ATTR_COLD void Vload___024root___stl_sequent__TOP__0(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___stl_sequent__TOP__0\n"); );
    // Body
    vlSelf->load__DOT__opcode = (0x7fU & vlSelf->load__DOT__instruction);
    vlSelf->load__DOT__funct3 = (7U & (vlSelf->load__DOT__instruction 
                                       >> 0xcU));
    vlSelf->load__DOT__rd = (0x1fU & (vlSelf->load__DOT__instruction 
                                      >> 7U));
    vlSelf->load__DOT__rs1 = (0x1fU & (vlSelf->load__DOT__instruction 
                                       >> 0xfU));
    vlSelf->load__DOT__i_imm = (((- (IData)((vlSelf->load__DOT__instruction 
                                             >> 0x1fU))) 
                                 << 0xcU) | (vlSelf->load__DOT__instruction 
                                             >> 0x14U));
    vlSelf->load__DOT__u_imm = (0xfffff000U & vlSelf->load__DOT__instruction);
    vlSelf->load__DOT__rs2 = (0x1fU & (vlSelf->load__DOT__instruction 
                                       >> 0x14U));
    vlSelf->load__DOT__s_imm = (((- (IData)((vlSelf->load__DOT__instruction 
                                             >> 0x1fU))) 
                                 << 0xcU) | ((0xfe0U 
                                              & (vlSelf->load__DOT__instruction 
                                                 >> 0x14U)) 
                                             | (0x1fU 
                                                & (vlSelf->load__DOT__instruction 
                                                   >> 7U))));
}

VL_ATTR_COLD void Vload___024root___eval_triggers__stl(Vload___024root* vlSelf);

VL_ATTR_COLD bool Vload___024root___eval_phase__stl(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_phase__stl\n"); );
    // Init
    CData/*0:0*/ __VstlExecute;
    // Body
    Vload___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = vlSelf->__VstlTriggered.any();
    if (__VstlExecute) {
        Vload___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vload___024root___dump_triggers__act(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ vlSelf->__VactTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge i_clk)\n");
    }
    if ((2ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 1 is active: @(posedge i_clk or negedge i_rst_n)\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vload___024root___dump_triggers__nba(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ vlSelf->__VnbaTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge i_clk)\n");
    }
    if ((2ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 1 is active: @(posedge i_clk or negedge i_rst_n)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vload___024root___ctor_var_reset(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->i_clk = VL_RAND_RESET_I(1);
    vlSelf->i_rst_n = VL_RAND_RESET_I(1);
    vlSelf->finished = VL_RAND_RESET_I(1);
    vlSelf->result = VL_RAND_RESET_I(32);
    vlSelf->led_done = VL_RAND_RESET_I(1);
    vlSelf->load__DOT__pc = VL_RAND_RESET_I(32);
    for (int __Vi0 = 0; __Vi0 < 32; ++__Vi0) {
        vlSelf->load__DOT__registers[__Vi0] = VL_RAND_RESET_I(32);
    }
    for (int __Vi0 = 0; __Vi0 < 1024; ++__Vi0) {
        vlSelf->load__DOT__memory[__Vi0] = VL_RAND_RESET_I(32);
    }
    vlSelf->load__DOT__state = VL_RAND_RESET_I(3);
    vlSelf->load__DOT__instruction = VL_RAND_RESET_I(32);
    vlSelf->load__DOT__opcode = VL_RAND_RESET_I(7);
    vlSelf->load__DOT__rd = VL_RAND_RESET_I(5);
    vlSelf->load__DOT__funct3 = VL_RAND_RESET_I(3);
    vlSelf->load__DOT__rs1 = VL_RAND_RESET_I(5);
    vlSelf->load__DOT__rs2 = VL_RAND_RESET_I(5);
    vlSelf->load__DOT__i_imm = VL_RAND_RESET_I(32);
    vlSelf->load__DOT__s_imm = VL_RAND_RESET_I(32);
    vlSelf->load__DOT__u_imm = VL_RAND_RESET_I(32);
    vlSelf->load__DOT__blink_counter = VL_RAND_RESET_I(26);
    vlSelf->__Vdly__load__DOT__instruction = VL_RAND_RESET_I(32);
    vlSelf->__Vdly__load__DOT__state = VL_RAND_RESET_I(3);
    vlSelf->__Vdly__load__DOT__pc = VL_RAND_RESET_I(32);
    vlSelf->__Vdlyvset__load__DOT__memory__v0 = 0;
    vlSelf->__Vdlyvset__load__DOT__registers__v0 = 0;
    vlSelf->__Vdlyvset__load__DOT__registers__v1 = 0;
    vlSelf->__Vdlyvset__load__DOT__registers__v2 = 0;
    vlSelf->__Vdlyvset__load__DOT__registers__v3 = 0;
    vlSelf->__Vtrigprevexpr___TOP__i_clk__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__i_rst_n__0 = VL_RAND_RESET_I(1);
}
