; iOS 27.0 arm64 Simulator. ASLR addresses belong to this capture.
; Reconstructed analysis input, not Apple source. No ambiguous ivar-name annotations.
ivars: 0

### +[STUIStatusBarVisualProvider_DynamicSplit visualProviderSubclassForScreen:visualProviderInfo:]  (58 条)
+0    stp     d11, d10, [sp, #-0x50]!
+4    stp     d9, d8, [sp, #0x10]
+8    stp     x22, x21, [sp, #0x20]
+12   stp     x20, x19, [sp, #0x30]
+16   stp     x29, x30, [sp, #0x40]
+20   add     x29, sp, #0x40
+24   mov     x20, x0
+28   bl      0x1028c123c                                ; symbol stub for: objc_retain_x2
+32   mov     x21, x0
+36   bl      0x1028b0560                                ; objc_msgSend$_exclusionArea
+40   bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+44   mov     x19, x0
+48   bl      0x1028b9920                                ; objc_msgSend$rect
+52   mov.16b v8, v2
+56   mov     x0, x21
+60   bl      0x1028b1760                                ; objc_msgSend$_unjailedReferenceBounds
+64   bl      0x1028c0c6c                                ; symbol stub for: CGRectGetWidth
+68   mov.16b v9, v0
+72   mov     x0, x21
+76   bl      0x1028b0ba0                                ; objc_msgSend$_nativeScale
+80   fmul    d10, d9, d0
+84   mov     x0, x21
+88   bl      0x1028b0f60                                ; objc_msgSend$_scale
+92   mov.16b v9, v0
+96   bl      0x1028c1164                                ; symbol stub for: objc_release_x21
+100  fdiv    d0, d10, d9
+104  adrp    x8, 124
+108  ldr     d1, [x8, #0xe10]                           ; = 402.0
+112  fcmp    d0, d1
+116  b.ls    0x102827358                                ; <+148>
+120  adrp    x8, 124
+124  ldr     d0, [x8, #0xe18]                           ; = 285.0
+128  fcmp    d8, d0
+132  b.hi    0x102827384                                ; <+192>
+136  adrp    x8, 218
+140  add     x8, x8, #0x7d0                             ; (void *)0x0000000102905be0: STUIStatusBarVisualProvider_DynamicSplitSmallIsland
+144  b       0x102827378                                ; <+180>
+148  adrp    x8, 218
+152  add     x8, x8, #0x7c0                             ; (void *)0x0000000102905bb8: STUIStatusBarVisualProvider_DynamicSplitMedium
+156  adrp    x9, 218
+160  add     x9, x9, #0x7c8                             ; (void *)0x0000000102905b90: STUIStatusBarVisualProvider_DynamicSplitMediumSmallIsland
+164  adrp    x10, 124
+168  ldr     d0, [x10, #0xe18]                          ; = 285.0
+172  fcmp    d8, d0
+176  csel    x8, x9, x8, ls
+180  ldr     x0, [x8]
+184  bl      0x1028c10ec                                ; symbol stub for: objc_opt_class
+188  mov     x20, x0
+192  mov     x0, x20
+196  bl      0x1028c11f4                                ; symbol stub for: objc_retainAutoreleaseReturnValue
+200  bl      0x1028c1140                                ; symbol stub for: objc_release_x19
+204  mov     x0, x20
+208  ldp     x29, x30, [sp, #0x40]
+212  ldp     x20, x19, [sp, #0x30]
+216  ldp     x22, x21, [sp, #0x20]
+220  ldp     d9, d8, [sp, #0x10]
+224  ldp     d11, d10, [sp], #0x50
+228  ret

### -[STUIStatusBarVisualProvider_Split normalIconSize]  (99 条)
+0    stp     d9, d8, [sp, #-0x40]!
+4    stp     x22, x21, [sp, #0x10]
+8    stp     x20, x19, [sp, #0x20]
+12   stp     x29, x30, [sp, #0x30]
+16   add     x29, sp, #0x30
+20   mov     x19, x0
+24   bl      0x1028b8a00                                ; objc_msgSend$normalIconScale
+28   mov.16b v8, v0
+32   mov     x0, x19
+36   bl      0x1028beaa0                                ; objc_msgSend$statusBar
+40   bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+44   mov     x19, x0
+48   bl      0x1028b0500                                ; objc_msgSend$_effectiveTargetScreen
+52   bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+56   mov     x20, x0
+60   bl      0x1028b0f60                                ; objc_msgSend$_scale
+64   fmov    d1, #2.50000000
+68   fcmp    d0, d1
+72   b.le    0x1028618d8                                ; <+100>
+76   adrp    x8, 68
+80   ldr     d0, [x8, #0x1d8]                           ; = 1.08
+84   fcmp    d8, d0
+88   b.ne    0x1028618f0                                ; <+124>
+92   mov     w21, #0x6                                  ; =6
+96   b       0x10286194c                                ; <+216>
+100  adrp    x8, 66
+104  ldr     d0, [x8, #0xcf8]                           ; = 1.07
+108  fcmp    d8, d0
+112  b.ne    0x102861908                                ; <+148>
+116  mov     w21, #0x5                                  ; =5
+120  b       0x10286194c                                ; <+216>
+124  adrp    x8, 68
+128  ldr     d0, [x8, #0x1e0]                           ; = 1.06
+132  fcmp    d8, d0
+136  b.ne    0x102861920                                ; <+172>
+140  mov     w21, #0x4                                  ; =4
+144  b       0x10286194c                                ; <+216>
+148  adrp    x8, 66
+152  ldr     d0, [x8, #0xcd0]                           ; = 1.16
+156  fcmp    d8, d0
+160  b.ne    0x102861938                                ; <+196>
+164  mov     w21, #0xb                                  ; =11
+168  b       0x10286194c                                ; <+216>
+172  adrp    x8, 66
+176  ldr     d0, [x8, #0xeb8]                           ; = 1.12
+180  fcmp    d8, d0
+184  b.ne    0x10286196c                                ; <+248>
+188  mov     w21, #0x7                                  ; =7
+192  b       0x10286194c                                ; <+216>
+196  adrp    x8, 68
+200  ldr     d0, [x8, #0x1d0]                           ; = 1.2412
+204  fcmp    d8, d0
+208  mov     w8, #0xd                                   ; =13
+212  csinc   x21, x8, xzr, eq
+216  bl      0x1028c1158                                ; symbol stub for: objc_release_x20
+220  bl      0x1028c1140                                ; symbol stub for: objc_release_x19
+224  mov     x0, x21
+228  ldp     x29, x30, [sp, #0x30]
+232  ldp     x20, x19, [sp, #0x20]
+236  ldp     x22, x21, [sp, #0x10]
+240  ldp     d9, d8, [sp], #0x40
+244  ret
+248  adrp    x8, 66
+252  ldr     d0, [x8, #0xec0]                           ; = 1.18
+256  fcmp    d8, d0
+260  b.ne    0x102861984                                ; <+272>
+264  mov     w21, #0x8                                  ; =8
+268  b       0x10286194c                                ; <+216>
+272  adrp    x8, 66
+276  ldr     d0, [x8, #0xe38]                           ; = 1.26
+280  fcmp    d8, d0
+284  b.ne    0x10286199c                                ; <+296>
+288  mov     w21, #0x9                                  ; =9
+292  b       0x10286194c                                ; <+216>
+296  adrp    x8, 66
+300  ldr     d0, [x8, #0xe90]                           ; = 1.32
+304  fcmp    d8, d0
+308  b.ne    0x1028619b4                                ; <+320>
+312  mov     w21, #0xa                                  ; =10
+316  b       0x10286194c                                ; <+216>
+320  adrp    x8, 66
+324  ldr     d0, [x8, #0xcd0]                           ; = 1.16
+328  fcmp    d8, d0
+332  b.ne    0x1028619cc                                ; <+344>
+336  mov     w21, #0xc                                  ; =12
+340  b       0x10286194c                                ; <+216>
+344  adrp    x8, 68
+348  ldr     d0, [x8, #0x1d0]                           ; = 1.2412
+352  fcmp    d8, d0
+356  b.ne    0x1028619e4                                ; <+368>
+360  mov     w21, #0xe                                  ; =14
+364  b       0x10286194c                                ; <+216>
+368  adrp    x8, 66
+372  ldr     d0, [x8, #0xe40]                           ; = 1.2992000000000001
+376  fcmp    d8, d0
+380  mov     w8, #0x2                                   ; =2
+384  mov     w9, #0xf                                   ; =15
+388  csel    x21, x9, x8, eq
+392  b       0x10286194c                                ; <+216>

### -[STUIStatusBarVisualProvider_Split expandedIconSize]  (99 条)
+0    stp     d9, d8, [sp, #-0x40]!
+4    stp     x22, x21, [sp, #0x10]
+8    stp     x20, x19, [sp, #0x20]
+12   stp     x29, x30, [sp, #0x30]
+16   add     x29, sp, #0x30
+20   mov     x19, x0
+24   bl      0x1028b6040                                ; objc_msgSend$expandedIconScale
+28   mov.16b v8, v0
+32   mov     x0, x19
+36   bl      0x1028beaa0                                ; objc_msgSend$statusBar
+40   bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+44   mov     x19, x0
+48   bl      0x1028b0500                                ; objc_msgSend$_effectiveTargetScreen
+52   bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+56   mov     x20, x0
+60   bl      0x1028b0f60                                ; objc_msgSend$_scale
+64   fmov    d1, #2.50000000
+68   fcmp    d0, d1
+72   b.le    0x102861a64                                ; <+100>
+76   adrp    x8, 68
+80   ldr     d0, [x8, #0x1d8]                           ; = 1.08
+84   fcmp    d8, d0
+88   b.ne    0x102861a7c                                ; <+124>
+92   mov     w21, #0x6                                  ; =6
+96   b       0x102861ad8                                ; <+216>
+100  adrp    x8, 66
+104  ldr     d0, [x8, #0xcf8]                           ; = 1.07
+108  fcmp    d8, d0
+112  b.ne    0x102861a94                                ; <+148>
+116  mov     w21, #0x5                                  ; =5
+120  b       0x102861ad8                                ; <+216>
+124  adrp    x8, 68
+128  ldr     d0, [x8, #0x1e0]                           ; = 1.06
+132  fcmp    d8, d0
+136  b.ne    0x102861aac                                ; <+172>
+140  mov     w21, #0x4                                  ; =4
+144  b       0x102861ad8                                ; <+216>
+148  adrp    x8, 66
+152  ldr     d0, [x8, #0xcd0]                           ; = 1.16
+156  fcmp    d8, d0
+160  b.ne    0x102861ac4                                ; <+196>
+164  mov     w21, #0xb                                  ; =11
+168  b       0x102861ad8                                ; <+216>
+172  adrp    x8, 66
+176  ldr     d0, [x8, #0xeb8]                           ; = 1.12
+180  fcmp    d8, d0
+184  b.ne    0x102861af8                                ; <+248>
+188  mov     w21, #0x7                                  ; =7
+192  b       0x102861ad8                                ; <+216>
+196  adrp    x8, 68
+200  ldr     d0, [x8, #0x1d0]                           ; = 1.2412
+204  fcmp    d8, d0
+208  mov     w8, #0xd                                   ; =13
+212  csinc   x21, x8, xzr, eq
+216  bl      0x1028c1158                                ; symbol stub for: objc_release_x20
+220  bl      0x1028c1140                                ; symbol stub for: objc_release_x19
+224  mov     x0, x21
+228  ldp     x29, x30, [sp, #0x30]
+232  ldp     x20, x19, [sp, #0x20]
+236  ldp     x22, x21, [sp, #0x10]
+240  ldp     d9, d8, [sp], #0x40
+244  ret
+248  adrp    x8, 66
+252  ldr     d0, [x8, #0xec0]                           ; = 1.18
+256  fcmp    d8, d0
+260  b.ne    0x102861b10                                ; <+272>
+264  mov     w21, #0x8                                  ; =8
+268  b       0x102861ad8                                ; <+216>
+272  adrp    x8, 66
+276  ldr     d0, [x8, #0xe38]                           ; = 1.26
+280  fcmp    d8, d0
+284  b.ne    0x102861b28                                ; <+296>
+288  mov     w21, #0x9                                  ; =9
+292  b       0x102861ad8                                ; <+216>
+296  adrp    x8, 66
+300  ldr     d0, [x8, #0xe90]                           ; = 1.32
+304  fcmp    d8, d0
+308  b.ne    0x102861b40                                ; <+320>
+312  mov     w21, #0xa                                  ; =10
+316  b       0x102861ad8                                ; <+216>
+320  adrp    x8, 66
+324  ldr     d0, [x8, #0xcd0]                           ; = 1.16
+328  fcmp    d8, d0
+332  b.ne    0x102861b58                                ; <+344>
+336  mov     w21, #0xc                                  ; =12
+340  b       0x102861ad8                                ; <+216>
+344  adrp    x8, 68
+348  ldr     d0, [x8, #0x1d0]                           ; = 1.2412
+352  fcmp    d8, d0
+356  b.ne    0x102861b70                                ; <+368>
+360  mov     w21, #0xe                                  ; =14
+364  b       0x102861ad8                                ; <+216>
+368  adrp    x8, 66
+372  ldr     d0, [x8, #0xe40]                           ; = 1.2992000000000001
+376  fcmp    d8, d0
+380  mov     w8, #0x2                                   ; =2
+384  mov     w9, #0xf                                   ; =15
+388  csel    x21, x9, x8, eq
+392  b       0x102861ad8                                ; <+216>

### -[STUIStatusBarVisualProvider_Split styleAttributesForStyle:]  (131 条)
+0    sub     sp, sp, #0x60
+4    stp     d9, d8, [sp, #0x10]
+8    stp     x24, x23, [sp, #0x20]
+12   stp     x22, x21, [sp, #0x30]
+16   stp     x20, x19, [sp, #0x40]
+20   stp     x29, x30, [sp, #0x50]
+24   add     x29, sp, #0x50
+28   mov     x20, x0
+32   adrp    x8, 157
+36   ldr     x8, [x8, #0x9e8]                           ; Class STUIStatusBarVisualProvider_Split
+40   stp     x0, x8, [sp]
+44   adrp    x8, 156
+48   ldr     x1, [x8, #0x2f8]
+52   mov     x0, sp
+56   bl      0x1028c10e0                                ; symbol stub for: objc_msgSendSuper2
+60   bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+64   mov     x19, x0
+68   bl      0x1028b8720                                ; objc_msgSend$mode
+72   cmp     x0, #0x5
+76   b.hi    0x102863fc0                                ; <+232>
+80   mov     w8, #0x1                                   ; =1
+84   lsl     x8, x8, x0
+88   mov     w9, #0x35                                  ; =53
+92   tst     x8, x9
+96   b.eq    0x102863ff0                                ; <+280>
+100  mov     x0, x20
+104  bl      0x1028b8a00                                ; objc_msgSend$normalIconScale
+108  mov     x0, x19
+112  bl      0x1028bc160                                ; objc_msgSend$setIconScale:
+116  mov     x0, x20
+120  bl      0x1028b8a20                                ; objc_msgSend$normalIconSize
+124  mov     x2, x0
+128  mov     x0, x19
+132  bl      0x1028bc180                                ; objc_msgSend$setIconSize:
+136  mov     x0, x20
+140  bl      0x1028b89e0                                ; objc_msgSend$normalFont
+144  bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+148  mov     x21, x0
+152  mov     x0, x19
+156  mov     x2, x21
+160  bl      0x1028bbea0                                ; objc_msgSend$setFont:
+164  bl      0x1028c1164                                ; symbol stub for: objc_release_x21
+168  mov     x0, x20
+172  bl      0x1028b5860                                ; objc_msgSend$emphasizedFont
+176  bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+180  mov     x21, x0
+184  mov     x0, x19
+188  mov     x2, x21
+192  bl      0x1028bbb60                                ; objc_msgSend$setEmphasizedFont:
+196  bl      0x1028c1164                                ; symbol stub for: objc_release_x21
+200  mov     x0, x20
+204  bl      0x1028be800                                ; objc_msgSend$smallFont
+208  bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+212  mov     x20, x0
+216  mov     x0, x19
+220  mov     x2, x20
+224  bl      0x1028bd780                                ; objc_msgSend$setSmallFont:
+228  bl      0x1028c1158                                ; symbol stub for: objc_release_x20
+232  adrp    x2, 157
+236  add     x2, x2, #0xf80
+240  mov     x0, x19
+244  bl      0x1028bc220                                ; objc_msgSend$setImageNamePrefixes:
+248  mov     x0, x19
+252  ldp     x29, x30, [sp, #0x50]
+256  ldp     x20, x19, [sp, #0x40]
+260  ldp     x22, x21, [sp, #0x30]
+264  ldp     x24, x23, [sp, #0x20]
+268  ldp     d9, d8, [sp, #0x10]
+272  add     sp, sp, #0x60
+276  b       0x1028c1074                                ; symbol stub for: objc_autoreleaseReturnValue
+280  cmp     x0, #0x1
+284  b.ne    0x10286406c                                ; <+404>
+288  mov     x0, x20
+292  bl      0x1028b6040                                ; objc_msgSend$expandedIconScale
+296  mov     x0, x19
+300  bl      0x1028bc160                                ; objc_msgSend$setIconScale:
+304  mov     x0, x20
+308  bl      0x1028b6060                                ; objc_msgSend$expandedIconSize
+312  mov     x2, x0
+316  mov     x0, x19
+320  bl      0x1028bc180                                ; objc_msgSend$setIconSize:
+324  mov     x0, x20
+328  bl      0x1028b6000                                ; objc_msgSend$expandedFont
+332  bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+336  mov     x21, x0
+340  mov     x0, x19
+344  mov     x2, x21
+348  bl      0x1028bbea0                                ; objc_msgSend$setFont:
+352  bl      0x1028c1164                                ; symbol stub for: objc_release_x21
+356  mov     x0, x20
+360  bl      0x1028b6000                                ; objc_msgSend$expandedFont
+364  bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+368  mov     x21, x0
+372  mov     x0, x19
+376  mov     x2, x21
+380  bl      0x1028bbb60                                ; objc_msgSend$setEmphasizedFont:
+384  bl      0x1028c1164                                ; symbol stub for: objc_release_x21
+388  mov     x0, x20
+392  bl      0x1028b6000                                ; objc_msgSend$expandedFont
+396  bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+400  b       0x102863fac                                ; <+212>
+404  adrp    x23, 157
+408  ldr     x0, [x23, #0x960]
+412  bl      0x1028b7e20                                ; objc_msgSend$labelColor
+416  bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+420  mov     x21, x0
+424  adrp    x8, 63
+428  ldr     d8, [x8, #0xd08]                           ; = 0.8
+432  mov.16b v0, v8
+436  bl      0x1028b40c0                                ; objc_msgSend$colorWithAlphaComponent:
+440  bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+444  mov     x22, x0
+448  mov     x0, x19
+452  mov     x2, x22
+456  bl      0x1028bdc00                                ; objc_msgSend$setTextColor:
+460  bl      0x1028c1170                                ; symbol stub for: objc_release_x22
+464  bl      0x1028c1164                                ; symbol stub for: objc_release_x21
+468  ldr     x0, [x23, #0x960]
+472  bl      0x1028b7e20                                ; objc_msgSend$labelColor
+476  bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+480  mov     x21, x0
+484  mov.16b v0, v8
+488  bl      0x1028b40c0                                ; objc_msgSend$colorWithAlphaComponent:
+492  bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+496  mov     x22, x0
+500  mov     x0, x19
+504  mov     x2, x22
+508  bl      0x1028bc240                                ; objc_msgSend$setImageTintColor:
+512  bl      0x1028c1170                                ; symbol stub for: objc_release_x22
+516  bl      0x1028c1164                                ; symbol stub for: objc_release_x21
+520  b       0x102863f3c                                ; <+100>

### -[STUIStatusBarVisualProvider_Split setExpanded:]  (68 条)
+0    sub     sp, sp, #0x70
+4    stp     x22, x21, [sp, #0x40]
+8    stp     x20, x19, [sp, #0x50]
+12   stp     x29, x30, [sp, #0x60]
+16   add     x29, sp, #0x60
+20   mov     x20, x2
+24   mov     x19, x0
+28   bl      0x1028b5f60                                ; objc_msgSend$expanded
+32   cmp     w20, w0
+36   b.eq    0x1028690cc                                ; <+252>
+40   cbz     x19, 0x10286901c                           ; <+76>
+44   adrp    x8, 156
+48   ldrsw   x8, [x8, #0x960]                           ; ivar 208
+52   ldr     x0, [x19, x8]
+56   cbz     x0, 0x10286901c                            ; <+76>
+60   bl      0x1028b7800                                ; objc_msgSend$invalidate
+64   mov     x0, x19
+68   mov     x2, #0x0                                   ; =0
+72   bl      0x1028bae20                                ; objc_msgSend$setBatteryExpansionTimer:
+76   mov     x0, x19
+80   bl      0x1028b5f60                                ; objc_msgSend$expanded
+84   cbz     w0, 0x102869094                            ; <+196>
+88   mov     x0, x19
+92   bl      0x1028b9220                                ; objc_msgSend$pillRegionCoordinator
+96   bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+100  mov     x21, x0
+104  bl      0x1028b91c0                                ; objc_msgSend$pillIconPlacement
+108  bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+112  mov     x22, x0
+116  mov     w2, #0x1                                   ; =1
+120  bl      0x1028bbbe0                                ; objc_msgSend$setEnabled:
+124  bl      0x1028c1170                                ; symbol stub for: objc_release_x22
+128  bl      0x1028c1164                                ; symbol stub for: objc_release_x21
+132  adrp    x8, 152
+136  ldr     x0, [x8, #0xa60]
+140  adrp    x8, 153
+144  ldr     x8, [x8, #0x400]
+148  str     x8, [sp, #0x18]
+152  adrp    x8, 58
+156  ldr     d0, [x8, #0x7c8]
+160  str     d0, [sp, #0x20]
+164  adrp    x8, 0
+168  add     x8, x8, #0xe0                              ; __49-[STUIStatusBarVisualProvider_Split setExpanded:]_block_invoke
+172  adrp    x9, 119
+176  add     x9, x9, #0x230                             ; __block_descriptor_40_e8_32s_e5_v8?0ls32l8
+180  stp     x8, x9, [sp, #0x28]
+184  str     x19, [sp, #0x38]
+188  add     x2, sp, #0x18
+192  bl      0x1028b90a0                                ; objc_msgSend$performWithoutAnimation:
+196  adrp    x8, 151
+200  ldr     x8, [x8, #0x9e8]                           ; Class STUIStatusBarVisualProvider_Split
+204  stp     x19, x8, [sp, #0x8]
+208  adrp    x8, 149
+212  ldr     x1, [x8, #0x678]
+216  add     x0, sp, #0x8
+220  mov     x2, x20
+224  bl      0x1028c10e0                                ; symbol stub for: objc_msgSendSuper2
+228  mov     x0, x19
+232  bl      0x1028b9220                                ; objc_msgSend$pillRegionCoordinator
+236  bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+240  mov     x19, x0
+244  bl      0x1028bfc40                                ; objc_msgSend$updatePill
+248  bl      0x1028c1140                                ; symbol stub for: objc_release_x19
+252  ldp     x29, x30, [sp, #0x60]
+256  ldp     x20, x19, [sp, #0x50]
+260  ldp     x22, x21, [sp, #0x40]
+264  add     sp, sp, #0x70
+268  ret

### -[STUIStatusBarVisualProvider_DynamicSplitMediumSmallIsland normalIconScale]  (3 条)
+0    adrp    x8, 120
+4    ldr     d0, [x8, #0xec0]                           ; = 1.18
+8    ret

### -[STUIStatusBarVisualProvider_DynamicSplitMediumSmallIsland itemSpacing]  (2 条)
+0    fmov    d0, #9.00000000
+4    ret

### -[STUIStatusBarVisualProvider_DynamicSplitMediumSmallIsland itemCreated:]  (43 条)
+0    sub     sp, sp, #0x40
+4    stp     x22, x21, [sp, #0x10]
+8    stp     x20, x19, [sp, #0x20]
+12   stp     x29, x30, [sp, #0x30]
+16   add     x29, sp, #0x30
+20   mov     x20, x0
+24   bl      0x1028c123c                                ; symbol stub for: objc_retain_x2
+28   mov     x19, x0
+32   adrp    x8, 213
+36   ldr     x8, [x8, #0x7a8]                           ; Class STUIStatusBarVisualProvider_DynamicSplitMediumSmallIsland
+40   stp     x20, x8, [sp]
+44   adrp    x8, 210
+48   ldr     x1, [x8, #0x640]
+52   mov     x0, sp
+56   mov     x2, x19
+60   bl      0x1028c10e0                                ; symbol stub for: objc_msgSendSuper2
+64   mov     x0, x19
+68   bl      0x1028b6d40                                ; objc_msgSend$identifier
+72   bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+76   mov     x20, x0
+80   adrp    x8, 214
+84   ldr     x0, [x8, #0x3c0]                           ; Class STUIStatusBarBatteryItem
+88   bl      0x1028b6d40                                ; objc_msgSend$identifier
+92   bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+96   mov     x21, x0
+100  bl      0x1028c1164                                ; symbol stub for: objc_release_x21
+104  bl      0x1028c1158                                ; symbol stub for: objc_release_x20
+108  cmp     x20, x21
+112  b.ne    0x10282ba10                                ; <+148>
+116  bl      0x1028c1230                                ; symbol stub for: objc_retain_x19
+120  mov     x20, x0
+124  mov     w2, #0x0                                   ; =0
+128  bl      0x1028ba7c0                                ; objc_msgSend$setAdjustBaselineInNonExpandedModes:
+132  mov     x0, x20
+136  mov     w2, #0x1                                   ; =1
+140  bl      0x1028ba7e0                                ; objc_msgSend$setAdjustsBaselineForCondensedPercentageDisplay:
+144  bl      0x1028c1158                                ; symbol stub for: objc_release_x20
+148  bl      0x1028c1140                                ; symbol stub for: objc_release_x19
+152  ldp     x29, x30, [sp, #0x30]
+156  ldp     x20, x19, [sp, #0x20]
+160  ldp     x22, x21, [sp, #0x10]
+164  add     sp, sp, #0x40
+168  ret

; Resolved by runtime IMP: ___lldb_unnamed_symbol_908d0

### -[STUIStatusBarWifiSignalIconView _updateImage]  (13 条)
+0    sub     sp, sp, #0x30
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   bl      0x1028c11dc                                ; symbol stub for: objc_retain
+20   str     x0, [sp, #0x8]
+24   mov     x20, x0
+28   bl      0x102890480                                ; ___lldb_unnamed_symbol_90480
+32   ldr     x0, [sp, #0x8]
+36   ldp     x29, x30, [sp, #0x20]
+40   ldp     x20, x19, [sp, #0x10]
+44   add     sp, sp, #0x30
+48   b       0x1028c1128                                ; symbol stub for: objc_release

; Resolved by runtime IMP: ___lldb_unnamed_symbol_90a8c

### +[STUIStatusBarWifiSignalIconView _totalWidthFor:]  (2 条)
+0    mov     x0, x2
+4    b       0x102890c2c                                ; ___lldb_unnamed_symbol_90c2c

; Resolved by runtime IMP: ___lldb_unnamed_symbol_90a94

### +[STUIStatusBarWifiSignalIconView _totalHeightFor:]  (2 条)
+0    mov     x0, x2
+4    b       0x102890c4c                                ; ___lldb_unnamed_symbol_90c4c

; Resolved by runtime IMP: ___lldb_unnamed_symbol_90a9c

### +[STUIStatusBarWifiSignalIconView _pointSizeFor:]  (2 条)
+0    mov     x0, x2
+4    b       0x102890c6c                                ; ___lldb_unnamed_symbol_90c6c

; Resolved by runtime IMP: ___lldb_unnamed_symbol_90aa4

### +[STUIStatusBarWifiSignalIconView _weightFor:]  (9 条)
+0    sub     x8, x2, #0x1
+4    cmp     x8, #0xf
+8    b.hi    0x102890ac0                                ; <+28>
+12   adrp    x9, 18
+16   add     x9, x9, #0xc88                             ; __swift_reflection_version
+20   ldr     x0, [x9, x8, lsl #3]
+24   ret
+28   mov     w0, #0x8                                   ; =8
+32   ret

; Resolved by runtime IMP: ___lldb_unnamed_symbol_90ac8

### +[STUIStatusBarWifiSignalIconView _verticalOffsetFor:]  (8 条)
+0    sub     x8, x2, #0x1
+4    movi.2d v0, #0000000000000000
+8    cmp     x8, #0x12
+12   b.hi    0x102890ae4                                ; <+28>
+16   adrp    x9, 18
+20   add     x9, x9, #0xd08                             ; __swift_reflection_version
+24   ldr     d0, [x9, x8, lsl #3]
+28   ret

### -[STUIStatusBarCellularSignalView layoutSubviews]  (120 条)
+0    sub     sp, sp, #0x80
+4    stp     d15, d14, [sp, #0x10]
+8    stp     d13, d12, [sp, #0x20]
+12   stp     d11, d10, [sp, #0x30]
+16   stp     d9, d8, [sp, #0x40]
+20   stp     x22, x21, [sp, #0x50]
+24   stp     x20, x19, [sp, #0x60]
+28   stp     x29, x30, [sp, #0x70]
+32   add     x29, sp, #0x70
+36   mov     x19, x0
+40   bl      0x1028b7e80                                ; objc_msgSend$layer
+44   bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+48   str     x0, [sp]
+52   bl      0x1028bf020                                ; objc_msgSend$sublayers
+56   bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+60   mov     x20, x0
+64   mov     x0, x19
+68   bl      0x1028b3a80                                ; objc_msgSend$bounds
+72   mov.16b v8, v0
+76   mov.16b v9, v1
+80   mov.16b v10, v2
+84   mov.16b v11, v3
+88   mov     x0, x19
+92   bl      0x1028c10ec                                ; symbol stub for: objc_opt_class
+96   mov     x21, x0
+100  mov     x0, x19
+104  bl      0x1028b6ce0                                ; objc_msgSend$iconSize
+108  mov     x2, x0
+112  mov     x0, x21
+116  bl      0x1028af7a0                                ; objc_msgSend$_barWidthForIconSize:
+120  mov.16b v12, v0
+124  mov     x0, x19
+128  bl      0x1028c10ec                                ; symbol stub for: objc_opt_class
+132  mov     x21, x0
+136  mov     x0, x19
+140  bl      0x1028b6ce0                                ; objc_msgSend$iconSize
+144  mov     x2, x0
+148  mov     x0, x21
+152  bl      0x1028b0960                                ; objc_msgSend$_interspaceForIconSize:
+156  mov.16b v14, v0
+160  mov     x0, x19
+164  bl      0x1028c10ec                                ; symbol stub for: objc_opt_class
+168  mov     x21, x0
+172  mov     x0, x19
+176  bl      0x1028b6ce0                                ; objc_msgSend$iconSize
+180  mov     x2, x0
+184  mov     x0, x21
+188  bl      0x1028b1e80                                ; objc_msgSend$_verticalOffsetForIconSize:
+192  str     d0, [sp, #0x8]
+196  mov     x0, x19
+200  bl      0x1028b8ae0                                ; objc_msgSend$numberOfBars
+204  cmp     x0, #0x1
+208  b.lt    0x102834cf0                                ; <+388>
+212  mov     x21, #0x0                                  ; =0
+216  fadd    d13, d12, d14
+220  mov     x0, x20
+224  mov     x2, x21
+228  bl      0x1028b8c00                                ; objc_msgSend$objectAtIndexedSubscript:
+232  bl      0x1028c1080                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+236  mov     x22, x0
+240  mov     x0, x19
+244  mov     x2, x21
+248  bl      0x1028b07c0                                ; objc_msgSend$_heightForBarAtIndex:
+252  mov.16b v14, v0
+256  mov     x0, x19
+260  bl      0x1028b12a0                                ; objc_msgSend$_shouldReverseLayoutDirection
+264  cbz     w0, 0x102834c9c                            ; <+304>
+268  mov.16b v0, v8
+272  mov.16b v1, v9
+276  mov.16b v2, v10
+280  mov.16b v3, v11
+284  bl      0x1028c0c6c                                ; symbol stub for: CGRectGetWidth
+288  fsub    d0, d0, d12
+292  ucvtf   d1, x21
+296  fmsub   d15, d1, d13, d0
+300  b       0x102834ca4                                ; <+312>
+304  ucvtf   d0, x21
+308  fmul    d15, d13, d0
+312  mov.16b v0, v8
+316  mov.16b v1, v9
+320  mov.16b v2, v10
+324  mov.16b v3, v11
+328  bl      0x1028c0c18                                ; symbol stub for: CGRectGetHeight
+332  fsub    d0, d0, d14
+336  ldr     d1, [sp, #0x8]
+340  fadd    d1, d1, d0
+344  mov     x0, x22
+348  mov.16b v0, v15
+352  mov.16b v2, v12
+356  mov.16b v3, v14
+360  bl      0x1028bbfa0                                ; objc_msgSend$setFrame:
+364  bl      0x1028c1170                                ; symbol stub for: objc_release_x22
+368  add     x21, x21, #0x1
+372  mov     x0, x19
+376  bl      0x1028b8ae0                                ; objc_msgSend$numberOfBars
+380  cmp     x21, x0
+384  b.lt    0x102834c48                                ; <+220>
+388  mov     x0, x19
+392  bl      0x1028b17a0                                ; objc_msgSend$_updateActiveBars
+396  mov     x0, x19
+400  bl      0x1028be720                                ; objc_msgSend$signalMode
+404  cmp     x0, #0x1
+408  b.ne    0x102834d20                                ; <+436>
+412  mov     x0, x19
+416  bl      0x1028b1920                                ; objc_msgSend$_updateCycleAnimationIfNeeded
+420  adrp    x8, 208
+424  ldrsw   x8, [x8, #0x6fc]                           ; ivar 488
+428  ldr     x0, [x19, x8]
+432  bl      0x1028be980                                ; objc_msgSend$start
+436  bl      0x1028c1158                                ; symbol stub for: objc_release_x20
+440  ldr     x0, [sp]
+444  ldp     x29, x30, [sp, #0x70]
+448  ldp     x20, x19, [sp, #0x60]
+452  ldp     x22, x21, [sp, #0x50]
+456  ldp     d9, d8, [sp, #0x40]
+460  ldp     d11, d10, [sp, #0x30]
+464  ldp     d13, d12, [sp, #0x20]
+468  ldp     d15, d14, [sp, #0x10]
+472  add     sp, sp, #0x80
+476  b       0x1028c1128                                ; symbol stub for: objc_release

### +[STUIStatusBarCellularSignalView _barCornerRadiusForIconSize:]  (27 条)
+0    stp     x20, x19, [sp, #-0x20]!
+4    stp     x29, x30, [sp, #0x10]
+8    add     x29, sp, #0x10
+12   mov     x19, x2
+16   adrp    x0, 117
+20   add     x0, x0, #0x2e4                             ; .str
+24   adrp    x1, 117
+28   add     x1, x1, #0x2f3                             ; .str
+32   bl      0x1028c0f00                                ; symbol stub for: _os_feature_enabled_impl
+36   cbz     w0, 0x102834234                            ; <+60>
+40   cmp     x19, #0x14
+44   b.hs    0x102834250                                ; <+88>
+48   adrp    x8, 112
+52   add     x8, x8, #0x38                              ; class metadata base offset for SystemStatusUI.STUIStatusBarDataOverridesViewController
+56   b       0x102834248                                ; <+80>
+60   fmov    d0, #1.00000000
+64   cmp     x19, #0x12
+68   b.hs    0x102834258                                ; <+96>
+72   adrp    x8, 112
+76   add     x8, x8, #0xd8                              ; class metadata base offset for SystemStatusUI.STUIStatusBarDataOverridesViewController
+80   ldr     d0, [x8, x19, lsl #3]
+84   b       0x102834258                                ; <+96>
+88   adrp    x8, 111
+92   ldr     d0, [x8, #0xfd8]                           ; = 1.4
+96   ldp     x29, x30, [sp, #0x10]
+100  ldp     x20, x19, [sp], #0x20
+104  ret

### +[STUIStatusBarCellularSignalView _verticalOffsetForIconSize:]  (9 条)
+0    cmp     x2, #0x8
+4    movi.2d v0, #0000000000000000
+8    fmov    d1, #1.00000000
+12   fcsel   d0, d1, d0, eq
+16   cmp     x2, #0xa
+20   adrp    x8, 111
+24   ldr     d1, [x8, #0xfe0]                           ; = 1.3333333333333333
+28   fcsel   d0, d1, d0, eq
+32   ret

; Following exact branch targets from the thunks above.
ivars: 0

### Swift implementation reached from -[STUIStatusBarWifiSignalIconView _updateImage]  (276 条)
+0    stp     d9, d8, [sp, #-0x70]!
+4    stp     x28, x27, [sp, #0x10]
+8    stp     x26, x25, [sp, #0x20]
+12   stp     x24, x23, [sp, #0x30]
+16   stp     x22, x21, [sp, #0x40]
+20   stp     x20, x19, [sp, #0x50]
+24   stp     x29, x30, [sp, #0x60]
+28   add     x29, sp, #0x60
+32   sub     sp, sp, #0x50
+36   mov     x0, x20
+40   bl      0x1028c1464                                ; symbol stub for: swift_getObjectType
+44   mov     x19, x0
+48   mov     x0, #0x0                                   ; =0
+52   bl      0x1028c0930
+56   stur    x0, [x29, #-0x78]
+60   ldur    x8, [x0, #-0x8]
+64   stur    x8, [x29, #-0x88]
+68   ldr     x8, [x8, #0x40]
+72   mov     x9, sp
+76   add     x8, x8, #0xf
+80   and     x8, x8, #0xfffffffffffffff0
+84   sub     x8, x9, x8
+88   stur    x8, [x29, #-0x90]
+92   mov     sp, x8
+96   mov     x0, #0x0                                   ; =0
+100  bl      0x1028c0954
+104  ldur    x8, [x0, #-0x8]
+108  stp     x8, x0, [x29, #-0x70]
+112  ldr     x8, [x8, #0x40]
+116  mov     x9, sp
+120  add     x8, x8, #0xf
+124  and     x8, x8, #0xfffffffffffffff0
+128  sub     x21, x9, x8
+132  mov     sp, x21
+136  mov     x0, #0x0                                   ; =0
+140  bl      0x1028c0990
+144  mov     x22, x0
+148  ldur    x8, [x0, #-0x8]
+152  stur    x8, [x29, #-0xa0]
+156  ldr     x8, [x8, #0x40]
+160  mov     x9, sp
+164  add     x8, x8, #0xf
+168  and     x8, x8, #0xfffffffffffffff0
+172  sub     x9, x9, x8
+176  stur    x9, [x29, #-0x80]
+180  mov     sp, x9
+184  mov     x9, sp
+188  sub     x9, x9, x8
+192  stur    x9, [x29, #-0x98]
+196  mov     sp, x9
+200  mov     x9, sp
+204  sub     x9, x9, x8
+208  stur    x9, [x29, #-0xa8]
+212  mov     sp, x9
+216  mov     x9, sp
+220  sub     x8, x9, x8
+224  stur    x8, [x29, #-0xb0]
+228  mov     sp, x8
+232  mov     x0, x20
+236  bl      0x1028be720                                ; objc_msgSend$signalMode
+240  cbz     x0, 0x10289059c                            ; <+284>
+244  mov     x0, x20
+248  bl      0x1028b20a0                                ; objc_msgSend$activeColor
+252  mov     x29, x29
+256  bl      0x1028c1200                                ; symbol stub for: objc_retainAutoreleasedReturnValue
+260  cbnz    x0, 0x1028905c8                            ; <+328>
+264  adrp    x8, 113
+268  ldr     x0, [x8, #0x960]
+272  bl      0x1028c111c                                ; symbol stub for: objc_opt_self
+276  bl      0x1028b7e20                                ; objc_msgSend$labelColor
+280  b       0x1028905c0                                ; <+320>
+284  mov     x0, x20
+288  bl      0x1028b7060                                ; objc_msgSend$inactiveColor
+292  mov     x29, x29
+296  bl      0x1028c1200                                ; symbol stub for: objc_retainAutoreleasedReturnValue
+300  cbnz    x0, 0x1028905c8                            ; <+328>
+304  adrp    x8, 113
+308  ldr     x0, [x8, #0x960]
+312  bl      0x1028c111c                                ; symbol stub for: objc_opt_self
+316  bl      0x1028bf4e0                                ; objc_msgSend$tertiaryLabelColor
+320  mov     x29, x29
+324  bl      0x1028c1200                                ; symbol stub for: objc_retainAutoreleasedReturnValue
+328  mov     x28, x0
+332  mov     x0, x20
+336  bl      0x1028be720                                ; objc_msgSend$signalMode
+340  fmov    d8, #1.00000000
+344  cmp     x0, #0x2
+348  b.ne    0x1028905fc                                ; <+380>
+352  mov     x0, x20
+356  bl      0x1028b8ac0                                ; objc_msgSend$numberOfActiveBars
+360  scvtf   d8, x0
+364  mov     x0, x20
+368  bl      0x1028b8ae0                                ; objc_msgSend$numberOfBars
+372  scvtf   d0, x0
+376  fdiv    d8, d8, d0
+380  mov     x0, x19
+384  bl      0x1028c144c                                ; symbol stub for: swift_getObjCClassFromMetadata
+388  mov     x24, x0
+392  mov     x0, x20
+396  bl      0x1028b6ce0                                ; objc_msgSend$iconSize
+400  mov     x2, x0
+404  mov     x0, x24
+408  bl      0x1028b0d00                                ; objc_msgSend$_pointSizeFor:
+412  mov.16b v9, v0
+416  adrp    x8, 113
+420  ldr     x0, [x8, #0x998]
+424  bl      0x1028c111c                                ; symbol stub for: objc_opt_self
+428  mov     x19, x0
+432  mov.16b v0, v9
+436  bl      0x1028b4260                                ; objc_msgSend$configurationWithPointSize:
+440  mov     x29, x29
+444  bl      0x1028c1200                                ; symbol stub for: objc_retainAutoreleasedReturnValue
+448  mov     x25, x0
+452  mov     x0, x20
+456  bl      0x1028b6ce0                                ; objc_msgSend$iconSize
+460  mov     x2, x0
+464  mov     x0, x24
+468  bl      0x1028b1ee0                                ; objc_msgSend$_weightFor:
+472  mov     x2, x0
+476  mov     x0, x19
+480  bl      0x1028b42a0                                ; objc_msgSend$configurationWithWeight:
+484  mov     x29, x29
+488  bl      0x1028c1200                                ; symbol stub for: objc_retainAutoreleasedReturnValue
+492  mov     x26, x0
+496  mov     x0, x25
+500  mov     x2, x26
+504  bl      0x1028b41e0                                ; objc_msgSend$configurationByApplyingConfiguration:
+508  mov     x29, x29
+512  bl      0x1028c1200                                ; symbol stub for: objc_retainAutoreleasedReturnValue
+516  mov     x27, x0
+520  bl      0x1028c1194                                ; symbol stub for: objc_release_x25
+524  bl      0x1028c11a0                                ; symbol stub for: objc_release_x26
+528  mov     x0, x19
+532  mov     x2, x28
+536  bl      0x1028b4220                                ; objc_msgSend$configurationWithHierarchicalColor:
+540  mov     x29, x29
+544  bl      0x1028c1200                                ; symbol stub for: objc_retainAutoreleasedReturnValue
+548  mov     x19, x0
+552  mov     x0, x27
+556  mov     x2, x19
+560  bl      0x1028b41e0                                ; objc_msgSend$configurationByApplyingConfiguration:
+564  mov     x29, x29
+568  bl      0x1028c1200                                ; symbol stub for: objc_retainAutoreleasedReturnValue
+572  mov     x25, x0
+576  bl      0x1028c11ac                                ; symbol stub for: objc_release_x27
+580  bl      0x1028c1140                                ; symbol stub for: objc_release_x19
+584  adrp    x8, 121
+588  ldr     x23, [x8, #0xf50]
+592  ldr     x8, [x20, x23]
+596  bl      0x1028c12d8                                ; symbol stub for: objc_retain_x8
+600  mov     x26, x0
+604  bl      0x1028c1284                                ; symbol stub for: objc_retain_x25
+608  mov     x19, x0
+612  mov     w0, #0x6977                                ; =26999
+616  movk    w0, #0x6966, lsl #16
+620  mov     x1, #-0x1c00000000000000                   ; =-2017612633061982208
+624  bl      0x1028c09cc
+628  mov     x25, x0
+632  adrp    x8, 113
+636  ldr     x0, [x8, #0x990]
+640  bl      0x1028c111c                                ; symbol stub for: objc_opt_self
+644  mov     x2, x25
+648  mov.16b v0, v8
+652  mov     x3, x19
+656  bl      0x1028b14e0                                ; objc_msgSend$_systemImageNamed:variableValue:withConfiguration:
+660  mov     x29, x29
+664  bl      0x1028c1200                                ; symbol stub for: objc_retainAutoreleasedReturnValue
+668  mov     x27, x0
+672  bl      0x1028c1140                                ; symbol stub for: objc_release_x19
+676  bl      0x1028c1194                                ; symbol stub for: objc_release_x25
+680  mov     x0, x26
+684  mov     x2, x27
+688  bl      0x1028bc1c0                                ; objc_msgSend$setImage:
+692  bl      0x1028c11a0                                ; symbol stub for: objc_release_x26
+696  bl      0x1028c11ac                                ; symbol stub for: objc_release_x27
+700  adrp    x8, 121
+704  ldr     x8, [x8, #0xf58]
+708  ldr     x8, [x20, x8]
+712  cbz     x8, 0x102890774                            ; <+756>
+716  bl      0x1028c12d8                                ; symbol stub for: objc_retain_x8
+720  mov     x25, x0
+724  mov     x0, x20
+728  bl      0x1028b6ce0                                ; objc_msgSend$iconSize
+732  mov     x2, x0
+736  mov     x0, x24
+740  bl      0x1028b1e40                                ; objc_msgSend$_verticalOffsetFor:
+744  mov     x0, x25
+748  bl      0x1028bb280                                ; objc_msgSend$setConstant:
+752  bl      0x1028c1194                                ; symbol stub for: objc_release_x25
+756  mov     x0, x20
+760  bl      0x1028be720                                ; objc_msgSend$signalMode
+764  mov     x25, x0
+768  ldr     x8, [x20, x23]
+772  bl      0x1028c12d8                                ; symbol stub for: objc_retain_x8
+776  mov     x24, x0
+780  cmp     x25, #0x1
+784  b.ne    0x102890878                                ; <+1016>
+788  ldur    x20, [x29, #-0xb0]
+792  mov     x8, x20
+796  bl      0x1028c0984
+800  ldur    x25, [x29, #-0xa8]
+804  mov     x8, x25
+808  bl      0x1028c0978
+812  ldur    x8, [x29, #-0xa0]
+816  ldr     x23, [x8, #0x8]
+820  mov     x0, x20
+824  mov     x1, x22
+828  blr     x23
+832  ldur    x26, [x29, #-0x98]
+836  mov     x8, x26
+840  mov     x20, x25
+844  bl      0x1028c096c
+848  mov     x0, x25
+852  mov     x1, x22
+856  blr     x23
+860  ldur    x25, [x29, #-0x80]
+864  mov     x8, x25
+868  mov     x20, x26
+872  bl      0x1028c0960
+876  mov     x0, x26
+880  mov     x1, x22
+884  blr     x23
+888  ldur    x20, [x29, #-0x90]
+892  mov     x8, x20
+896  bl      0x1028c0924
+900  mov     x8, x21
+904  mov     x0, x20
+908  bl      0x1028c093c
+912  ldur    x8, [x29, #-0x88]
+916  ldr     x8, [x8, #0x8]
+920  mov     x0, x20
+924  ldur    x1, [x29, #-0x78]
+928  blr     x8
+932  bl      0x102890ba8                                ; ___lldb_unnamed_symbol_90ba8
+936  mov     x6, x0
+940  mov     x0, x25
+944  mov     x1, x21
+948  mov     w2, #0x1                                   ; =1
+952  mov     x3, #0x0                                   ; =0
+956  mov     x4, #0x0                                   ; =0
+960  mov     x5, x22
+964  mov     x20, x24
+968  bl      0x1028c0a2c
+972  bl      0x1028c1140                                ; symbol stub for: objc_release_x19
+976  bl      0x1028c11b8                                ; symbol stub for: objc_release_x28
+980  bl      0x1028c1188                                ; symbol stub for: objc_release_x24
+984  ldp     x8, x1, [x29, #-0x70]
+988  ldr     x8, [x8, #0x8]
+992  mov     x0, x21
+996  blr     x8
+1000 mov     x0, x25
+1004 mov     x1, x22
+1008 blr     x23
+1012 b       0x1028908ac                                ; <+1068>
+1016 mov     x8, x21
+1020 bl      0x1028c0948
+1024 mov     x0, x21
+1028 mov     w1, #0x1                                   ; =1
+1032 mov     x20, x24
+1036 bl      0x1028c0a38
+1040 bl      0x1028c1140                                ; symbol stub for: objc_release_x19
+1044 bl      0x1028c1188                                ; symbol stub for: objc_release_x24
+1048 bl      0x1028c11b8                                ; symbol stub for: objc_release_x28
+1052 ldp     x8, x1, [x29, #-0x70]
+1056 ldr     x8, [x8, #0x8]
+1060 mov     x0, x21
+1064 blr     x8
+1068 sub     sp, x29, #0x60
+1072 ldp     x29, x30, [sp, #0x60]
+1076 ldp     x20, x19, [sp, #0x50]
+1080 ldp     x22, x21, [sp, #0x40]
+1084 ldp     x24, x23, [sp, #0x30]
+1088 ldp     x26, x25, [sp, #0x20]
+1092 ldp     x28, x27, [sp, #0x10]
+1096 ldp     d9, d8, [sp], #0x70
+1100 ret

### Swift implementation reached from +[STUIStatusBarWifiSignalIconView _totalWidthFor:]  (8 条)
+0    sub     x8, x0, #0x1
+4    movi.2d v0, #0000000000000000
+8    cmp     x8, #0x12
+12   b.hi    0x102890c48                                ; <+28>
+16   adrp    x9, 18
+20   add     x9, x9, #0xda0                             ; __swift_reflection_version
+24   ldr     d0, [x9, x8, lsl #3]
+28   ret

### Swift implementation reached from +[STUIStatusBarWifiSignalIconView _totalHeightFor:]  (8 条)
+0    sub     x8, x0, #0x1
+4    movi.2d v0, #0000000000000000
+8    cmp     x8, #0x12
+12   b.hi    0x102890c68                                ; <+28>
+16   adrp    x9, 18
+20   add     x9, x9, #0xe38                             ; __swift_reflection_version
+24   ldr     d0, [x9, x8, lsl #3]
+28   ret

### Swift implementation reached from +[STUIStatusBarWifiSignalIconView _pointSizeFor:]  (8 条)
+0    sub     x8, x0, #0x1
+4    movi.2d v0, #0000000000000000
+8    cmp     x8, #0x12
+12   b.hi    0x102890c88                                ; <+28>
+16   adrp    x9, 18
+20   add     x9, x9, #0xed0                             ; __swift_reflection_version
+24   ldr     d0, [x9, x8, lsl #3]
+28   ret
