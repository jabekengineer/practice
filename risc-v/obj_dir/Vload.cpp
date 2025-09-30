// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vload__pch.h"

//============================================================
// Constructors

Vload::Vload(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vload__Syms(contextp(), _vcname__, this)}
    , i_clk{vlSymsp->TOP.i_clk}
    , i_rst_n{vlSymsp->TOP.i_rst_n}
    , finished{vlSymsp->TOP.finished}
    , led_done{vlSymsp->TOP.led_done}
    , debug_state{vlSymsp->TOP.debug_state}
    , result{vlSymsp->TOP.result}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vload::Vload(const char* _vcname__)
    : Vload(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vload::~Vload() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vload___024root___eval_debug_assertions(Vload___024root* vlSelf);
#endif  // VL_DEBUG
void Vload___024root___eval_static(Vload___024root* vlSelf);
void Vload___024root___eval_initial(Vload___024root* vlSelf);
void Vload___024root___eval_settle(Vload___024root* vlSelf);
void Vload___024root___eval(Vload___024root* vlSelf);

void Vload::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vload::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vload___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vload___024root___eval_static(&(vlSymsp->TOP));
        Vload___024root___eval_initial(&(vlSymsp->TOP));
        Vload___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vload___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vload::eventsPending() { return false; }

uint64_t Vload::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "%Error: No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vload::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vload___024root___eval_final(Vload___024root* vlSelf);

VL_ATTR_COLD void Vload::final() {
    Vload___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vload::hierName() const { return vlSymsp->name(); }
const char* Vload::modelName() const { return "Vload"; }
unsigned Vload::threads() const { return 1; }
void Vload::prepareClone() const { contextp()->prepareClone(); }
void Vload::atClone() const {
    contextp()->threadPoolpOnClone();
}

//============================================================
// Trace configuration

VL_ATTR_COLD void Vload::trace(VerilatedVcdC* tfp, int levels, int options) {
    vl_fatal(__FILE__, __LINE__, __FILE__,"'Vload::trace()' called on model that was Verilated without --trace option");
}
