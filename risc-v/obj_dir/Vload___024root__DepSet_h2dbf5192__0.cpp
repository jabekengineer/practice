// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vload.h for the primary calling header

#include "Vload__pch.h"
#include "Vload__Syms.h"
#include "Vload___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vload___024root___dump_triggers__act(Vload___024root* vlSelf);
#endif  // VL_DEBUG

void Vload___024root___eval_triggers__act(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_triggers__act\n"); );
    // Body
    vlSelf->__VactTriggered.set(0U, ((IData)(vlSelf->i_clk) 
                                     & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__i_clk__0))));
    vlSelf->__VactTriggered.set(1U, (((IData)(vlSelf->i_clk) 
                                      & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__i_clk__0))) 
                                     | ((~ (IData)(vlSelf->i_rst_n)) 
                                        & (IData)(vlSelf->__Vtrigprevexpr___TOP__i_rst_n__0))));
    vlSelf->__Vtrigprevexpr___TOP__i_clk__0 = vlSelf->i_clk;
    vlSelf->__Vtrigprevexpr___TOP__i_rst_n__0 = vlSelf->i_rst_n;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vload___024root___dump_triggers__act(vlSelf);
    }
#endif
}
