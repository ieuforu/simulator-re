; iOS 17.4 arm64 Simulator. ASLR addresses belong to this capture.
; Reconstructed analysis input, not Apple source. No ambiguous ivar-name annotations.
ivars: 0

### -[STUIStatusBar setMode:]  (58 条)
+0    sub     sp, sp, #0x60
+4    stp     x22, x21, [sp, #0x30]
+8    stp     x20, x19, [sp, #0x40]
+12   stp     x29, x30, [sp, #0x50]
+16   add     x29, sp, #0x50
+20   mov     x21, x2
+24   mov     x19, x0
+28   adrp    x8, 51503
+32   ldr     x0, [x8, #0x598]                           ; Class STUIStatusBarSettingsDomain
+36   bl      0x2024b5620                                ; objc_msgSend$rootSettings
+40   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+44   mov     x20, x0
+48   bl      0x2024b1e20                                ; objc_msgSend$forcedMode
+52   mov     x22, x0
+56   bl      0x20247bfdc                                ; symbol stub for: objc_release_x20
+60   cmn     x22, #0x1
+64   b.ne    0x202471afc                                ; <+212>
+68   adrp    x8, 47025
+72   ldrsw   x8, [x8, #0x7ec]                           ; ivar 464
+76   ldr     x20, [x19, x8]
+80   adrp    x22, 47025
+84   cmp     x20, x21
+88   b.eq    0x202471aec                                ; <+196>
+92   str     x21, [x19, x8]
+96   adrp    x8, 47025
+100  ldrsw   x21, [x8, #0x800]                          ; ivar 416
+104  ldr     x8, [x19, x21]
+108  cbz     x8, 0x202471aec                            ; <+196>
+112  adrp    x8, 51472
+116  ldr     x8, [x8, #0xf38]
+120  str     x8, [sp, #0x8]
+124  adrp    x8, 21
+128  ldr     d0, [x8, #0xb68]
+132  adrp    x8, 0
+136  add     x8, x8, #0xb10                             ; __25-[STUIStatusBar setMode:]_block_invoke
+140  str     d0, [sp, #0x10]
+144  adrp    x9, 51474
+148  add     x9, x9, #0x4a0                             ; __block_descriptor_40_e8_32s_e5_v8?0ls32l8
+152  stp     x8, x9, [sp, #0x18]
+156  str     x19, [sp, #0x28]
+160  add     x2, sp, #0x8
+164  mov     x0, x19
+168  bl      0x2024ace00                                ; objc_msgSend$_performWithInheritedAnimation:
+172  ldrsw   x8, [x22, #0x7e4]                          ; ivar 424
+176  ldrb    w8, [x19, x8]
+180  tbz     w8, #0x4, 0x202471aec                      ; <+196>
+184  ldr     x0, [x19, x21]
+188  mov     x2, x20
+192  bl      0x2024b3de0                                ; objc_msgSend$modeUpdatedFromMode:
+196  ldrsw   x8, [x22, #0x7e4]                          ; ivar 424
+200  ldr     w9, [x19, x8]
+204  orr     w9, w9, #0x1
+208  str     w9, [x19, x8]
+212  ldp     x29, x30, [sp, #0x50]
+216  ldp     x20, x19, [sp, #0x40]
+220  ldp     x22, x21, [sp, #0x30]
+224  add     sp, sp, #0x60
+228  ret

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

### -[STUIStatusBarVisualProvider_Split setExpanded:]  (61 条)
+0    sub     sp, sp, #0x70
+4    stp     x22, x21, [sp, #0x40]
+8    stp     x20, x19, [sp, #0x50]
+12   stp     x29, x30, [sp, #0x60]
+16   add     x29, sp, #0x60
+20   mov     x19, x2
+24   mov     x20, x0
+28   bl      0x2024b18c0                                ; objc_msgSend$expanded
+32   cmp     w0, w19
+36   b.eq    0x202466bec                                ; <+224>
+40   mov     x0, x20
+44   bl      0x2024ad4c0                                ; objc_msgSend$_stopBatteryCollapseTimer
+48   mov     x0, x20
+52   bl      0x2024b18c0                                ; objc_msgSend$expanded
+56   cbz     w0, 0x202466bb4                            ; <+168>
+60   mov     x0, x20
+64   bl      0x2024b4840                                ; objc_msgSend$pillRegionCoordinator
+68   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+72   mov     x21, x0
+76   bl      0x2024b4800                                ; objc_msgSend$pillIconPlacement
+80   bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+84   mov     x22, x0
+88   mov     w2, #0x1                                   ; =1
+92   bl      0x2024b6e80                                ; objc_msgSend$setEnabled:
+96   bl      0x20247bff4                                ; symbol stub for: objc_release_x22
+100  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+104  adrp    x8, 51483
+108  ldr     x8, [x8, #0xf38]
+112  adrp    x9, 51514
+116  ldr     x0, [x9, #0x538]
+120  str     x8, [sp, #0x18]
+124  adrp    x8, 32
+128  ldr     d0, [x8, #0xb68]
+132  adrp    x8, 0
+136  add     x8, x8, #0xc00                             ; __49-[STUIStatusBarVisualProvider_Split setExpanded:]_block_invoke
+140  str     d0, [sp, #0x20]
+144  adrp    x9, 51485
+148  add     x9, x9, #0x4a0                             ; __block_descriptor_40_e8_32s_e5_v8?0ls32l8
+152  stp     x8, x9, [sp, #0x28]
+156  str     x20, [sp, #0x38]
+160  add     x2, sp, #0x18
+164  bl      0x2024b46e0                                ; objc_msgSend$performWithoutAnimation:
+168  mov     x0, x20
+172  bl      0x2024b4840                                ; objc_msgSend$pillRegionCoordinator
+176  bl      0x20247bf04                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+180  mov     x21, x0
+184  bl      0x2024ba8a0                                ; objc_msgSend$updatePill
+188  bl      0x20247bfe8                                ; symbol stub for: objc_release_x21
+192  adrp    x8, 51515
+196  ldr     x8, [x8, #0xd8]                            ; Class STUIStatusBarVisualProvider_Split
+200  stp     x20, x8, [sp, #0x8]
+204  adrp    x8, -138147
+208  add     x1, x8, #0x3aa
+212  add     x0, sp, #0x8
+216  mov     x2, x19
+220  bl      0x20247bf70                                ; symbol stub for: objc_msgSendSuper2
+224  ldp     x29, x30, [sp, #0x60]
+228  ldp     x20, x19, [sp, #0x50]
+232  ldp     x22, x21, [sp, #0x40]
+236  add     sp, sp, #0x70
+240  ret

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
