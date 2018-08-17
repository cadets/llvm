; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mcpu=pwr8 -mtriple=powerpc64le-unknown-unknown -verify-machineinstrs < %s | FileCheck %s

define <4 x float> @truncf32(<4 x float> %a) #0 {
; CHECK-LABEL: truncf32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvrspiz 34, 34
; CHECK-NEXT:    blr
  %t0 = fptosi <4 x float> %a to <4 x i32>
  %t1 = sitofp <4 x i32> %t0 to <4 x float>
  ret <4 x float> %t1
}

define <2 x double> @truncf64(<2 x double> %a) #0 {
; CHECK-LABEL: truncf64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvrdpiz 34, 34
; CHECK-NEXT:    blr
  %t0 = fptosi <2 x double> %a to <2 x i64>
  %t1 = sitofp <2 x i64> %t0 to <2 x double>
  ret <2 x double> %t1
}

define <4 x float> @truncf32u(<4 x float> %a) #0 {
; CHECK-LABEL: truncf32u:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvrspiz 34, 34
; CHECK-NEXT:    blr
  %t0 = fptoui <4 x float> %a to <4 x i32>
  %t1 = uitofp <4 x i32> %t0 to <4 x float>
  ret <4 x float> %t1
}

define <2 x double> @truncf64u(<2 x double> %a) #0 {
; CHECK-LABEL: truncf64u:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvrdpiz 34, 34
; CHECK-NEXT:    blr
  %t0 = fptoui <2 x double> %a to <2 x i64>
  %t1 = uitofp <2 x i64> %t0 to <2 x double>
  ret <2 x double> %t1
}

attributes #0 = { "no-signed-zeros-fp-math"="true" }

