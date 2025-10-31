
short s_short = 1;
int s_int = 1;
long s_long = 1;
long long s_longlong = 1;

signed a_signed = 1;
unsigned a_unsigned = 1;

/**
 * cat build/ir/int_ir.ll;
; ModuleID = 'concepts/int_ir.cpp'
source_filename = "concepts/int_ir.cpp"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

@s_short = dso_local global i16 1, align 2
@s_int = dso_local global i32 1, align 4
@s_long = dso_local global i64 1, align 8
@s_longlong = dso_local global i64 1, align 8
@a_signed = dso_local global i32 1, align 4
@a_unsigned = dso_local global i32 1, align 4

!llvm.linker.options = !{}
!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
 */
