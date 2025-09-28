// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vload.h for the primary calling header

#include "Vload__pch.h"
#include "Vload__Syms.h"
#include "Vload___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vload___024root___dump_triggers__stl(Vload___024root* vlSelf);
#endif  // VL_DEBUG

VL_ATTR_COLD void Vload___024root___eval_triggers__stl(Vload___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vload__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vload___024root___eval_triggers__stl\n"); );
    // Body
    vlSelf->__VstlTriggered.set(0U, (IData)(vlSelf->__VstlFirstIteration));
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vload___024root___dump_triggers__stl(vlSelf);
    }
#endif
}
