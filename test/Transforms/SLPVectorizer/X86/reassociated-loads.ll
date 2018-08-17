; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -reassociate -slp-vectorizer -slp-vectorize-hor -slp-vectorize-hor-store -S < %s -mtriple=x86_64-apple-macosx -mcpu=corei7-avx -mattr=+avx2 | FileCheck %s

define signext i8 @Foo(<32 x i8>* %__v) {
; CHECK-LABEL: @Foo(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load <32 x i8>, <32 x i8>* [[__V:%.*]], align 32
; CHECK-NEXT:    [[ADD_I_1_I:%.*]] = add i8 undef, undef
; CHECK-NEXT:    [[ADD_I_2_I:%.*]] = add i8 [[ADD_I_1_I]], undef
; CHECK-NEXT:    [[ADD_I_3_I:%.*]] = add i8 [[ADD_I_2_I]], undef
; CHECK-NEXT:    [[ADD_I_4_I:%.*]] = add i8 [[ADD_I_3_I]], undef
; CHECK-NEXT:    [[ADD_I_5_I:%.*]] = add i8 [[ADD_I_4_I]], undef
; CHECK-NEXT:    [[ADD_I_6_I:%.*]] = add i8 [[ADD_I_5_I]], undef
; CHECK-NEXT:    [[ADD_I_7_I:%.*]] = add i8 [[ADD_I_6_I]], undef
; CHECK-NEXT:    [[ADD_I_8_I:%.*]] = add i8 [[ADD_I_7_I]], undef
; CHECK-NEXT:    [[ADD_I_9_I:%.*]] = add i8 [[ADD_I_8_I]], undef
; CHECK-NEXT:    [[ADD_I_10_I:%.*]] = add i8 [[ADD_I_9_I]], undef
; CHECK-NEXT:    [[ADD_I_11_I:%.*]] = add i8 [[ADD_I_10_I]], undef
; CHECK-NEXT:    [[ADD_I_12_I:%.*]] = add i8 [[ADD_I_11_I]], undef
; CHECK-NEXT:    [[ADD_I_13_I:%.*]] = add i8 [[ADD_I_12_I]], undef
; CHECK-NEXT:    [[ADD_I_14_I:%.*]] = add i8 [[ADD_I_13_I]], undef
; CHECK-NEXT:    [[ADD_I_15_I:%.*]] = add i8 [[ADD_I_14_I]], undef
; CHECK-NEXT:    [[ADD_I_16_I:%.*]] = add i8 [[ADD_I_15_I]], undef
; CHECK-NEXT:    [[ADD_I_17_I:%.*]] = add i8 [[ADD_I_16_I]], undef
; CHECK-NEXT:    [[ADD_I_18_I:%.*]] = add i8 [[ADD_I_17_I]], undef
; CHECK-NEXT:    [[ADD_I_19_I:%.*]] = add i8 [[ADD_I_18_I]], undef
; CHECK-NEXT:    [[ADD_I_20_I:%.*]] = add i8 [[ADD_I_19_I]], undef
; CHECK-NEXT:    [[ADD_I_21_I:%.*]] = add i8 [[ADD_I_20_I]], undef
; CHECK-NEXT:    [[ADD_I_22_I:%.*]] = add i8 [[ADD_I_21_I]], undef
; CHECK-NEXT:    [[ADD_I_23_I:%.*]] = add i8 [[ADD_I_22_I]], undef
; CHECK-NEXT:    [[ADD_I_24_I:%.*]] = add i8 [[ADD_I_23_I]], undef
; CHECK-NEXT:    [[ADD_I_25_I:%.*]] = add i8 [[ADD_I_24_I]], undef
; CHECK-NEXT:    [[ADD_I_26_I:%.*]] = add i8 [[ADD_I_25_I]], undef
; CHECK-NEXT:    [[ADD_I_27_I:%.*]] = add i8 [[ADD_I_26_I]], undef
; CHECK-NEXT:    [[ADD_I_28_I:%.*]] = add i8 [[ADD_I_27_I]], undef
; CHECK-NEXT:    [[ADD_I_29_I:%.*]] = add i8 [[ADD_I_28_I]], undef
; CHECK-NEXT:    [[ADD_I_30_I:%.*]] = add i8 [[ADD_I_29_I]], undef
; CHECK-NEXT:    [[RDX_SHUF:%.*]] = shufflevector <32 x i8> [[TMP0]], <32 x i8> undef, <32 x i32> <i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; CHECK-NEXT:    [[BIN_RDX:%.*]] = add <32 x i8> [[TMP0]], [[RDX_SHUF]]
; CHECK-NEXT:    [[RDX_SHUF1:%.*]] = shufflevector <32 x i8> [[BIN_RDX]], <32 x i8> undef, <32 x i32> <i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; CHECK-NEXT:    [[BIN_RDX2:%.*]] = add <32 x i8> [[BIN_RDX]], [[RDX_SHUF1]]
; CHECK-NEXT:    [[RDX_SHUF3:%.*]] = shufflevector <32 x i8> [[BIN_RDX2]], <32 x i8> undef, <32 x i32> <i32 4, i32 5, i32 6, i32 7, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; CHECK-NEXT:    [[BIN_RDX4:%.*]] = add <32 x i8> [[BIN_RDX2]], [[RDX_SHUF3]]
; CHECK-NEXT:    [[RDX_SHUF5:%.*]] = shufflevector <32 x i8> [[BIN_RDX4]], <32 x i8> undef, <32 x i32> <i32 2, i32 3, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; CHECK-NEXT:    [[BIN_RDX6:%.*]] = add <32 x i8> [[BIN_RDX4]], [[RDX_SHUF5]]
; CHECK-NEXT:    [[RDX_SHUF7:%.*]] = shufflevector <32 x i8> [[BIN_RDX6]], <32 x i8> undef, <32 x i32> <i32 1, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef, i32 undef>
; CHECK-NEXT:    [[BIN_RDX8:%.*]] = add <32 x i8> [[BIN_RDX6]], [[RDX_SHUF7]]
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <32 x i8> [[BIN_RDX8]], i32 0
; CHECK-NEXT:    [[ADD_I_31_I:%.*]] = add i8 [[ADD_I_30_I]], undef
; CHECK-NEXT:    ret i8 [[TMP1]]
;
entry:
  %0 = load <32 x i8>, <32 x i8>* %__v, align 32
  %vecext.i.i.i = extractelement <32 x i8> %0, i64 0
  %vecext.i.i.1.i = extractelement <32 x i8> %0, i64 1
  %add.i.1.i = add i8 %vecext.i.i.1.i, %vecext.i.i.i
  %vecext.i.i.2.i = extractelement <32 x i8> %0, i64 2
  %add.i.2.i = add i8 %vecext.i.i.2.i, %add.i.1.i
  %vecext.i.i.3.i = extractelement <32 x i8> %0, i64 3
  %add.i.3.i = add i8 %vecext.i.i.3.i, %add.i.2.i
  %vecext.i.i.4.i = extractelement <32 x i8> %0, i64 4
  %add.i.4.i = add i8 %vecext.i.i.4.i, %add.i.3.i
  %vecext.i.i.5.i = extractelement <32 x i8> %0, i64 5
  %add.i.5.i = add i8 %vecext.i.i.5.i, %add.i.4.i
  %vecext.i.i.6.i = extractelement <32 x i8> %0, i64 6
  %add.i.6.i = add i8 %vecext.i.i.6.i, %add.i.5.i
  %vecext.i.i.7.i = extractelement <32 x i8> %0, i64 7
  %add.i.7.i = add i8 %vecext.i.i.7.i, %add.i.6.i
  %vecext.i.i.8.i = extractelement <32 x i8> %0, i64 8
  %add.i.8.i = add i8 %vecext.i.i.8.i, %add.i.7.i
  %vecext.i.i.9.i = extractelement <32 x i8> %0, i64 9
  %add.i.9.i = add i8 %vecext.i.i.9.i, %add.i.8.i
  %vecext.i.i.10.i = extractelement <32 x i8> %0, i64 10
  %add.i.10.i = add i8 %vecext.i.i.10.i, %add.i.9.i
  %vecext.i.i.11.i = extractelement <32 x i8> %0, i64 11
  %add.i.11.i = add i8 %vecext.i.i.11.i, %add.i.10.i
  %vecext.i.i.12.i = extractelement <32 x i8> %0, i64 12
  %add.i.12.i = add i8 %vecext.i.i.12.i, %add.i.11.i
  %vecext.i.i.13.i = extractelement <32 x i8> %0, i64 13
  %add.i.13.i = add i8 %vecext.i.i.13.i, %add.i.12.i
  %vecext.i.i.14.i = extractelement <32 x i8> %0, i64 14
  %add.i.14.i = add i8 %vecext.i.i.14.i, %add.i.13.i
  %vecext.i.i.15.i = extractelement <32 x i8> %0, i64 15
  %add.i.15.i = add i8 %vecext.i.i.15.i, %add.i.14.i
  %vecext.i.i.16.i = extractelement <32 x i8> %0, i64 16
  %add.i.16.i = add i8 %vecext.i.i.16.i, %add.i.15.i
  %vecext.i.i.17.i = extractelement <32 x i8> %0, i64 17
  %add.i.17.i = add i8 %vecext.i.i.17.i, %add.i.16.i
  %vecext.i.i.18.i = extractelement <32 x i8> %0, i64 18
  %add.i.18.i = add i8 %vecext.i.i.18.i, %add.i.17.i
  %vecext.i.i.19.i = extractelement <32 x i8> %0, i64 19
  %add.i.19.i = add i8 %vecext.i.i.19.i, %add.i.18.i
  %vecext.i.i.20.i = extractelement <32 x i8> %0, i64 20
  %add.i.20.i = add i8 %vecext.i.i.20.i, %add.i.19.i
  %vecext.i.i.21.i = extractelement <32 x i8> %0, i64 21
  %add.i.21.i = add i8 %vecext.i.i.21.i, %add.i.20.i
  %vecext.i.i.22.i = extractelement <32 x i8> %0, i64 22
  %add.i.22.i = add i8 %vecext.i.i.22.i, %add.i.21.i
  %vecext.i.i.23.i = extractelement <32 x i8> %0, i64 23
  %add.i.23.i = add i8 %vecext.i.i.23.i, %add.i.22.i
  %vecext.i.i.24.i = extractelement <32 x i8> %0, i64 24
  %add.i.24.i = add i8 %vecext.i.i.24.i, %add.i.23.i
  %vecext.i.i.25.i = extractelement <32 x i8> %0, i64 25
  %add.i.25.i = add i8 %vecext.i.i.25.i, %add.i.24.i
  %vecext.i.i.26.i = extractelement <32 x i8> %0, i64 26
  %add.i.26.i = add i8 %vecext.i.i.26.i, %add.i.25.i
  %vecext.i.i.27.i = extractelement <32 x i8> %0, i64 27
  %add.i.27.i = add i8 %vecext.i.i.27.i, %add.i.26.i
  %vecext.i.i.28.i = extractelement <32 x i8> %0, i64 28
  %add.i.28.i = add i8 %vecext.i.i.28.i, %add.i.27.i
  %vecext.i.i.29.i = extractelement <32 x i8> %0, i64 29
  %add.i.29.i = add i8 %vecext.i.i.29.i, %add.i.28.i
  %vecext.i.i.30.i = extractelement <32 x i8> %0, i64 30
  %add.i.30.i = add i8 %vecext.i.i.30.i, %add.i.29.i
  %vecext.i.i.31.i = extractelement <32 x i8> %0, i64 31
  %add.i.31.i = add i8 %vecext.i.i.31.i, %add.i.30.i
  ret i8 %add.i.31.i
}
