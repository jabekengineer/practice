// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vload.h for the primary calling header

#include "Vload__pch.h"
#include "Vload___024root.h"

void Vload___024root___eval_act(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_act\n"); );
}

void Vload___024root___nba_sequent__TOP__0(Vload___024root* vlSelf);
void Vload___024root___nba_sequent__TOP__1(Vload___024root* vlSelf);
void Vload___024root___nba_sequent__TOP__2(Vload___024root* vlSelf);

void Vload___024root___eval_nba(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_nba\n"); );
    // Body
    if ((2ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vload___024root___nba_sequent__TOP__0(vlSelf);
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vload___024root___nba_sequent__TOP__1(vlSelf);
    }
    if ((2ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vload___024root___nba_sequent__TOP__2(vlSelf);
    }
}

VL_INLINE_OPT void Vload___024root___nba_sequent__TOP__0(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___nba_sequent__TOP__0\n"); );
    // Body
    vlSelf->__Vdly__load__DOT__pc = vlSelf->load__DOT__pc;
    vlSelf->__Vdly__load__DOT__state = vlSelf->load__DOT__state;
    vlSelf->__Vdlyvset__load__DOT__memory__v0 = 0U;
    vlSelf->__Vdlyvset__load__DOT__registers__v0 = 0U;
    vlSelf->__Vdlyvset__load__DOT__registers__v1 = 0U;
    vlSelf->__Vdlyvset__load__DOT__registers__v2 = 0U;
    vlSelf->__Vdlyvset__load__DOT__registers__v3 = 0U;
    vlSelf->__Vdly__load__DOT__instruction = vlSelf->load__DOT__instruction;
}

VL_INLINE_OPT void Vload___024root___nba_sequent__TOP__1(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___nba_sequent__TOP__1\n"); );
    // Init
    IData/*25:0*/ __Vdly__load__DOT__blink_counter;
    __Vdly__load__DOT__blink_counter = 0;
    // Body
    __Vdly__load__DOT__blink_counter = vlSelf->load__DOT__blink_counter;
    __Vdly__load__DOT__blink_counter = (0x3ffffffU 
                                        & ((IData)(1U) 
                                           + vlSelf->load__DOT__blink_counter));
    vlSelf->led_done = (1U & ((IData)(vlSelf->finished)
                               ? (0x539U == vlSelf->result)
                               : (vlSelf->load__DOT__blink_counter 
                                  >> 0x14U)));
    vlSelf->load__DOT__blink_counter = __Vdly__load__DOT__blink_counter;
}

VL_INLINE_OPT void Vload___024root___nba_sequent__TOP__2(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___nba_sequent__TOP__2\n"); );
    // Init
    IData/*31:0*/ load__DOT__i;
    load__DOT__i = 0;
    SData/*9:0*/ __Vdlyvdim0__load__DOT__memory__v0;
    __Vdlyvdim0__load__DOT__memory__v0 = 0;
    IData/*31:0*/ __Vdlyvval__load__DOT__memory__v0;
    __Vdlyvval__load__DOT__memory__v0 = 0;
    CData/*4:0*/ __Vdlyvdim0__load__DOT__registers__v0;
    __Vdlyvdim0__load__DOT__registers__v0 = 0;
    IData/*31:0*/ __Vdlyvval__load__DOT__registers__v0;
    __Vdlyvval__load__DOT__registers__v0 = 0;
    CData/*4:0*/ __Vdlyvdim0__load__DOT__registers__v1;
    __Vdlyvdim0__load__DOT__registers__v1 = 0;
    IData/*31:0*/ __Vdlyvval__load__DOT__registers__v1;
    __Vdlyvval__load__DOT__registers__v1 = 0;
    CData/*4:0*/ __Vdlyvdim0__load__DOT__registers__v2;
    __Vdlyvdim0__load__DOT__registers__v2 = 0;
    IData/*31:0*/ __Vdlyvval__load__DOT__registers__v2;
    __Vdlyvval__load__DOT__registers__v2 = 0;
    // Body
    if (vlSelf->i_rst_n) {
        if (VL_UNLIKELY((0U == (IData)(vlSelf->load__DOT__state)))) {
            VL_WRITEF_NX("Fetch: PC=0x%08x, Instr=0x%08x\n",0,
                         32,vlSelf->load__DOT__pc,32,
                         vlSelf->load__DOT__memory[
                         (0x3ffU & (vlSelf->load__DOT__pc 
                                    >> 2U))]);
            vlSelf->__Vdly__load__DOT__instruction 
                = vlSelf->load__DOT__memory[(0x3ffU 
                                             & (vlSelf->load__DOT__pc 
                                                >> 2U))];
            vlSelf->__Vdly__load__DOT__state = 1U;
        } else if (VL_LIKELY((1U == (IData)(vlSelf->load__DOT__state)))) {
            if ((0x40U & (IData)(vlSelf->load__DOT__opcode))) {
                if (VL_LIKELY((0x20U & (IData)(vlSelf->load__DOT__opcode)))) {
                    if (VL_UNLIKELY((0x10U & (IData)(vlSelf->load__DOT__opcode)))) {
                        VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                                     7,vlSelf->load__DOT__opcode);
                        vlSelf->__Vdly__load__DOT__pc 
                            = ((IData)(4U) + vlSelf->load__DOT__pc);
                        vlSelf->__Vdly__load__DOT__state = 0U;
                    } else if (VL_LIKELY((8U & (IData)(vlSelf->load__DOT__opcode)))) {
                        if (VL_LIKELY((4U & (IData)(vlSelf->load__DOT__opcode)))) {
                            if (VL_LIKELY((2U & (IData)(vlSelf->load__DOT__opcode)))) {
                                if (VL_LIKELY((1U & (IData)(vlSelf->load__DOT__opcode)))) {
                                    if (VL_UNLIKELY(
                                                    (0x6fU 
                                                     == vlSelf->load__DOT__instruction))) {
                                        VL_WRITEF_NX("Program finished: x7 = %0#\n",0,
                                                     32,
                                                     vlSelf->load__DOT__registers
                                                     [7U]);
                                        vlSelf->finished = 1U;
                                        vlSelf->result 
                                            = vlSelf->load__DOT__registers
                                            [7U];
                                    }
                                    vlSelf->__Vdly__load__DOT__state = 1U;
                                } else {
                                    VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                                                 7,
                                                 vlSelf->load__DOT__opcode);
                                    vlSelf->__Vdly__load__DOT__pc 
                                        = ((IData)(4U) 
                                           + vlSelf->load__DOT__pc);
                                    vlSelf->__Vdly__load__DOT__state = 0U;
                                }
                            } else {
                                VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                                             7,vlSelf->load__DOT__opcode);
                                vlSelf->__Vdly__load__DOT__pc 
                                    = ((IData)(4U) 
                                       + vlSelf->load__DOT__pc);
                                vlSelf->__Vdly__load__DOT__state = 0U;
                            }
                        } else {
                            VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                                         7,vlSelf->load__DOT__opcode);
                            vlSelf->__Vdly__load__DOT__pc 
                                = ((IData)(4U) + vlSelf->load__DOT__pc);
                            vlSelf->__Vdly__load__DOT__state = 0U;
                        }
                    } else {
                        VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                                     7,vlSelf->load__DOT__opcode);
                        vlSelf->__Vdly__load__DOT__pc 
                            = ((IData)(4U) + vlSelf->load__DOT__pc);
                        vlSelf->__Vdly__load__DOT__state = 0U;
                    }
                } else {
                    VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                                 7,vlSelf->load__DOT__opcode);
                    vlSelf->__Vdly__load__DOT__pc = 
                        ((IData)(4U) + vlSelf->load__DOT__pc);
                    vlSelf->__Vdly__load__DOT__state = 0U;
                }
            } else if ((0x20U & (IData)(vlSelf->load__DOT__opcode))) {
                if (VL_UNLIKELY((0x10U & (IData)(vlSelf->load__DOT__opcode)))) {
                    VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                                 7,vlSelf->load__DOT__opcode);
                    vlSelf->__Vdly__load__DOT__pc = 
                        ((IData)(4U) + vlSelf->load__DOT__pc);
                    vlSelf->__Vdly__load__DOT__state = 0U;
                } else if (VL_UNLIKELY((8U & (IData)(vlSelf->load__DOT__opcode)))) {
                    VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                                 7,vlSelf->load__DOT__opcode);
                    vlSelf->__Vdly__load__DOT__pc = 
                        ((IData)(4U) + vlSelf->load__DOT__pc);
                    vlSelf->__Vdly__load__DOT__state = 0U;
                } else if (VL_UNLIKELY((4U & (IData)(vlSelf->load__DOT__opcode)))) {
                    VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                                 7,vlSelf->load__DOT__opcode);
                    vlSelf->__Vdly__load__DOT__pc = 
                        ((IData)(4U) + vlSelf->load__DOT__pc);
                    vlSelf->__Vdly__load__DOT__state = 0U;
                } else if (VL_LIKELY((2U & (IData)(vlSelf->load__DOT__opcode)))) {
                    if (VL_LIKELY((1U & (IData)(vlSelf->load__DOT__opcode)))) {
                        vlSelf->__Vdly__load__DOT__pc 
                            = ((IData)(4U) + vlSelf->load__DOT__pc);
                        if (VL_UNLIKELY((2U == (IData)(vlSelf->load__DOT__funct3)))) {
                            VL_WRITEF_NX("SW x%0#, %0d(x%0#) -> Mem[0x%08x] = 0x%08x\n",0,
                                         5,vlSelf->load__DOT__rs2,
                                         32,vlSelf->load__DOT__s_imm,
                                         5,(IData)(vlSelf->load__DOT__rs1),
                                         32,(vlSelf->load__DOT__registers
                                             [vlSelf->load__DOT__rs1] 
                                             + vlSelf->load__DOT__s_imm),
                                         32,vlSelf->load__DOT__registers
                                         [vlSelf->load__DOT__rs2]);
                            __Vdlyvval__load__DOT__memory__v0 
                                = vlSelf->load__DOT__registers
                                [vlSelf->load__DOT__rs2];
                            vlSelf->__Vdlyvset__load__DOT__memory__v0 = 1U;
                            __Vdlyvdim0__load__DOT__memory__v0 
                                = (0x3ffU & ((vlSelf->load__DOT__registers
                                              [vlSelf->load__DOT__rs1] 
                                              + vlSelf->load__DOT__s_imm) 
                                             >> 2U));
                        }
                        vlSelf->__Vdly__load__DOT__state = 0U;
                    } else {
                        VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                                     7,vlSelf->load__DOT__opcode);
                        vlSelf->__Vdly__load__DOT__pc 
                            = ((IData)(4U) + vlSelf->load__DOT__pc);
                        vlSelf->__Vdly__load__DOT__state = 0U;
                    }
                } else {
                    VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                                 7,vlSelf->load__DOT__opcode);
                    vlSelf->__Vdly__load__DOT__pc = 
                        ((IData)(4U) + vlSelf->load__DOT__pc);
                    vlSelf->__Vdly__load__DOT__state = 0U;
                }
            } else if ((0x10U & (IData)(vlSelf->load__DOT__opcode))) {
                if (VL_UNLIKELY((8U & (IData)(vlSelf->load__DOT__opcode)))) {
                    VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                                 7,vlSelf->load__DOT__opcode);
                    vlSelf->__Vdly__load__DOT__pc = 
                        ((IData)(4U) + vlSelf->load__DOT__pc);
                    vlSelf->__Vdly__load__DOT__state = 0U;
                } else if ((4U & (IData)(vlSelf->load__DOT__opcode))) {
                    if (VL_LIKELY((2U & (IData)(vlSelf->load__DOT__opcode)))) {
                        if (VL_LIKELY((1U & (IData)(vlSelf->load__DOT__opcode)))) {
                            if (VL_UNLIKELY((0U != (IData)(vlSelf->load__DOT__rd)))) {
                                __Vdlyvval__load__DOT__registers__v0 
                                    = (vlSelf->load__DOT__pc 
                                       + vlSelf->load__DOT__u_imm);
                                vlSelf->__Vdlyvset__load__DOT__registers__v0 = 1U;
                                __Vdlyvdim0__load__DOT__registers__v0 
                                    = vlSelf->load__DOT__rd;
                                VL_WRITEF_NX("AUIPC x%0#, 0x%05x -> x%0# = 0x%08x\n",0,
                                             5,vlSelf->load__DOT__rd,
                                             20,(vlSelf->load__DOT__u_imm 
                                                 >> 0xcU),
                                             5,(IData)(vlSelf->load__DOT__rd),
                                             32,(vlSelf->load__DOT__pc 
                                                 + vlSelf->load__DOT__u_imm));
                            }
                            vlSelf->__Vdly__load__DOT__state = 0U;
                            vlSelf->__Vdly__load__DOT__pc 
                                = ((IData)(4U) + vlSelf->load__DOT__pc);
                        } else {
                            VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                                         7,vlSelf->load__DOT__opcode);
                            vlSelf->__Vdly__load__DOT__pc 
                                = ((IData)(4U) + vlSelf->load__DOT__pc);
                            vlSelf->__Vdly__load__DOT__state = 0U;
                        }
                    } else {
                        VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                                     7,vlSelf->load__DOT__opcode);
                        vlSelf->__Vdly__load__DOT__pc 
                            = ((IData)(4U) + vlSelf->load__DOT__pc);
                        vlSelf->__Vdly__load__DOT__state = 0U;
                    }
                } else if (VL_LIKELY((2U & (IData)(vlSelf->load__DOT__opcode)))) {
                    if (VL_LIKELY((1U & (IData)(vlSelf->load__DOT__opcode)))) {
                        if (VL_UNLIKELY(((0U == (IData)(vlSelf->load__DOT__funct3)) 
                                         & (0U != (IData)(vlSelf->load__DOT__rd))))) {
                            __Vdlyvval__load__DOT__registers__v1 
                                = (vlSelf->load__DOT__registers
                                   [vlSelf->load__DOT__rs1] 
                                   + vlSelf->load__DOT__i_imm);
                            vlSelf->__Vdlyvset__load__DOT__registers__v1 = 1U;
                            __Vdlyvdim0__load__DOT__registers__v1 
                                = vlSelf->load__DOT__rd;
                            VL_WRITEF_NX("ADDI x%0#, x%0#, %0# -> x%0# = 0x%08x\n",0,
                                         5,vlSelf->load__DOT__rd,
                                         5,(IData)(vlSelf->load__DOT__rs1),
                                         32,vlSelf->load__DOT__i_imm,
                                         5,(IData)(vlSelf->load__DOT__rd),
                                         32,vlSelf->load__DOT__registers
                                         [vlSelf->load__DOT__rd]);
                        }
                        vlSelf->__Vdly__load__DOT__pc 
                            = ((IData)(4U) + vlSelf->load__DOT__pc);
                        vlSelf->__Vdly__load__DOT__state = 0U;
                    } else {
                        VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                                     7,vlSelf->load__DOT__opcode);
                        vlSelf->__Vdly__load__DOT__pc 
                            = ((IData)(4U) + vlSelf->load__DOT__pc);
                        vlSelf->__Vdly__load__DOT__state = 0U;
                    }
                } else {
                    VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                                 7,vlSelf->load__DOT__opcode);
                    vlSelf->__Vdly__load__DOT__pc = 
                        ((IData)(4U) + vlSelf->load__DOT__pc);
                    vlSelf->__Vdly__load__DOT__state = 0U;
                }
            } else if (VL_UNLIKELY((8U & (IData)(vlSelf->load__DOT__opcode)))) {
                VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                             7,vlSelf->load__DOT__opcode);
                vlSelf->__Vdly__load__DOT__pc = ((IData)(4U) 
                                                 + vlSelf->load__DOT__pc);
                vlSelf->__Vdly__load__DOT__state = 0U;
            } else if (VL_UNLIKELY((4U & (IData)(vlSelf->load__DOT__opcode)))) {
                VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                             7,vlSelf->load__DOT__opcode);
                vlSelf->__Vdly__load__DOT__pc = ((IData)(4U) 
                                                 + vlSelf->load__DOT__pc);
                vlSelf->__Vdly__load__DOT__state = 0U;
            } else if (VL_LIKELY((2U & (IData)(vlSelf->load__DOT__opcode)))) {
                if (VL_LIKELY((1U & (IData)(vlSelf->load__DOT__opcode)))) {
                    if (VL_UNLIKELY(((2U == (IData)(vlSelf->load__DOT__funct3)) 
                                     & (0U != (IData)(vlSelf->load__DOT__rd))))) {
                        __Vdlyvval__load__DOT__registers__v2 
                            = vlSelf->load__DOT__memory
                            [(0x3ffU & ((vlSelf->load__DOT__registers
                                         [vlSelf->load__DOT__rs1] 
                                         + vlSelf->load__DOT__i_imm) 
                                        >> 2U))];
                        vlSelf->__Vdlyvset__load__DOT__registers__v2 = 1U;
                        __Vdlyvdim0__load__DOT__registers__v2 
                            = vlSelf->load__DOT__rd;
                        VL_WRITEF_NX("LW x%0#, %0d(x%0#) -> x%0# = 0x%08x\n",0,
                                     5,vlSelf->load__DOT__rd,
                                     32,vlSelf->load__DOT__i_imm,
                                     5,(IData)(vlSelf->load__DOT__rs1),
                                     5,vlSelf->load__DOT__rd,
                                     32,vlSelf->load__DOT__memory
                                     [(0x3ffU & ((vlSelf->load__DOT__registers
                                                  [vlSelf->load__DOT__rs1] 
                                                  + vlSelf->load__DOT__i_imm) 
                                                 >> 2U))]);
                    }
                    vlSelf->__Vdly__load__DOT__pc = 
                        ((IData)(4U) + vlSelf->load__DOT__pc);
                    vlSelf->__Vdly__load__DOT__state = 0U;
                } else {
                    VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                                 7,vlSelf->load__DOT__opcode);
                    vlSelf->__Vdly__load__DOT__pc = 
                        ((IData)(4U) + vlSelf->load__DOT__pc);
                    vlSelf->__Vdly__load__DOT__state = 0U;
                }
            } else {
                VL_WRITEF_NX("Unknown opcode: 0x%02x\n",0,
                             7,vlSelf->load__DOT__opcode);
                vlSelf->__Vdly__load__DOT__pc = ((IData)(4U) 
                                                 + vlSelf->load__DOT__pc);
                vlSelf->__Vdly__load__DOT__state = 0U;
            }
        } else {
            VL_WRITEF_NX("Ignored state: 0x%02x\n",0,
                         3,vlSelf->load__DOT__state);
        }
    } else {
        vlSelf->__Vdly__load__DOT__pc = 0U;
        load__DOT__i = 0x20U;
        vlSelf->__Vdly__load__DOT__state = 0U;
        vlSelf->finished = 0U;
        vlSelf->result = 0U;
        vlSelf->__Vdlyvset__load__DOT__registers__v3 = 1U;
    }
    vlSelf->load__DOT__state = vlSelf->__Vdly__load__DOT__state;
    vlSelf->load__DOT__pc = vlSelf->__Vdly__load__DOT__pc;
    if (vlSelf->__Vdlyvset__load__DOT__memory__v0) {
        vlSelf->load__DOT__memory[__Vdlyvdim0__load__DOT__memory__v0] 
            = __Vdlyvval__load__DOT__memory__v0;
    }
    if (vlSelf->__Vdlyvset__load__DOT__registers__v0) {
        vlSelf->load__DOT__registers[__Vdlyvdim0__load__DOT__registers__v0] 
            = __Vdlyvval__load__DOT__registers__v0;
    }
    if (vlSelf->__Vdlyvset__load__DOT__registers__v1) {
        vlSelf->load__DOT__registers[__Vdlyvdim0__load__DOT__registers__v1] 
            = __Vdlyvval__load__DOT__registers__v1;
    }
    if (vlSelf->__Vdlyvset__load__DOT__registers__v2) {
        vlSelf->load__DOT__registers[__Vdlyvdim0__load__DOT__registers__v2] 
            = __Vdlyvval__load__DOT__registers__v2;
    }
    if (vlSelf->__Vdlyvset__load__DOT__registers__v3) {
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
    }
    vlSelf->load__DOT__instruction = vlSelf->__Vdly__load__DOT__instruction;
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

void Vload___024root___eval_triggers__act(Vload___024root* vlSelf);

bool Vload___024root___eval_phase__act(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<2> __VpreTriggered;
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
    (void)vlSelf;  // Prevent unused variable warning
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
    (void)vlSelf;  // Prevent unused variable warning
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
            VL_FATAL_MT("rtl/load.v", 2, "", "NBA region did not converge.");
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
                VL_FATAL_MT("rtl/load.v", 2, "", "Active region did not converge.");
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
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->i_clk & 0xfeU))) {
        Verilated::overWidthError("i_clk");}
    if (VL_UNLIKELY((vlSelf->i_rst_n & 0xfeU))) {
        Verilated::overWidthError("i_rst_n");}
}
#endif  // VL_DEBUG
