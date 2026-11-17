; iOS 17.4 (21E213) arm64 Simulator, SystemStatusUI; 2026-11-17
; Annotated disassembly; addresses are session-specific, not stable ABI.
ivars: 26

### -[STUIStatusBarSignalView applyStyleAttributes:]  (44 条)
+0    stp     x22, x21, [sp, #-0x30]!
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   mov     x19, x0
+20   bl      0x20247c0c0                                ; symbol stub for: objc_retain_x2
+24   mov     x22, x0
+28   bl      0x2024b31e0                                ; objc_msgSend$isRounded
+32   mov     x20, x0
+36   mov     x0, x22
+40   bl      0x2024b2400                                ; objc_msgSend$iconSize
+44   mov     x21, x0
+48   bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+52   adrp    x8, 47110
+56   ldrsw   x8, [x8, #0xc8]                            ; ivar _iconSize
+60   ldr     x8, [x19, x8]
+64   cmp     x8, x21
+68   b.ne    0x20241c2f4                                ; <+132>
+72   adrp    x8, 47110
+76   ldrsw   x8, [x8, #0xcc]                            ; ivar _rounded
+80   ldrb    w22, [x19, x8]
+84   mov     x0, x19
+88   mov     x2, x20
+92   bl      0x2024b8440                                ; objc_msgSend$setRounded:
+96   mov     x0, x19
+100  mov     x2, x21
+104  bl      0x2024b73e0                                ; objc_msgSend$setIconSize:
+108  cmp     w22, w20
+112  b.ne    0x20241c30c                                ; <+156>
+116  ldp     x29, x30, [sp, #0x20]
+120  ldp     x20, x19, [sp, #0x10]
+124  ldp     x22, x21, [sp], #0x30
+128  ret
+132  mov     x0, x19
+136  mov     x2, x20
+140  bl      0x2024b8440                                ; objc_msgSend$setRounded:
+144  mov     x0, x19
+148  mov     x2, x21
+152  bl      0x2024b73e0                                ; objc_msgSend$setIconSize:
+156  mov     x0, x19
+160  ldp     x29, x30, [sp, #0x20]
+164  ldp     x20, x19, [sp, #0x10]
+168  ldp     x22, x21, [sp], #0x30
+172  b       0x2024ac9a0                                ; objc_msgSend$_iconSizeDidChange

### -[STUIStatusBarStyleAttributes isRounded]  (20 条)
+0    stp     x20, x19, [sp, #-0x20]!
+4    stp     x29, x30, [sp, #0x10]
+8    add     x29, sp, #0x10
+12   bl      0x2024b1d00                                ; objc_msgSend$font
+16   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+20   mov     x19, x0
+24   bl      0x20247bc10                                ; symbol stub for: CTFontGetUIFontDesign
+28   mov     x20, x0
+32   bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+36   adrp    x8, 51478
+40   ldr     x8, [x8, #0x110]
+44   ldr     x2, [x8]
+48   mov     x0, x20
+52   bl      0x2024b3080                                ; objc_msgSend$isEqualToString:
+56   mov     x19, x0
+60   bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+64   mov     x0, x19
+68   ldp     x29, x30, [sp, #0x10]
+72   ldp     x20, x19, [sp], #0x20
+76   ret

### -[STUIStatusBarCellularSignalView _updateBars]  (95 条)
+0    sub     sp, sp, #0x70
+4    stp     d9, d8, [sp, #0x10]
+8    stp     x26, x25, [sp, #0x20]
+12   stp     x24, x23, [sp, #0x30]
+16   stp     x22, x21, [sp, #0x40]
+20   stp     x20, x19, [sp, #0x50]
+24   stp     x29, x30, [sp, #0x60]
+28   add     x29, sp, #0x60
+32   mov     x19, x0
+36   bl      0x2024b2400                                ; objc_msgSend$iconSize
+40   cbz     x0, 0x20243b458                            ; <+348>
+44   adrp    x8, 51557
+48   ldr     x8, [x8, #0xf50]
+52   stp     x19, x8, [sp]
+56   adrp    x8, -138303
+60   add     x1, x8, #0x3c8
+64   mov     x0, sp
+68   bl      0x20247bf70                                ; symbol stub for: objc_msgSendSuper2
+72   mov     x0, x19
+76   bl      0x2024b5660                                ; objc_msgSend$rounded
+80   mov     x21, x0
+84   mov     x0, x19
+88   bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+92   mov     x20, x0
+96   mov     x0, x19
+100  bl      0x2024b2400                                ; objc_msgSend$iconSize
+104  mov     x2, x0
+108  mov     x0, x20
+112  cbz     w21, 0x20243b380                           ; <+132>
+116  bl      0x2024abac0                                ; objc_msgSend$_barWidthForIconSize:
+120  fmov    d1, #0.50000000
+124  fmul    d8, d0, d1
+128  b       0x20243b388                                ; <+140>
+132  bl      0x2024aba60                                ; objc_msgSend$_barCornerRadiusForIconSize:
+136  fmov    d8, d0
+140  mov     x0, x19
+144  bl      0x2024b4140                                ; objc_msgSend$numberOfBars
+148  cmp     x0, #0x1
+152  b.lt    0x20243b450                                ; <+340>
+156  mov     x24, #0x0                                  ; =0
+160  adrp    x8, 51527
+164  ldr     x8, [x8, #0x98]
+168  ldr     x20, [x8]
+172  adrp    x8, 51527
+176  ldr     x8, [x8, #0xe0]
+180  ldr     x21, [x8]
+184  adrp    x25, 51557
+188  ldr     x0, [x25, #0xa80]
+192  bl      0x2024b3560                                ; objc_msgSend$layer
+196  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+200  mov     x22, x0
+204  fmov    d0, #0.50000000
+208  fmov    d1, #1.00000000
+212  bl      0x2024b5e40                                ; objc_msgSend$setAnchorPoint:
+216  mov     x0, x22
+220  mov     x2, x20
+224  bl      0x2024b6780                                ; objc_msgSend$setCornerCurve:
+228  mov     x0, x22
+232  fmov    d0, d8
+236  bl      0x2024b67a0                                ; objc_msgSend$setCornerRadius:
+240  mov     x0, x19
+244  bl      0x2024b3f60                                ; objc_msgSend$needsLargerScale
+248  cbz     w0, 0x20243b41c                            ; <+288>
+252  mov     x0, x22
+256  mov     x2, x21
+260  bl      0x2024b7a40                                ; objc_msgSend$setMinificationFilter:
+264  fmov    d0, #5.00000000
+268  mov     x0, x22
+272  bl      0x2024b8240                                ; objc_msgSend$setRasterizationScale:
+276  mov     x0, x22
+280  mov     w2, #0x1                                   ; =1
+284  bl      0x2024b8600                                ; objc_msgSend$setShouldRasterize:
+288  mov     x0, x19
+292  bl      0x2024b3560                                ; objc_msgSend$layer
+296  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+300  mov     x23, x0
+304  mov     x2, x22
+308  bl      0x2024ae380                                ; objc_msgSend$addSublayer:
+312  bl      0x20247c000                                ; symbol stub for: objc_release_x23
+316  bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+320  add     x24, x24, #0x1
+324  mov     x0, x19
+328  bl      0x2024b4140                                ; objc_msgSend$numberOfBars
+332  cmp     x24, x0
+336  b.lt    0x20243b3b8                                ; <+188>
+340  mov     x0, x19
+344  bl      0x2024ad1a0                                ; objc_msgSend$_setNeedsUpdateCycleAnimation
+348  ldp     x29, x30, [sp, #0x60]
+352  ldp     x20, x19, [sp, #0x50]
+356  ldp     x22, x21, [sp, #0x40]
+360  ldp     x24, x23, [sp, #0x30]
+364  ldp     x26, x25, [sp, #0x20]
+368  ldp     d9, d8, [sp, #0x10]
+372  add     sp, sp, #0x70
+376  ret

### -[STUIStatusBarCellularSignalView layoutSubviews]  (109 条)
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
+40   bl      0x2024b3560                                ; objc_msgSend$layer
+44   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+48   str     x0, [sp, #0x8]
+52   bl      0x2024b9dc0                                ; objc_msgSend$sublayers
+56   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+60   mov     x20, x0
+64   mov     x0, x19
+68   bl      0x2024af880                                ; objc_msgSend$bounds
+72   fmov    d8, d0
+76   fmov    d9, d1
+80   fmov    d10, d2
+84   fmov    d11, d3
+88   mov     x0, x19
+92   bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+96   mov     x21, x0
+100  mov     x0, x19
+104  bl      0x2024b2400                                ; objc_msgSend$iconSize
+108  mov     x2, x0
+112  mov     x0, x21
+116  bl      0x2024abac0                                ; objc_msgSend$_barWidthForIconSize:
+120  fmov    d12, d0
+124  mov     x0, x19
+128  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+132  mov     x21, x0
+136  mov     x0, x19
+140  bl      0x2024b2400                                ; objc_msgSend$iconSize
+144  mov     x2, x0
+148  mov     x0, x21
+152  bl      0x2024acac0                                ; objc_msgSend$_interspaceForIconSize:
+156  fmov    d13, d0
+160  mov     x0, x19
+164  bl      0x2024b4140                                ; objc_msgSend$numberOfBars
+168  cmp     x0, #0x1
+172  b.lt    0x20243bd08                                ; <+344>
+176  mov     x21, #0x0                                  ; =0
+180  fadd    d15, d12, d13
+184  mov     x0, x20
+188  mov     x2, x21
+192  bl      0x2024b41e0                                ; objc_msgSend$objectAtIndexedSubscript:
+196  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+200  mov     x22, x0
+204  mov     x0, x19
+208  mov     x2, x21
+212  bl      0x2024ac900                                ; objc_msgSend$_heightForBarAtIndex:
+216  fmov    d13, d0
+220  mov     x0, x19
+224  bl      0x2024ad360                                ; objc_msgSend$_shouldReverseLayoutDirection
+228  cbz     w0, 0x20243bcbc                            ; <+268>
+232  fmov    d0, d8
+236  fmov    d1, d9
+240  fmov    d2, d10
+244  fmov    d3, d11
+248  bl      0x20247bbb0                                ; symbol stub for: CGRectGetWidth
+252  fsub    d0, d0, d12
+256  scvtf   d1, x21
+260  fmsub   d14, d1, d15, d0
+264  b       0x20243bcc4                                ; <+276>
+268  scvtf   d0, x21
+272  fmul    d14, d15, d0
+276  fmov    d0, d8
+280  fmov    d1, d9
+284  fmov    d2, d10
+288  fmov    d3, d11
+292  bl      0x20247bb5c                                ; symbol stub for: CGRectGetHeight
+296  fsub    d1, d0, d13
+300  mov     x0, x22
+304  fmov    d0, d14
+308  fmov    d2, d12
+312  fmov    d3, d13
+316  bl      0x2024b7220                                ; objc_msgSend$setFrame:
+320  bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+324  add     x21, x21, #0x1
+328  mov     x0, x19
+332  bl      0x2024b4140                                ; objc_msgSend$numberOfBars
+336  cmp     x21, x0
+340  b.lt    0x20243bc68                                ; <+184>
+344  mov     x0, x19
+348  bl      0x2024ad820                                ; objc_msgSend$_updateActiveBars
+352  mov     x0, x19
+356  bl      0x2024b9540                                ; objc_msgSend$signalMode
+360  cmp     x0, #0x1
+364  b.ne    0x20243bd38                                ; <+392>
+368  mov     x0, x19
+372  bl      0x2024ad960                                ; objc_msgSend$_updateCycleAnimationIfNeeded
+376  adrp    x8, 47079
+380  ldrsw   x8, [x8, #0x36c]                           ; ivar _cycleAnimation/_cycleAnimation
+384  ldr     x0, [x19, x8]
+388  bl      0x2024b9760                                ; objc_msgSend$start
+392  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+396  ldr     x0, [sp, #0x8]
+400  ldp     x29, x30, [sp, #0x70]
+404  ldp     x20, x19, [sp, #0x60]
+408  ldp     x22, x21, [sp, #0x50]
+412  ldp     d9, d8, [sp, #0x40]
+416  ldp     d11, d10, [sp, #0x30]
+420  ldp     d13, d12, [sp, #0x20]
+424  ldp     d15, d14, [sp, #0x10]
+428  add     sp, sp, #0x80
+432  b       0x20247bfb8                                ; symbol stub for: objc_release

### -[STUIStatusBarCellularSignalView _heightForBarAtIndex:mode:]  (36 条)
+0    stp     x22, x21, [sp, #-0x30]!
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   mov     x19, x0
+20   cmp     x3, #0x2
+24   b.hs    0x20243b020                                ; <+72>
+28   mov     x0, x19
+32   bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+36   mov     x20, x0
+40   mov     x0, x19
+44   bl      0x2024b2400                                ; objc_msgSend$iconSize
+48   mov     x2, x0
+52   mov     x0, x20
+56   ldp     x29, x30, [sp, #0x20]
+60   ldp     x20, x19, [sp, #0x10]
+64   ldp     x22, x21, [sp], #0x30
+68   b       0x2024abac0                                ; objc_msgSend$_barWidthForIconSize:
+72   b.ne    0x20243b058                                ; <+128>
+76   mov     x20, x2
+80   mov     x0, x19
+84   bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+88   mov     x21, x0
+92   mov     x0, x19
+96   bl      0x2024b2400                                ; objc_msgSend$iconSize
+100  mov     x3, x0
+104  mov     x0, x21
+108  mov     x2, x20
+112  ldp     x29, x30, [sp, #0x20]
+116  ldp     x20, x19, [sp, #0x10]
+120  ldp     x22, x21, [sp], #0x30
+124  b       0x2024ac940                                ; objc_msgSend$_heightForNormalBarAtIndex:iconSize:
+128  ldp     x29, x30, [sp, #0x20]
+132  ldp     x20, x19, [sp, #0x10]
+136  ldp     x22, x21, [sp], #0x30
+140  ret

### -[STUIStatusBarCellularSignalView _iconSizeDidChange]  (18 条)
+0    sub     sp, sp, #0x30
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   mov     x19, x0
+20   adrp    x8, 51557
+24   ldr     x8, [x8, #0xf50]
+28   stp     x0, x8, [sp]
+32   adrp    x8, -138435
+36   add     x1, x8, #0xbd3
+40   mov     x0, sp
+44   bl      0x20247bf70                                ; symbol stub for: objc_msgSendSuper2
+48   mov     x0, x19
+52   bl      0x2024ad1a0                                ; objc_msgSend$_setNeedsUpdateCycleAnimation
+56   ldp     x29, x30, [sp, #0x20]
+60   ldp     x20, x19, [sp, #0x10]
+64   add     sp, sp, #0x30
+68   ret

### -[STUIStatusBarWifiSignalView _updateBars]  (45 条)
+0    sub     sp, sp, #0x50
+4    stp     x24, x23, [sp, #0x10]
+8    stp     x22, x21, [sp, #0x20]
+12   stp     x20, x19, [sp, #0x30]
+16   stp     x29, x30, [sp, #0x40]
+20   add     x29, sp, #0x40
+24   mov     x19, x0
+28   adrp    x8, 51548
+32   ldr     x8, [x8, #0xfd0]
+36   stp     x0, x8, [sp]
+40   adrp    x8, -138312
+44   add     x1, x8, #0x3c8
+48   mov     x0, sp
+52   bl      0x20247bf70                                ; symbol stub for: objc_msgSendSuper2
+56   mov     x0, x19
+60   bl      0x2024b4140                                ; objc_msgSend$numberOfBars
+64   cmp     x0, #0x1
+68   b.lt    0x202444c0c                                ; <+148>
+72   mov     x22, #0x0                                  ; =0
+76   adrp    x23, 51548
+80   ldr     x0, [x23, #0xa80]
+84   bl      0x2024b3560                                ; objc_msgSend$layer
+88   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+92   mov     x20, x0
+96   mov     x0, x19
+100  bl      0x2024b3560                                ; objc_msgSend$layer
+104  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+108  mov     x21, x0
+112  mov     x2, x20
+116  bl      0x2024ae380                                ; objc_msgSend$addSublayer:
+120  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+124  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+128  add     x22, x22, #0x1
+132  mov     x0, x19
+136  bl      0x2024b4140                                ; objc_msgSend$numberOfBars
+140  cmp     x22, x0
+144  b.lt    0x202444bc8                                ; <+80>
+148  mov     x0, x19
+152  bl      0x2024ad1a0                                ; objc_msgSend$_setNeedsUpdateCycleAnimation
+156  ldp     x29, x30, [sp, #0x40]
+160  ldp     x20, x19, [sp, #0x30]
+164  ldp     x22, x21, [sp, #0x20]
+168  ldp     x24, x23, [sp, #0x10]
+172  add     sp, sp, #0x50
+176  ret

### -[STUIStatusBarWifiSignalView _barCornerRadius]  (11 条)
+0    stp     x29, x30, [sp, #-0x10]!
+4    mov     x29, sp
+8    bl      0x2024b2400                                ; objc_msgSend$iconSize
+12   fmov    d0, #0.50000000
+16   cmp     x0, #0x11
+20   b.hi    0x202444af0                                ; <+36>
+24   adrp    x8, 67
+28   add     x8, x8, #0x7a0                             ; STUIStatusBarActivityIconViewDefaultOuterArcAlpha
+32   ldr     d0, [x8, x0, lsl #3]
+36   ldp     x29, x30, [sp], #0x10
+40   ret

### -[STUIStatusBarWifiSignalView layoutSubviews]  (176 条)
+0    sub     sp, sp, #0xd0
+4    stp     d15, d14, [sp, #0x40]
+8    stp     d13, d12, [sp, #0x50]
+12   stp     d11, d10, [sp, #0x60]
+16   stp     d9, d8, [sp, #0x70]
+20   stp     x26, x25, [sp, #0x80]
+24   stp     x24, x23, [sp, #0x90]
+28   stp     x22, x21, [sp, #0xa0]
+32   stp     x20, x19, [sp, #0xb0]
+36   stp     x29, x30, [sp, #0xc0]
+40   add     x29, sp, #0xc0
+44   mov     x19, x0
+48   bl      0x2024b3560                                ; objc_msgSend$layer
+52   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+56   str     x0, [sp, #0x10]
+60   bl      0x2024b9dc0                                ; objc_msgSend$sublayers
+64   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+68   mov     x20, x0
+72   mov     x0, x19
+76   bl      0x2024aba40                                ; objc_msgSend$_barCornerRadius
+80   fmov    d8, d0
+84   mov     x0, x19
+88   bl      0x2024af880                                ; objc_msgSend$bounds
+92   fmov    d9, d0
+96   fmov    d14, d1
+100  fmov    d11, d2
+104  fmov    d12, d3
+108  mov     x0, x19
+112  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+116  mov     x21, x0
+120  mov     x0, x19
+124  bl      0x2024b2400                                ; objc_msgSend$iconSize
+128  mov     x2, x0
+132  mov     x0, x21
+136  bl      0x2024acac0                                ; objc_msgSend$_interspaceForIconSize:
+140  str     d0, [sp, #0x20]
+144  fmov    d0, d9
+148  fmov    d1, d14
+152  fmov    d2, d11
+156  fmov    d3, d12
+160  bl      0x20247bb80                                ; symbol stub for: CGRectGetMidX
+164  fmov    d10, d0
+168  fmov    d0, d9
+172  fmov    d1, d14
+176  fmov    d2, d11
+180  fmov    d3, d12
+184  bl      0x20247bb74                                ; symbol stub for: CGRectGetMaxY
+188  fmov    d15, d0
+192  mov     x0, x19
+196  bl      0x2024b5660                                ; objc_msgSend$rounded
+200  mov     x21, x0
+204  str     d9, [sp, #0x38]
+208  fmov    d0, d9
+212  fmov    d13, d14
+216  fmov    d1, d14
+220  fmov    d2, d11
+224  fmov    d3, d12
+228  bl      0x20247bb5c                                ; symbol stub for: CGRectGetHeight
+232  str     d10, [sp, #0x30]
+236  fdiv    d0, d10, d0
+240  bl      0x20247bdf0                                ; symbol stub for: acos
+244  fmov    d9, d0
+248  mov     x0, x19
+252  bl      0x2024ba520                                ; objc_msgSend$traitCollection
+256  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+260  mov     x22, x0
+264  cbz     x0, 0x202444d58                            ; <+300>
+268  mov     x0, x22
+272  bl      0x2024b0e20                                ; objc_msgSend$displayScale
+276  fcmp    d0, #0.0
+280  b.eq    0x202444d58                                ; <+300>
+284  mov     x0, x22
+288  bl      0x2024b0e20                                ; objc_msgSend$displayScale
+292  str     d0, [sp, #0x28]
+296  b       0x202444d74                                ; <+328>
+300  mov     x0, x19
+304  bl      0x2024ad0a0                                ; objc_msgSend$_screen
+308  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+312  mov     x23, x0
+316  bl      0x2024b5720                                ; objc_msgSend$scale
+320  str     d0, [sp, #0x28]
+324  bl      0x20247c000                                ; symbol stub for: objc_release_x23
+328  mov     x0, x19
+332  bl      0x2024b4140                                ; objc_msgSend$numberOfBars
+336  cbz     x0, 0x202444eac                            ; <+640>
+340  mov     x23, #0x0                                  ; =0
+344  fmov    d0, #-0.50000000
+348  fmul    d0, d8, d0
+352  ldr     d1, [sp, #0x20]
+356  fadd    d1, d8, d1
+360  fadd    d0, d15, d0
+364  stp     d0, d1, [sp, #0x18]
+368  movi    d15, #0000000000000000
+372  mov     x0, x20
+376  mov     x2, x23
+380  bl      0x2024b41e0                                ; objc_msgSend$objectAtIndexedSubscript:
+384  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+388  mov     x24, x0
+392  mov     x0, x19
+396  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+400  mov     x25, x0
+404  mov     x0, x19
+408  bl      0x2024b2400                                ; objc_msgSend$iconSize
+412  mov     x3, x0
+416  mov     x0, x25
+420  mov     x2, x23
+424  bl      0x2024abaa0                                ; objc_msgSend$_barThicknessAtIndex:iconSize:
+428  fsub    d10, d0, d8
+432  fmov    d14, d9
+436  cbz     w21, 0x202444e0c                           ; <+480>
+440  fmov    d0, #0.50000000
+444  fmul    d14, d10, d0
+448  ldr     d0, [sp, #0x38]
+452  fmov    d1, d13
+456  fmov    d2, d11
+460  fmov    d3, d12
+464  bl      0x20247bb5c                                ; symbol stub for: CGRectGetHeight
+468  fdiv    d0, d14, d0
+472  bl      0x20247bdfc                                ; symbol stub for: atan
+476  fadd    d14, d9, d0
+480  mov     x0, x19
+484  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+488  str     d10, [sp]
+492  fmov    d0, d11
+496  fmov    d1, d12
+500  ldp     d2, d5, [sp, #0x28]
+504  fmov    d3, d15
+508  fmov    d4, d14
+512  ldr     d6, [sp, #0x18]
+516  mov     x2, x21
+520  fmov    d7, d8
+524  bl      0x2024aba80                                ; objc_msgSend$_barImageWithSize:forScale:distance:angle:centerPoint:cornerRadius:thickness:rounded:
+528  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+532  bl      0x20247c06c                                ; symbol stub for: objc_retainAutorelease
+536  mov     x25, x0
+540  bl      0x2024ab5e0                                ; objc_msgSend$CGImage
+544  mov     x2, x0
+548  mov     x0, x24
+552  bl      0x2024b6740                                ; objc_msgSend$setContents:
+556  mov     x0, x19
+560  bl      0x2024af880                                ; objc_msgSend$bounds
+564  mov     x0, x24
+568  bl      0x2024b63a0                                ; objc_msgSend$setBounds:
+572  ldr     d0, [sp, #0x38]
+576  fmov    d1, d13
+580  fmov    d2, d11
+584  fmov    d3, d12
+588  bl      0x20247bce8                                ; symbol stub for: UIRectGetCenter
+592  mov     x0, x24
+596  bl      0x2024b8080                                ; objc_msgSend$setPosition:
+600  ldr     d0, [sp, #0x20]
+604  fadd    d0, d0, d10
+608  fadd    d15, d15, d0
+612  bl      0x20247c018                                ; symbol stub for: objc_release_x25
+616  bl      0x20247c00c                                ; symbol stub for: objc_release_x24
+620  add     x23, x23, #0x1
+624  mov     x0, x19
+628  bl      0x2024b4140                                ; objc_msgSend$numberOfBars
+632  cmp     x23, x0
+636  b.lo    0x202444da0                                ; <+372>
+640  mov     x0, x19
+644  bl      0x2024ad820                                ; objc_msgSend$_updateActiveBars
+648  bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+652  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+656  ldr     x0, [sp, #0x10]
+660  ldp     x29, x30, [sp, #0xc0]
+664  ldp     x20, x19, [sp, #0xb0]
+668  ldp     x22, x21, [sp, #0xa0]
+672  ldp     x24, x23, [sp, #0x90]
+676  ldp     x26, x25, [sp, #0x80]
+680  ldp     d9, d8, [sp, #0x70]
+684  ldp     d11, d10, [sp, #0x60]
+688  ldp     d13, d12, [sp, #0x50]
+692  ldp     d15, d14, [sp, #0x40]
+696  add     sp, sp, #0xd0
+700  b       0x20247bfb8                                ; symbol stub for: objc_release

### -[STUIStatusBarWifiSignalView _iconSizeDidChange]  (18 条)
+0    sub     sp, sp, #0x30
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   mov     x19, x0
+20   adrp    x8, 51547
+24   ldr     x8, [x8, #0xfd0]
+28   stp     x0, x8, [sp]
+32   adrp    x8, -138445
+36   add     x1, x8, #0xbd3
+40   mov     x0, sp
+44   bl      0x20247bf70                                ; symbol stub for: objc_msgSendSuper2
+48   mov     x0, x19
+52   bl      0x2024ad1a0                                ; objc_msgSend$_setNeedsUpdateCycleAnimation
+56   ldp     x29, x30, [sp, #0x20]
+60   ldp     x20, x19, [sp, #0x10]
+64   add     sp, sp, #0x30
+68   ret

### +[STUIStatusBarWifiSignalView _barImageWithSize:forScale:distance:angle:centerPoint:cornerRadius:thickness:rounded:]  (160 条)
+0    sub     sp, sp, #0x1a0
+4    stp     d15, d14, [sp, #0x100]
+8    stp     d13, d12, [sp, #0x110]
+12   stp     d11, d10, [sp, #0x120]
+16   stp     d9, d8, [sp, #0x130]
+20   stp     x28, x27, [sp, #0x140]
+24   stp     x26, x25, [sp, #0x150]
+28   stp     x24, x23, [sp, #0x160]
+32   stp     x22, x21, [sp, #0x170]
+36   stp     x20, x19, [sp, #0x180]
+40   stp     x29, x30, [sp, #0x190]
+44   add     x29, sp, #0x190
+48   mov     x20, x2
+52   fmov    d9, d7
+56   fmov    d11, d6
+60   fmov    d12, d5
+64   fmov    d10, d4
+68   str     d3, [sp, #0x10]
+72   fmov    d14, d2
+76   fmov    d15, d1
+80   fmov    d13, d0
+84   mov     x19, x0
+88   ldr     d8, [x29, #0x10]
+92   adrp    x8, 47077
+96   ldr     x8, [x8, #0x1e8]
+100  cmn     x8, #0x1
+104  b.ne    0x202445154                                ; <+616>
+108  adrp    x8, 51548
+112  ldr     x0, [x8, #0x828]
+116  bl      0x20247bec8                                ; symbol stub for: objc_alloc
+120  mov     x21, x0
+124  mov     x0, x19
+128  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+132  mov     x2, x0
+136  str     d14, [sp]
+140  mov     x0, x21
+144  fmov    d0, d13
+148  fmov    d1, d15
+152  fmov    d2, d12
+156  fmov    d3, d11
+160  ldr     d4, [sp, #0x10]
+164  fmov    d5, d10
+168  fmov    d6, d9
+172  fmov    d7, d8
+176  mov     x3, x20
+180  bl      0x2024b2940                                ; objc_msgSend$initWithClass:size:rect:radius:lineWidth:alternate:scale:
+184  mov     x19, x0
+188  adrp    x25, 47077
+192  ldr     x0, [x25, #0x1e0]
+196  mov     x2, x19
+200  bl      0x2024b4200                                ; objc_msgSend$objectForKey:
+204  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+208  mov     x22, x0
+212  cbnz    x0, 0x20244511c                            ; <+560>
+216  adrp    x26, 51517
+220  ldr     x26, [x26, #0xf38]
+224  str     x26, [sp, #0xb0]
+228  adrp    x8, 66
+232  ldr     d0, [x8, #0xb68]
+236  str     d0, [sp, #0xb8]
+240  str     d8, [sp, #0x8]
+244  fmov    d8, d0
+248  adrp    x8, 1
+252  add     x8, x8, #0x198                             ; __116+[STUIStatusBarWifiSignalView _barImageWithSize:forScale:distance:angle:centerPoint:cornerRadius:thickness:rounded:]_block_invoke_2
+256  adrp    x9, 51520
+260  add     x9, x9, #0x300                             ; __block_descriptor_80_e19_{CGPoint=dd}16?0d8l
+264  stp     x8, x9, [sp, #0xc0]
+268  stp     d12, d11, [sp, #0xd0]
+272  stp     d10, d13, [sp, #0xe0]
+276  stp     d15, d9, [sp, #0xf0]
+280  add     x0, sp, #0xb0
+284  bl      0x20247c090                                ; symbol stub for: objc_retainBlock
+288  mov     x22, x0
+292  str     x26, [sp, #0x80]
+296  str     d8, [sp, #0x88]
+300  adrp    x8, 0
+304  add     x8, x8, #0x1e8                             ; __116+[STUIStatusBarWifiSignalView _barImageWithSize:forScale:distance:angle:centerPoint:cornerRadius:thickness:rounded:]_block_invoke_3
+308  adrp    x9, 51519
+312  add     x9, x9, #0x320                             ; __block_descriptor_48_e30_{CGPoint=dd}24?0{CGPoint=dd}8l
+316  stp     x8, x9, [sp, #0x90]
+320  stp     d13, d15, [sp, #0xa0]
+324  add     x0, sp, #0x80
+328  bl      0x20247c090                                ; symbol stub for: objc_retainBlock
+332  mov     x24, x0
+336  adrp    x8, 51547
+340  ldr     x0, [x8, #0xb10]
+344  bl      0x2024b4b00                                ; objc_msgSend$preferredFormat
+348  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+352  mov     x21, x0
+356  fmov    d0, d14
+360  bl      0x2024b84c0                                ; objc_msgSend$setScale:
+364  mov     x0, x21
+368  mov     w2, #0x0                                   ; =0
+372  bl      0x2024b7d40                                ; objc_msgSend$setOpaque:
+376  mov     x0, x21
+380  mov     w2, #0x7fff                                ; =32767
+384  bl      0x2024b80c0                                ; objc_msgSend$setPreferredRange:
+388  adrp    x8, 51547
+392  ldr     x0, [x8, #0xad8]
+396  bl      0x20247bec8                                ; symbol stub for: objc_alloc
+400  fmov    d0, d13
+404  fmov    d1, d15
+408  mov     x2, x21
+412  bl      0x2024b2ba0                                ; objc_msgSend$initWithSize:format:
+416  mov     x23, x0
+420  str     x26, [sp, #0x18]
+424  adrp    x8, 0
+428  add     x8, x8, #0x1f4                             ; __116+[STUIStatusBarWifiSignalView _barImageWithSize:forScale:distance:angle:centerPoint:cornerRadius:thickness:rounded:]_block_invoke_4
+432  adrp    x9, 51519
+436  add     x9, x9, #0x348                             ; __block_descriptor_97_e8_32bs40bs_e40_v16?0"UIGraphicsImageRendererContext"8ls32l8s40l8
+440  str     d8, [sp, #0x20]
+444  stp     x8, x9, [sp, #0x28]
+448  strb    w20, [sp, #0x78]
+452  ldr     d0, [sp, #0x10]
+456  stp     d0, d12, [sp, #0x48]
+460  ldr     d0, [sp, #0x8]
+464  stp     d11, d0, [sp, #0x58]
+468  stp     x22, x24, [sp, #0x38]
+472  stp     d10, d9, [sp, #0x68]
+476  bl      0x20247c0fc                                ; symbol stub for: objc_retain_x24
+480  mov     x20, x0
+484  bl      0x20247c0e4                                ; symbol stub for: objc_retain_x22
+488  mov     x24, x0
+492  add     x2, sp, #0x18
+496  mov     x0, x23
+500  bl      0x2024b26a0                                ; objc_msgSend$imageWithActions:
+504  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+508  mov     x22, x0
+512  ldr     x0, [x25, #0x1e0]
+516  mov     x2, x22
+520  mov     x3, x19
+524  bl      0x2024b7c20                                ; objc_msgSend$setObject:forKey:
+528  ldr     x8, [sp, #0x40]
+532  bl      0x20247c048                                ; symbol stub for: objc_release_x8
+536  ldr     x8, [sp, #0x38]
+540  bl      0x20247c048                                ; symbol stub for: objc_release_x8
+544  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+548  bl      0x20247c00c                                ; symbol stub for: objc_release_x24
+552  bl      0x20247c000                                ; symbol stub for: objc_release_x23
+556  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+560  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+564  mov     x0, x22
+568  ldp     x29, x30, [sp, #0x190]
+572  ldp     x20, x19, [sp, #0x180]
+576  ldp     x22, x21, [sp, #0x170]
+580  ldp     x24, x23, [sp, #0x160]
+584  ldp     x26, x25, [sp, #0x150]
+588  ldp     x28, x27, [sp, #0x140]
+592  ldp     d9, d8, [sp, #0x130]
+596  ldp     d11, d10, [sp, #0x120]
+600  ldp     d13, d12, [sp, #0x110]
+604  ldp     d15, d14, [sp, #0x100]
+608  add     sp, sp, #0x1a0
+612  b       0x20247bef8                                ; symbol stub for: objc_autoreleaseReturnValue
+616  adrp    x0, 47076
+620  add     x0, x0, #0x1e8                             ; _MergedGlobals.2
+624  adrp    x1, 51519
+628  add     x1, x1, #0x2e0                             ; __block_literal_global
+632  bl      0x20247be80                                ; symbol stub for: dispatch_once
+636  b       0x202444f58                                ; <+108>

### +[STUIStatusBarWifiSignalView _intrinsicContentSizeForNumberOfBars:iconSize:]  (63 条)
+0    stp     d11, d10, [sp, #-0x50]!
+4    stp     d9, d8, [sp, #0x10]
+8    stp     x22, x21, [sp, #0x20]
+12   stp     x20, x19, [sp, #0x30]
+16   stp     x29, x30, [sp, #0x40]
+20   add     x29, sp, #0x40
+24   mov     x20, x3
+28   mov     x19, x2
+32   mov     x21, x0
+36   cbz     x2, 0x202445be4                            ; <+84>
+40   mov     x22, #0x0                                  ; =0
+44   movi    d11, #0000000000000000
+48   mov     x0, x21
+52   mov     x2, x22
+56   mov     x3, x20
+60   bl      0x2024abaa0                                ; objc_msgSend$_barThicknessAtIndex:iconSize:
+64   fadd    d11, d11, d0
+68   add     x22, x22, #0x1
+72   cmp     x19, x22
+76   b.ne    0x202445bc0                                ; <+48>
+80   b       0x202445be8                                ; <+88>
+84   movi    d11, #0000000000000000
+88   mov     x0, x21
+92   mov     x2, x20
+96   bl      0x2024acac0                                ; objc_msgSend$_interspaceForIconSize:
+100  fmov    d8, d0
+104  fmov    d9, #2.00000000
+108  cmp     x20, #0x11
+112  b.hi    0x202445c20                                ; <+144>
+116  mov     w8, #0x1                                   ; =1
+120  lsl     x8, x8, x20
+124  mov     w9, #0x35dc                                ; =13788
+128  movk    w9, #0x2, lsl #16
+132  tst     x8, x9
+136  b.eq    0x202445c64                                ; <+212>
+140  fmov    d9, #3.00000000
+144  mov     x0, x21
+148  mov     x2, x20
+152  bl      0x2024ad6a0                                ; objc_msgSend$_totalWidthForIconSize:
+156  fmov    d10, d0
+160  sub     x8, x19, #0x1
+164  scvtf   d0, x8
+168  fmadd   d0, d0, d8, d11
+172  fmov    d1, d9
+176  bl      0x20247bc88                                ; symbol stub for: UICeilToScale
+180  fmov    d1, d0
+184  fmov    d0, d10
+188  ldp     x29, x30, [sp, #0x40]
+192  ldp     x20, x19, [sp, #0x30]
+196  ldp     x22, x21, [sp, #0x20]
+200  ldp     d9, d8, [sp, #0x10]
+204  ldp     d11, d10, [sp], #0x50
+208  ret
+212  cbnz    x20, 0x202445c20                           ; <+144>
+216  adrp    x8, 51547
+220  ldr     x0, [x8, #0x760]
+224  bl      0x2024b3b40                                ; objc_msgSend$mainScreen
+228  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+232  mov     x22, x0
+236  bl      0x2024b5720                                ; objc_msgSend$scale
+240  fmov    d9, d0
+244  bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+248  b       0x202445c20                                ; <+144>

### __116+[STUIStatusBarWifiSignalView _barImageWithSize:forScale:distance:angle:centerPoint:cornerRadius:thickness:rounded:]_block_invoke_2  (20 条)
+0    stp     d9, d8, [sp, #-0x30]!
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   fmov    d8, d0
+20   mov     x19, x0
+24   ldr     d9, [x0, #0x20]
+28   ldr     d0, [x0, #0x30]
+32   bl      0x20247bdc0                                ; symbol stub for: __sincos_stret
+36   fmsub   d2, d8, d1, d9
+40   ldp     d1, d3, [x19, #0x40]
+44   fmsub   d0, d8, d0, d1
+48   fmov    d1, #-0.50000000
+52   fmul    d1, d3, d1
+56   fadd    d1, d0, d1
+60   fmov    d0, d2
+64   ldp     x29, x30, [sp, #0x20]
+68   ldp     x20, x19, [sp, #0x10]
+72   ldp     d9, d8, [sp], #0x30
+76   ret

### __116+[STUIStatusBarWifiSignalView _barImageWithSize:forScale:distance:angle:centerPoint:cornerRadius:thickness:rounded:]_block_invoke_3  (3 条)
+0    ldr     d2, [x0, #0x20]
+4    fsub    d0, d2, d0
+8    ret

### __116+[STUIStatusBarWifiSignalView _barImageWithSize:forScale:distance:angle:centerPoint:cornerRadius:thickness:rounded:]_block_invoke_4  (125 条)
+0    sub     sp, sp, #0x50
+4    stp     d11, d10, [sp, #0x10]
+8    stp     d9, d8, [sp, #0x20]
+12   stp     x20, x19, [sp, #0x30]
+16   stp     x29, x30, [sp, #0x40]
+20   add     x29, sp, #0x40
+24   mov     x19, x0
+28   ldrb    w8, [x0, #0x60]
+32   ldr     d8, [x0, #0x30]
+36   cbz     w8, 0x202445260                            ; <+108>
+40   fcmp    d8, #0.0
+44   b.ne    0x202445260                                ; <+108>
+48   ldp     d0, d1, [x19, #0x38]
+52   ldr     d2, [x19, #0x48]
+56   fmov    d3, #0.50000000
+60   fmul    d2, d2, d3
+64   fsub    d1, d1, d2
+68   adrp    x8, 51547
+72   ldr     x0, [x8, #0xb18]
+76   adrp    x8, 66
+80   ldr     d4, [x8, #0x798]                           ; = 6.283185307179586
+84   movi    d3, #0000000000000000
+88   mov     w2, #0x1                                   ; =1
+92   bl      0x2024af680                                ; objc_msgSend$bezierPathWithArcCenter:radius:startAngle:endAngle:clockwise:
+96   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+100  str     x0, [sp, #0x8]
+104  b       0x2024453a8                                ; <+436>
+108  ldr     x0, [x19, #0x20]
+112  ldr     x8, [x0, #0x10]
+116  fmov    d0, d8
+120  blr     x8
+124  fmov    d9, d0
+128  fmov    d10, d1
+132  adrp    x8, 51547
+136  ldr     x0, [x8, #0xb18]
+140  bl      0x2024af660                                ; objc_msgSend$bezierPath
+144  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+148  str     x0, [sp, #0x8]
+152  fmov    d0, d9
+156  fmov    d1, d10
+160  bl      0x2024b3e40                                ; objc_msgSend$moveToPoint:
+164  ldr     d0, [x19, #0x50]
+168  adrp    x8, 66
+172  ldr     d9, [x8, #0x790]                           ; = 3.141592653589793
+176  fadd    d3, d0, d9
+180  adrp    x8, 66
+184  ldr     d10, [x8, #0x798]                          ; = 6.283185307179586
+188  fsub    d4, d10, d0
+192  ldp     d0, d1, [x19, #0x38]
+196  ldr     x0, [sp, #0x8]
+200  fmov    d2, d8
+204  mov     w2, #0x1                                   ; =1
+208  bl      0x2024ae180                                ; objc_msgSend$addArcWithCenter:radius:startAngle:endAngle:clockwise:
+212  ldrb    w8, [x19, #0x60]
+216  ldr     d0, [x19, #0x48]
+220  fmov    d11, #0.50000000
+224  fmul    d1, d0, d11
+228  cmp     w8, #0x0
+232  fcsel   d0, d0, d1, eq
+236  fadd    d8, d8, d0
+240  ldr     x0, [x19, #0x20]
+244  ldr     x8, [x0, #0x10]
+248  fmov    d0, d8
+252  blr     x8
+256  ldr     x0, [x19, #0x28]
+260  ldr     x8, [x0, #0x10]
+264  blr     x8
+268  ldrb    w8, [x19, #0x60]
+272  cbz     w8, 0x202445334                            ; <+320>
+276  ldp     d2, d4, [x19, #0x48]
+280  fmul    d2, d2, d11
+284  fsub    d3, d9, d4
+288  fsub    d4, d10, d4
+292  ldr     x0, [sp, #0x8]
+296  mov     w2, #0x0                                   ; =0
+300  bl      0x2024ae180                                ; objc_msgSend$addArcWithCenter:radius:startAngle:endAngle:clockwise:
+304  ldr     d0, [x19, #0x48]
+308  fmul    d0, d0, d11
+312  fadd    d8, d8, d0
+316  b       0x20244533c                                ; <+328>
+320  ldr     x0, [sp, #0x8]
+324  bl      0x2024ae2c0                                ; objc_msgSend$addLineToPoint:
+328  ldr     d0, [x19, #0x50]
+332  fsub    d3, d10, d0
+336  fadd    d4, d0, d9
+340  ldp     d0, d1, [x19, #0x38]
+344  ldr     x0, [sp, #0x8]
+348  fmov    d2, d8
+352  mov     w2, #0x0                                   ; =0
+356  bl      0x2024ae180                                ; objc_msgSend$addArcWithCenter:radius:startAngle:endAngle:clockwise:
+360  ldrb    w8, [x19, #0x60]
+364  cbz     w8, 0x20244539c                            ; <+424>
+368  ldr     d0, [x19, #0x48]
+372  fmov    d10, #0.50000000
+376  fmul    d0, d0, d10
+380  fsub    d0, d8, d0
+384  ldr     x0, [x19, #0x20]
+388  ldr     x8, [x0, #0x10]
+392  blr     x8
+396  ldp     d2, d4, [x19, #0x48]
+400  fmul    d2, d2, d10
+404  fadd    d3, d4, d9
+408  ldr     x0, [sp, #0x8]
+412  mov     w2, #0x0                                   ; =0
+416  bl      0x2024ae180                                ; objc_msgSend$addArcWithCenter:radius:startAngle:endAngle:clockwise:
+420  b       0x2024453a8                                ; <+436>
+424  ldr     x0, [sp, #0x8]
+428  mov     w2, #0x1                                   ; =1
+432  bl      0x2024b7760                                ; objc_msgSend$setLineJoinStyle:
+436  ldr     d0, [x19, #0x58]
+440  ldr     x0, [sp, #0x8]
+444  bl      0x2024b7780                                ; objc_msgSend$setLineWidth:
+448  ldr     x0, [sp, #0x8]
+452  bl      0x2024afde0                                ; objc_msgSend$closePath
+456  ldr     x0, [sp, #0x8]
+460  bl      0x2024b1b60                                ; objc_msgSend$fill
+464  ldr     x0, [sp, #0x8]
+468  bl      0x2024b9b60                                ; objc_msgSend$stroke
+472  ldr     x0, [sp, #0x8]
+476  ldp     x29, x30, [sp, #0x40]
+480  ldp     x20, x19, [sp, #0x30]
+484  ldp     d9, d8, [sp, #0x20]
+488  ldp     d11, d10, [sp, #0x10]
+492  add     sp, sp, #0x50
+496  b       0x20247bfb8                                ; symbol stub for: objc_release

### -[_UIBatteryView rounded]  (4 条)
+0    adrp    x8, 423420
+4    ldrsw   x8, [x8, #0x314]                           ; ivar 400
+8    ldrb    w0, [x0, x8]
+12   ret

### -[STUIStatusBarStaticBatteryView rounded]: 未找到

### -[STUIStatusBarBatteryView rounded]: 未找到
