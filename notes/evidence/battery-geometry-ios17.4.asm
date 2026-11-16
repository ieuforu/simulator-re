ivars: 26

### +[_UIBatteryView _pinBezierPathForSize:isComplex:]  (72 条)
+0    stp     d11, d10, [sp, #-0x40]!
+4    stp     d9, d8, [sp, #0x10]
+8    stp     x20, x19, [sp, #0x20]
+12   stp     x29, x30, [sp, #0x30]
+16   add     x29, sp, #0x30
+20   mov     x20, x2
+24   fmov    d9, d1
+28   fmov    d8, d0
+32   adrp    x8, 438637
+36   ldr     x0, [x8, #0x90]
+40   bl      0x18609c200                                ; objc_msgSend$bezierPath
+44   bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+48   mov     x19, x0
+52   cbz     w20, 0x184c9f288                           ; <+168>
+56   adrp    x8, 437693
+60   ldr     x8, [x8, #0x728]
+64   ldp     d0, d1, [x8]
+68   mov     x0, x19
+72   bl      0x1861039c0                                ; objc_msgSend$moveToPoint:
+76   adrp    x8, 3707
+80   ldr     d3, [x8, #0x9d8]                           ; = 4.71238898038469
+84   movi    d0, #0000000000000000
+88   movi    d4, #0000000000000000
+92   mov     x0, x19
+96   fmov    d1, d8
+100  fmov    d2, d8
+104  mov     w2, #0x1                                   ; =1
+108  bl      0x18608b8e0                                ; objc_msgSend$addArcWithCenter:radius:startAngle:endAngle:clockwise:
+112  fsub    d9, d9, d8
+116  mov     x0, x19
+120  fmov    d0, d8
+124  fmov    d1, d9
+128  bl      0x18608c8e0                                ; objc_msgSend$addLineToPoint:
+132  adrp    x8, 3705
+136  ldr     d4, [x8, #0xc08]                           ; = 1.5707963267948966
+140  movi    d0, #0000000000000000
+144  movi    d3, #0000000000000000
+148  mov     x0, x19
+152  fmov    d1, d9
+156  fmov    d2, d8
+160  mov     w2, #0x1                                   ; =1
+164  b       0x184c9f2dc                                ; <+252>
+168  fmov    d0, #0.50000000
+172  fmul    d9, d9, d0
+176  fsub    d10, d9, d8
+180  fmul    d0, d9, d9
+184  fmul    d1, d10, d10
+188  fsub    d0, d0, d1
+192  fsqrt   d11, d0
+196  fdiv    d0, d10, d9
+200  bl      0x1859cebdc                                ; symbol stub for: acos
+204  fmov    d8, d0
+208  fsub    d1, d9, d11
+212  movi    d0, #0000000000000000
+216  mov     x0, x19
+220  bl      0x1861039c0                                ; objc_msgSend$moveToPoint:
+224  fneg    d0, d10
+228  fneg    d4, d8
+232  mov     x0, x19
+236  fmov    d1, d9
+240  fmov    d2, d9
+244  fmov    d3, d8
+248  mov     w2, #0x0                                   ; =0
+252  bl      0x18608b8e0                                ; objc_msgSend$addArcWithCenter:radius:startAngle:endAngle:clockwise:
+256  mov     x0, x19
+260  bl      0x1860a6340                                ; objc_msgSend$closePath
+264  mov     x0, x19
+268  ldp     x29, x30, [sp, #0x30]
+272  ldp     x20, x19, [sp, #0x20]
+276  ldp     d9, d8, [sp, #0x10]
+280  ldp     d11, d10, [sp], #0x40
+284  b       0x1859cf4e8                                ; symbol stub for: objc_autoreleaseReturnValue

### -[_UIStaticBatteryView _updateBodyLayers]  (225 条)
+0    sub     sp, sp, #0x130
+4    stp     d15, d14, [sp, #0xa0]
+8    stp     d13, d12, [sp, #0xb0]
+12   stp     d11, d10, [sp, #0xc0]
+16   stp     d9, d8, [sp, #0xd0]
+20   stp     x28, x27, [sp, #0xe0]
+24   stp     x24, x23, [sp, #0xf0]
+28   stp     x22, x21, [sp, #0x100]
+32   stp     x20, x19, [sp, #0x110]
+36   stp     x29, x30, [sp, #0x120]
+40   add     x29, sp, #0x120
+44   mov     x20, x0
+48   bl      0x186185ce0                                ; objc_msgSend$traitCollection
+52   bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+56   mov     x19, x0
+60   mov     x0, x20
+64   bl      0x186082680                                ; objc_msgSend$_useImagesWithCutoutsForBolt
+68   mov     x21, x0
+72   mov     x0, x20
+76   bl      0x186069280                                ; objc_msgSend$_shouldReverseLayoutDirection
+80   mov     x22, x0
+84   mov     x0, x20
+88   bl      0x1861716c0                                ; objc_msgSend$showsPercentage
+92   mov     x23, x0
+96   mov     x0, x20
+100  mov     x2, x19
+104  bl      0x1860352c0                                ; objc_msgSend$_lineWidthAndInterspaceForTraitCollection:
+108  fmov    d8, d0
+112  mov     x0, x19
+116  bl      0x1860bf740                                ; objc_msgSend$displayScale
+120  fmov    d14, d0
+124  mov     x0, x20
+128  mov     x2, x19
+132  bl      0x185ffbd40                                ; objc_msgSend$_batterySizeForTraitCollection:
+136  str     d0, [sp, #0x70]
+140  mov     x0, x20
+144  mov     x2, x19
+148  bl      0x186040500                                ; objc_msgSend$_pinSizeForTraitCollection:
+152  fmov    d15, d0
+156  str     d1, [sp, #0x80]
+160  mov     x0, x20
+164  mov     x2, x19
+168  bl      0x185ffcd20                                ; objc_msgSend$_bodyRectForTraitCollection:
+172  fmov    d11, d0
+176  stp     d2, d1, [sp, #0x88]
+180  stur    d3, [x29, #-0x88]
+184  mov     x0, x20
+188  bl      0x18609d980                                ; objc_msgSend$bounds
+192  fmov    d10, d0
+196  fmov    d9, d1
+200  fmov    d13, d2
+204  str     d3, [sp, #0x78]
+208  mov     x0, x20
+212  bl      0x1861253e0                                ; objc_msgSend$rounded
+216  cbz     w0, 0x185919f28                            ; <+236>
+220  fmov    d0, #3.12500000
+224  ldur    d1, [x29, #-0x88]
+228  fdiv    d0, d1, d0
+232  b       0x185919f40                                ; <+260>
+236  mov     x0, x20
+240  mov     x2, x19
+244  bl      0x18603cf60                                ; objc_msgSend$_outsideCornerRadiusForTraitCollection:
+248  fmov    d1, #-0.50000000
+252  fmul    d1, d8, d1
+256  fadd    d0, d0, d1
+260  str     d0, [sp, #0x68]
+264  mov     x0, x20
+268  cbz     w21, 0x18591a01c                           ; <+480>
+272  bl      0x18609cea0                                ; objc_msgSend$boltMaskLayer
+276  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+280  mov     x23, x0
+284  bl      0x18609d980                                ; objc_msgSend$bounds
+288  stp     d9, d11, [sp, #0x58]
+292  fmov    d11, d2
+296  str     d10, [sp, #0x50]
+300  fmov    d10, d8
+304  fmov    d8, d3
+308  bl      0x1859cf698                                ; symbol stub for: objc_release_x23
+312  mov     x0, x20
+316  bl      0x185ffcd80                                ; objc_msgSend$_boltPathSize
+320  fmov    d12, d0
+324  str     d1, [sp, #0x48]
+328  mov     x0, x20
+332  mov     x2, x19
+336  fmov    d0, d11
+340  fmov    d1, d8
+344  bl      0x185ffcda0                                ; objc_msgSend$_boltRectForTraitCollection:boltSize:
+348  str     d0, [sp, #0x40]
+352  fmov    d11, d1
+356  fmov    d8, d15
+360  fmov    d15, d14
+364  fmov    d14, d2
+368  fmov    d9, d13
+372  fmov    d13, d3
+376  mov     x0, x20
+380  bl      0x1859cf5f0                                ; symbol stub for: objc_opt_class
+384  str     d13, [sp, #0x30]
+388  fmov    d13, d9
+392  ldp     d5, d4, [sp, #0x88]
+396  ldur    d6, [x29, #-0x88]
+400  stp     d11, d14, [sp, #0x20]
+404  fmov    d14, d15
+408  fmov    d15, d8
+412  fmov    d8, d10
+416  ldp     d10, d9, [sp, #0x50]
+420  ldp     d11, d7, [sp, #0x60]
+424  ldr     d0, [sp, #0x40]
+428  str     d0, [sp, #0x18]
+432  ldr     d0, [sp, #0x48]
+436  stp     d12, d0, [sp, #0x8]
+440  str     d8, [sp]
+444  fmov    d0, d13
+448  ldr     d12, [sp, #0x78]
+452  fmov    d1, d12
+456  fmov    d2, d14
+460  fmov    d3, d11
+464  mov     x2, x22
+468  bl      0x185ffbb60                                ; objc_msgSend$_batteryBodyImageWithSize:forScale:batteryRect:cornerRadius:lineWidth:withBoltCutOutOfSize:inRect:boltFlipped:
+472  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+476  b       0x18591a05c                                ; <+544>
+480  bl      0x1859cf5f0                                ; symbol stub for: objc_opt_class
+484  cmp     w23, #0x0
+488  movi    d0, #0000000000000000
+492  fcsel   d0, d0, d8, ne
+496  str     d0, [sp]
+500  fmov    d0, d13
+504  ldr     d12, [sp, #0x78]
+508  fmov    d1, d12
+512  fmov    d2, d14
+516  fmov    d3, d11
+520  ldp     d5, d4, [sp, #0x88]
+524  ldur    d6, [x29, #-0x88]
+528  mov     x2, x23
+532  ldr     d7, [sp, #0x68]
+536  bl      0x185ffbb40                                ; objc_msgSend$_batteryBodyImageWithSize:forScale:batteryRect:cornerRadius:lineWidth:filled:
+540  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+544  bl      0x1859cf71c                                ; symbol stub for: objc_retainAutorelease
+548  mov     x22, x0
+552  bl      0x185fedc60                                ; objc_msgSend$CGImage
+556  mov     x23, x0
+560  mov     x0, x20
+564  bl      0x18609cc60                                ; objc_msgSend$bodyLayer
+568  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+572  mov     x24, x0
+576  mov     x2, x23
+580  bl      0x186137740                                ; objc_msgSend$setContents:
+584  bl      0x1859cf6a4                                ; symbol stub for: objc_release_x24
+588  mov     x0, x20
+592  bl      0x18609cc60                                ; objc_msgSend$bodyLayer
+596  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+600  mov     x23, x0
+604  fmov    d0, d10
+608  fmov    d1, d9
+612  fmov    d2, d13
+616  fmov    d3, d12
+620  bl      0x186141740                                ; objc_msgSend$setFrame:
+624  bl      0x1859cf698                                ; symbol stub for: objc_release_x23
+628  mov     x0, x20
+632  bl      0x18609cea0                                ; objc_msgSend$boltMaskLayer
+636  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+640  mov     x23, x0
+644  mov     x2, x21
+648  bl      0x1861436c0                                ; objc_msgSend$setHidden:
+652  bl      0x1859cf698                                ; symbol stub for: objc_release_x23
+656  ldr     d0, [sp, #0x70]
+660  fadd    d8, d8, d0
+664  fmov    d0, d10
+668  fmov    d1, d9
+672  fmov    d2, d13
+676  fmov    d3, d12
+680  bl      0x1859cd4b4                                ; symbol stub for: CGRectGetMidY
+684  fmov    d1, #-0.50000000
+688  ldr     d13, [sp, #0x80]
+692  fmul    d1, d13, d1
+696  fadd    d9, d0, d1
+700  mov     x0, x20
+704  bl      0x18610f2c0                                ; objc_msgSend$pinLayer
+708  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+712  mov     x21, x0
+716  fmov    d0, d8
+720  fmov    d1, d9
+724  fmov    d2, d15
+728  fmov    d3, d13
+732  bl      0x186141740                                ; objc_msgSend$setFrame:
+736  bl      0x1859cf680                                ; symbol stub for: objc_release_x21
+740  mov     x0, x20
+744  bl      0x1860ec0c0                                ; objc_msgSend$internalSizeCategory
+748  cmp     x0, #0x2
+752  cset    w21, eq
+756  mov     x0, x20
+760  bl      0x1859cf5f0                                ; symbol stub for: objc_opt_class
+764  fmov    d0, d15
+768  fmov    d1, d13
+772  fmov    d2, d14
+776  mov     x2, x21
+780  bl      0x185ffbd00                                ; objc_msgSend$_batteryPinImageWithSize:forScale:complexPinPath:
+784  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+788  bl      0x1859cf71c                                ; symbol stub for: objc_retainAutorelease
+792  mov     x21, x0
+796  bl      0x185fedc60                                ; objc_msgSend$CGImage
+800  mov     x23, x0
+804  mov     x0, x20
+808  bl      0x18610f2c0                                ; objc_msgSend$pinLayer
+812  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+816  mov     x20, x0
+820  mov     x2, x23
+824  bl      0x186137740                                ; objc_msgSend$setContents:
+828  bl      0x1859cf674                                ; symbol stub for: objc_release_x20
+832  bl      0x1859cf680                                ; symbol stub for: objc_release_x21
+836  bl      0x1859cf68c                                ; symbol stub for: objc_release_x22
+840  bl      0x1859cf65c                                ; symbol stub for: objc_release_x19
+844  fmov    d0, d11
+848  ldp     d2, d1, [sp, #0x88]
+852  ldur    d3, [x29, #-0x88]
+856  ldp     x29, x30, [sp, #0x120]
+860  ldp     x20, x19, [sp, #0x110]
+864  ldp     x22, x21, [sp, #0x100]
+868  ldp     x24, x23, [sp, #0xf0]
+872  ldp     x28, x27, [sp, #0xe0]
+876  ldp     d9, d8, [sp, #0xd0]
+880  ldp     d11, d10, [sp, #0xc0]
+884  ldp     d13, d12, [sp, #0xb0]
+888  ldp     d15, d14, [sp, #0xa0]
+892  add     sp, sp, #0x130
+896  ret

### -[_UIBatteryView _bodyRectForTraitCollection:]  (39 条)
+0    stp     d11, d10, [sp, #-0x40]!
+4    stp     d9, d8, [sp, #0x10]
+8    stp     x20, x19, [sp, #0x20]
+12   stp     x29, x30, [sp, #0x30]
+16   add     x29, sp, #0x30
+20   mov     x19, x0
+24   bl      0x1859cf794                                ; symbol stub for: objc_retain_x2
+28   mov     x20, x0
+32   mov     x0, x19
+36   mov     x2, x20
+40   bl      0x185ffbd40                                ; objc_msgSend$_batterySizeForTraitCollection:
+44   fmov    d8, d0
+48   fmov    d9, d1
+52   mov     x0, x19
+56   mov     x2, x20
+60   bl      0x1860352c0                                ; objc_msgSend$_lineWidthAndInterspaceForTraitCollection:
+64   fmov    d10, d0
+68   bl      0x1859cf674                                ; symbol stub for: objc_release_x20
+72   mov     x0, x19
+76   bl      0x18609d980                                ; objc_msgSend$bounds
+80   adrp    x8, 423423
+84   ldrsw   x8, [x8, #0x2e4]                           ; ivar _showsPercentage
+88   ldrb    w8, [x19, x8]
+92   cbnz    w8, 0x184c9c744                            ; <+128>
+96   fmov    d2, #0.50000000
+100  fmul    d2, d10, d2
+104  fadd    d0, d2, d0
+108  fsub    d3, d8, d2
+112  fsub    d8, d3, d2
+116  fadd    d1, d2, d1
+120  fsub    d3, d9, d2
+124  fsub    d9, d3, d2
+128  fmov    d2, d8
+132  fmov    d3, d9
+136  ldp     x29, x30, [sp, #0x30]
+140  ldp     x20, x19, [sp, #0x20]
+144  ldp     d9, d8, [sp, #0x10]
+148  ldp     d11, d10, [sp], #0x40
+152  ret

### -[_UIBatteryView _fillLayerFrame:cornerRadius:]  (93 条)
+0    sub     sp, sp, #0x70
+4    stp     d13, d12, [sp, #0x10]
+8    stp     d11, d10, [sp, #0x20]
+12   stp     d9, d8, [sp, #0x30]
+16   stp     x22, x21, [sp, #0x40]
+20   stp     x20, x19, [sp, #0x50]
+24   stp     x29, x30, [sp, #0x60]
+28   add     x29, sp, #0x60
+32   mov     x19, x3
+36   mov     x20, x2
+40   mov     x21, x0
+44   bl      0x186185ce0                                ; objc_msgSend$traitCollection
+48   bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+52   mov     x2, x0
+56   str     x0, [sp, #0x8]
+60   mov     x0, x21
+64   bl      0x185ffbd40                                ; objc_msgSend$_batterySizeForTraitCollection:
+68   fmov    d11, d0
+72   fmov    d8, d1
+76   mov     x0, x21
+80   ldr     x2, [sp, #0x8]
+84   bl      0x1860352c0                                ; objc_msgSend$_lineWidthAndInterspaceForTraitCollection:
+88   fmov    d12, d0
+92   mov     x0, x21
+96   bl      0x18609d980                                ; objc_msgSend$bounds
+100  fmov    d10, d0
+104  fmov    d9, d1
+108  mov     x0, x21
+112  bl      0x1860a3900                                ; objc_msgSend$chargePercent
+116  adrp    x8, 423422
+120  ldrsw   x22, [x8, #0x2e4]                          ; ivar _showsPercentage
+124  ldrb    w8, [x21, x22]
+128  cbnz    w8, 0x184c9d744                            ; <+160>
+132  fadd    d1, d12, d12
+136  fadd    d10, d1, d10
+140  fsub    d2, d11, d1
+144  fsub    d11, d2, d1
+148  fadd    d9, d1, d9
+152  fsub    d2, d8, d1
+156  fsub    d8, d2, d1
+160  fmul    d11, d0, d11
+164  mov     x0, x21
+168  ldr     x2, [sp, #0x8]
+172  bl      0x186029640                                ; objc_msgSend$_insideCornerRadiusForTraitCollection:
+176  fmov    d12, d0
+180  mov     x0, x21
+184  bl      0x1861253e0                                ; objc_msgSend$rounded
+188  fmov    d0, #3.12500000
+192  fdiv    d0, d8, d0
+196  cmp     w0, #0x0
+200  fcsel   d12, d0, d12, ne
+204  ldrb    w8, [x21, x22]
+208  cbnz    w8, 0x184c9d7cc                            ; <+296>
+212  fmov    d0, d10
+216  fmov    d1, d9
+220  fmov    d2, d11
+224  fmov    d3, d8
+228  bl      0x1859cd4d8                                ; symbol stub for: CGRectGetWidth
+232  fadd    d1, d12, d12
+236  fcmp    d0, d1
+240  b.pl    0x184c9d7cc                                ; <+296>
+244  fmov    d0, d10
+248  fmov    d1, d9
+252  fmov    d2, d11
+256  fmov    d3, d8
+260  bl      0x1859cd4d8                                ; symbol stub for: CGRectGetWidth
+264  fmov    d1, #0.50000000
+268  fmul    d0, d0, d1
+272  fsub    d2, d12, d0
+276  fmul    d1, d2, d1
+280  fadd    d9, d9, d1
+284  fsub    d2, d8, d1
+288  fsub    d8, d2, d1
+292  fmov    d12, d0
+296  fmov    d0, d11
+300  mov     x0, x21
+304  bl      0x184f8a6c0                                ; UIRoundToViewScale
+308  cbz     x20, 0x184c9d7ec                           ; <+328>
+312  fmov    d1, #1.00000000
+316  fmaxnm  d0, d0, d1
+320  stp     d10, d9, [x20]
+324  stp     d0, d8, [x20, #0x10]
+328  cbz     x19, 0x184c9d7f4                           ; <+336>
+332  str     d12, [x19]
+336  ldr     x0, [sp, #0x8]
+340  ldp     x29, x30, [sp, #0x60]
+344  ldp     x20, x19, [sp, #0x50]
+348  ldp     x22, x21, [sp, #0x40]
+352  ldp     d9, d8, [sp, #0x30]
+356  ldp     d11, d10, [sp, #0x20]
+360  ldp     d13, d12, [sp, #0x10]
+364  add     sp, sp, #0x70
+368  b       0x1859cf638                                ; symbol stub for: objc_release

### +[UIBezierPath bezierPathWithRoundedRect:cornerRadius:]  (2 条)
+0    mov     x2, #-0x1                                  ; =-1
+4    b       0x185ffcb80                                ; objc_msgSend$_bezierPathWithRoundedRect:byRoundingCorners:cornerRadius:

### +[UIBezierPath _bezierPathWithRoundedRect:byRoundingCorners:cornerRadius:]  (3 条)
+0    mov     w4, #0x0                                   ; =0
+4    mov     w3, #0x10                                  ; =16
+8    b       0x186050000                                ; objc_msgSend$_roundedRectBezierPath:withRoundedCorners:cornerRadius:segments:legacyCorners:

### -[_UIStaticBatteryView _useImagesWithCutoutsForBolt]  (18 条)
+0    stp     x20, x19, [sp, #-0x20]!
+4    stp     x29, x30, [sp, #0x10]
+8    add     x29, sp, #0x10
+12   mov     x19, x0
+16   bl      0x1861716c0                                ; objc_msgSend$showsPercentage
+20   tbnz    w0, #0x0, 0x18591a68c                      ; <+40>
+24   adrp    x8, 420241
+28   ldrsw   x8, [x8, #0xb2c]                           ; ivar _inflightBoltAnimationCount
+32   ldr     x8, [x19, x8]
+36   cbz     x8, 0x18591a69c                            ; <+56>
+40   mov     w0, #0x0                                   ; =0
+44   ldp     x29, x30, [sp, #0x10]
+48   ldp     x20, x19, [sp], #0x20
+52   ret
+56   mov     x0, x19
+60   ldp     x29, x30, [sp, #0x10]
+64   ldp     x20, x19, [sp], #0x20
+68   b       0x1860695a0                                ; objc_msgSend$_shouldShowBolt

### +[_UIStaticBatteryView _batteryPinImageWithSize:forScale:complexPinPath:]  (79 条)
+0    sub     sp, sp, #0x70
+4    stp     d11, d10, [sp, #0x10]
+8    stp     d9, d8, [sp, #0x20]
+12   stp     x24, x23, [sp, #0x30]
+16   stp     x22, x21, [sp, #0x40]
+20   stp     x20, x19, [sp, #0x50]
+24   stp     x29, x30, [sp, #0x60]
+28   add     x29, sp, #0x60
+32   mov     x20, x2
+36   fmov    d8, d2
+40   fmov    d9, d1
+44   fmov    d10, d0
+48   mov     x19, x0
+52   adrp    x8, 420397
+56   ldr     x8, [x8, #0x460]
+60   cmn     x8, #0x1
+64   b.ne    0x18591b2bc                                ; <+292>
+68   adrp    x8, 435447
+72   ldr     x0, [x8, #0x8d0]
+76   bl      0x1859cf494                                ; symbol stub for: objc_alloc
+80   adrp    x8, 434497
+84   ldr     x8, [x8, #0x7e0]
+88   ldp     d2, d3, [x8]
+92   ldp     d4, d5, [x8, #0x10]
+96   str     d8, [sp]
+100  movi    d6, #0000000000000000
+104  movi    d7, #0000000000000000
+108  mov     x2, x19
+112  fmov    d0, d10
+116  fmov    d1, d9
+120  mov     x3, x20
+124  bl      0x1860de600                                ; objc_msgSend$initWithClass:size:rect:radius:lineWidth:alternate:scale:
+128  mov     x21, x0
+132  adrp    x23, 420397
+136  ldr     x0, [x23, #0x458]
+140  mov     x2, x21
+144  bl      0x1861080a0                                ; objc_msgSend$objectForKey:
+148  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+152  mov     x22, x0
+156  cbnz    x0, 0x18591b294                            ; <+252>
+160  mov     x0, x19
+164  fmov    d0, d10
+168  fmov    d1, d9
+172  mov     x2, x20
+176  bl      0x1860403e0                                ; objc_msgSend$_pinBezierPathForSize:isComplex:
+180  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+184  mov     x20, x0
+188  fmov    d3, #1.00000000
+192  mov     x0, x19
+196  mov     x2, x20
+200  fmov    d0, d10
+204  fmov    d1, d9
+208  fmov    d2, d8
+212  mov     w3, #0x0                                   ; =0
+216  mov     w4, #0x1                                   ; =1
+220  bl      0x186025ee0                                ; objc_msgSend$_imageWithRenderedBezierPath:size:scale:pathScaleFactor:stroke:fill:
+224  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+228  mov     x22, x0
+232  ldr     x0, [x23, #0x458]
+236  mov     x2, x22
+240  mov     x3, x21
+244  bl      0x1861506e0                                ; objc_msgSend$setObject:forKey:
+248  bl      0x1859cf674                                ; symbol stub for: objc_release_x20
+252  bl      0x1859cf680                                ; symbol stub for: objc_release_x21
+256  mov     x0, x22
+260  ldp     x29, x30, [sp, #0x60]
+264  ldp     x20, x19, [sp, #0x50]
+268  ldp     x22, x21, [sp, #0x40]
+272  ldp     x24, x23, [sp, #0x30]
+276  ldp     d9, d8, [sp, #0x20]
+280  ldp     d11, d10, [sp, #0x10]
+284  add     sp, sp, #0x70
+288  b       0x1859cf4e8                                ; symbol stub for: objc_autoreleaseReturnValue
+292  adrp    x0, 420397
+296  add     x0, x0, #0x460                             ; _MergedGlobals
+300  adrp    x1, 434583
+304  add     x1, x1, #0x978                             ; __block_literal_global.22
+308  bl      0x1859ceedc                                ; symbol stub for: dispatch_once
+312  b       0x18591b1dc                                ; <+68>

### +[_UIStaticBatteryView _batteryBodyImageWithSize:forScale:batteryRect:cornerRadius:lineWidth:filled:]  (96 条)
+0    sub     sp, sp, #0xa0
+4    stp     d15, d14, [sp, #0x20]
+8    stp     d13, d12, [sp, #0x30]
+12   stp     d11, d10, [sp, #0x40]
+16   stp     d9, d8, [sp, #0x50]
+20   stp     x24, x23, [sp, #0x60]
+24   stp     x22, x21, [sp, #0x70]
+28   stp     x20, x19, [sp, #0x80]
+32   stp     x29, x30, [sp, #0x90]
+36   add     x29, sp, #0x90
+40   mov     x19, x2
+44   str     d7, [sp, #0x18]
+48   fmov    d13, d6
+52   fmov    d14, d5
+56   fmov    d15, d4
+60   fmov    d8, d3
+64   fmov    d12, d2
+68   fmov    d10, d1
+72   fmov    d11, d0
+76   mov     x20, x0
+80   ldr     d9, [x29, #0x10]
+84   adrp    x8, 420398
+88   ldr     x8, [x8, #0x430]
+92   cmn     x8, #0x1
+96   b.ne    0x18591ad68                                ; <+360>
+100  adrp    x8, 435448
+104  ldr     x0, [x8, #0x8d0]
+108  bl      0x1859cf494                                ; symbol stub for: objc_alloc
+112  str     d12, [sp, #0x10]
+116  str     d12, [sp]
+120  mov     x2, x20
+124  fmov    d0, d11
+128  fmov    d1, d10
+132  fmov    d2, d8
+136  fmov    d3, d15
+140  fmov    d4, d14
+144  fmov    d5, d13
+148  ldr     d12, [sp, #0x18]
+152  fmov    d6, d12
+156  fmov    d7, d9
+160  mov     x3, x19
+164  bl      0x1860de600                                ; objc_msgSend$initWithClass:size:rect:radius:lineWidth:alternate:scale:
+168  mov     x21, x0
+172  adrp    x24, 420398
+176  ldr     x0, [x24, #0x428]
+180  mov     x2, x21
+184  bl      0x1861080a0                                ; objc_msgSend$objectForKey:
+188  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+192  mov     x22, x0
+196  cbnz    x0, 0x18591ad38                            ; <+312>
+200  adrp    x8, 435442
+204  ldr     x0, [x8, #0x90]
+208  fmov    d0, d8
+212  fmov    d1, d15
+216  fmov    d2, d14
+220  fmov    d3, d13
+224  fmov    d4, d12
+228  bl      0x18609c340                                ; objc_msgSend$bezierPathWithRoundedRect:cornerRadius:
+232  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+236  mov     x23, x0
+240  fmov    d0, d9
+244  bl      0x18614c120                                ; objc_msgSend$setLineWidth:
+248  fmov    d3, #1.00000000
+252  mov     x0, x20
+256  mov     x2, x23
+260  fmov    d0, d11
+264  fmov    d1, d10
+268  ldr     d2, [sp, #0x10]
+272  mov     w3, #0x1                                   ; =1
+276  mov     x4, x19
+280  bl      0x186025ee0                                ; objc_msgSend$_imageWithRenderedBezierPath:size:scale:pathScaleFactor:stroke:fill:
+284  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+288  mov     x22, x0
+292  ldr     x0, [x24, #0x428]
+296  mov     x2, x22
+300  mov     x3, x21
+304  bl      0x1861506e0                                ; objc_msgSend$setObject:forKey:
+308  bl      0x1859cf698                                ; symbol stub for: objc_release_x23
+312  bl      0x1859cf680                                ; symbol stub for: objc_release_x21
+316  mov     x0, x22
+320  ldp     x29, x30, [sp, #0x90]
+324  ldp     x20, x19, [sp, #0x80]
+328  ldp     x22, x21, [sp, #0x70]
+332  ldp     x24, x23, [sp, #0x60]
+336  ldp     d9, d8, [sp, #0x50]
+340  ldp     d11, d10, [sp, #0x40]
+344  ldp     d13, d12, [sp, #0x30]
+348  ldp     d15, d14, [sp, #0x20]
+352  add     sp, sp, #0xa0
+356  b       0x1859cf4e8                                ; symbol stub for: objc_autoreleaseReturnValue
+360  adrp    x0, 420398
+364  add     x0, x0, #0x430                             ; _MergedGlobals
+368  adrp    x1, 434584
+372  add     x1, x1, #0x918                             ; __block_literal_global
+376  bl      0x1859ceedc                                ; symbol stub for: dispatch_once
+380  b       0x18591ac64                                ; <+100>

### +[_UIStaticBatteryView _batteryFillImageWithSize:forScale:cornerRadius:]  (86 条)
+0    sub     sp, sp, #0x70
+4    stp     d11, d10, [sp, #0x10]
+8    stp     d9, d8, [sp, #0x20]
+12   stp     x24, x23, [sp, #0x30]
+16   stp     x22, x21, [sp, #0x40]
+20   stp     x20, x19, [sp, #0x50]
+24   stp     x29, x30, [sp, #0x60]
+28   add     x29, sp, #0x60
+32   fmov    d11, d3
+36   fmov    d8, d2
+40   fmov    d9, d1
+44   fmov    d10, d0
+48   mov     x19, x0
+52   adrp    x8, 420397
+56   ldr     x8, [x8, #0x490]
+60   cmn     x8, #0x1
+64   b.ne    0x18591b750                                ; <+320>
+68   adrp    x8, 435447
+72   ldr     x0, [x8, #0x8d0]
+76   bl      0x1859cf494                                ; symbol stub for: objc_alloc
+80   adrp    x8, 434497
+84   ldr     x8, [x8, #0x7e0]
+88   ldp     d2, d3, [x8]
+92   ldp     d4, d5, [x8, #0x10]
+96   str     d8, [sp]
+100  movi    d7, #0000000000000000
+104  mov     x2, x19
+108  fmov    d0, d10
+112  fmov    d1, d9
+116  fmov    d6, d11
+120  mov     w3, #0x0                                   ; =0
+124  bl      0x1860de600                                ; objc_msgSend$initWithClass:size:rect:radius:lineWidth:alternate:scale:
+128  mov     x20, x0
+132  adrp    x23, 420397
+136  ldr     x0, [x23, #0x488]
+140  mov     x2, x20
+144  bl      0x1861080a0                                ; objc_msgSend$objectForKey:
+148  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+152  mov     x21, x0
+156  cbnz    x0, 0x18591b728                            ; <+280>
+160  adrp    x8, 435441
+164  ldr     x0, [x8, #0x90]
+168  adrp    x8, 434497
+172  ldr     x8, [x8, #0x728]
+176  ldp     d0, d1, [x8]
+180  fmov    d2, d10
+184  fmov    d3, d9
+188  mov     x2, #-0x1                                  ; =-1
+192  fmov    d4, d11
+196  fmov    d5, d11
+200  mov     w3, #0x10                                  ; =16
+204  bl      0x186009700                                ; objc_msgSend$_continuousRoundedCARectBezierPath:withRoundedCorners:cornerRadius:segments:
+208  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+212  mov     x22, x0
+216  fmov    d3, #1.00000000
+220  mov     x0, x19
+224  mov     x2, x22
+228  fmov    d0, d10
+232  fmov    d1, d9
+236  fmov    d2, d8
+240  mov     w3, #0x0                                   ; =0
+244  mov     w4, #0x1                                   ; =1
+248  bl      0x186025ee0                                ; objc_msgSend$_imageWithRenderedBezierPath:size:scale:pathScaleFactor:stroke:fill:
+252  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+256  mov     x21, x0
+260  ldr     x0, [x23, #0x488]
+264  mov     x2, x21
+268  mov     x3, x20
+272  bl      0x1861506e0                                ; objc_msgSend$setObject:forKey:
+276  bl      0x1859cf68c                                ; symbol stub for: objc_release_x22
+280  bl      0x1859cf674                                ; symbol stub for: objc_release_x20
+284  mov     x0, x21
+288  ldp     x29, x30, [sp, #0x60]
+292  ldp     x20, x19, [sp, #0x50]
+296  ldp     x22, x21, [sp, #0x40]
+300  ldp     x24, x23, [sp, #0x30]
+304  ldp     d9, d8, [sp, #0x20]
+308  ldp     d11, d10, [sp, #0x10]
+312  add     sp, sp, #0x70
+316  b       0x1859cf4e8                                ; symbol stub for: objc_autoreleaseReturnValue
+320  adrp    x0, 420397
+324  add     x0, x0, #0x490                             ; _MergedGlobals
+328  adrp    x1, 434583
+332  add     x1, x1, #0x9d8                             ; __block_literal_global.25
+336  bl      0x1859ceedc                                ; symbol stub for: dispatch_once
+340  b       0x18591b654                                ; <+68>

### +[_UIStaticBatteryView _imageWithRenderedBezierPath:size:scale:pathScaleFactor:stroke:fill:]  (51 条)
+0    sub     sp, sp, #0x90
+4    stp     d11, d10, [sp, #0x40]
+8    stp     d9, d8, [sp, #0x50]
+12   stp     x22, x21, [sp, #0x60]
+16   stp     x20, x19, [sp, #0x70]
+20   stp     x29, x30, [sp, #0x80]
+24   add     x29, sp, #0x80
+28   mov     x19, x4
+32   mov     x20, x3
+36   fmov    d8, d3
+40   fmov    d9, d2
+44   fmov    d10, d1
+48   fmov    d11, d0
+52   mov     x21, x0
+56   bl      0x1859cf794                                ; symbol stub for: objc_retain_x2
+60   adrp    x8, 434500
+64   ldr     x8, [x8, #0x3f0]
+68   str     x8, [sp, #0x8]
+72   adrp    x8, 510
+76   ldr     d0, [x8, #0x8f8]
+80   str     d0, [sp, #0x10]
+84   adrp    x8, 0
+88   add     x8, x8, #0x900                             ; __92+[_UIStaticBatteryView _imageWithRenderedBezierPath:size:scale:pathScaleFactor:stroke:fill:]_block_invoke
+92   adrp    x9, 434538
+96   add     x9, x9, #0x1f0                             ; __block_descriptor_50_e8_32s_e40_v16?0"UIGraphicsImageRendererContext"8ls32l8
+100  stp     x8, x9, [sp, #0x18]
+104  str     d8, [sp, #0x30]
+108  strb    w20, [sp, #0x38]
+112  str     x0, [sp, #0x28]
+116  strb    w19, [sp, #0x39]
+120  bl      0x1859cf710                                ; symbol stub for: objc_retain
+124  mov     x19, x0
+128  add     x2, sp, #0x8
+132  mov     x0, x21
+136  fmov    d0, d11
+140  fmov    d1, d10
+144  fmov    d2, d9
+148  bl      0x18604c2c0                                ; objc_msgSend$_renderedImageOfSize:scale:withActions:
+152  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+156  mov     x20, x0
+160  ldr     x8, [sp, #0x28]
+164  bl      0x1859cf6f8                                ; symbol stub for: objc_release_x8
+168  bl      0x1859cf65c                                ; symbol stub for: objc_release_x19
+172  mov     x0, x20
+176  ldp     x29, x30, [sp, #0x80]
+180  ldp     x20, x19, [sp, #0x70]
+184  ldp     x22, x21, [sp, #0x60]
+188  ldp     d9, d8, [sp, #0x50]
+192  ldp     d11, d10, [sp, #0x40]
+196  add     sp, sp, #0x90
+200  b       0x1859cf4e8                                ; symbol stub for: objc_autoreleaseReturnValue

### +[_UIStaticBatteryView _imageByPunchingImage:inRect:flippedHorizontally:outOfImage:inRect:size:scale:]  (83 条)
+0    sub     sp, sp, #0x110
+4    stp     d15, d14, [sp, #0x90]
+8    stp     d13, d12, [sp, #0xa0]
+12   stp     d11, d10, [sp, #0xb0]
+16   stp     d9, d8, [sp, #0xc0]
+20   stp     x28, x27, [sp, #0xd0]
+24   stp     x22, x21, [sp, #0xe0]
+28   stp     x20, x19, [sp, #0xf0]
+32   stp     x29, x30, [sp, #0x100]
+36   add     x29, sp, #0x100
+40   mov     x21, x4
+44   mov     x22, x3
+48   fmov    d11, d7
+52   fmov    d13, d6
+56   fmov    d15, d5
+60   fmov    d9, d4
+64   fmov    d12, d3
+68   fmov    d14, d2
+72   fmov    d8, d1
+76   fmov    d10, d0
+80   mov     x20, x0
+84   ldr     d0, [x29, #0x18]
+88   str     d0, [sp, #0x18]
+92   ldr     d0, [x29, #0x10]
+96   str     d0, [sp, #0x10]
+100  ldr     d0, [x29, #0x20]
+104  str     d0, [sp, #0x8]
+108  bl      0x1859cf794                                ; symbol stub for: objc_retain_x2
+112  mov     x19, x0
+116  bl      0x1859cf7ac                                ; symbol stub for: objc_retain_x21
+120  mov     x21, x0
+124  tbz     w22, #0x0, 0x18591a9e8                     ; <+144>
+128  mov     x0, x19
+132  bl      0x1860daa60                                ; objc_msgSend$imageWithHorizontallyFlippedOrientation
+136  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+140  b       0x18591a9ec                                ; <+148>
+144  bl      0x1859cf788                                ; symbol stub for: objc_retain_x19
+148  mov     x8, x0
+152  adrp    x9, 434500
+156  ldr     x9, [x9, #0x3f0]
+160  str     x9, [sp, #0x20]
+164  adrp    x9, 510
+168  ldr     d0, [x9, #0x8f8]
+172  str     d0, [sp, #0x28]
+176  adrp    x9, 0
+180  add     x9, x9, #0xaa4                             ; __102+[_UIStaticBatteryView _imageByPunchingImage:inRect:flippedHorizontally:outOfImage:inRect:size:scale:]_block_invoke
+184  adrp    x10, 434538
+188  add     x10, x10, #0x218                           ; __block_descriptor_112_e8_32s40s_e40_v16?0"UIGraphicsImageRendererContext"8ls32l8s40l8
+192  stp     x9, x10, [sp, #0x30]
+196  stp     d9, d15, [sp, #0x50]
+200  stp     d13, d11, [sp, #0x60]
+204  stp     x21, x0, [sp, #0x40]
+208  stp     d10, d8, [sp, #0x70]
+212  stp     d14, d12, [sp, #0x80]
+216  bl      0x1859cf848                                ; symbol stub for: objc_retain_x8
+220  mov     x22, x0
+224  bl      0x1859cf7ac                                ; symbol stub for: objc_retain_x21
+228  mov     x21, x0
+232  add     x2, sp, #0x20
+236  mov     x0, x20
+240  ldp     d0, d1, [sp, #0x10]
+244  ldr     d2, [sp, #0x8]
+248  bl      0x18604c2c0                                ; objc_msgSend$_renderedImageOfSize:scale:withActions:
+252  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+256  mov     x20, x0
+260  ldr     x8, [sp, #0x48]
+264  bl      0x1859cf6f8                                ; symbol stub for: objc_release_x8
+268  ldr     x8, [sp, #0x40]
+272  bl      0x1859cf6f8                                ; symbol stub for: objc_release_x8
+276  bl      0x1859cf68c                                ; symbol stub for: objc_release_x22
+280  bl      0x1859cf680                                ; symbol stub for: objc_release_x21
+284  bl      0x1859cf65c                                ; symbol stub for: objc_release_x19
+288  mov     x0, x20
+292  ldp     x29, x30, [sp, #0x100]
+296  ldp     x20, x19, [sp, #0xf0]
+300  ldp     x22, x21, [sp, #0xe0]
+304  ldp     x28, x27, [sp, #0xd0]
+308  ldp     d9, d8, [sp, #0xc0]
+312  ldp     d11, d10, [sp, #0xb0]
+316  ldp     d13, d12, [sp, #0xa0]
+320  ldp     d15, d14, [sp, #0x90]
+324  add     sp, sp, #0x110
+328  b       0x1859cf4e8                                ; symbol stub for: objc_autoreleaseReturnValue

### +[UIBezierPath _roundedRectBezierPath:withRoundedCorners:cornerRadius:segments:legacyCorners:]  (303 条)
+0    sub     sp, sp, #0xb0
+4    stp     d15, d14, [sp, #0x20]
+8    stp     d13, d12, [sp, #0x30]
+12   stp     d11, d10, [sp, #0x40]
+16   stp     d9, d8, [sp, #0x50]
+20   stp     x26, x25, [sp, #0x60]
+24   stp     x24, x23, [sp, #0x70]
+28   stp     x22, x21, [sp, #0x80]
+32   stp     x20, x19, [sp, #0x90]
+36   stp     x29, x30, [sp, #0xa0]
+40   add     x29, sp, #0xa0
+44   mov     x22, x3
+48   fmov    d11, d4
+52   mov     x19, x2
+56   fmov    d10, d3
+60   fmov    d12, d2
+64   fmov    d9, d1
+68   fmov    d8, d0
+72   mov     x20, x0
+76   tbz     w4, #0x0, 0x184f694c4                      ; <+300>
+80   mvn     w8, w19
+84   mov     w9, #0x5                                   ; =5
+88   tst     x8, x9
+92   b.eq    0x184f69408                                ; <+112>
+96   mov     w8, #0xa                                   ; =10
+100  and     x8, x19, x8
+104  cmp     x8, #0xa
+108  b.ne    0x184f6942c                                ; <+148>
+112  fmov    d0, d8
+116  fmov    d1, d9
+120  fmov    d2, d12
+124  fmov    d3, d10
+128  bl      0x1859cd484                                ; symbol stub for: CGRectGetHeight
+132  fmov    d1, #0.50000000
+136  fmul    d0, d0, d1
+140  fcmp    d0, d11
+144  fcsel   d11, d11, d0, gt
+148  mvn     w8, w19
+152  tst     x8, #0x3
+156  b.eq    0x184f69444                                ; <+172>
+160  and     x8, x19, #0xc
+164  cmp     x8, #0xc
+168  b.ne    0x184f69468                                ; <+208>
+172  fmov    d0, d8
+176  fmov    d1, d9
+180  fmov    d2, d12
+184  fmov    d3, d10
+188  bl      0x1859cd4d8                                ; symbol stub for: CGRectGetWidth
+192  fmov    d1, #0.50000000
+196  fmul    d0, d0, d1
+200  fcmp    d11, d0
+204  fcsel   d11, d11, d0, mi
+208  fmov    d0, d8
+212  fmov    d1, d9
+216  fmov    d2, d12
+220  fmov    d3, d10
+224  bl      0x1859cd4d8                                ; symbol stub for: CGRectGetWidth
+228  fmov    d13, d0
+232  fmov    d0, d8
+236  fmov    d1, d9
+240  fmov    d2, d12
+244  fmov    d3, d10
+248  bl      0x1859cd484                                ; symbol stub for: CGRectGetHeight
+252  fcmp    d13, d0
+256  fcsel   d0, d13, d0, mi
+260  fcmp    d11, d0
+264  fcsel   d11, d11, d0, mi
+268  bl      0x1859cd310                                ; symbol stub for: CGPathCreateMutable
+272  mov     x21, x0
+276  tbnz    w22, #0x4, 0x184f694f8                     ; <+352>
+280  mov     w8, #0xd                                   ; =13
+284  bics    wzr, w8, w22
+288  b.ne    0x184f69500                                ; <+360>
+292  ubfx    w23, w22, #1, #1
+296  b       0x184f69504                                ; <+364>
+300  mov     x0, x20
+304  fmov    d0, d8
+308  fmov    d1, d9
+312  fmov    d2, d12
+316  fmov    d3, d10
+320  mov     x2, x19
+324  fmov    d4, d11
+328  fmov    d5, d11
+332  mov     x3, x22
+336  bl      0x186009740                                ; objc_msgSend$_continuousRoundedRectBezierPath:withRoundedCorners:cornerRadius:segments:
+340  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+344  mov     x20, x0
+348  b       0x184f69824                                ; <+1164>
+352  mov     w23, #0x1                                  ; =1
+356  b       0x184f69504                                ; <+364>
+360  mov     w23, #0x0                                  ; =0
+364  tst     x19, #0x2
+368  cset    w8, eq
+372  tst     x19, #0x4
+376  cset    w9, eq
+380  tst     x19, #0x1
+384  cset    w10, eq
+388  eor     w11, w23, #0x1
+392  tst     w22, #0x4
+396  cset    w12, eq
+400  and     w24, w12, w11
+404  tst     w22, #0x1
+408  cset    w13, eq
+412  and     w14, w13, w24
+416  orr     w10, w10, w14
+420  cmp     w10, #0x0
+424  movi    d0, #0000000000000000
+428  fcsel   d14, d0, d11, ne
+432  and     w10, w13, w11
+436  tst     w22, #0x8
+440  cset    w13, eq
+444  and     w14, w13, w10
+448  orr     w8, w8, w14
+452  cmp     w8, #0x0
+456  fcsel   d15, d0, d11, ne
+460  and     w25, w13, w11
+464  tst     w22, #0x2
+468  cset    w8, eq
+472  and     w13, w8, w25
+476  tst     x19, #0x8
+480  cset    w14, eq
+484  orr     w13, w14, w13
+488  cmp     w13, #0x0
+492  fcsel   d1, d0, d11, ne
+496  and     w22, w8, w11
+500  and     w8, w12, w22
+504  orr     w8, w9, w8
+508  cmp     w8, #0x0
+512  fcsel   d0, d0, d11, ne
+516  stp     d0, d1, [sp, #0x10]
+520  tbnz    w10, #0x0, 0x184f695d0                     ; <+568>
+524  fadd    d0, d8, d14
+528  mov     x0, x21
+532  mov     x1, #0x0                                   ; =0
+536  fmov    d1, d9
+540  bl      0x1859cd3ac                                ; symbol stub for: CGPathMoveToPoint
+544  fadd    d0, d8, d12
+548  fsub    d0, d0, d15
+552  mov     x0, x21
+556  mov     x1, #0x0                                   ; =0
+560  fmov    d1, d9
+564  bl      0x1859cd280                                ; symbol stub for: CGPathAddLineToPoint
+568  fcmp    d15, #0.0
+572  b.le    0x184f69630                                ; <+664>
+576  str     d14, [sp, #0x8]
+580  fadd    d0, d8, d12
+584  fsub    d13, d0, d11
+588  fadd    d14, d9, d11
+592  tbnz    w23, #0x0, 0x184f69600                     ; <+616>
+596  mov     x0, x21
+600  mov     x1, #0x0                                   ; =0
+604  fmov    d0, d13
+608  fmov    d1, d9
+612  bl      0x1859cd3ac                                ; symbol stub for: CGPathMoveToPoint
+616  adrp    x8, 2993
+620  ldr     d3, [x8, #0x9d8]                           ; = 4.71238898038469
+624  adrp    x8, 2991
+628  ldr     d4, [x8, #0xe18]                           ; = 6.283185307179586
+632  mov     x0, x21
+636  mov     x1, #0x0                                   ; =0
+640  fmov    d0, d13
+644  fmov    d1, d14
+648  fmov    d2, d11
+652  mov     w2, #0x0                                   ; =0
+656  bl      0x1859cd25c                                ; symbol stub for: CGPathAddArc
+660  ldr     d14, [sp, #0x8]
+664  tbnz    w25, #0x0, 0x184f6966c                     ; <+724>
+668  fadd    d13, d8, d12
+672  tbnz    w23, #0x0, 0x184f69650                     ; <+696>
+676  fadd    d1, d9, d15
+680  mov     x0, x21
+684  mov     x1, #0x0                                   ; =0
+688  fmov    d0, d13
+692  bl      0x1859cd3ac                                ; symbol stub for: CGPathMoveToPoint
+696  fadd    d0, d9, d10
+700  ldr     d1, [sp, #0x18]
+704  fsub    d1, d0, d1
+708  mov     x0, x21
+712  mov     x1, #0x0                                   ; =0
+716  fmov    d0, d13
+720  bl      0x1859cd280                                ; symbol stub for: CGPathAddLineToPoint
+724  ldr     d0, [sp, #0x18]
+728  fcmp    d0, #0.0
+732  b.le    0x184f696cc                                ; <+820>
+736  fmov    d15, d14
+740  fadd    d0, d8, d12
+744  fsub    d13, d0, d11
+748  fadd    d1, d9, d10
+752  fsub    d14, d1, d11
+756  tbnz    w23, #0x0, 0x184f696a0                     ; <+776>
+760  mov     x0, x21
+764  mov     x1, #0x0                                   ; =0
+768  fmov    d0, d13
+772  bl      0x1859cd3ac                                ; symbol stub for: CGPathMoveToPoint
+776  adrp    x8, 2991
+780  ldr     d4, [x8, #0xc08]                           ; = 1.5707963267948966
+784  movi    d3, #0000000000000000
+788  mov     x0, x21
+792  mov     x1, #0x0                                   ; =0
+796  fmov    d0, d13
+800  fmov    d1, d14
+804  fmov    d2, d11
+808  mov     w2, #0x0                                   ; =0
+812  bl      0x1859cd25c                                ; symbol stub for: CGPathAddArc
+816  fmov    d14, d15
+820  ldr     d15, [sp, #0x10]
+824  tbnz    w22, #0x0, 0x184f69714                     ; <+892>
+828  cbz     w23, 0x184f696e0                           ; <+840>
+832  fadd    d12, d9, d10
+836  b       0x184f69700                                ; <+872>
+840  fadd    d0, d8, d12
+844  ldr     d1, [sp, #0x18]
+848  fsub    d0, d0, d1
+852  fadd    d12, d9, d10
+856  mov     x0, x21
+860  mov     x1, #0x0                                   ; =0
+864  fmov    d1, d12
+868  bl      0x1859cd3ac                                ; symbol stub for: CGPathMoveToPoint
+872  fadd    d0, d8, d15
+876  mov     x0, x21
+880  mov     x1, #0x0                                   ; =0
+884  fmov    d1, d12
+888  bl      0x1859cd280                                ; symbol stub for: CGPathAddLineToPoint
+892  fcmp    d15, #0.0
+896  b.le    0x184f69768                                ; <+976>
+900  fadd    d12, d8, d11
+904  fadd    d1, d9, d10
+908  fsub    d13, d1, d11
+912  tbnz    w23, #0x0, 0x184f6973c                     ; <+932>
+916  mov     x0, x21
+920  mov     x1, #0x0                                   ; =0
+924  fmov    d0, d12
+928  bl      0x1859cd3ac                                ; symbol stub for: CGPathMoveToPoint
+932  adrp    x8, 2991
+936  ldr     d3, [x8, #0xc08]                           ; = 1.5707963267948966
+940  adrp    x8, 2993
+944  ldr     d4, [x8, #0x1b8]                           ; = 3.141592653589793
+948  mov     x0, x21
+952  mov     x1, #0x0                                   ; =0
+956  fmov    d0, d12
+960  fmov    d1, d13
+964  fmov    d2, d11
+968  mov     w2, #0x0                                   ; =0
+972  bl      0x1859cd25c                                ; symbol stub for: CGPathAddArc
+976  tbnz    w24, #0x0, 0x184f6979c                     ; <+1028>
+980  tbnz    w23, #0x0, 0x184f69788                     ; <+1008>
+984  fadd    d0, d9, d10
+988  fsub    d1, d0, d15
+992  mov     x0, x21
+996  mov     x1, #0x0                                   ; =0
+1000 fmov    d0, d8
+1004 bl      0x1859cd3ac                                ; symbol stub for: CGPathMoveToPoint
+1008 fadd    d1, d9, d14
+1012 mov     x0, x21
+1016 mov     x1, #0x0                                   ; =0
+1020 fmov    d0, d8
+1024 bl      0x1859cd280                                ; symbol stub for: CGPathAddLineToPoint
+1028 fcmp    d14, #0.0
+1032 b.le    0x184f697f0                                ; <+1112>
+1036 fadd    d10, d8, d11
+1040 fadd    d9, d9, d11
+1044 tbnz    w23, #0x0, 0x184f697c4                     ; <+1068>
+1048 mov     x0, x21
+1052 mov     x1, #0x0                                   ; =0
+1056 fmov    d0, d8
+1060 fmov    d1, d9
+1064 bl      0x1859cd3ac                                ; symbol stub for: CGPathMoveToPoint
+1068 adrp    x8, 2993
+1072 ldr     d3, [x8, #0x1b8]                           ; = 3.141592653589793
+1076 adrp    x8, 2993
+1080 ldr     d4, [x8, #0x9d8]                           ; = 4.71238898038469
+1084 mov     x0, x21
+1088 mov     x1, #0x0                                   ; =0
+1092 fmov    d0, d10
+1096 fmov    d1, d9
+1100 fmov    d2, d11
+1104 mov     w2, #0x0                                   ; =0
+1108 bl      0x1859cd25c                                ; symbol stub for: CGPathAddArc
+1112 mov     x0, x20
+1116 bl      0x1859cf494                                ; symbol stub for: objc_alloc
+1120 mov     x2, x21
+1124 bl      0x1860275c0                                ; objc_msgSend$_initWithCGMutablePath:
+1128 mov     x20, x0
+1132 mov     x0, x21
+1136 bl      0x1859cc0bc                                ; symbol stub for: CFRelease
+1140 mov     w8, #0x1                                   ; =1
+1144 strb    w8, [x20, #0x59]
+1148 str     d11, [x20, #0x60]
+1152 strb    wzr, [x20, #0x68]
+1156 and     x8, x19, #0xf
+1160 str     x8, [x20, #0x70]
+1164 mov     x0, x20
+1168 ldp     x29, x30, [sp, #0xa0]
+1172 ldp     x20, x19, [sp, #0x90]
+1176 ldp     x22, x21, [sp, #0x80]
+1180 ldp     x24, x23, [sp, #0x70]
+1184 ldp     x26, x25, [sp, #0x60]
+1188 ldp     d9, d8, [sp, #0x50]
+1192 ldp     d11, d10, [sp, #0x40]
+1196 ldp     d13, d12, [sp, #0x30]
+1200 ldp     d15, d14, [sp, #0x20]
+1204 add     sp, sp, #0xb0
+1208 b       0x1859cf4e8                                ; symbol stub for: objc_autoreleaseReturnValue

### +[UIBezierPath _continuousRoundedCARectBezierPath:withRoundedCorners:cornerRadius:segments:]  (66 条)
+0    sub     sp, sp, #0x90
+4    stp     d11, d10, [sp, #0x30]
+8    stp     d9, d8, [sp, #0x40]
+12   stp     x24, x23, [sp, #0x50]
+16   stp     x22, x21, [sp, #0x60]
+20   stp     x20, x19, [sp, #0x70]
+24   stp     x29, x30, [sp, #0x80]
+28   add     x29, sp, #0x80
+32   mov     x19, x3
+36   mov     x20, x2
+40   fmov    d8, d3
+44   fmov    d9, d2
+48   fmov    d10, d1
+52   fmov    d11, d0
+56   mov     x21, x0
+60   adrp    x8, 436981
+64   ldr     x8, [x8, #0x538]
+68   ldr     x8, [x8]
+72   str     x8, [sp, #0x28]
+76   adrp    x8, 437923
+80   ldr     x0, [x8, #0x168]
+84   fmov    d0, d4
+88   fmov    d1, d5
+92   bl      0x1861923a0                                ; objc_msgSend$valueWithCGSize:
+96   bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+100  mov     x22, x0
+104  stp     x0, x0, [sp, #0x8]
+108  stp     x0, x0, [sp, #0x18]
+112  adrp    x8, 437923
+116  ldr     x0, [x8, #0x3f8]
+120  add     x2, sp, #0x8
+124  mov     w3, #0x4                                   ; =4
+128  bl      0x186095f40                                ; objc_msgSend$arrayWithObjects:count:
+132  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+136  mov     x23, x0
+140  mov     x0, x21
+144  fmov    d0, d11
+148  fmov    d1, d10
+152  fmov    d2, d9
+156  fmov    d3, d8
+160  mov     x2, x20
+164  mov     x3, x23
+168  mov     x4, x19
+172  mov     w5, #0x0                                   ; =0
+176  mov     w6, #0x0                                   ; =0
+180  bl      0x186009720                                ; objc_msgSend$_continuousRoundedRectBezierPath:withRoundedCorners:cornerRadii:segments:smoothPillShapes:clampCornerRadii:
+184  bl      0x1859cf500                                ; symbol stub for: objc_claimAutoreleasedReturnValue
+188  mov     x19, x0
+192  bl      0x1859cf698                                ; symbol stub for: objc_release_x23
+196  bl      0x1859cf68c                                ; symbol stub for: objc_release_x22
+200  ldr     x8, [sp, #0x28]
+204  adrp    x9, 436981
+208  ldr     x9, [x9, #0x538]
+212  ldr     x9, [x9]
+216  cmp     x9, x8
+220  b.ne    0x184f69bb0                                ; <+260>
+224  mov     x0, x19
+228  ldp     x29, x30, [sp, #0x80]
+232  ldp     x20, x19, [sp, #0x70]
+236  ldp     x22, x21, [sp, #0x60]
+240  ldp     x24, x23, [sp, #0x50]
+244  ldp     d9, d8, [sp, #0x40]
+248  ldp     d11, d10, [sp, #0x30]
+252  add     sp, sp, #0x90
+256  b       0x1859cf4e8                                ; symbol stub for: objc_autoreleaseReturnValue
+260  bl      0x1859ceac8                                ; symbol stub for: __stack_chk_fail

### __92+[_UIStaticBatteryView _imageWithRenderedBezierPath:size:scale:pathScaleFactor:stroke:fill:]_block_invoke  (22 条)
+0    stp     x20, x19, [sp, #-0x20]!
+4    stp     x29, x30, [sp, #0x10]
+8    add     x29, sp, #0x10
+12   mov     x19, x0
+16   mov     x0, x1
+20   bl      0x185fedc00                                ; objc_msgSend$CGContext
+24   ldr     d0, [x19, #0x28]
+28   fmov    d1, d0
+32   bl      0x1859cc8c0                                ; symbol stub for: CGContextScaleCTM
+36   ldrb    w8, [x19, #0x30]
+40   cbz     w8, 0x18591a934                            ; <+52>
+44   ldr     x0, [x19, #0x20]
+48   bl      0x186178380                                ; objc_msgSend$stroke
+52   ldrb    w8, [x19, #0x31]
+56   cbz     w8, 0x18591a94c                            ; <+76>
+60   ldr     x0, [x19, #0x20]
+64   ldp     x29, x30, [sp, #0x10]
+68   ldp     x20, x19, [sp], #0x20
+72   b       0x1860cab60                                ; objc_msgSend$fill
+76   ldp     x29, x30, [sp, #0x10]
+80   ldp     x20, x19, [sp], #0x20
+84   ret

### __102+[_UIStaticBatteryView _imageByPunchingImage:inRect:flippedHorizontally:outOfImage:inRect:size:scale:]_block_invoke  (18 条)
+0    stp     x20, x19, [sp, #-0x20]!
+4    stp     x29, x30, [sp, #0x10]
+8    add     x29, sp, #0x10
+12   mov     x19, x0
+16   ldr     x0, [x0, #0x20]
+20   ldp     d0, d1, [x19, #0x30]
+24   ldp     d2, d3, [x19, #0x40]
+28   fmov    d4, #1.00000000
+32   mov     w2, #0x0                                   ; =0
+36   bl      0x1860c1fc0                                ; objc_msgSend$drawInRect:blendMode:alpha:
+40   ldr     x0, [x19, #0x28]
+44   ldp     d0, d1, [x19, #0x50]
+48   ldp     d2, d3, [x19, #0x60]
+52   fmov    d4, #1.00000000
+56   mov     w2, #0x17                                  ; =23
+60   ldp     x29, x30, [sp, #0x10]
+64   ldp     x20, x19, [sp], #0x20
+68   b       0x1860c1fc0                                ; objc_msgSend$drawInRect:blendMode:alpha:
