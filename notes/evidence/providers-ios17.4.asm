; iOS 17.4 (21E213) arm64 Simulator; 2026-11-17
; Native disassembly with runtime class references. Addresses are session-specific.
; Setup methods are explicitly excerpted; ivar offsets are kept numeric.
ivars: 0

### +[STUIStatusBarVisualProvider_iOS visualProviderSubclassForScreen:visualProviderInfo:]  (45 条)
+0    stp     x22, x21, [sp, #-0x30]!
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   mov     x20, x3
+20   bl      0x20247c0c0                                ; symbol stub for: objc_retain_x2
+24   mov     x19, x0
+28   bl      0x20247c0cc                                ; symbol stub for: objc_retain_x20
+32   mov     x20, x0
+36   mov     x0, x19
+40   bl      0x2024ba520                                ; objc_msgSend$traitCollection
+44   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+48   mov     x22, x0
+52   bl      0x2024baa40                                ; objc_msgSend$userInterfaceIdiom
+56   mov     x21, x0
+60   bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+64   cbz     x21, 0x2024284c8                           ; <+96>
+68   cmp     x21, #0x3
+72   b.eq    0x2024284d4                                ; <+108>
+76   cmp     x21, #0x1
+80   b.ne    0x2024284fc                                ; <+148>
+84   adrp    x8, 51576
+88   add     x8, x8, #0x730                             ; (void *)0x000000020dc22f58: STUIStatusBarVisualProvider_Pad
+92   b       0x2024284dc                                ; <+116>
+96   adrp    x8, 51576
+100  add     x8, x8, #0x940                             ; (void *)0x000000020dc24e70: STUIStatusBarVisualProvider_Phone
+104  b       0x2024284dc                                ; <+116>
+108  adrp    x8, 51576
+112  add     x8, x8, #0x948                             ; (void *)0x000000020dc257d0: STUIStatusBarVisualProvider_CarPlay
+116  ldr     x0, [x8]
+120  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+124  mov     x1, x19
+128  mov     x2, x20
+132  bl      0x202436ba8                                ; STUIStatusBarGetVisualProviderSubclassForScreenWithVisualProviderInfo
+136  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+140  mov     x21, x0
+144  b       0x202428500                                ; <+152>
+148  mov     x21, #0x0                                  ; =0
+152  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+156  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+160  mov     x0, x21
+164  ldp     x29, x30, [sp, #0x20]
+168  ldp     x20, x19, [sp, #0x10]
+172  ldp     x22, x21, [sp], #0x30
+176  b       0x20247bef8                                ; symbol stub for: objc_autoreleaseReturnValue

### +[STUIStatusBarVisualProvider_Phone visualProviderSubclassForScreen:visualProviderInfo:]  (58 条)
+0    stp     x24, x23, [sp, #-0x40]!
+4    stp     x22, x21, [sp, #0x10]
+8    stp     x20, x19, [sp, #0x20]
+12   stp     x29, x30, [sp, #0x30]
+16   add     x29, sp, #0x30
+20   bl      0x20247c0c0                                ; symbol stub for: objc_retain_x2
+24   mov     x19, x0
+28   bl      0x2024ac680                                ; objc_msgSend$_exclusionArea
+32   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+36   mov     x20, x0
+40   adrp    x8, -138165
+44   add     x1, x8, #0x5a3
+48   bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+52   tbz     w0, #0x0, 0x20245543c                      ; <+84>
+56   mov     x0, x20
+60   bl      0x2024b4ee0                                ; objc_msgSend$rect
+64   fcmp    d1, #0.0
+68   b.le    0x202455484                                ; <+156>
+72   adrp    x8, 51531
+76   ldr     x0, [x8, #0xca0]                           ; Class STUIStatusBarVisualProvider_DynamicSplit
+80   b       0x202455498                                ; <+176>
+84   adrp    x8, 51531
+88   ldr     x0, [x8, #0x598]                           ; Class STUIStatusBarSettingsDomain
+92   bl      0x2024b5620                                ; objc_msgSend$rootSettings
+96   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+100  mov     x21, x0
+104  bl      0x2024bace0                                ; objc_msgSend$visualProviderSettings
+108  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+112  mov     x22, x0
+116  bl      0x2024b3820                                ; objc_msgSend$legacyPhoneUsesiPadLayout
+120  mov     x23, x0
+124  bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+128  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+132  cbz     w23, 0x202455490                           ; <+168>
+136  adrp    x8, 51531
+140  ldr     x0, [x8, #0x730]                           ; Class STUIStatusBarVisualProvider_Pad
+144  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+148  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+152  b       0x2024554ac                                ; <+196>
+156  adrp    x8, 51531
+160  ldr     x0, [x8, #0xca8]                           ; Class STUIStatusBarVisualProvider_Split
+164  b       0x202455498                                ; <+176>
+168  adrp    x8, 51531
+172  ldr     x0, [x8, #0xcb0]                           ; Class STUIStatusBarVisualProvider_LegacyPhone
+176  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+180  mov     x1, x19
+184  mov     x2, #0x0                                   ; =0
+188  bl      0x202436ba8                                ; STUIStatusBarGetVisualProviderSubclassForScreenWithVisualProviderInfo
+192  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+196  mov     x21, x0
+200  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+204  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+208  mov     x0, x21
+212  ldp     x29, x30, [sp, #0x30]
+216  ldp     x20, x19, [sp, #0x20]
+220  ldp     x22, x21, [sp, #0x10]
+224  ldp     x24, x23, [sp], #0x40
+228  b       0x20247bef8                                ; symbol stub for: objc_autoreleaseReturnValue

### +[STUIStatusBarVisualProvider_Split visualProviderSubclassForScreen:visualProviderInfo:]  (131 条)
+0    sub     sp, sp, #0x120
+4    stp     d11, d10, [sp, #0xc0]
+8    stp     d9, d8, [sp, #0xd0]
+12   stp     x24, x23, [sp, #0xe0]
+16   stp     x22, x21, [sp, #0xf0]
+20   stp     x20, x19, [sp, #0x100]
+24   stp     x29, x30, [sp, #0x110]
+28   add     x29, sp, #0x110
+32   mov     x19, x3
+36   adrp    x8, 51490
+40   ldr     x8, [x8, #0xfd0]
+44   ldr     x8, [x8]
+48   stur    x8, [x29, #-0x58]
+52   bl      0x20247c0c0                                ; symbol stub for: objc_retain_x2
+56   mov     x21, x0
+60   bl      0x20247c0b4                                ; symbol stub for: objc_retain_x19
+64   mov     x19, x0
+68   mov     x0, x21
+72   bl      0x2024acca0                                ; objc_msgSend$_nativeDisplayBounds
+76   bl      0x20247bbb0                                ; symbol stub for: CGRectGetWidth
+80   fmov    d8, d0
+84   mov     x0, x21
+88   bl      0x2024ac680                                ; objc_msgSend$_exclusionArea
+92   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+96   mov     x20, x0
+100  bl      0x2024b4ee0                                ; objc_msgSend$rect
+104  fmov    d9, d2
+108  fmov    d10, d3
+112  adrp    x8, 51521
+116  ldr     x0, [x8, #0xd20]                           ; Class STUIStatusBarVisualProvider_Split1125
+120  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+124  str     x0, [sp, #0x70]
+128  adrp    x8, 51521
+132  ldr     x0, [x8, #0xd28]                           ; Class STUIStatusBarVisualProvider_Split1080
+136  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+140  str     x0, [sp, #0x78]
+144  adrp    x8, 51521
+148  ldr     x0, [x8, #0xd30]                           ; Class STUIStatusBarVisualProvider_Split1080_Wide
+152  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+156  str     x0, [sp, #0x80]
+160  adrp    x8, 51521
+164  ldr     x0, [x8, #0xd38]                           ; Class STUIStatusBarVisualProvider_Split1170
+168  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+172  str     x0, [sp, #0x88]
+176  adrp    x8, 51521
+180  ldr     x0, [x8, #0xd40]                           ; Class STUIStatusBarVisualProvider_Split1170_Wide
+184  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+188  str     x0, [sp, #0x90]
+192  adrp    x8, 51521
+196  ldr     x0, [x8, #0xd48]                           ; Class STUIStatusBarVisualProvider_Split1242
+200  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+204  str     x0, [sp, #0x98]
+208  adrp    x8, 51521
+212  ldr     x0, [x8, #0xd50]                           ; Class STUIStatusBarVisualProvider_Split828
+216  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+220  str     x0, [sp, #0xa0]
+224  adrp    x8, 51521
+228  ldr     x0, [x8, #0xd58]                           ; Class STUIStatusBarVisualProvider_Split1284
+232  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+236  str     x0, [sp, #0xa8]
+240  adrp    x8, 51521
+244  ldr     x0, [x8, #0xd60]                           ; Class STUIStatusBarVisualProvider_Split1284_Wide
+248  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+252  str     x0, [sp, #0xb0]
+256  adrp    x8, 51521
+260  ldr     x0, [x8, #0x628]
+264  add     x2, sp, #0x70
+268  mov     w3, #0x9                                   ; =9
+272  bl      0x2024af160                                ; objc_msgSend$arrayWithObjects:count:
+276  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+280  mov     x22, x0
+284  add     x23, sp, #0x50
+288  stp     xzr, x23, [sp, #0x50]
+292  adrp    x8, 39
+296  ldr     d0, [x8, #0xeb0]
+300  str     d0, [sp, #0x60]
+304  adrp    x8, 51490
+308  ldr     x8, [x8, #0xf38]
+312  str     xzr, [sp, #0x68]
+316  str     x8, [sp, #0x8]
+320  adrp    x8, 39
+324  ldr     d0, [x8, #0xb68]
+328  adrp    x8, 0
+332  add     x8, x8, #0x694                             ; __88+[STUIStatusBarVisualProvider_Split visualProviderSubclassForScreen:visualProviderInfo:]_block_invoke
+336  str     d0, [sp, #0x10]
+340  adrp    x9, 51493
+344  add     x9, x9, #0xac0                             ; __block_descriptor_72_e8_32s40r_e15_v32?0#8Q16^B24ls32l8r40l8
+348  stp     x8, x9, [sp, #0x18]
+352  str     d8, [sp, #0x38]
+356  bl      0x20247c0d8                                ; symbol stub for: objc_retain_x21
+360  mov     x21, x0
+364  stp     d9, d10, [sp, #0x40]
+368  stp     x0, x23, [sp, #0x28]
+372  add     x2, sp, #0x8
+376  mov     x0, x22
+380  bl      0x2024b1760                                ; objc_msgSend$enumerateObjectsUsingBlock:
+384  ldr     x8, [sp, #0x58]
+388  ldr     x8, [x8, #0x18]
+392  bl      0x20247c15c                                ; symbol stub for: objc_retain_x8
+396  mov     x23, x0
+400  ldr     x8, [sp, #0x28]
+404  bl      0x20247c048                                ; symbol stub for: objc_release_x8
+408  add     x0, sp, #0x50
+412  mov     w1, #0x8                                   ; =8
+416  bl      0x20247bd3c                                ; symbol stub for: _Block_object_dispose
+420  bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+424  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+428  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+432  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+436  ldur    x8, [x29, #-0x58]
+440  adrp    x9, 51490
+444  ldr     x9, [x9, #0xfd0]
+448  ldr     x9, [x9]
+452  cmp     x9, x8
+456  b.ne    0x20245f678                                ; <+496>
+460  mov     x0, x23
+464  ldp     x29, x30, [sp, #0x110]
+468  ldp     x20, x19, [sp, #0x100]
+472  ldp     x22, x21, [sp, #0xf0]
+476  ldp     x24, x23, [sp, #0xe0]
+480  ldp     d9, d8, [sp, #0xd0]
+484  ldp     d11, d10, [sp, #0xc0]
+488  add     sp, sp, #0x120
+492  b       0x20247bef8                                ; symbol stub for: objc_autoreleaseReturnValue
+496  bl      0x20247bdcc                                ; symbol stub for: __stack_chk_fail
+500  mov     x19, x0
+504  add     x0, sp, #0x50
+508  mov     w1, #0x8                                   ; =8
+512  bl      0x20247bd3c                                ; symbol stub for: _Block_object_dispose
+516  mov     x0, x19
+520  bl      0x20247bdb4                                ; symbol stub for: _Unwind_Resume

### +[STUIStatusBarVisualProvider_DynamicSplit visualProviderSubclassForScreen:visualProviderInfo:]  (32 条)
+0    stp     d9, d8, [sp, #-0x30]!
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   mov     x19, x0
+20   bl      0x20247c0c0                                ; symbol stub for: objc_retain_x2
+24   mov     x20, x0
+28   bl      0x2024ad7e0                                ; objc_msgSend$_unjailedReferenceBounds
+32   bl      0x20247bbb0                                ; symbol stub for: CGRectGetWidth
+36   fmov    d8, d0
+40   mov     x0, x20
+44   bl      0x2024accc0                                ; objc_msgSend$_nativeScale
+48   fmul    d9, d8, d0
+52   mov     x0, x20
+56   bl      0x2024ad060                                ; objc_msgSend$_scale
+60   fmov    d8, d0
+64   bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+68   fdiv    d0, d9, d8
+72   adrp    x8, 89
+76   ldr     d1, [x8, #0xd38]                           ; = 393.0
+80   fcmp    d0, d1
+84   b.ls    0x20242d618                                ; <+96>
+88   bl      0x20247c0b4                                ; symbol stub for: objc_retain_x19
+92   b       0x20242d628                                ; <+112>
+96   adrp    x8, 51571
+100  ldr     x0, [x8, #0x998]                           ; Class STUIStatusBarVisualProvider_DynamicSplitMedium
+104  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+108  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+112  ldp     x29, x30, [sp, #0x20]
+116  ldp     x20, x19, [sp, #0x10]
+120  ldp     d9, d8, [sp], #0x30
+124  b       0x20247bef8                                ; symbol stub for: objc_autoreleaseReturnValue

### -[STUIStatusBar _visualProviderClass]  (4 条)
+0    adrp    x8, 47018
+4    ldrsw   x8, [x8, #0x808]                           ; ivar 584
+8    ldr     x0, [x0, x8]
+12   ret

### -[STUIStatusBar _prepareVisualProviderIfNeeded]  (406 条)
+0    sub     sp, sp, #0xb0
+4    stp     d9, d8, [sp, #0x60]
+8    stp     x24, x23, [sp, #0x70]
+12   stp     x22, x21, [sp, #0x80]
+16   stp     x20, x19, [sp, #0x90]
+20   stp     x29, x30, [sp, #0xa0]
+24   add     x29, sp, #0xa0
+28   mov     x19, x0
+32   adrp    x8, 47026
+36   ldrsw   x8, [x8, #0x800]                           ; ivar 416
+40   add     x24, x0, x8
+44   ldr     x8, [x24]
+48   cbnz    x8, 0x202470e40                            ; <+1008>
+52   adrp    x8, 47026
+56   ldrsw   x23, [x8, #0x808]                          ; ivar 584
+60   ldr     x0, [x19, x23]
+64   adrp    x22, 47026
+68   cbnz    x0, 0x202470b58                            ; <+264>
+72   mov     x0, x19
+76   bl      0x2024ac620                                ; objc_msgSend$_effectiveTargetScreen
+80   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+84   mov     x20, x0
+88   mov     x0, x19
+92   bl      0x2024bacc0                                ; objc_msgSend$visualProviderInfo
+96   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+100  mov     x21, x0
+104  mov     x0, x20
+108  mov     x1, x21
+112  bl      0x2024367cc                                ; STUIStatusBarGetVisualProviderClassForScreen
+116  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+120  ldr     x8, [x19, x23]
+124  str     x0, [x19, x23]
+128  bl      0x20247c048                                ; symbol stub for: objc_release_x8
+132  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+136  ldr     x0, [x19, x23]
+140  bl      0x2024b5740                                ; objc_msgSend$scalesWithScreenNativeScale
+144  ldrsw   x21, [x22, #0x7e4]                         ; ivar 424
+148  ldr     w8, [x19, x21]
+152  mov     w9, #0x2                                   ; =2
+156  cmp     w0, #0x0
+160  csel    w9, w9, wzr, ne
+164  and     w8, w8, #0xfffffffd
+168  orr     w8, w8, w9
+172  str     w8, [x19, x21]
+176  ldr     x0, [x19, x23]
+180  adrp    x8, -138192
+184  add     x1, x8, #0xbc4
+188  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+192  ldr     w8, [x19, x21]
+196  tst     w0, #0x1
+200  mov     w9, #0x4                                   ; =4
+204  csel    w9, w9, wzr, ne
+208  and     w8, w8, #0xfffffffb
+212  orr     w8, w8, w9
+216  str     w8, [x19, x21]
+220  ldr     x0, [x19, x23]
+224  bl      0x2024b5460                                ; objc_msgSend$requiresIterativeOverflowLayout
+228  ldr     w8, [x19, x21]
+232  mov     w9, #0x8                                   ; =8
+236  cmp     w0, #0x0
+240  csel    w9, w9, wzr, ne
+244  and     w8, w8, #0xfffffff7
+248  orr     w8, w8, w9
+252  str     w8, [x19, x21]
+256  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+260  ldr     x0, [x19, x23]
+264  bl      0x20247bee0                                ; symbol stub for: objc_alloc_init
+268  ldr     x8, [x24]
+272  str     x0, [x24]
+276  bl      0x20247c048                                ; symbol stub for: objc_release_x8
+280  ldr     x0, [x24]
+284  mov     x2, x19
+288  bl      0x2024b8900                                ; objc_msgSend$setStatusBar:
+292  ldr     x0, [x24]
+296  adrp    x8, -138217
+300  add     x1, x8, #0x995
+304  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+308  ldrsw   x20, [x22, #0x7e4]                         ; ivar 424
+312  ldr     w8, [x19, x20]
+316  tst     w0, #0x1
+320  mov     w9, #0x10                                  ; =16
+324  csel    w9, w9, wzr, ne
+328  and     w8, w8, #0xffffffef
+332  orr     w8, w8, w9
+336  str     w8, [x19, x20]
+340  ldr     x0, [x24]
+344  adrp    x8, -138209
+348  add     x1, x8, #0x2b1
+352  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+356  ldr     w8, [x19, x20]
+360  tst     w0, #0x1
+364  mov     w9, #0x20                                  ; =32
+368  csel    w9, w9, wzr, ne
+372  and     w8, w8, #0xffffffdf
+376  orr     w8, w8, w9
+380  str     w8, [x19, x20]
+384  ldr     x0, [x24]
+388  adrp    x8, -138319
+392  add     x1, x8, #0x726
+396  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+400  ldr     w8, [x19, x20]
+404  tst     w0, #0x1
+408  mov     w9, #0x40                                  ; =64
+412  csel    w9, w9, wzr, ne
+416  and     w8, w8, #0xffffffbf
+420  orr     w8, w8, w9
+424  str     w8, [x19, x20]
+428  ldr     x0, [x24]
+432  adrp    x8, -138105
+436  add     x1, x8, #0x7bf
+440  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+444  ldr     w8, [x19, x20]
+448  tst     w0, #0x1
+452  mov     w9, #0x80                                  ; =128
+456  csel    w9, w9, wzr, ne
+460  and     w8, w8, #0xffffff7f
+464  orr     w8, w8, w9
+468  str     w8, [x19, x20]
+472  ldr     x0, [x24]
+476  adrp    x8, -138074
+480  add     x1, x8, #0xb05
+484  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+488  ldr     w8, [x19, x20]
+492  tst     w0, #0x1
+496  mov     w9, #0x100                                 ; =256
+500  csel    w9, w9, wzr, ne
+504  and     w8, w8, #0xfffffeff
+508  orr     w8, w8, w9
+512  str     w8, [x19, x20]
+516  ldr     x0, [x24]
+520  adrp    x8, -138294
+524  add     x1, x8, #0xd6b
+528  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+532  ldr     w8, [x19, x20]
+536  tst     w0, #0x1
+540  mov     w9, #0x200                                 ; =512
+544  csel    w9, w9, wzr, ne
+548  and     w8, w8, #0xfffffdff
+552  orr     w8, w8, w9
+556  str     w8, [x19, x20]
+560  ldr     x0, [x24]
+564  adrp    x8, -138313
+568  add     x1, x8, #0xbbb
+572  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+576  ldr     w8, [x19, x20]
+580  tst     w0, #0x1
+584  mov     w9, #0x400                                 ; =1024
+588  csel    w9, w9, wzr, ne
+592  and     w8, w8, #0xfffffbff
+596  orr     w8, w8, w9
+600  str     w8, [x19, x20]
+604  ldr     x0, [x24]
+608  adrp    x8, -138111
+612  add     x1, x8, #0xedc
+616  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+620  ldr     w8, [x19, x20]
+624  tst     w0, #0x1
+628  mov     w9, #0x800                                 ; =2048
+632  csel    w9, w9, wzr, ne
+636  and     w8, w8, #0xfffff7ff
+640  orr     w8, w8, w9
+644  str     w8, [x19, x20]
+648  ldr     x0, [x24]
+652  adrp    x8, -138191
+656  add     x1, x8, #0x207
+660  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+664  ldr     w8, [x19, x20]
+668  tst     w0, #0x1
+672  mov     w9, #0x1000                                ; =4096
+676  csel    w9, w9, wzr, ne
+680  and     w8, w8, #0xffffefff
+684  orr     w8, w8, w9
+688  str     w8, [x19, x20]
+692  ldr     x0, [x24]
+696  adrp    x8, -138106
+700  add     x1, x8, #0x21e
+704  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+708  ldr     w8, [x19, x20]
+712  tst     w0, #0x1
+716  mov     w9, #0x2000                                ; =8192
+720  csel    w9, w9, wzr, ne
+724  and     w8, w8, #0xffffdfff
+728  orr     w8, w8, w9
+732  str     w8, [x19, x20]
+736  ldr     x0, [x24]
+740  adrp    x8, -138333
+744  add     x1, x8, #0x278
+748  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+752  ldr     w8, [x19, x20]
+756  tst     w0, #0x1
+760  mov     w9, #0x4000                                ; =16384
+764  csel    w9, w9, wzr, ne
+768  and     w8, w8, #0xffffbfff
+772  orr     w8, w8, w9
+776  str     w8, [x19, x20]
+780  ldr     x0, [x24]
+784  adrp    x8, -138282
+788  add     x1, x8, #0x93c
+792  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+796  ldr     w8, [x19, x20]
+800  tst     w0, #0x1
+804  mov     w9, #0x8000                                ; =32768
+808  csel    w9, w9, wzr, ne
+812  and     w8, w8, #0xffff7fff
+816  orr     w8, w8, w9
+820  str     w8, [x19, x20]
+824  ldr     x0, [x24]
+828  adrp    x8, -138191
+832  add     x1, x8, #0x30a
+836  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+840  ldr     w8, [x19, x20]
+844  tst     w0, #0x1
+848  mov     w9, #0x10000                               ; =65536
+852  csel    w9, w9, wzr, ne
+856  and     w8, w8, #0xfffeffff
+860  orr     w8, w8, w9
+864  str     w8, [x19, x20]
+868  ldr     x0, [x24]
+872  adrp    x8, -138107
+876  add     x1, x8, #0xf27
+880  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+884  ldr     w8, [x19, x20]
+888  tst     w0, #0x1
+892  mov     w9, #0x20000                               ; =131072
+896  csel    w9, w9, wzr, ne
+900  and     w8, w8, #0xfffdffff
+904  orr     w8, w8, w9
+908  str     w8, [x19, x20]
+912  ldr     x0, [x24]
+916  adrp    x8, -138231
+920  add     x1, x8, #0xf54
+924  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+928  ldr     w8, [x19, x20]
+932  tst     w0, #0x1
+936  mov     w9, #0x40000                               ; =262144
+940  csel    w9, w9, wzr, ne
+944  and     w8, w8, #0xfffbffff
+948  orr     w8, w8, w9
+952  str     w8, [x19, x20]
+956  ldr     x0, [x24]
+960  adrp    x8, -127138
+964  add     x1, x8, #0xd5a
+968  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+972  ldr     w8, [x19, x20]
+976  tst     w0, #0x1
+980  mov     w9, #0x80000                               ; =524288
+984  csel    w9, w9, wzr, ne
+988  and     w8, w8, #0xfff7ffff
+992  orr     w8, w8, w9
+996  str     w8, [x19, x20]
+1000 mov     x0, x19
+1004 bl      0x2024ad800                                ; objc_msgSend$_updateActionGestureRecognizerAllowableTouchTypesIfNeeded
+1008 adrp    x8, 47026
+1012 ldrsw   x21, [x8, #0x80c]                          ; ivar 544
+1016 ldr     x8, [x19, x21]
+1020 cbnz    x8, 0x202470ed4                            ; <+1156>
+1024 adrp    x8, 51504
+1028 ldr     x0, [x8, #0xdb8]                           ; Class STUIStatusBarForegroundView
+1032 bl      0x20247bec8                                ; symbol stub for: objc_alloc
+1036 mov     x20, x0
+1040 mov     x0, x19
+1044 bl      0x2024af880                                ; objc_msgSend$bounds
+1048 mov     x0, x20
+1052 bl      0x2024b2a40                                ; objc_msgSend$initWithFrame:
+1056 mov     x20, x0
+1060 mov     x0, x19
+1064 mov     x2, x20
+1068 bl      0x2024b71e0                                ; objc_msgSend$setForegroundView:
+1072 bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+1076 adrp    x8, 51504
+1080 ldr     x0, [x8, #0xdc0]
+1084 bl      0x20247bec8                                ; symbol stub for: objc_alloc
+1088 mov     x2, x19
+1092 bl      0x2024b29e0                                ; objc_msgSend$initWithDelegate:
+1096 adrp    x8, 47026
+1100 ldrsw   x22, [x8, #0x810]                          ; ivar 560
+1104 ldr     x8, [x19, x22]
+1108 str     x0, [x19, x22]
+1112 bl      0x20247c048                                ; symbol stub for: objc_release_x8
+1116 mov     x0, x19
+1120 bl      0x2024b1e80                                ; objc_msgSend$foregroundView
+1124 bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+1128 mov     x20, x0
+1132 ldr     x2, [x19, x22]
+1136 bl      0x2024ae260                                ; objc_msgSend$addInteraction:
+1140 bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+1144 ldr     x2, [x19, x21]
+1148 mov     x0, x19
+1152 bl      0x2024ae3a0                                ; objc_msgSend$addSubview:
+1156 adrp    x8, 47026
+1160 ldrsw   x8, [x8, #0x814]                           ; ivar 592
+1164 add     x21, x19, x8
+1168 ldr     x0, [x21]
+1172 bl      0x2024b0320                                ; objc_msgSend$count
+1176 cbz     x0, 0x202470f08                            ; <+1208>
+1180 ldp     x29, x30, [sp, #0xa0]
+1184 ldp     x20, x19, [sp, #0x90]
+1188 ldp     x22, x21, [sp, #0x80]
+1192 ldp     x24, x23, [sp, #0x70]
+1196 ldp     d9, d8, [sp, #0x60]
+1200 add     sp, sp, #0xb0
+1204 ret
+1208 adrp    x8, 51504
+1212 ldr     x0, [x8, #0x748]
+1216 bl      0x2024b0a60                                ; objc_msgSend$dictionary
+1220 bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+1224 mov     x22, x0
+1228 ldr     x20, [x24]
+1232 mov     x0, x19
+1236 bl      0x2024b0180                                ; objc_msgSend$containerView
+1240 bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+1244 mov     x23, x0
+1248 mov     x0, x20
+1252 mov     x2, x23
+1256 bl      0x2024b9260                                ; objc_msgSend$setupInContainerView:
+1260 bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+1264 mov     x20, x0
+1268 bl      0x20247c000                                ; symbol stub for: objc_release_x23
+1272 adrp    x23, 51473
+1276 ldr     x23, [x23, #0xf38]
+1280 str     x23, [sp, #0x30]
+1284 adrp    x8, 22
+1288 ldr     d8, [x8, #0xb68]
+1292 adrp    x8, 1
+1296 add     x8, x8, #0xa8                              ; __47-[STUIStatusBar _prepareVisualProviderIfNeeded]_block_invoke
+1300 str     d8, [sp, #0x38]
+1304 adrp    x9, 51476
+1308 add     x9, x9, #0xf30                             ; __block_descriptor_48_e8_32s40s_e36_v32?0"STUIStatusBarRegion"8Q16^B24ls32l8s40l8
+1312 stp     x8, x9, [sp, #0x40]
+1316 str     x19, [sp, #0x50]
+1320 bl      0x20247c0e4                                ; symbol stub for: objc_retain_x22
+1324 str     x0, [sp]
+1328 str     x0, [sp, #0x58]
+1332 add     x2, sp, #0x30
+1336 mov     x0, x20
+1340 bl      0x2024b1760                                ; objc_msgSend$enumerateObjectsUsingBlock:
+1344 mov     x0, x21
+1348 mov     x1, x22
+1352 bl      0x20247c18c                                ; symbol stub for: objc_storeStrong
+1356 ldr     x0, [x21]
+1360 str     x23, [sp, #0x8]
+1364 adrp    x8, 1
+1368 add     x8, x8, #0x114                             ; __47-[STUIStatusBar _prepareVisualProviderIfNeeded]_block_invoke_2
+1372 str     d8, [sp, #0x10]
+1376 adrp    x9, 51476
+1380 add     x9, x9, #0xf58                             ; __block_descriptor_40_e8_32s_e46_v32?0"NSString"8"STUIStatusBarRegion"16^B24ls32l8
+1384 stp     x8, x9, [sp, #0x18]
+1388 str     x19, [sp, #0x28]
+1392 add     x2, sp, #0x8
+1396 bl      0x2024b1740                                ; objc_msgSend$enumerateKeysAndObjectsUsingBlock:
+1400 adrp    x8, 51504
+1404 ldr     x0, [x8, #0xdc8]                           ; Class STUIStatusBarDisplayItemState
+1408 adrp    x21, 47026
+1412 add     x21, x21, #0x7e4                           ; _MergedGlobals
+1416 ldrsw   x8, [x21, #0x34]                           ; ivar 56
+1420 ldr     x2, [x19, x8]
+1424 ldr     x3, [x24]
+1428 bl      0x2024b9280                                ; objc_msgSend$setupRelationsBetweenDisplayItemStates:visualProvider:
+1432 ldrsw   x8, [x21, #0x8]                            ; ivar 104
+1436 ldr     x8, [x19, x8]
+1440 ldrsw   x23, [x21]
+1444 cbz     x8, 0x20247100c                            ; <+1468>
+1448 ldrb    w8, [x19, x23]
+1452 tbz     w8, #0x4, 0x20247100c                      ; <+1468>
+1456 ldr     x0, [x24]
+1460 mov     x2, #0x0                                   ; =0
+1464 bl      0x2024b3de0                                ; objc_msgSend$modeUpdatedFromMode:
+1468 add     x8, x19, x23
+1472 ldrb    w8, [x8, #0x2]
+1476 tbz     w8, #0x3, 0x202471074                      ; <+1572>
+1480 ldr     x21, [x24]
+1484 bl      0x20247c0b4                                ; symbol stub for: objc_retain_x19
+1488 mov     x22, x0
+1492 ldr     w8, [x19, x23]
+1496 tbz     w8, #0x13, 0x202471044                     ; <+1524>
+1500 adrp    x9, 47025
+1504 ldrsw   x9, [x9, #0x7e8]                           ; ivar 448
+1508 ldrb    w9, [x22, x9]
+1512 tst     w9, #0x3f
+1516 b.eq    0x20247104c                                ; <+1532>
+1520 tbnz    w8, #0x16, 0x202471054                     ; <+1540>
+1524 mov     w23, #0x0                                  ; =0
+1528 b       0x202471064                                ; <+1556>
+1532 mov     w23, #0x1                                  ; =1
+1536 b       0x202471064                                ; <+1556>
+1540 mov     x0, x22
+1544 bl      0x2024b3dc0                                ; objc_msgSend$mode
+1548 cmp     x0, #0x1
+1552 cset    w23, ne
+1556 bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+1560 mov     x0, x21
+1564 mov     x2, x23
+1568 bl      0x2024ba880                                ; objc_msgSend$updateLumaTracking:
+1572 mov     x0, x19
+1576 bl      0x2024adc60                                ; objc_msgSend$_updateStyleAttributes
+1580 ldr     x8, [sp, #0x58]
+1584 bl      0x20247c048                                ; symbol stub for: objc_release_x8
+1588 bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+1592 ldr     x0, [sp]
+1596 ldp     x29, x30, [sp, #0xa0]
+1600 ldp     x20, x19, [sp, #0x90]
+1604 ldp     x22, x21, [sp, #0x80]
+1608 ldp     x24, x23, [sp, #0x70]
+1612 ldp     d9, d8, [sp, #0x60]
+1616 add     sp, sp, #0xb0
+1620 b       0x20247bfb8                                ; symbol stub for: objc_release

### -[STUIStatusBarVisualProvider_Split normalIconSize]  (87 条)
+0    stp     d9, d8, [sp, #-0x40]!
+4    stp     x22, x21, [sp, #0x10]
+8    stp     x20, x19, [sp, #0x20]
+12   stp     x29, x30, [sp, #0x30]
+16   add     x29, sp, #0x30
+20   mov     x19, x0
+24   bl      0x2024b4060                                ; objc_msgSend$normalIconScale
+28   fmov    d8, d0
+32   mov     x0, x19
+36   bl      0x2024b9880                                ; objc_msgSend$statusBar
+40   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+44   mov     x19, x0
+48   bl      0x2024ac620                                ; objc_msgSend$_effectiveTargetScreen
+52   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+56   mov     x20, x0
+60   bl      0x2024ad060                                ; objc_msgSend$_scale
+64   fmov    d1, #2.50000000
+68   fcmp    d0, d1
+72   b.le    0x20245fb98                                ; <+100>
+76   adrp    x8, 41
+80   ldr     d0, [x8, #0x40]                            ; = 1.08
+84   fcmp    d8, d0
+88   b.ne    0x20245fbb0                                ; <+124>
+92   mov     w21, #0x6                                  ; =6
+96   b       0x20245fc0c                                ; <+216>
+100  adrp    x8, 39
+104  ldr     d0, [x8, #0xbd8]                           ; = 1.07
+108  fcmp    d8, d0
+112  b.ne    0x20245fbc8                                ; <+148>
+116  mov     w21, #0x5                                  ; =5
+120  b       0x20245fc0c                                ; <+216>
+124  adrp    x8, 41
+128  ldr     d0, [x8, #0x48]                            ; = 1.06
+132  fcmp    d8, d0
+136  b.ne    0x20245fbe0                                ; <+172>
+140  mov     w21, #0x4                                  ; =4
+144  b       0x20245fc0c                                ; <+216>
+148  adrp    x8, 39
+152  ldr     d0, [x8, #0xbb8]                           ; = 1.16
+156  fcmp    d8, d0
+160  b.ne    0x20245fbf8                                ; <+196>
+164  mov     w21, #0x9                                  ; =9
+168  b       0x20245fc0c                                ; <+216>
+172  adrp    x8, 39
+176  ldr     d0, [x8, #0xd90]                           ; = 1.12
+180  fcmp    d8, d0
+184  b.ne    0x20245fc2c                                ; <+248>
+188  mov     w21, #0x7                                  ; =7
+192  b       0x20245fc0c                                ; <+216>
+196  adrp    x8, 41
+200  ldr     d0, [x8, #0x38]                            ; = 1.2412
+204  fcmp    d8, d0
+208  mov     w8, #0xb                                   ; =11
+212  csinc   x21, x8, xzr, eq
+216  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+220  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+224  mov     x0, x21
+228  ldp     x29, x30, [sp, #0x30]
+232  ldp     x20, x19, [sp, #0x20]
+236  ldp     x22, x21, [sp, #0x10]
+240  ldp     d9, d8, [sp], #0x40
+244  ret
+248  adrp    x8, 39
+252  ldr     d0, [x8, #0xd60]                           ; = 1.26
+256  fcmp    d8, d0
+260  b.ne    0x20245fc44                                ; <+272>
+264  mov     w21, #0x8                                  ; =8
+268  b       0x20245fc0c                                ; <+216>
+272  adrp    x8, 39
+276  ldr     d0, [x8, #0xbb8]                           ; = 1.16
+280  fcmp    d8, d0
+284  b.ne    0x20245fc5c                                ; <+296>
+288  mov     w21, #0xa                                  ; =10
+292  b       0x20245fc0c                                ; <+216>
+296  adrp    x8, 41
+300  ldr     d0, [x8, #0x38]                            ; = 1.2412
+304  fcmp    d8, d0
+308  b.ne    0x20245fc74                                ; <+320>
+312  mov     w21, #0xc                                  ; =12
+316  b       0x20245fc0c                                ; <+216>
+320  adrp    x8, 39
+324  ldr     d0, [x8, #0xd68]                           ; = 1.2992000000000001
+328  fcmp    d8, d0
+332  mov     w8, #0x2                                   ; =2
+336  mov     w9, #0xd                                   ; =13
+340  csel    x21, x9, x8, eq
+344  b       0x20245fc0c                                ; <+216>

### -[STUIStatusBarVisualProvider_Split expandedIconSize]  (87 条)
+0    stp     d9, d8, [sp, #-0x40]!
+4    stp     x22, x21, [sp, #0x10]
+8    stp     x20, x19, [sp, #0x20]
+12   stp     x29, x30, [sp, #0x30]
+16   add     x29, sp, #0x30
+20   mov     x19, x0
+24   bl      0x2024b19a0                                ; objc_msgSend$expandedIconScale
+28   fmov    d8, d0
+32   mov     x0, x19
+36   bl      0x2024b9880                                ; objc_msgSend$statusBar
+40   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+44   mov     x19, x0
+48   bl      0x2024ac620                                ; objc_msgSend$_effectiveTargetScreen
+52   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+56   mov     x20, x0
+60   bl      0x2024ad060                                ; objc_msgSend$_scale
+64   fmov    d1, #2.50000000
+68   fcmp    d0, d1
+72   b.le    0x20245fcf4                                ; <+100>
+76   adrp    x8, 41
+80   ldr     d0, [x8, #0x40]                            ; = 1.08
+84   fcmp    d8, d0
+88   b.ne    0x20245fd0c                                ; <+124>
+92   mov     w21, #0x6                                  ; =6
+96   b       0x20245fd68                                ; <+216>
+100  adrp    x8, 39
+104  ldr     d0, [x8, #0xbd8]                           ; = 1.07
+108  fcmp    d8, d0
+112  b.ne    0x20245fd24                                ; <+148>
+116  mov     w21, #0x5                                  ; =5
+120  b       0x20245fd68                                ; <+216>
+124  adrp    x8, 41
+128  ldr     d0, [x8, #0x48]                            ; = 1.06
+132  fcmp    d8, d0
+136  b.ne    0x20245fd3c                                ; <+172>
+140  mov     w21, #0x4                                  ; =4
+144  b       0x20245fd68                                ; <+216>
+148  adrp    x8, 39
+152  ldr     d0, [x8, #0xbb8]                           ; = 1.16
+156  fcmp    d8, d0
+160  b.ne    0x20245fd54                                ; <+196>
+164  mov     w21, #0x9                                  ; =9
+168  b       0x20245fd68                                ; <+216>
+172  adrp    x8, 39
+176  ldr     d0, [x8, #0xd90]                           ; = 1.12
+180  fcmp    d8, d0
+184  b.ne    0x20245fd88                                ; <+248>
+188  mov     w21, #0x7                                  ; =7
+192  b       0x20245fd68                                ; <+216>
+196  adrp    x8, 41
+200  ldr     d0, [x8, #0x38]                            ; = 1.2412
+204  fcmp    d8, d0
+208  mov     w8, #0xb                                   ; =11
+212  csinc   x21, x8, xzr, eq
+216  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+220  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+224  mov     x0, x21
+228  ldp     x29, x30, [sp, #0x30]
+232  ldp     x20, x19, [sp, #0x20]
+236  ldp     x22, x21, [sp, #0x10]
+240  ldp     d9, d8, [sp], #0x40
+244  ret
+248  adrp    x8, 39
+252  ldr     d0, [x8, #0xd60]                           ; = 1.26
+256  fcmp    d8, d0
+260  b.ne    0x20245fda0                                ; <+272>
+264  mov     w21, #0x8                                  ; =8
+268  b       0x20245fd68                                ; <+216>
+272  adrp    x8, 39
+276  ldr     d0, [x8, #0xbb8]                           ; = 1.16
+280  fcmp    d8, d0
+284  b.ne    0x20245fdb8                                ; <+296>
+288  mov     w21, #0xa                                  ; =10
+292  b       0x20245fd68                                ; <+216>
+296  adrp    x8, 41
+300  ldr     d0, [x8, #0x38]                            ; = 1.2412
+304  fcmp    d8, d0
+308  b.ne    0x20245fdd0                                ; <+320>
+312  mov     w21, #0xc                                  ; =12
+316  b       0x20245fd68                                ; <+216>
+320  adrp    x8, 39
+324  ldr     d0, [x8, #0xd68]                           ; = 1.2992000000000001
+328  fcmp    d8, d0
+332  mov     w8, #0x2                                   ; =2
+336  mov     w9, #0xd                                   ; =13
+340  csel    x21, x9, x8, eq
+344  b       0x20245fd68                                ; <+216>

### -[STUIStatusBarVisualProvider_Split normalIconScale]  (3 条)
+0    adrp    x8, 39
+4    ldr     d0, [x8, #0xd90]                           ; = 1.12
+8    ret

### -[STUIStatusBarVisualProvider_Split normalFont]  (34 条)
+0    stp     x22, x21, [sp, #-0x30]!
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   mov     x19, x0
+20   bl      0x20247bc7c                                ; symbol stub for: UIAccessibilityIsBoldTextEnabled
+24   mov     x8, x0
+28   adrp    x21, 47050
+32   add     x21, x21, #0x238                           ; _MergedGlobals.5
+36   ldr     x0, [x21, #0x10]
+40   ldrb    w9, [x21]
+44   cmp     x0, #0x0
+48   ccmp    w9, w8, #0x0, ne
+52   b.eq    0x20245f85c                                ; <+120>
+56   strb    w8, [x21]
+60   adrp    x8, 51521
+64   ldr     x20, [x8, #0x5b8]
+68   mov     x0, x19
+72   bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+76   bl      0x2024af480                                ; objc_msgSend$baseFontSize
+80   adrp    x8, 51490
+84   ldr     x8, [x8, #0xe98]
+88   ldr     d1, [x8]
+92   mov     x0, x20
+96   bl      0x2024ba040                                ; objc_msgSend$systemFontOfSize:weight:
+100  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+104  ldr     x8, [x21, #0x10]
+108  str     x0, [x21, #0x10]
+112  bl      0x20247c048                                ; symbol stub for: objc_release_x8
+116  ldr     x0, [x21, #0x10]
+120  ldp     x29, x30, [sp, #0x20]
+124  ldp     x20, x19, [sp, #0x10]
+128  ldp     x22, x21, [sp], #0x30
+132  b       0x20247c078                                ; symbol stub for: objc_retainAutoreleaseReturnValue

### -[STUIStatusBarVisualProvider_Split emphasizedFont]  (36 条)
+0    stp     x22, x21, [sp, #-0x30]!
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   mov     x19, x0
+20   bl      0x20247bc7c                                ; symbol stub for: UIAccessibilityIsBoldTextEnabled
+24   mov     x8, x0
+28   adrp    x21, 47050
+32   add     x21, x21, #0x23a                           ; _MergedGlobals.5
+36   ldur    x0, [x21, #0x1e]
+40   ldrb    w9, [x21]
+44   cmp     x0, #0x0
+48   ccmp    w9, w8, #0x0, ne
+52   b.eq    0x20245f974                                ; <+128>
+56   strb    w8, [x21]
+60   adrp    x8, 51521
+64   ldr     x20, [x8, #0x5b8]
+68   mov     x0, x19
+72   bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+76   bl      0x2024af480                                ; objc_msgSend$baseFontSize
+80   fmov    d1, #2.00000000
+84   fadd    d0, d0, d1
+88   adrp    x8, 51490
+92   ldr     x8, [x8, #0xea8]
+96   ldr     d1, [x8]
+100  mov     x0, x20
+104  bl      0x2024ba040                                ; objc_msgSend$systemFontOfSize:weight:
+108  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+112  ldur    x8, [x21, #0x1e]
+116  stur    x0, [x21, #0x1e]
+120  bl      0x20247c048                                ; symbol stub for: objc_release_x8
+124  ldur    x0, [x21, #0x1e]
+128  ldp     x29, x30, [sp, #0x20]
+132  ldp     x20, x19, [sp, #0x10]
+136  ldp     x22, x21, [sp], #0x30
+140  b       0x20247c078                                ; symbol stub for: objc_retainAutoreleaseReturnValue

### -[STUIStatusBarVisualProvider_Split styleAttributesForStyle:]  (129 条)
+0    sub     sp, sp, #0x60
+4    stp     d9, d8, [sp, #0x10]
+8    stp     x24, x23, [sp, #0x20]
+12   stp     x22, x21, [sp, #0x30]
+16   stp     x20, x19, [sp, #0x40]
+20   stp     x29, x30, [sp, #0x50]
+24   add     x29, sp, #0x50
+28   mov     x20, x0
+32   adrp    x8, 51520
+36   ldr     x8, [x8, #0xd8]                            ; Class STUIStatusBarVisualProvider_Split
+40   stp     x0, x8, [sp]
+44   adrp    x8, -138090
+48   add     x1, x8, #0x525
+52   mov     x0, sp
+56   bl      0x20247bf70                                ; symbol stub for: objc_msgSendSuper2
+60   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+64   mov     x19, x0
+68   bl      0x2024b3dc0                                ; objc_msgSend$mode
+72   cmp     x0, #0x3
+76   b.hi    0x202461bb0                                ; <+468>
+80   adrp    x8, 39
+84   add     x8, x8, #0x178                             ; STUIStatusBarVisualProvider_CarPlayPillAppearanceDuration
+88   adr     x9, 0x202461a44                            ; <+104>
+92   ldrb    w10, [x8, x0]
+96   add     x9, x9, x10, lsl #2
+100  br      x9
+104  mov     x0, x20
+108  bl      0x2024b19a0                                ; objc_msgSend$expandedIconScale
+112  mov     x0, x19
+116  bl      0x2024b73c0                                ; objc_msgSend$setIconScale:
+120  mov     x0, x20
+124  bl      0x2024b19c0                                ; objc_msgSend$expandedIconSize
+128  mov     x2, x0
+132  mov     x0, x19
+136  bl      0x2024b73e0                                ; objc_msgSend$setIconSize:
+140  mov     x0, x20
+144  bl      0x2024b1960                                ; objc_msgSend$expandedFont
+148  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+152  mov     x21, x0
+156  mov     x0, x19
+160  mov     x2, x21
+164  bl      0x2024b7140                                ; objc_msgSend$setFont:
+168  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+172  mov     x0, x20
+176  bl      0x2024b1960                                ; objc_msgSend$expandedFont
+180  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+184  mov     x21, x0
+188  mov     x0, x19
+192  mov     x2, x21
+196  bl      0x2024b6e00                                ; objc_msgSend$setEmphasizedFont:
+200  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+204  mov     x0, x20
+208  bl      0x2024b1960                                ; objc_msgSend$expandedFont
+212  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+216  b       0x202461b9c                                ; <+448>
+220  adrp    x23, 51519
+224  ldr     x0, [x23, #0x568]
+228  bl      0x2024b3500                                ; objc_msgSend$labelColor
+232  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+236  mov     x21, x0
+240  adrp    x8, 38
+244  ldr     d8, [x8, #0x6f0]                           ; = 0.8
+248  fmov    d0, d8
+252  bl      0x2024afe60                                ; objc_msgSend$colorWithAlphaComponent:
+256  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+260  mov     x22, x0
+264  mov     x0, x19
+268  mov     x2, x22
+272  bl      0x2024b8c00                                ; objc_msgSend$setTextColor:
+276  bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+280  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+284  ldr     x0, [x23, #0x568]
+288  bl      0x2024b3500                                ; objc_msgSend$labelColor
+292  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+296  mov     x21, x0
+300  fmov    d0, d8
+304  bl      0x2024afe60                                ; objc_msgSend$colorWithAlphaComponent:
+308  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+312  mov     x22, x0
+316  mov     x0, x19
+320  mov     x2, x22
+324  bl      0x2024b7480                                ; objc_msgSend$setImageTintColor:
+328  bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+332  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+336  mov     x0, x20
+340  bl      0x2024b4060                                ; objc_msgSend$normalIconScale
+344  mov     x0, x19
+348  bl      0x2024b73c0                                ; objc_msgSend$setIconScale:
+352  mov     x0, x20
+356  bl      0x2024b4080                                ; objc_msgSend$normalIconSize
+360  mov     x2, x0
+364  mov     x0, x19
+368  bl      0x2024b73e0                                ; objc_msgSend$setIconSize:
+372  mov     x0, x20
+376  bl      0x2024b4040                                ; objc_msgSend$normalFont
+380  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+384  mov     x21, x0
+388  mov     x0, x19
+392  mov     x2, x21
+396  bl      0x2024b7140                                ; objc_msgSend$setFont:
+400  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+404  mov     x0, x20
+408  bl      0x2024b12c0                                ; objc_msgSend$emphasizedFont
+412  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+416  mov     x21, x0
+420  mov     x0, x19
+424  mov     x2, x21
+428  bl      0x2024b6e00                                ; objc_msgSend$setEmphasizedFont:
+432  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+436  mov     x0, x20
+440  bl      0x2024b9620                                ; objc_msgSend$smallFont
+444  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+448  mov     x20, x0
+452  mov     x0, x19
+456  mov     x2, x20
+460  bl      0x2024b8820                                ; objc_msgSend$setSmallFont:
+464  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+468  adrp    x2, 51520
+472  add     x2, x2, #0x650
+476  mov     x0, x19
+480  bl      0x2024b7460                                ; objc_msgSend$setImageNamePrefixes:
+484  mov     x0, x19
+488  ldp     x29, x30, [sp, #0x50]
+492  ldp     x20, x19, [sp, #0x40]
+496  ldp     x22, x21, [sp, #0x30]
+500  ldp     x24, x23, [sp, #0x20]
+504  ldp     d9, d8, [sp, #0x10]
+508  add     sp, sp, #0x60
+512  b       0x20247bef8                                ; symbol stub for: objc_autoreleaseReturnValue

### -[STUIStatusBarVisualProvider_Split overriddenStyleAttributesForDisplayItemWithIdentifier:]  (80 条)
+0    stp     x22, x21, [sp, #-0x30]!
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   mov     x20, x0
+20   bl      0x20247c0c0                                ; symbol stub for: objc_retain_x2
+24   mov     x19, x0
+28   adrp    x8, 51519
+32   ldr     x0, [x8, #0x6a0]                           ; Class STUIStatusBarNavigationItem
+36   bl      0x2024b0860                                ; objc_msgSend$defaultDisplayIdentifier
+40   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+44   mov     x21, x0
+48   bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+52   cmp     x21, x19
+56   b.eq    0x202461e64                                ; <+160>
+60   adrp    x22, 51519
+64   ldr     x0, [x22, #0x6d8]                          ; Class STUIStatusBarIndicatorLocationItem
+68   bl      0x2024b0860                                ; objc_msgSend$defaultDisplayIdentifier
+72   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+76   cmp     x0, x19
+80   b.eq    0x202461e88                                ; <+196>
+84   mov     x21, x0
+88   ldr     x0, [x22, #0x6d8]                          ; Class STUIStatusBarIndicatorLocationItem
+92   bl      0x2024b4cc0                                ; objc_msgSend$prominentDisplayIdentifier
+96   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+100  mov     x22, x0
+104  bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+108  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+112  cmp     x22, x19
+116  b.eq    0x202461e8c                                ; <+200>
+120  adrp    x8, 51519
+124  ldr     x0, [x8, #0x9e8]                           ; Class STUIStatusBarVoiceControlItem
+128  bl      0x2024b0860                                ; objc_msgSend$defaultDisplayIdentifier
+132  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+136  mov     x21, x0
+140  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+144  cmp     x21, x19
+148  b.eq    0x202461eb0                                ; <+236>
+152  mov     x21, #0x0                                  ; =0
+156  b       0x202461eec                                ; <+296>
+160  adrp    x8, 51519
+164  ldr     x0, [x8, #0x640]                           ; Class STUIStatusBarStyleAttributes
+168  bl      0x2024b4560                                ; objc_msgSend$overriddenStyleAttributes
+172  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+176  mov     x21, x0
+180  mov     x0, x20
+184  bl      0x2024b9620                                ; objc_msgSend$smallFont
+188  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+192  b       0x202461ed8                                ; <+276>
+196  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+200  adrp    x8, 51519
+204  ldr     x0, [x8, #0x640]                           ; Class STUIStatusBarStyleAttributes
+208  bl      0x2024b4560                                ; objc_msgSend$overriddenStyleAttributes
+212  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+216  mov     x21, x0
+220  mov     x0, x20
+224  bl      0x2024b12c0                                ; objc_msgSend$emphasizedFont
+228  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+232  b       0x202461ed8                                ; <+276>
+236  adrp    x8, 51519
+240  ldr     x0, [x8, #0x640]                           ; Class STUIStatusBarStyleAttributes
+244  bl      0x2024b4560                                ; objc_msgSend$overriddenStyleAttributes
+248  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+252  mov     x21, x0
+256  mov     w2, #0x1                                   ; =1
+260  bl      0x2024b8b00                                ; objc_msgSend$setSymbolScale:
+264  mov     x0, x20
+268  bl      0x2024bad40                                ; objc_msgSend$voiceControlFont
+272  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+276  mov     x20, x0
+280  mov     x0, x21
+284  mov     x2, x20
+288  bl      0x2024b7140                                ; objc_msgSend$setFont:
+292  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+296  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+300  mov     x0, x21
+304  ldp     x29, x30, [sp, #0x20]
+308  ldp     x20, x19, [sp, #0x10]
+312  ldp     x22, x21, [sp], #0x30
+316  b       0x20247bef8                                ; symbol stub for: objc_autoreleaseReturnValue

### -[STUIStatusBarVisualProvider_DynamicSplit normalRoundFont]  (37 条)
+0    stp     x22, x21, [sp, #-0x30]!
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   mov     x19, x0
+20   bl      0x20247bc7c                                ; symbol stub for: UIAccessibilityIsBoldTextEnabled
+24   mov     x8, x0
+28   adrp    x21, 47100
+32   add     x21, x21, #0x168                           ; _MergedGlobals.5
+36   ldr     x0, [x21, #0x8]
+40   ldrb    w9, [x21]
+44   cmp     x0, #0x0
+48   ccmp    w9, w8, #0x0, ne
+52   b.eq    0x20242d738                                ; <+132>
+56   strb    w8, [x21]
+60   adrp    x8, 51571
+64   ldr     x20, [x8, #0x5b8]
+68   mov     x0, x19
+72   bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+76   bl      0x2024af480                                ; objc_msgSend$baseFontSize
+80   adrp    x8, 51540
+84   ldr     x8, [x8, #0xe98]
+88   ldr     d1, [x8]
+92   adrp    x8, 51540
+96   ldr     x8, [x8, #0xe70]
+100  ldr     x2, [x8]
+104  mov     x0, x20
+108  bl      0x2024ba060                                ; objc_msgSend$systemFontOfSize:weight:design:
+112  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+116  ldr     x8, [x21, #0x8]
+120  str     x0, [x21, #0x8]
+124  bl      0x20247c048                                ; symbol stub for: objc_release_x8
+128  ldr     x0, [x21, #0x8]
+132  ldp     x29, x30, [sp, #0x20]
+136  ldp     x20, x19, [sp, #0x10]
+140  ldp     x22, x21, [sp], #0x30
+144  b       0x20247c078                                ; symbol stub for: objc_retainAutoreleaseReturnValue

### -[STUIStatusBarVisualProvider_DynamicSplit overriddenStyleAttributesForDisplayItemWithIdentifier:]  (55 条)
+0    sub     sp, sp, #0x40
+4    stp     x22, x21, [sp, #0x10]
+8    stp     x20, x19, [sp, #0x20]
+12   stp     x29, x30, [sp, #0x30]
+16   add     x29, sp, #0x30
+20   mov     x20, x0
+24   bl      0x20247c0c0                                ; symbol stub for: objc_retain_x2
+28   mov     x19, x0
+32   adrp    x22, 51567
+36   ldr     x0, [x22, #0x7f8]                          ; Class STUIStatusBarBatteryItem
+40   bl      0x2024b23a0                                ; objc_msgSend$iconDisplayIdentifier
+44   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+48   cmp     x0, x19
+52   b.eq    0x202431668                                ; <+136>
+56   mov     x21, x0
+60   ldr     x0, [x22, #0x7f8]                          ; Class STUIStatusBarBatteryItem
+64   bl      0x2024b9840                                ; objc_msgSend$staticIconDisplayIdentifier
+68   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+72   mov     x22, x0
+76   bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+80   bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+84   cmp     x22, x19
+88   b.eq    0x20243166c                                ; <+140>
+92   adrp    x8, 51567
+96   ldr     x8, [x8, #0xf10]                           ; Class STUIStatusBarVisualProvider_DynamicSplit
+100  stp     x20, x8, [sp]
+104  adrp    x8, -138146
+108  add     x1, x8, #0xe0b
+112  mov     x0, sp
+116  mov     x2, x19
+120  bl      0x20247bf70                                ; symbol stub for: objc_msgSendSuper2
+124  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+128  mov     x21, x0
+132  b       0x2024316a0                                ; <+192>
+136  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+140  adrp    x8, 51567
+144  ldr     x0, [x8, #0x640]                           ; Class STUIStatusBarStyleAttributes
+148  bl      0x2024b4560                                ; objc_msgSend$overriddenStyleAttributes
+152  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+156  mov     x21, x0
+160  mov     x0, x20
+164  bl      0x2024b40a0                                ; objc_msgSend$normalRoundFont
+168  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+172  mov     x20, x0
+176  mov     x0, x21
+180  mov     x2, x20
+184  bl      0x2024b7140                                ; objc_msgSend$setFont:
+188  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+192  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+196  mov     x0, x21
+200  ldp     x29, x30, [sp, #0x30]
+204  ldp     x20, x19, [sp, #0x20]
+208  ldp     x22, x21, [sp, #0x10]
+212  add     sp, sp, #0x40
+216  b       0x20247bef8                                ; symbol stub for: objc_autoreleaseReturnValue

### -[STUIStatusBarVisualProvider_DynamicSplit normalIconScale]  (3 条)
+0    adrp    x8, 89
+4    ldr     d0, [x8, #0xd60]                           ; = 1.26
+8    ret

### -[STUIStatusBarVisualProvider_DynamicSplitMedium normalIconScale]  (3 条)
+0    adrp    x8, 84
+4    ldr     d0, [x8, #0xd90]                           ; = 1.12
+8    ret

### -[STUIStatusBarVisualProvider_FixedSplit overriddenStyleAttributesForDisplayItemWithIdentifier:]  (65 条)
+0    sub     sp, sp, #0x40
+4    stp     x22, x21, [sp, #0x10]
+8    stp     x20, x19, [sp, #0x20]
+12   stp     x29, x30, [sp, #0x30]
+16   add     x29, sp, #0x30
+20   mov     x21, x0
+24   bl      0x20247c0c0                                ; symbol stub for: objc_retain_x2
+28   mov     x19, x0
+32   adrp    x8, 51510
+36   ldr     x0, [x8, #0x708]                           ; Class STUIStatusBarExpandedPillBackgroundActivityItem
+40   bl      0x2024b4780                                ; objc_msgSend$pillCombinedDisplayIdentifier
+44   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+48   mov     x20, x0
+52   bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+56   cmp     x20, x19
+60   b.eq    0x20246a200                                ; <+108>
+64   adrp    x8, 51511
+68   ldr     x8, [x8, #0xe0]                            ; Class STUIStatusBarVisualProvider_FixedSplit
+72   stp     x21, x8, [sp]
+76   adrp    x8, -138203
+80   add     x1, x8, #0xe0b
+84   mov     x0, sp
+88   mov     x2, x19
+92   bl      0x20247bf70                                ; symbol stub for: objc_msgSendSuper2
+96   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+100  mov     x20, x0
+104  b       0x20246a27c                                ; <+232>
+108  adrp    x8, 51510
+112  ldr     x0, [x8, #0x640]                           ; Class STUIStatusBarStyleAttributes
+116  bl      0x2024b4560                                ; objc_msgSend$overriddenStyleAttributes
+120  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+124  mov     x20, x0
+128  mov     x0, x21
+132  bl      0x2024b1a20                                ; objc_msgSend$expandedPillFont
+136  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+140  mov     x22, x0
+144  mov     x0, x20
+148  mov     x2, x22
+152  bl      0x2024b7140                                ; objc_msgSend$setFont:
+156  bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+160  mov     x0, x21
+164  bl      0x2024b1a20                                ; objc_msgSend$expandedPillFont
+168  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+172  mov     x22, x0
+176  mov     x0, x20
+180  mov     x2, x22
+184  bl      0x2024b8820                                ; objc_msgSend$setSmallFont:
+188  bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+192  mov     x0, x21
+196  bl      0x2024b1a80                                ; objc_msgSend$expandedPillSize
+200  adrp    x8, 28
+204  ldr     d0, [x8, #0xbc0]                           ; = 21.333333333333332
+208  fdiv    d0, d1, d0
+212  mov     x0, x20
+216  bl      0x2024b73c0                                ; objc_msgSend$setIconScale:
+220  mov     x0, x20
+224  mov     w2, #0x2                                   ; =2
+228  bl      0x2024b8b00                                ; objc_msgSend$setSymbolScale:
+232  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+236  mov     x0, x20
+240  ldp     x29, x30, [sp, #0x30]
+244  ldp     x20, x19, [sp, #0x20]
+248  ldp     x22, x21, [sp, #0x10]
+252  add     sp, sp, #0x40
+256  b       0x20247bef8                                ; symbol stub for: objc_autoreleaseReturnValue

### -[STUIStatusBarVisualProvider_Split1170 normalIconScale]  (3 条)
+0    adrp    x8, 30
+4    ldr     d0, [x8, #0x48]                            ; = 1.06
+8    ret

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

### STUIStatusBarGetVisualProviderClassForScreen  (140 条)
+0    sub     sp, sp, #0xb0
+4    stp     d9, d8, [sp, #0x50]
+8    stp     x26, x25, [sp, #0x60]
+12   stp     x24, x23, [sp, #0x70]
+16   stp     x22, x21, [sp, #0x80]
+20   stp     x20, x19, [sp, #0x90]
+24   stp     x29, x30, [sp, #0xa0]
+28   add     x29, sp, #0xa0
+32   mov     x20, x1
+36   adrp    x8, 51531
+40   ldr     x8, [x8, #0xfd0]
+44   ldr     x8, [x8]
+48   str     x8, [sp, #0x48]
+52   bl      0x20247c060                                ; symbol stub for: objc_retain
+56   mov     x19, x0
+60   bl      0x20247c0cc                                ; symbol stub for: objc_retain_x20
+64   mov     x20, x0
+68   mov     x0, x19
+72   bl      0x2024acb40                                ; objc_msgSend$_isEmbeddedScreen
+76   mov     x21, x0
+80   adrp    x25, 47091
+84   cbz     w0, 0x20243682c                            ; <+96>
+88   ldr     x22, [x25, #0x1b8]
+92   cbnz    x22, 0x2024369ac                           ; <+480>
+96   cbz     w21, 0x2024368ac                           ; <+224>
+100  adrp    x8, 51562
+104  ldr     x0, [x8, #0x598]                           ; Class STUIStatusBarSettingsDomain
+108  bl      0x2024b5620                                ; objc_msgSend$rootSettings
+112  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+116  mov     x22, x0
+120  bl      0x2024bace0                                ; objc_msgSend$visualProviderSettings
+124  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+128  mov     x24, x0
+132  bl      0x2024baca0                                ; objc_msgSend$visualProviderClassName
+136  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+140  mov     x23, x0
+144  bl      0x20247c00c                                ; symbol stub for: objc_release_x24
+148  bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+152  mov     x0, x23
+156  bl      0x2024b3860                                ; objc_msgSend$length
+160  cbz     x0, 0x2024368a8                            ; <+220>
+164  mov     x0, x23
+168  bl      0x20247bc34                                ; symbol stub for: NSClassFromString
+172  cbz     x0, 0x2024368a8                            ; <+220>
+176  mov     x22, x0
+180  adrp    x26, 51562
+184  mov     x24, x0
+188  ldr     x1, [x26, #0x4a8]
+192  mov     x0, x24
+196  bl      0x20247be08                                ; symbol stub for: class_conformsToProtocol
+200  tbnz    w0, #0x0, 0x202436990                      ; <+452>
+204  mov     x0, x24
+208  bl      0x20247be20                                ; symbol stub for: class_getSuperclass
+212  mov     x24, x0
+216  cbnz    x0, 0x202436888                            ; <+188>
+220  bl      0x20247c000                                ; symbol stub for: objc_release_x23
+224  mov     x0, x19
+228  mov     x1, x20
+232  bl      0x2024369fc                                ; STUIStatusBarGetNativeVisualProviderClassForScreenWithVisualProviderInfo
+236  mov     x22, x0
+240  cbnz    x0, 0x2024369a4                            ; <+472>
+244  mov     x0, x19
+248  bl      0x2024ad7e0                                ; objc_msgSend$_unjailedReferenceBounds
+252  bl      0x20247bbb0                                ; symbol stub for: CGRectGetWidth
+256  fmov    d8, d0
+260  mov     x0, x19
+264  bl      0x2024accc0                                ; objc_msgSend$_nativeScale
+268  fmov    d9, d0
+272  mov     x0, x19
+276  bl      0x2024ba520                                ; objc_msgSend$traitCollection
+280  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+284  mov     x22, x0
+288  bl      0x2024baa40                                ; objc_msgSend$userInterfaceIdiom
+292  mov     x23, x0
+296  bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+300  mov     x0, x19
+304  bl      0x2024ac4e0                                ; objc_msgSend$_displayCornerRadius
+308  adrp    x8, 51562
+312  ldr     x0, [x8, #0x520]
+316  str     d0, [sp, #0x20]
+320  str     x23, [sp, #0x18]
+324  stp     d8, d9, [sp, #0x8]
+328  str     x19, [sp]
+332  adrp    x2, 51536
+336  add     x2, x2, #0xa20                             ; @"No status bar visual provider for screen %@ (width: %.2f, scale: %.2f, idiom: %ld, cornerRadius: %.2f). Please see rdar://45025538."
+340  bl      0x2024b9b20                                ; objc_msgSend$stringWithFormat:
+344  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+348  mov     x23, x0
+352  bl      0x202439f7c                                ; _STUIStatusBar_Log
+356  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+360  mov     x22, x0
+364  mov     w1, #0x10                                  ; =16
+368  bl      0x20247c1bc                                ; symbol stub for: os_log_type_enabled
+372  cbz     w0, 0x202436978                            ; <+428>
+376  mov     w8, #0x102                                 ; =258
+380  movk    w8, #0x840, lsl #16
+384  str     w8, [sp, #0x30]
+388  stur    x23, [sp, #0x34]
+392  adrp    x0, -63
+396  add     x0, x0, #0x0
+400  adrp    x3, 88
+404  add     x3, x3, #0xb8d                             ; "%@"
+408  add     x4, sp, #0x30
+412  mov     x1, x22
+416  mov     w2, #0x10                                  ; =16
+420  mov     w5, #0xc                                   ; =12
+424  bl      0x20247bde4                                ; symbol stub for: _os_log_impl
+428  bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+432  adrp    x8, 51562
+436  ldr     x0, [x8, #0xa50]                           ; Class STUIStatusBarVisualProvider_Fallback
+440  bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+444  mov     x22, x0
+448  b       0x2024369a0                                ; <+468>
+452  str     x22, [sp]
+456  adrp    x0, 51536
+460  add     x0, x0, #0xa00                             ; @"WARNING: Using overridden status bar visual provider class: %@"
+464  bl      0x20247bc40                                ; symbol stub for: NSLog
+468  bl      0x20247c000                                ; symbol stub for: objc_release_x23
+472  cbz     w21, 0x2024369ac                           ; <+480>
+476  str     x22, [x25, #0x1b8]
+480  bl      0x20247c0e4                                ; symbol stub for: objc_retain_x22
+484  mov     x21, x0
+488  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+492  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+496  ldr     x8, [sp, #0x48]
+500  adrp    x9, 51531
+504  ldr     x9, [x9, #0xfd0]
+508  ldr     x9, [x9]
+512  cmp     x9, x8
+516  b.ne    0x2024369f8                                ; <+556>
+520  mov     x0, x21
+524  ldp     x29, x30, [sp, #0xa0]
+528  ldp     x20, x19, [sp, #0x90]
+532  ldp     x22, x21, [sp, #0x80]
+536  ldp     x24, x23, [sp, #0x70]
+540  ldp     x26, x25, [sp, #0x60]
+544  ldp     d9, d8, [sp, #0x50]
+548  add     sp, sp, #0xb0
+552  b       0x20247bef8                                ; symbol stub for: objc_autoreleaseReturnValue
+556  bl      0x20247bdcc                                ; symbol stub for: __stack_chk_fail

### STUIStatusBarGetVisualProviderSubclassForScreenWithVisualProviderInfo  (46 条)
+0    stp     x24, x23, [sp, #-0x40]!
+4    stp     x22, x21, [sp, #0x10]
+8    stp     x20, x19, [sp, #0x20]
+12   stp     x29, x30, [sp, #0x30]
+16   add     x29, sp, #0x30
+20   mov     x20, x2
+24   mov     x21, x0
+28   bl      0x20247c09c                                ; symbol stub for: objc_retain_x1
+32   mov     x19, x0
+36   bl      0x20247c0cc                                ; symbol stub for: objc_retain_x20
+40   mov     x20, x0
+44   adrp    x8, -138019
+48   add     x22, x8, #0xed
+52   mov     x0, x21
+56   mov     x1, x22
+60   bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+64   tbz     w0, #0x0, 0x202436c38                      ; <+144>
+68   mov     x0, x21
+72   bl      0x20247be20                                ; symbol stub for: class_getSuperclass
+76   cbz     x0, 0x202436c20                            ; <+120>
+80   mov     x23, x0
+84   mov     x0, x21
+88   mov     x1, x22
+92   bl      0x20247be14                                ; symbol stub for: class_getClassMethod
+96   mov     x24, x0
+100  mov     x0, x23
+104  mov     x1, x22
+108  bl      0x20247be14                                ; symbol stub for: class_getClassMethod
+112  cmp     x24, x0
+116  b.eq    0x202436c38                                ; <+144>
+120  mov     x0, x21
+124  mov     x2, x19
+128  mov     x3, x20
+132  bl      0x2024bad00                                ; objc_msgSend$visualProviderSubclassForScreen:visualProviderInfo:
+136  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+140  b       0x202436c3c                                ; <+148>
+144  bl      0x20247c0d8                                ; symbol stub for: objc_retain_x21
+148  mov     x21, x0
+152  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+156  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+160  mov     x0, x21
+164  ldp     x29, x30, [sp, #0x30]
+168  ldp     x20, x19, [sp, #0x20]
+172  ldp     x22, x21, [sp, #0x10]
+176  ldp     x24, x23, [sp], #0x40
+180  b       0x20247bef8                                ; symbol stub for: objc_autoreleaseReturnValue

### __88+[STUIStatusBarVisualProvider_Split visualProviderSubclassForScreen:visualProviderInfo:]_block_invoke  (57 条)
+0    stp     d11, d10, [sp, #-0x50]!
+4    stp     d9, d8, [sp, #0x10]
+8    stp     x22, x21, [sp, #0x20]
+12   stp     x20, x19, [sp, #0x30]
+16   stp     x29, x30, [sp, #0x40]
+20   add     x29, sp, #0x40
+24   mov     x19, x3
+28   mov     x21, x1
+32   mov     x20, x0
+36   mov     x0, x1
+40   bl      0x2024b3f20                                ; objc_msgSend$nativeDisplayWidth
+44   ldr     d1, [x20, #0x30]
+48   fabd    d0, d0, d1
+52   adrp    x8, 39
+56   ldr     d9, [x8, #0xd80]                           ; = 0.0001
+60   fcmp    d0, d9
+64   b.hi    0x20245f760                                ; <+204>
+68   ldr     x0, [x20, #0x20]
+72   bl      0x2024accc0                                ; objc_msgSend$_nativeScale
+76   fmov    d8, d0
+80   adrp    x8, -138175
+84   add     x1, x8, #0xbc4
+88   mov     x0, x21
+92   bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+96   tbz     w0, #0x0, 0x20245f704                      ; <+112>
+100  mov     x0, x21
+104  bl      0x2024b4f40                                ; objc_msgSend$referenceScreenScale
+108  b       0x20245f70c                                ; <+120>
+112  ldr     x0, [x20, #0x20]
+116  bl      0x2024ad060                                ; objc_msgSend$_scale
+120  fdiv    d8, d8, d0
+124  ldp     d0, d10, [x20, #0x38]
+128  fmul    d11, d0, d8
+132  mov     x0, x21
+136  bl      0x2024b40e0                                ; objc_msgSend$notchSize
+140  fabd    d0, d0, d11
+144  fcmp    d0, d9
+148  b.hi    0x20245f760                                ; <+204>
+152  fmul    d0, d8, d10
+156  fabd    d0, d1, d0
+160  fcmp    d0, d9
+164  b.hi    0x20245f760                                ; <+204>
+168  ldr     x1, [x20, #0x20]
+172  mov     x0, x21
+176  mov     x2, #0x0                                   ; =0
+180  bl      0x202436ba8                                ; STUIStatusBarGetVisualProviderSubclassForScreenWithVisualProviderInfo
+184  ldr     x8, [x20, #0x28]
+188  ldr     x8, [x8, #0x8]
+192  str     x0, [x8, #0x18]
+196  mov     w8, #0x1                                   ; =1
+200  strb    w8, [x19]
+204  ldp     x29, x30, [sp, #0x40]
+208  ldp     x20, x19, [sp, #0x30]
+212  ldp     x22, x21, [sp, #0x20]
+216  ldp     d9, d8, [sp, #0x10]
+220  ldp     d11, d10, [sp], #0x50
+224  ret

### -[STUIStatusBar _updateStyleAttributes]  (52 条)
+0    sub     sp, sp, #0x30
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   bl      0x20247c060                                ; symbol stub for: objc_retain
+20   mov     x19, x0
+24   adrp    x8, 47024
+28   ldrsw   x8, [x8, #0x7e4]                           ; ivar 424
+32   ldr     w8, [x0, x8]
+36   tbz     w8, #0x13, 0x20247278c                     ; <+64>
+40   adrp    x9, 47024
+44   ldrsw   x9, [x9, #0x7e8]                           ; ivar 448
+48   ldrb    w9, [x19, x9]
+52   tst     w9, #0x3f
+56   b.eq    0x20247279c                                ; <+80>
+60   tbnz    w8, #0x16, 0x2024727a4                     ; <+88>
+64   bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+68   adrp    x8, 47024
+72   add     x8, x8, #0x7e8                             ; _MergedGlobals
+76   b       0x2024727c4                                ; <+120>
+80   bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+84   b       0x2024727bc                                ; <+112>
+88   mov     x0, x19
+92   bl      0x2024b3dc0                                ; objc_msgSend$mode
+96   mov     x20, x0
+100  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+104  cmp     x20, #0x1
+108  b.eq    0x202472790                                ; <+68>
+112  adrp    x8, 47024
+116  add     x8, x8, #0x82c                             ; _MergedGlobals
+120  ldrsw   x8, [x8]
+124  ldr     x20, [x19, x8]
+128  cmp     x20, #0x1
+132  cset    w8, eq
+136  ubfiz   x8, x8, #1, #32
+140  cmp     x20, #0x2
+144  csinc   x2, x8, xzr, ne
+148  mov     x0, x19
+152  bl      0x2024b7e60                                ; objc_msgSend$setOverrideUserInterfaceStyle:
+156  mov     x0, x19
+160  mov     x2, x20
+164  bl      0x2024b9ca0                                ; objc_msgSend$styleAttributesForStyle:
+168  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+172  mov     x2, x0
+176  str     x0, [sp, #0x8]
+180  mov     x0, x19
+184  bl      0x2024b8a60                                ; objc_msgSend$setStyleAttributes:
+188  ldr     x0, [sp, #0x8]
+192  ldp     x29, x30, [sp, #0x20]
+196  ldp     x20, x19, [sp, #0x10]
+200  add     sp, sp, #0x30
+204  b       0x20247bfb8                                ; symbol stub for: objc_release

### STUIStatusBarGetNativeVisualProviderClassForScreenWithVisualProviderInfo  (86 条)
+0    sub     sp, sp, #0xa0
+4    stp     x22, x21, [sp, #0x70]
+8    stp     x20, x19, [sp, #0x80]
+12   stp     x29, x30, [sp, #0x90]
+16   add     x29, sp, #0x90
+20   mov     x19, x1
+24   adrp    x8, 51531
+28   ldr     x8, [x8, #0xfd0]
+32   ldr     x8, [x8]
+36   stur    x8, [x29, #-0x28]
+40   bl      0x20247c060                                ; symbol stub for: objc_retain
+44   mov     x21, x0
+48   bl      0x20247c0b4                                ; symbol stub for: objc_retain_x19
+52   mov     x20, x0
+56   add     x8, sp, #0x40
+60   stp     xzr, x8, [sp, #0x40]
+64   adrp    x8, 80
+68   ldr     d0, [x8, #0xeb0]
+72   str     d0, [sp, #0x50]
+76   str     xzr, [sp, #0x58]
+80   adrp    x8, 51562
+84   ldr     x0, [x8, #0xa58]                           ; Class STUIStatusBarVisualProvider_iOS
+88   bl      0x20247bf7c                                ; symbol stub for: objc_opt_class
+92   stur    x0, [x29, #-0x30]
+96   adrp    x8, 51562
+100  ldr     x0, [x8, #0x628]
+104  sub     x2, x29, #0x30
+108  mov     w3, #0x1                                   ; =1
+112  bl      0x2024af160                                ; objc_msgSend$arrayWithObjects:count:
+116  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+120  mov     x19, x0
+124  adrp    x8, 51531
+128  ldr     x8, [x8, #0xf38]
+132  str     x8, [sp, #0x8]
+136  adrp    x8, 80
+140  ldr     d0, [x8, #0xb68]
+144  str     d0, [sp, #0x10]
+148  adrp    x8, 0
+152  add     x8, x8, #0xb54                             ; __STUIStatusBarGetNativeVisualProviderClassForScreenWithVisualProviderInfo_block_invoke
+156  adrp    x9, 51534
+160  add     x9, x9, #0x0                               ; __block_descriptor_56_e8_32s40s48r_e15_v32?0#8Q16^B24lr48l8s32l8s40l8
+164  stp     x8, x9, [sp, #0x18]
+168  add     x8, sp, #0x40
+172  str     x8, [sp, #0x38]
+176  bl      0x20247c0d8                                ; symbol stub for: objc_retain_x21
+180  mov     x21, x0
+184  str     x0, [sp, #0x28]
+188  bl      0x20247c0cc                                ; symbol stub for: objc_retain_x20
+192  mov     x20, x0
+196  str     x0, [sp, #0x30]
+200  add     x2, sp, #0x8
+204  mov     x0, x19
+208  bl      0x2024b1760                                ; objc_msgSend$enumerateObjectsUsingBlock:
+212  ldr     x8, [sp, #0x48]
+216  ldr     x8, [x8, #0x18]
+220  bl      0x20247c15c                                ; symbol stub for: objc_retain_x8
+224  mov     x22, x0
+228  ldr     x8, [sp, #0x30]
+232  bl      0x20247c048                                ; symbol stub for: objc_release_x8
+236  ldr     x8, [sp, #0x28]
+240  bl      0x20247c048                                ; symbol stub for: objc_release_x8
+244  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+248  add     x0, sp, #0x40
+252  mov     w1, #0x8                                   ; =8
+256  bl      0x20247bd3c                                ; symbol stub for: _Block_object_dispose
+260  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+264  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+268  ldur    x8, [x29, #-0x28]
+272  adrp    x9, 51531
+276  ldr     x9, [x9, #0xfd0]
+280  ldr     x9, [x9]
+284  cmp     x9, x8
+288  b.ne    0x202436b38                                ; <+316>
+292  mov     x0, x22
+296  ldp     x29, x30, [sp, #0x90]
+300  ldp     x20, x19, [sp, #0x80]
+304  ldp     x22, x21, [sp, #0x70]
+308  add     sp, sp, #0xa0
+312  b       0x20247bef8                                ; symbol stub for: objc_autoreleaseReturnValue
+316  bl      0x20247bdcc                                ; symbol stub for: __stack_chk_fail
+320  mov     x19, x0
+324  add     x0, sp, #0x40
+328  mov     w1, #0x8                                   ; =8
+332  bl      0x20247bd3c                                ; symbol stub for: _Block_object_dispose
+336  mov     x0, x19
+340  bl      0x20247bdb4                                ; symbol stub for: _Unwind_Resume

### -[STUIStatusBarDisplayItem applyStyleAttributes:]  (80 条)
+0    sub     sp, sp, #0x80
+4    stp     d9, d8, [sp, #0x30]
+8    stp     x24, x23, [sp, #0x40]
+12   stp     x22, x21, [sp, #0x50]
+16   stp     x20, x19, [sp, #0x60]
+20   stp     x29, x30, [sp, #0x70]
+24   add     x29, sp, #0x70
+28   mov     x21, x0
+32   bl      0x20247c0c0                                ; symbol stub for: objc_retain_x2
+36   mov     x19, x0
+40   mov     x0, x21
+44   bl      0x2024b0ea0                                ; objc_msgSend$displayable
+48   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+52   mov     x20, x0
+56   cbz     x0, 0x202459574                            ; <+284>
+60   adrp    x8, -138299
+64   add     x1, x8, #0x9b6
+68   mov     x0, x20
+72   bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+76   tbz     w0, #0x0, 0x202459574                      ; <+284>
+80   adrp    x8, -138054
+84   add     x1, x8, #0x6aa
+88   mov     x0, x20
+92   bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+96   tbz     w0, #0x0, 0x202459568                      ; <+272>
+100  mov     x0, x20
+104  bl      0x2024bada0                                ; objc_msgSend$wantsCrossfade
+108  cbz     w0, 0x202459568                            ; <+272>
+112  adrp    x23, 51527
+116  ldr     x0, [x23, #0x538]
+120  bl      0x2024acb60                                ; objc_msgSend$_isInAnimationBlock
+124  cbz     w0, 0x202459568                            ; <+272>
+128  ldr     x22, [x23, #0x538]
+132  mov     x0, x21
+136  bl      0x2024babe0                                ; objc_msgSend$view
+140  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+144  mov     x21, x0
+148  ldr     x0, [x23, #0x538]
+152  bl      0x2024ac2e0                                ; objc_msgSend$_currentAnimationDuration
+156  fmov    d8, d0
+160  adrp    x8, 51496
+164  ldr     x8, [x8, #0xf38]
+168  str     x8, [sp]
+172  adrp    x8, 45
+176  ldr     d0, [x8, #0xb68]
+180  str     d0, [sp, #0x8]
+184  adrp    x8, 0
+188  add     x8, x8, #0x598                             ; __49-[STUIStatusBarDisplayItem applyStyleAttributes:]_block_invoke
+192  adrp    x9, 51498
+196  add     x9, x9, #0x6f0                             ; __block_descriptor_48_e8_32s40s_e5_v8?0ls32l8s40l8
+200  stp     x8, x9, [sp, #0x10]
+204  bl      0x20247c0cc                                ; symbol stub for: objc_retain_x20
+208  str     x0, [sp, #0x20]
+212  bl      0x20247c0b4                                ; symbol stub for: objc_retain_x19
+216  str     x0, [sp, #0x28]
+220  mov     x4, sp
+224  mov     x0, x22
+228  mov     x2, x21
+232  fmov    d0, d8
+236  mov     w3, #0x500000                              ; =5242880
+240  mov     x5, #0x0                                   ; =0
+244  bl      0x2024ba5a0                                ; objc_msgSend$transitionWithView:duration:options:animations:completion:
+248  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+252  ldr     x8, [sp, #0x28]
+256  bl      0x20247c048                                ; symbol stub for: objc_release_x8
+260  ldr     x8, [sp, #0x20]
+264  bl      0x20247c048                                ; symbol stub for: objc_release_x8
+268  b       0x202459574                                ; <+284>
+272  mov     x0, x20
+276  mov     x2, x19
+280  bl      0x2024aefe0                                ; objc_msgSend$applyStyleAttributes:
+284  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+288  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+292  ldp     x29, x30, [sp, #0x70]
+296  ldp     x20, x19, [sp, #0x60]
+300  ldp     x22, x21, [sp, #0x50]
+304  ldp     x24, x23, [sp, #0x40]
+308  ldp     d9, d8, [sp, #0x30]
+312  add     sp, sp, #0x80
+316  ret

### -[STUIStatusBarItem applyStyleAttributes:toDisplayItem:]  (2 条)
+0    mov     x0, x3
+4    b       0x2024aefe0                                ; objc_msgSend$applyStyleAttributes:

### -[STUIStatusBarItem overriddenStyleAttributesForData:identifier:]  (2 条)
+0    mov     x0, #0x0                                   ; =0
+4    ret

### -[STUIStatusBarStyleAttributes styleAttributesWithOverrides:]  (144 条)
+0    stp     x22, x21, [sp, #-0x30]!
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   mov     x20, x0
+20   bl      0x20247c0c0                                ; symbol stub for: objc_retain_x2
+24   mov     x19, x0
+28   cbz     x0, 0x20246c51c                            ; <+544>
+32   cmp     x19, x20
+36   b.eq    0x20246c51c                                ; <+544>
+40   mov     x0, x20
+44   bl      0x2024b02e0                                ; objc_msgSend$copy
+48   mov     x20, x0
+52   mov     x0, x19
+56   bl      0x2024b23e0                                ; objc_msgSend$iconScale
+60   fcmp    d0, #0.0
+64   b.le    0x20246c350                                ; <+84>
+68   mov     x0, x19
+72   bl      0x2024b23e0                                ; objc_msgSend$iconScale
+76   mov     x0, x20
+80   bl      0x2024b73c0                                ; objc_msgSend$setIconScale:
+84   mov     x0, x19
+88   bl      0x2024b2400                                ; objc_msgSend$iconSize
+92   cbz     x0, 0x20246c370                            ; <+116>
+96   mov     x0, x19
+100  bl      0x2024b2400                                ; objc_msgSend$iconSize
+104  mov     x2, x0
+108  mov     x0, x20
+112  bl      0x2024b73e0                                ; objc_msgSend$setIconSize:
+116  mov     x0, x19
+120  bl      0x2024b9f80                                ; objc_msgSend$symbolScale
+124  cbz     x0, 0x20246c390                            ; <+148>
+128  mov     x0, x19
+132  bl      0x2024b9f80                                ; objc_msgSend$symbolScale
+136  mov     x2, x0
+140  mov     x0, x20
+144  bl      0x2024b8b00                                ; objc_msgSend$setSymbolScale:
+148  mov     x0, x19
+152  bl      0x2024b1d00                                ; objc_msgSend$font
+156  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+160  mov     x21, x0
+164  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+168  cbz     x21, 0x20246c3c8                           ; <+204>
+172  mov     x0, x19
+176  bl      0x2024b1d00                                ; objc_msgSend$font
+180  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+184  mov     x21, x0
+188  mov     x0, x20
+192  mov     x2, x21
+196  bl      0x2024b7140                                ; objc_msgSend$setFont:
+200  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+204  mov     x0, x19
+208  bl      0x2024b12c0                                ; objc_msgSend$emphasizedFont
+212  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+216  mov     x21, x0
+220  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+224  cbz     x21, 0x20246c400                           ; <+260>
+228  mov     x0, x19
+232  bl      0x2024b12c0                                ; objc_msgSend$emphasizedFont
+236  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+240  mov     x21, x0
+244  mov     x0, x20
+248  mov     x2, x21
+252  bl      0x2024b6e00                                ; objc_msgSend$setEmphasizedFont:
+256  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+260  mov     x0, x19
+264  bl      0x2024b9620                                ; objc_msgSend$smallFont
+268  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+272  mov     x21, x0
+276  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+280  cbz     x21, 0x20246c438                           ; <+316>
+284  mov     x0, x19
+288  bl      0x2024b9620                                ; objc_msgSend$smallFont
+292  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+296  mov     x21, x0
+300  mov     x0, x20
+304  mov     x2, x21
+308  bl      0x2024b8820                                ; objc_msgSend$setSmallFont:
+312  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+316  mov     x0, x19
+320  bl      0x2024ba240                                ; objc_msgSend$textColor
+324  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+328  mov     x21, x0
+332  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+336  cbz     x21, 0x20246c470                           ; <+372>
+340  mov     x0, x19
+344  bl      0x2024ba240                                ; objc_msgSend$textColor
+348  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+352  mov     x21, x0
+356  mov     x0, x20
+360  mov     x2, x21
+364  bl      0x2024b8c00                                ; objc_msgSend$setTextColor:
+368  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+372  mov     x0, x19
+376  bl      0x2024b2620                                ; objc_msgSend$imageTintColor
+380  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+384  mov     x21, x0
+388  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+392  cbz     x21, 0x20246c4a8                           ; <+428>
+396  mov     x0, x19
+400  bl      0x2024b2620                                ; objc_msgSend$imageTintColor
+404  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+408  mov     x21, x0
+412  mov     x0, x20
+416  mov     x2, x21
+420  bl      0x2024b7480                                ; objc_msgSend$setImageTintColor:
+424  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+428  mov     x0, x19
+432  bl      0x2024b24e0                                ; objc_msgSend$imageDimmedTintColor
+436  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+440  mov     x21, x0
+444  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+448  cbz     x21, 0x20246c4e0                           ; <+484>
+452  mov     x0, x19
+456  bl      0x2024b24e0                                ; objc_msgSend$imageDimmedTintColor
+460  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+464  mov     x21, x0
+468  mov     x0, x20
+472  mov     x2, x21
+476  bl      0x2024b7440                                ; objc_msgSend$setImageDimmedTintColor:
+480  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+484  mov     x0, x19
+488  bl      0x2024b25a0                                ; objc_msgSend$imageNamePrefixes
+492  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+496  mov     x21, x0
+500  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+504  cbz     x21, 0x20246c524                           ; <+552>
+508  mov     x0, x19
+512  bl      0x2024b25a0                                ; objc_msgSend$imageNamePrefixes
+516  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+520  mov     x21, x0
+524  mov     x0, x20
+528  mov     x2, x21
+532  bl      0x2024b7460                                ; objc_msgSend$setImageNamePrefixes:
+536  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+540  b       0x20246c524                                ; <+552>
+544  bl      0x20247c0cc                                ; symbol stub for: objc_retain_x20
+548  mov     x20, x0
+552  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+556  mov     x0, x20
+560  ldp     x29, x30, [sp, #0x20]
+564  ldp     x20, x19, [sp, #0x10]
+568  ldp     x22, x21, [sp], #0x30
+572  b       0x20247bef8                                ; symbol stub for: objc_autoreleaseReturnValue

### -[STUIStatusBarVisualProvider_iOS styleAttributesForStyle:]  (122 条)
+0    stp     x22, x21, [sp, #-0x30]!
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   mov     x21, x2
+20   adrp    x8, 51576
+24   ldr     x19, [x8, #0x640]                          ; Class STUIStatusBarStyleAttributes
+28   bl      0x2024b9880                                ; objc_msgSend$statusBar
+32   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+36   mov     x20, x0
+40   mov     x0, x19
+44   mov     x2, x20
+48   mov     x3, x21
+52   bl      0x2024b9c80                                ; objc_msgSend$styleAttributesForStatusBar:style:
+56   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+60   mov     x19, x0
+64   bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+68   mov     x0, x19
+72   bl      0x2024ba240                                ; objc_msgSend$textColor
+76   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+80   mov     x20, x0
+84   bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+88   cmp     x21, #0x1
+92   b.ne    0x20242869c                                ; <+180>
+96   cbnz    x20, 0x202428670                           ; <+136>
+100  adrp    x8, 51576
+104  ldr     x0, [x8, #0x568]
+108  bl      0x2024baea0                                ; objc_msgSend$whiteColor
+112  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+116  mov     x20, x0
+120  mov     x0, x19
+124  mov     x2, x20
+128  bl      0x2024b8c00                                ; objc_msgSend$setTextColor:
+132  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+136  mov     x0, x19
+140  bl      0x2024b2620                                ; objc_msgSend$imageTintColor
+144  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+148  mov     x20, x0
+152  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+156  cbnz    x20, 0x202428700                           ; <+280>
+160  adrp    x8, 51576
+164  ldr     x0, [x8, #0x568]
+168  bl      0x2024baea0                                ; objc_msgSend$whiteColor
+172  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+176  b       0x2024286ec                                ; <+260>
+180  cbnz    x20, 0x2024286c4                           ; <+220>
+184  adrp    x8, 51576
+188  ldr     x0, [x8, #0x568]
+192  bl      0x2024af6c0                                ; objc_msgSend$blackColor
+196  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+200  mov     x20, x0
+204  mov     x0, x19
+208  mov     x2, x20
+212  bl      0x2024b8c00                                ; objc_msgSend$setTextColor:
+216  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+220  mov     x0, x19
+224  bl      0x2024b2620                                ; objc_msgSend$imageTintColor
+228  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+232  mov     x20, x0
+236  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+240  cbnz    x20, 0x202428700                           ; <+280>
+244  adrp    x8, 51576
+248  ldr     x0, [x8, #0x568]
+252  bl      0x2024af6c0                                ; objc_msgSend$blackColor
+256  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+260  mov     x20, x0
+264  mov     x0, x19
+268  mov     x2, x20
+272  bl      0x2024b7480                                ; objc_msgSend$setImageTintColor:
+276  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+280  adrp    x8, 51576
+284  ldr     x0, [x8, #0x598]                           ; Class STUIStatusBarSettingsDomain
+288  bl      0x2024b5620                                ; objc_msgSend$rootSettings
+292  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+296  mov     x20, x0
+300  bl      0x2024bace0                                ; objc_msgSend$visualProviderSettings
+304  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+308  mov     x21, x0
+312  bl      0x2024b4f20                                ; objc_msgSend$redInSpringBoard
+316  mov     x22, x0
+320  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+324  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+328  cbz     w22, 0x202428778                           ; <+400>
+332  adrp    x21, 51576
+336  ldr     x0, [x21, #0x568]
+340  bl      0x2024b4f00                                ; objc_msgSend$redColor
+344  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+348  mov     x20, x0
+352  mov     x0, x19
+356  mov     x2, x20
+360  bl      0x2024b8c00                                ; objc_msgSend$setTextColor:
+364  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+368  ldr     x0, [x21, #0x568]
+372  bl      0x2024b4f00                                ; objc_msgSend$redColor
+376  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+380  mov     x20, x0
+384  mov     x0, x19
+388  mov     x2, x20
+392  bl      0x2024b7480                                ; objc_msgSend$setImageTintColor:
+396  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+400  mov     x0, x19
+404  bl      0x2024b2620                                ; objc_msgSend$imageTintColor
+408  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+412  mov     x20, x0
+416  adrp    x8, 93
+420  ldr     d0, [x8, #0x690]                           ; = 0.2
+424  bl      0x2024afe60                                ; objc_msgSend$colorWithAlphaComponent:
+428  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+432  mov     x21, x0
+436  mov     x0, x19
+440  mov     x2, x21
+444  bl      0x2024b7440                                ; objc_msgSend$setImageDimmedTintColor:
+448  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+452  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+456  mov     x0, x19
+460  mov     w2, #0x1                                   ; =1
+464  bl      0x2024b8b00                                ; objc_msgSend$setSymbolScale:
+468  mov     x0, x19
+472  ldp     x29, x30, [sp, #0x20]
+476  ldp     x20, x19, [sp, #0x10]
+480  ldp     x22, x21, [sp], #0x30
+484  b       0x20247bef8                                ; symbol stub for: objc_autoreleaseReturnValue

### +[STUIStatusBarStyleAttributes styleAttributesForStatusBar:style:]  (109 条)
+0    stp     d9, d8, [sp, #-0x50]!
+4    stp     x24, x23, [sp, #0x10]
+8    stp     x22, x21, [sp, #0x20]
+12   stp     x20, x19, [sp, #0x30]
+16   stp     x29, x30, [sp, #0x40]
+20   add     x29, sp, #0x40
+24   mov     x21, x3
+28   mov     x20, x0
+32   bl      0x20247c0c0                                ; symbol stub for: objc_retain_x2
+36   mov     x19, x0
+40   mov     x0, x20
+44   bl      0x20247bee0                                ; symbol stub for: objc_alloc_init
+48   mov     x20, x0
+52   str     x21, [x0, #0x10]
+56   mov     x0, x19
+60   bl      0x2024b3dc0                                ; objc_msgSend$mode
+64   str     x0, [x20, #0x18]
+68   mov     x0, x19
+72   bl      0x2024b1260                                ; objc_msgSend$effectiveUserInterfaceLayoutDirection
+76   mov     x8, #0x3ff0000000000000                    ; =4607182418800017408
+80   stp     x0, x8, [x20, #0x28]
+84   str     xzr, [x20, #0x38]
+88   mov     x0, x19
+92   bl      0x2024ba520                                ; objc_msgSend$traitCollection
+96   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+100  mov     x21, x0
+104  bl      0x2024b0e20                                ; objc_msgSend$displayScale
+108  fcmp    d0, #0.0
+112  b.ne    0x20246b980                                ; <+204>
+116  adrp    x8, 51509
+120  ldr     x0, [x8, #0x760]
+124  bl      0x2024b3b40                                ; objc_msgSend$mainScreen
+128  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+132  mov     x22, x0
+136  bl      0x2024b5720                                ; objc_msgSend$scale
+140  fmov    d8, d0
+144  adrp    x8, 51509
+148  ldr     x0, [x8, #0xc90]
+152  bl      0x20247bfac                                ; symbol stub for: objc_opt_self
+156  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+160  mov     x23, x0
+164  mov     x0, x21
+168  fmov    d0, d8
+172  mov     x2, x23
+176  bl      0x2024ba540                                ; objc_msgSend$traitCollectionByReplacingCGFloatValue:forTrait:
+180  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+184  mov     x24, x0
+188  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+192  bl      0x20247c000                                ; symbol stub for: objc_release_x23
+196  bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+200  mov     x21, x24
+204  add     x0, x20, #0x20
+208  mov     x1, x21
+212  bl      0x20247c18c                                ; symbol stub for: objc_storeStrong
+216  mov     x0, x21
+220  bl      0x2024b0e20                                ; objc_msgSend$displayScale
+224  fmov    d8, d0
+228  adrp    x8, 51509
+232  ldr     x0, [x8, #0xd88]
+236  bl      0x2024b0420                                ; objc_msgSend$currentDevice
+240  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+244  mov     x22, x0
+248  bl      0x2024baa40                                ; objc_msgSend$userInterfaceIdiom
+252  cmp     x0, #0x1
+256  b.eq    0x20246b9d8                                ; <+292>
+260  fmov    d0, #2.50000000
+264  cmp     x0, #0x3
+268  b.ne    0x20246b9e0                                ; <+300>
+272  fcmp    d8, d0
+276  mov     w8, #0x10                                  ; =16
+280  mov     w9, #0x11                                  ; =17
+284  csel    x8, x9, x8, gt
+288  b       0x20246b9f4                                ; <+320>
+292  mov     w8, #0xe                                   ; =14
+296  b       0x20246b9f4                                ; <+320>
+300  fcmp    d8, d0
+304  b.le    0x20246b9f0                                ; <+316>
+308  mov     w8, #0x2                                   ; =2
+312  b       0x20246b9f4                                ; <+320>
+316  mov     w8, #0x1                                   ; =1
+320  str     x8, [x20, #0x40]
+324  bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+328  mov     x0, x19
+332  bl      0x2024b1e60                                ; objc_msgSend$foregroundColor
+336  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+340  mov     x22, x0
+344  bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+348  cbz     x22, 0x20246ba44                           ; <+400>
+352  mov     x0, x19
+356  bl      0x2024b1e60                                ; objc_msgSend$foregroundColor
+360  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+364  ldr     x8, [x20, #0x60]
+368  str     x0, [x20, #0x60]
+372  bl      0x20247c048                                ; symbol stub for: objc_release_x8
+376  mov     x0, x19
+380  bl      0x2024b1e60                                ; objc_msgSend$foregroundColor
+384  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+388  ldr     x8, [x20, #0x68]
+392  str     x0, [x20, #0x68]
+396  bl      0x20247c048                                ; symbol stub for: objc_release_x8
+400  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+404  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+408  mov     x0, x20
+412  ldp     x29, x30, [sp, #0x40]
+416  ldp     x20, x19, [sp, #0x30]
+420  ldp     x22, x21, [sp, #0x20]
+424  ldp     x24, x23, [sp, #0x10]
+428  ldp     d9, d8, [sp], #0x50
+432  b       0x20247bef8                                ; symbol stub for: objc_autoreleaseReturnValue

### -[STUIStatusBarCellularSignalView applyStyleAttributes:]  (24 条)
+0    sub     sp, sp, #0x30
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   mov     x19, x0
+20   bl      0x20247c0c0                                ; symbol stub for: objc_retain_x2
+24   mov     x20, x0
+28   bl      0x2024b3200                                ; objc_msgSend$isScaledFixedWidthBar
+32   mov     x2, x0
+36   mov     x0, x19
+40   bl      0x2024b7ae0                                ; objc_msgSend$setNeedsLargerScale:
+44   adrp    x8, 51556
+48   ldr     x8, [x8, #0xf50]                           ; Class STUIStatusBarCellularSignalView
+52   stp     x19, x8, [sp]
+56   adrp    x8, -138270
+60   add     x1, x8, #0x9b6
+64   mov     x0, sp
+68   mov     x2, x20
+72   bl      0x20247bf70                                ; symbol stub for: objc_msgSendSuper2
+76   bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+80   ldp     x29, x30, [sp, #0x20]
+84   ldp     x20, x19, [sp, #0x10]
+88   add     sp, sp, #0x30
+92   ret

### +[STUIStatusBarStyleAttributes overriddenStyleAttributes]  (5 条)
+0    stp     x29, x30, [sp, #-0x10]!
+4    mov     x29, sp
+8    bl      0x20247bee0                                ; symbol stub for: objc_alloc_init
+12   ldp     x29, x30, [sp], #0x10
+16   b       0x20247bef8                                ; symbol stub for: objc_autoreleaseReturnValue

### __STUIStatusBarGetNativeVisualProviderClassForScreenWithVisualProviderInfo_block_invoke  (21 条)
+0    stp     x20, x19, [sp, #-0x20]!
+4    stp     x29, x30, [sp, #0x10]
+8    add     x29, sp, #0x10
+12   mov     x19, x3
+16   mov     x8, x1
+20   mov     x20, x0
+24   ldp     x1, x2, [x0, #0x20]
+28   mov     x0, x8
+32   bl      0x202436ba8                                ; STUIStatusBarGetVisualProviderSubclassForScreenWithVisualProviderInfo
+36   ldr     x8, [x20, #0x30]
+40   ldr     x8, [x8, #0x8]
+44   str     x0, [x8, #0x18]
+48   ldr     x8, [x20, #0x30]
+52   ldr     x8, [x8, #0x8]
+56   ldr     x8, [x8, #0x18]
+60   cmp     x8, #0x0
+64   cset    w8, ne
+68   strb    w8, [x19]
+72   ldp     x29, x30, [sp, #0x10]
+76   ldp     x20, x19, [sp], #0x20
+80   ret

### -[STUIStatusBarDisplayItemState _effectiveStyleAttributesFromStyleAttributes:data:styleAttributesChanged:]  (174 条)
+0    sub     sp, sp, #0xc0
+4    stp     x28, x27, [sp, #0x60]
+8    stp     x26, x25, [sp, #0x70]
+12   stp     x24, x23, [sp, #0x80]
+16   stp     x22, x21, [sp, #0x90]
+20   stp     x20, x19, [sp, #0xa0]
+24   stp     x29, x30, [sp, #0xb0]
+28   add     x29, sp, #0xb0
+32   mov     x22, x4
+36   mov     x19, x3
+40   mov     x23, x0
+44   bl      0x20247c0c0                                ; symbol stub for: objc_retain_x2
+48   mov     x20, x0
+52   bl      0x20247c0b4                                ; symbol stub for: objc_retain_x19
+56   mov     x19, x0
+60   bl      0x20247c0cc                                ; symbol stub for: objc_retain_x20
+64   mov     x20, x0
+68   mov     x0, x23
+72   bl      0x2024b0460                                ; objc_msgSend$currentPlacementState
+76   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+80   mov     x24, x0
+84   bl      0x2024b4f80                                ; objc_msgSend$region
+88   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+92   mov     x21, x0
+96   bl      0x20247c00c                                ; symbol stub for: objc_release_x24
+100  add     x8, sp, #0x30
+104  stp     xzr, x8, [sp, #0x30]
+108  adrp    x9, 97
+112  ldr     d0, [x9, #0xc50]
+116  str     d0, [sp, #0x40]
+120  adrp    x9, 1
+124  add     x9, x9, #0x4c                              ; __Block_byref_object_copy_
+128  adrp    x10, 1
+132  add     x10, x10, #0x5c                            ; __Block_byref_object_dispose_
+136  stp     x9, x10, [sp, #0x48]
+140  adrp    x9, 51548
+144  ldr     x9, [x9, #0xf38]
+148  str     xzr, [sp, #0x58]
+152  str     x9, [sp, #0x8]
+156  adrp    x9, 97
+160  ldr     d0, [x9, #0xb68]
+164  adrp    x9, 1
+168  add     x9, x9, #0x64                              ; __106-[STUIStatusBarDisplayItemState _effectiveStyleAttributesFromStyleAttributes:data:styleAttributesChanged:]_block_invoke
+172  str     d0, [sp, #0x10]
+176  adrp    x10, 51550
+180  add     x10, x10, #0x938                           ; __block_descriptor_40_e8_32r_e38_v16?0"STUIStatusBarStyleAttributes"8lr32l8
+184  stp     x9, x10, [sp, #0x18]
+188  str     x8, [sp, #0x28]
+192  mov     x0, x21
+196  bl      0x2024b1220                                ; objc_msgSend$effectiveStyle
+200  mov     x25, x0
+204  cmp     x0, #0x4
+208  b.eq    0x202425e98                                ; <+260>
+212  add     x0, x23, #0x20
+216  bl      0x20247bf58                                ; symbol stub for: objc_loadWeakRetained
+220  mov     x24, x0
+224  mov     x2, x25
+228  bl      0x2024b9ca0                                ; objc_msgSend$styleAttributesForStyle:
+232  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+236  mov     x25, x0
+240  add     x0, sp, #0x8
+244  mov     x1, x25
+248  bl      0x202426064                                ; __106-[STUIStatusBarDisplayItemState _effectiveStyleAttributesFromStyleAttributes:data:styleAttributesChanged:]_block_invoke
+252  bl      0x20247c018                                ; symbol stub for: objc_release_x25
+256  bl      0x20247c00c                                ; symbol stub for: objc_release_x24
+260  mov     x0, x21
+264  bl      0x2024b4560                                ; objc_msgSend$overriddenStyleAttributes
+268  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+272  mov     x24, x0
+276  add     x0, sp, #0x8
+280  mov     x1, x24
+284  bl      0x202426064                                ; __106-[STUIStatusBarDisplayItemState _effectiveStyleAttributesFromStyleAttributes:data:styleAttributesChanged:]_block_invoke
+288  bl      0x20247c00c                                ; symbol stub for: objc_release_x24
+292  add     x0, x23, #0x10
+296  bl      0x20247bf58                                ; symbol stub for: objc_loadWeakRetained
+300  mov     x24, x0
+304  bl      0x2024b4560                                ; objc_msgSend$overriddenStyleAttributes
+308  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+312  mov     x25, x0
+316  add     x0, sp, #0x8
+320  mov     x1, x25
+324  bl      0x202426064                                ; __106-[STUIStatusBarDisplayItemState _effectiveStyleAttributesFromStyleAttributes:data:styleAttributesChanged:]_block_invoke
+328  bl      0x20247c018                                ; symbol stub for: objc_release_x25
+332  bl      0x20247c00c                                ; symbol stub for: objc_release_x24
+336  add     x0, x23, #0x28
+340  bl      0x20247bf58                                ; symbol stub for: objc_loadWeakRetained
+344  mov     x24, x0
+348  ldr     x3, [x23, #0x18]
+352  mov     x2, x19
+356  bl      0x2024b4580                                ; objc_msgSend$overriddenStyleAttributesForData:identifier:
+360  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+364  mov     x25, x0
+368  add     x0, sp, #0x8
+372  mov     x1, x25
+376  bl      0x202426064                                ; __106-[STUIStatusBarDisplayItemState _effectiveStyleAttributesFromStyleAttributes:data:styleAttributesChanged:]_block_invoke
+380  bl      0x20247c018                                ; symbol stub for: objc_release_x25
+384  bl      0x20247c00c                                ; symbol stub for: objc_release_x24
+388  add     x24, x23, #0x20
+392  mov     x0, x24
+396  bl      0x20247bf58                                ; symbol stub for: objc_loadWeakRetained
+400  mov     x25, x0
+404  bl      0x2024bac80                                ; objc_msgSend$visualProvider
+408  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+412  mov     x26, x0
+416  adrp    x8, -138134
+420  add     x1, x8, #0xe0b
+424  bl      0x20247bfa0                                ; symbol stub for: objc_opt_respondsToSelector
+428  mov     x27, x0
+432  bl      0x20247c024                                ; symbol stub for: objc_release_x26
+436  bl      0x20247c018                                ; symbol stub for: objc_release_x25
+440  tbz     w27, #0x0, 0x202425fa8                     ; <+532>
+444  mov     x0, x24
+448  bl      0x20247bf58                                ; symbol stub for: objc_loadWeakRetained
+452  mov     x24, x0
+456  bl      0x2024bac80                                ; objc_msgSend$visualProvider
+460  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+464  mov     x25, x0
+468  mov     x0, x23
+472  bl      0x2024b2460                                ; objc_msgSend$identifier
+476  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+480  mov     x26, x0
+484  mov     x0, x25
+488  mov     x2, x26
+492  bl      0x2024b45a0                                ; objc_msgSend$overriddenStyleAttributesForDisplayItemWithIdentifier:
+496  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+500  mov     x27, x0
+504  add     x0, sp, #0x8
+508  mov     x1, x27
+512  bl      0x202426064                                ; __106-[STUIStatusBarDisplayItemState _effectiveStyleAttributesFromStyleAttributes:data:styleAttributesChanged:]_block_invoke
+516  bl      0x20247c030                                ; symbol stub for: objc_release_x27
+520  bl      0x20247c024                                ; symbol stub for: objc_release_x26
+524  bl      0x20247c018                                ; symbol stub for: objc_release_x25
+528  bl      0x20247c00c                                ; symbol stub for: objc_release_x24
+532  ldr     x8, [sp, #0x38]
+536  ldr     x0, [x8, #0x28]
+540  ldr     x1, [x23, #0x48]!
+544  bl      0x20247ba0c                                ; symbol stub for: BSEqualObjects
+548  tbnz    w0, #0x0, 0x202425fd4                      ; <+576>
+552  ldr     x8, [sp, #0x38]
+556  ldr     x1, [x8, #0x28]
+560  mov     x0, x23
+564  bl      0x20247c18c                                ; symbol stub for: objc_storeStrong
+568  mov     w8, #0x1                                   ; =1
+572  strb    w8, [x22]
+576  ldr     x8, [sp, #0x38]
+580  ldr     x2, [x8, #0x28]
+584  mov     x0, x20
+588  bl      0x2024b9cc0                                ; objc_msgSend$styleAttributesWithOverrides:
+592  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+596  mov     x22, x0
+600  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+604  add     x0, sp, #0x30
+608  mov     w1, #0x8                                   ; =8
+612  bl      0x20247bd3c                                ; symbol stub for: _Block_object_dispose
+616  ldr     x8, [sp, #0x58]
+620  bl      0x20247c048                                ; symbol stub for: objc_release_x8
+624  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+628  bl      0x20247bfd0                                ; symbol stub for: objc_release_x19
+632  bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+636  mov     x0, x22
+640  ldp     x29, x30, [sp, #0xb0]
+644  ldp     x20, x19, [sp, #0xa0]
+648  ldp     x22, x21, [sp, #0x90]
+652  ldp     x24, x23, [sp, #0x80]
+656  ldp     x26, x25, [sp, #0x70]
+660  ldp     x28, x27, [sp, #0x60]
+664  add     sp, sp, #0xc0
+668  b       0x20247bef8                                ; symbol stub for: objc_autoreleaseReturnValue
+672  mov     x19, x0
+676  add     x0, sp, #0x30
+680  mov     w1, #0x8                                   ; =8
+684  bl      0x20247bd3c                                ; symbol stub for: _Block_object_dispose
+688  mov     x0, x19
+692  bl      0x20247bdb4                                ; symbol stub for: _Unwind_Resume

### __106-[STUIStatusBarDisplayItemState _effectiveStyleAttributesFromStyleAttributes:data:styleAttributesChanged:]_block_invoke  (30 条)
+0    sub     sp, sp, #0x30
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   mov     x19, x0
+20   bl      0x20247c09c                                ; symbol stub for: objc_retain_x1
+24   mov     x1, x0
+28   cbz     x0, 0x2024260cc                            ; <+104>
+32   ldr     x8, [x19, #0x20]
+36   ldr     x20, [x8, #0x8]
+40   ldr     x0, [x20, #0x28]
+44   str     x1, [sp, #0x8]
+48   cbz     x0, 0x2024260b8                            ; <+84>
+52   mov     x2, x1
+56   bl      0x2024b9cc0                                ; objc_msgSend$styleAttributesWithOverrides:
+60   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+64   ldr     x8, [x19, #0x20]
+68   ldr     x9, [x8, #0x8]
+72   ldr     x8, [x9, #0x28]
+76   str     x0, [x9, #0x28]
+80   b       0x2024260c4                                ; <+96>
+84   bl      0x20247c09c                                ; symbol stub for: objc_retain_x1
+88   ldr     x8, [x20, #0x28]
+92   str     x0, [x20, #0x28]
+96   bl      0x20247c048                                ; symbol stub for: objc_release_x8
+100  ldr     x1, [sp, #0x8]
+104  ldp     x29, x30, [sp, #0x20]
+108  ldp     x20, x19, [sp, #0x10]
+112  add     sp, sp, #0x30
+116  b       0x20247bfc4                                ; symbol stub for: objc_release_x1

### -[UIScreen _exclusionArea]  (14 条)
+0    stp     x20, x19, [sp, #-0x20]!
+4    stp     x29, x30, [sp, #0x10]
+8    add     x29, sp, #0x10
+12   bl      0x1860141c0                                ; objc_msgSend$_displayInfoProvider
+16   bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+20   mov     x19, x0
+24   bl      0x1860c8480                                ; objc_msgSend$exclusionArea
+28   bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+32   mov     x20, x0
+36   bl      0x1859cf65c                                ; symbol stub for: objc_release_x19
+40   mov     x0, x20
+44   ldp     x29, x30, [sp, #0x10]
+48   ldp     x20, x19, [sp], #0x20
+52   b       0x1859cf4e8                                ; symbol stub for: objc_autoreleaseReturnValue

### -[UIScreen _nativeDisplayBounds]  (32 条)
+0    stp     d11, d10, [sp, #-0x40]!
+4    stp     d9, d8, [sp, #0x10]
+8    stp     x20, x19, [sp, #0x20]
+12   stp     x29, x30, [sp, #0x30]
+16   add     x29, sp, #0x30
+20   mov     x19, x0
+24   adrp    x8, 436867
+28   ldr     x8, [x8, #0x728]
+32   ldp     d8, d9, [x8]
+36   adrp    x20, 422757
+40   add     x20, x20, #0x378                           ; _MergedGlobals
+44   mov     x0, x20
+48   bl      0x1859cf9a4                                ; symbol stub for: os_unfair_lock_lock
+52   ldr     x8, [x19, #0xa0]
+56   bl      0x1859cf848                                ; symbol stub for: objc_retain_x8
+60   mov     x19, x0
+64   mov     x0, x20
+68   bl      0x1859cf9bc                                ; symbol stub for: os_unfair_lock_unlock
+72   mov     x0, x19
+76   bl      0x18610f740                                ; objc_msgSend$pixelSize
+80   fmov    d10, d0
+84   fmov    d11, d1
+88   bl      0x1859cf65c                                ; symbol stub for: objc_release_x19
+92   fmov    d0, d8
+96   fmov    d1, d9
+100  fmov    d2, d10
+104  fmov    d3, d11
+108  ldp     x29, x30, [sp, #0x30]
+112  ldp     x20, x19, [sp, #0x20]
+116  ldp     d9, d8, [sp, #0x10]
+120  ldp     d11, d10, [sp], #0x40
+124  ret

### -[UIScreen _unjailedReferenceBounds]  (3 条)
+0    ldp     d0, d1, [x0, #0x8]
+4    ldp     d2, d3, [x0, #0x18]
+8    ret

### -[UIScreen _nativeScale]  (2 条)
+0    mov     w2, #0x2                                   ; =2
+4    b       0x1860390a0                                ; objc_msgSend$_nativeScaleWithLevel:

### -[UIScreen _scale]  (2 条)
+0    ldr     d0, [x0, #0x50]
+4    ret

### -[UISDisplayContext exclusionArea]  (2 条)
+0    ldr     x0, [x0, #0x28]
+4    ret

### +[STUIStatusBarVisualProvider_Split1170 baseFontSize]  (2 条)
+0    fmov    d0, #13.50000000
+4    ret

### -[STUIStatusBarVisualProvider_Split1170 expandedIconScale]  (3 条)
+0    adrp    x8, 28
+4    ldr     d0, [x8, #0xbb8]                           ; = 1.16
+8    ret

### +[STUIStatusBarVisualProvider_DynamicSplitMedium baseFontSize]  (2 条)
+0    fmov    d0, #15.00000000
+4    ret

### -[STUIStatusBarVisualProvider_DynamicSplitMedium expandedIconScale]  (3 条)
+0    adrp    x8, 84
+4    ldr     d0, [x8, #0xbb8]                           ; = 1.16
+8    ret

### +[STUIStatusBarVisualProvider_DynamicSplit baseFontSize]  (2 条)
+0    fmov    d0, #16.00000000
+4    ret

### -[STUIStatusBarVisualProvider_DynamicSplit expandedIconScale]  (3 条)
+0    adrp    x8, 89
+4    ldr     d0, [x8, #0xd68]                           ; = 1.2992000000000001
+8    ret

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
+56   ldrsw   x8, [x8, #0xc8]                            ; ivar 456
+60   ldr     x8, [x19, x8]
+64   cmp     x8, x21
+68   b.ne    0x20241c2f4                                ; <+132>
+72   adrp    x8, 47110
+76   ldrsw   x8, [x8, #0xcc]                            ; ivar 409
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

### -[STUIStatusBarBatteryView applyStyleAttributes:]  (20 条)
+0    stp     x22, x21, [sp, #-0x30]!
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   mov     x19, x0
+20   bl      0x20247c0c0                                ; symbol stub for: objc_retain_x2
+24   mov     x20, x0
+28   bl      0x2024b31e0                                ; objc_msgSend$isRounded
+32   mov     x21, x0
+36   mov     x0, x20
+40   bl      0x2024b2400                                ; objc_msgSend$iconSize
+44   mov     x22, x0
+48   bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+52   mov     x0, x19
+56   mov     x2, x21
+60   mov     x3, x22
+64   ldp     x29, x30, [sp, #0x20]
+68   ldp     x20, x19, [sp, #0x10]
+72   ldp     x22, x21, [sp], #0x30
+76   b       0x2024b8460                                ; objc_msgSend$setRounded:iconSize:

### -[STUIStatusBarStaticBatteryView applyStyleAttributes:]  (20 条)
+0    stp     x22, x21, [sp, #-0x30]!
+4    stp     x20, x19, [sp, #0x10]
+8    stp     x29, x30, [sp, #0x20]
+12   add     x29, sp, #0x20
+16   mov     x19, x0
+20   bl      0x20247c0c0                                ; symbol stub for: objc_retain_x2
+24   mov     x20, x0
+28   bl      0x2024b31e0                                ; objc_msgSend$isRounded
+32   mov     x21, x0
+36   mov     x0, x20
+40   bl      0x2024b2400                                ; objc_msgSend$iconSize
+44   mov     x22, x0
+48   bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+52   mov     x0, x19
+56   mov     x2, x21
+60   mov     x3, x22
+64   ldp     x29, x30, [sp, #0x20]
+68   ldp     x20, x19, [sp, #0x10]
+72   ldp     x22, x21, [sp], #0x30
+76   b       0x2024b8460                                ; objc_msgSend$setRounded:iconSize:

### EXCERPT: -[STUIStatusBarVisualProvider_DynamicSplit setupInContainerView:]  (1250 条); offsets +1844..+2236, trailing-region setup only
+1844 adrp    x8, 51570
+1848 ldr     x0, [x8, #0x608]                           ; Class STUIStatusBarRegion
+1852 bl      0x20247bec8                                ; symbol stub for: objc_alloc
+1856 adrp    x8, 51542
+1860 add     x8, x8, #0xa78                             ; STUIStatusBarSplitVisualProviderRegionTrailing
+1864 ldr     x2, [x8]
+1868 bl      0x2024b2a60                                ; objc_msgSend$initWithIdentifier:
+1872 mov     x25, x0
+1876 adrp    x8, 51570
+1880 ldr     x0, [x8, #0x610]                           ; Class STUIStatusBarRegionAxesLayout
+1884 bl      0x20247bee0                                ; symbol stub for: objc_alloc_init
+1888 mov     x26, x0
+1892 adrp    x8, 51570
+1896 ldr     x0, [x8, #0x9a0]                           ; Class STUIStatusBarRegionAxisSquishyLayout
+1900 bl      0x20247bee0                                ; symbol stub for: objc_alloc_init
+1904 mov     x24, x0
+1908 mov     w2, #0x4                                   ; =4
+1912 bl      0x2024b5d20                                ; objc_msgSend$setAlignment:
+1916 mov     x0, x24
+1920 ldr     d10, [sp, #0x28]
+1924 fmov    d0, d10
+1928 bl      0x2024b74e0                                ; objc_msgSend$setInterspace:
+1932 mov     x0, x24
+1936 mov     w2, #0x3                                   ; =3
+1940 bl      0x2024b79c0                                ; objc_msgSend$setMaxNumberOfItems:
+1944 ldr     x1, [sp, #0x60]
+1948 ldr     d0, [sp, #0x70]
+1952 mov     x0, x24
+1956 bl      0x20242ee88                                ; _updateSquishyRegionForDynamicValues
+1960 mov     x0, x19
+1964 bl      0x2024b3d40                                ; objc_msgSend$minimumItemScaleFactor
+1968 mov     x0, x24
+1972 bl      0x2024b7a20                                ; objc_msgSend$setMinItemDynamicScale:
+1976 mov     x0, x24
+1980 fmov    d0, d11
+1984 bl      0x2024b7a00                                ; objc_msgSend$setMinInterspaceDynamicScale:
+1988 mov     x0, x24
+1992 mov     x2, x19
+1996 bl      0x2024b6d40                                ; objc_msgSend$setDynamicHidingDelegate:
+2000 mov     x0, x26
+2004 mov     x2, x24
+2008 bl      0x2024b7360                                ; objc_msgSend$setHorizontalLayout:
+2012 bl      0x20247c00c                                ; symbol stub for: objc_release_x24
+2016 adrp    x8, 51570
+2020 ldr     x0, [x8, #0x620]                           ; Class STUIStatusBarRegionAxisAligningLayout
+2024 mov     w2, #0x5                                   ; =5
+2028 bl      0x2024ae680                                ; objc_msgSend$aligningLayoutWithAlignment:
+2032 bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+2036 mov     x21, x0
+2040 mov     x0, x26
+2044 mov     x2, x21
+2048 bl      0x2024b8fa0                                ; objc_msgSend$setVerticalLayout:
+2052 bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+2056 mov     x0, x25
+2060 mov     x2, x26
+2064 bl      0x2024b7660                                ; objc_msgSend$setLayout:
+2068 mov     x8, #-0x3fa7000000000000                   ; =-4586634745500139520
+2072 fmov    d13, x8
+2076 fmov    d1, #-20.00000000
+2080 fmov    d2, #-10.00000000
+2084 fmov    d3, #-20.00000000
+2088 mov     x0, x25
+2092 fmov    d0, d13
+2096 bl      0x2024b5b20                                ; objc_msgSend$setActionInsets:
+2100 mov     x0, x25
+2104 mov     w2, #0x1                                   ; =1
+2108 bl      0x2024b6ae0                                ; objc_msgSend$setDisableItemFrameBasedOverflow:
+2112 mov     x0, x25
+2116 bl      0x2024b3620                                ; objc_msgSend$layoutItem
+2120 bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+2124 mov     x24, x0
+2128 adrp    x8, 51570
+2132 ldr     x0, [x8, #0x640]                           ; Class STUIStatusBarStyleAttributes
+2136 bl      0x2024b4560                                ; objc_msgSend$overriddenStyleAttributes
+2140 bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+2144 mov     x27, x0
+2148 mov     x0, x19
+2152 bl      0x2024b12c0                                ; objc_msgSend$emphasizedFont
+2156 bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+2160 mov     x21, x0
+2164 mov     x0, x27
+2168 mov     x2, x21
+2172 bl      0x2024b7140                                ; objc_msgSend$setFont:
+2176 bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+2180 mov     x0, x19
+2184 bl      0x2024b4040                                ; objc_msgSend$normalFont
+2188 bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+2192 mov     x21, x0
+2196 mov     x0, x27
+2200 mov     x2, x21
+2204 bl      0x2024b8820                                ; objc_msgSend$setSmallFont:
+2208 bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+2212 adrp    x2, 51571
+2216 add     x2, x2, #0x440
+2220 mov     x0, x27
+2224 bl      0x2024b7460                                ; objc_msgSend$setImageNamePrefixes:
+2228 mov     x0, x25
+2232 mov     x2, x27
+2236 bl      0x2024b7e40                                ; objc_msgSend$setOverriddenStyleAttributes:

### EXCERPT: -[STUIStatusBarVisualProvider_FixedSplit setupInContainerView:]  (1670 条); offsets +3068..+3312, trailing-region setup only
+3068 adrp    x8, 51512
+3072 ldr     x0, [x8, #0x608]                           ; Class STUIStatusBarRegion
+3076 bl      0x20247bec8                                ; symbol stub for: objc_alloc
+3080 adrp    x2, 51485
+3084 add     x2, x2, #0xac0                             ; @"trailing"
+3088 bl      0x2024b2a60                                ; objc_msgSend$initWithIdentifier:
+3092 mov     x25, x0
+3096 adrp    x8, 51512
+3100 ldr     x0, [x8, #0x610]                           ; Class STUIStatusBarRegionAxesLayout
+3104 bl      0x20247bee0                                ; symbol stub for: objc_alloc_init
+3108 mov     x26, x0
+3112 adrp    x8, 51512
+3116 ldr     x0, [x8, #0x620]                           ; Class STUIStatusBarRegionAxisAligningLayout
+3120 mov     w2, #0x5                                   ; =5
+3124 bl      0x2024ae680                                ; objc_msgSend$aligningLayoutWithAlignment:
+3128 bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+3132 mov     x20, x0
+3136 mov     x0, x26
+3140 mov     x2, x20
+3144 bl      0x2024b8fa0                                ; objc_msgSend$setVerticalLayout:
+3148 bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+3152 mov     x0, x25
+3156 mov     x2, x26
+3160 bl      0x2024b7660                                ; objc_msgSend$setLayout:
+3164 fmov    d1, #-20.00000000
+3168 fmov    d2, #-10.00000000
+3172 fmov    d3, #-20.00000000
+3176 mov     x0, x25
+3180 fmov    d0, d11
+3184 bl      0x2024b5b20                                ; objc_msgSend$setActionInsets:
+3188 mov     x0, x25
+3192 bl      0x2024b3620                                ; objc_msgSend$layoutItem
+3196 bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+3200 mov     x24, x0
+3204 adrp    x8, 51512
+3208 ldr     x0, [x8, #0x640]                           ; Class STUIStatusBarStyleAttributes
+3212 bl      0x2024b4560                                ; objc_msgSend$overriddenStyleAttributes
+3216 bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+3220 mov     x27, x0
+3224 mov     x0, x19
+3228 bl      0x2024b12c0                                ; objc_msgSend$emphasizedFont
+3232 bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+3236 mov     x20, x0
+3240 mov     x0, x27
+3244 mov     x2, x20
+3248 bl      0x2024b7140                                ; objc_msgSend$setFont:
+3252 bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+3256 mov     x0, x19
+3260 bl      0x2024b4040                                ; objc_msgSend$normalFont
+3264 bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+3268 mov     x20, x0
+3272 mov     x0, x27
+3276 mov     x2, x20
+3280 bl      0x2024b8820                                ; objc_msgSend$setSmallFont:
+3284 bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+3288 adrp    x2, 51513
+3292 add     x2, x2, #0x668
+3296 mov     x0, x27
+3300 bl      0x2024b7460                                ; objc_msgSend$setImageNamePrefixes:
+3304 mov     x0, x25
+3308 mov     x2, x27
+3312 bl      0x2024b7e40                                ; objc_msgSend$setOverriddenStyleAttributes:
