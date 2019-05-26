@echo off
REM ROMs required for driver "1942".
REM srb-03.m3                             16384 CRC(d9dafcc3) SHA1(a089a9bc55fb7d6d0ac53f91b258396d5d62677a)
REM srb-04.m4                             16384 CRC(da0cf924) SHA1(856fbb302c9a4ec7850a26ab23dab8467f79bba4)
REM srb-05.m5                             16384 CRC(d102911c) SHA1(35ba1d82bd901940f61d8619273463d02fc0a952)
REM srb-06.m6                              8192 CRC(466f8248) SHA1(2ccc8fc59962d3001fbc10e8d2f20a254a74f251)
REM srb-07.m7                             16384 CRC(0d31038c) SHA1(b588eaf6fddd66ecb2d9832dc197f286f1ccd846)
REM plus all the common ROMs

REM ROMs required for driver "1942a".
REM sra-03.m3                             16384 CRC(40201bab) SHA1(4886c07a4602223c21419118e10aadce9c99fa5a)
REM sr-04.m4                              16384 CRC(a60ac644) SHA1(f37862db3cf5e6cc9ab3276f3bc45fd629fd70dd)
REM sr-05.m5                              16384 CRC(835f7b24) SHA1(24b66827f08c43fbf5b9517d638acdfc38e1b1e7)
REM sr-06.m6                               8192 CRC(821c6481) SHA1(06becb6bf8b4bde3a458098498eecad566a87711)
REM sr-07.m7                              16384 CRC(5df525e1) SHA1(70cd2910e2945db76bd6ebfa0ff09a5efadc2d0b)
REM plus all the common ROMs

REM ROMs required for driver "1942b".
REM sr-03.m3                              16384 CRC(612975f2) SHA1(f3744335862dd4c53925cc32792badd4a378c837)
REM sr-04.m4                              16384 CRC(a60ac644) SHA1(f37862db3cf5e6cc9ab3276f3bc45fd629fd70dd)
REM sr-05.m5                              16384 CRC(835f7b24) SHA1(24b66827f08c43fbf5b9517d638acdfc38e1b1e7)
REM sr-06.m6                               8192 CRC(821c6481) SHA1(06becb6bf8b4bde3a458098498eecad566a87711)
REM sr-07.m7                              16384 CRC(5df525e1) SHA1(70cd2910e2945db76bd6ebfa0ff09a5efadc2d0b)
REM plus all the common ROMs

REM common ROMs
REM sr-01.c11                             16384 CRC(bd87f06b) SHA1(821f85cf157f81117eeaba0c3cf0337eac357e58)
REM sr-02.f2                               8192 CRC(6ebca191) SHA1(0dbddadde54a0ab66994c4a8726be05c6ca88a0e)
REM sr-08.a1                               8192 CRC(3884d9eb) SHA1(5cbd9215fa5ba5a61208b383700adc4428521aed)
REM sr-09.a2                               8192 CRC(999cf6e0) SHA1(5b8b685038ec98b781908b92eb7fb9506db68544)
REM sr-10.a3                               8192 CRC(8edb273a) SHA1(85fdd4c690ed31e6396e3c16aa02140ee7ea2d61)
REM sr-11.a4                               8192 CRC(3a2726c3) SHA1(187c92ef591febdcbd1d42ab850e0cbb62c00873)
REM sr-12.a5                               8192 CRC(1bd3d8bb) SHA1(ef4dce605eb4dc8035985a415315ec61c21419c6)
REM sr-13.a6                               8192 CRC(658f02c4) SHA1(f087d69e49e38cf3107350cde18fcf85a8fa04f0)
REM sr-14.l1                              16384 CRC(2528bec6) SHA1(29f7719f18faad6bd1ec6735cc24e69168361470)
REM sr-15.l2                              16384 CRC(f89287aa) SHA1(136fff6d2a4f48a488fc7c620213761459c3ada0)
REM sr-16.n1                              16384 CRC(024418f8) SHA1(145b8d5d6c8654cd090955a98f6dd8c8dbafe7c1)
REM sr-17.n2                              16384 CRC(e2c7e489) SHA1(d4b5d575c021f58f6966df189df94e08c5b3621c)

REM sb-0.f1                                 256 CRC(6047d91b) SHA1(1ce025f9524c1033e48c5294ee7d360f8bfebe8d)
REM sb-1.k6                                 256 CRC(712ac508) SHA1(5349d722ab6733afdda65f6e0a98322f0d515e86)
REM sb-2.d1                                 256 CRC(8bb8b3df) SHA1(49de2819c4c92057fedcb20425282515d85829aa)
REM sb-3.d2                                 256 CRC(3b0c99af) SHA1(38f30ac1e48632634e409f328ee3051b987de7ad)
REM sb-4.d6                                 256 CRC(4858968d) SHA1(20b5dbcaa1a4081b3139e7e2332d8fe3c9e55ed6)
REM sb-5.e8                                 256 CRC(93ab8153) SHA1(a792f24e5c0c3c4a6b436102e7a98199f878ece1)
REM sb-6.e9                                 256 CRC(8ab44f7d) SHA1(f74680a6a987d74b3acb32e6396f20e127874149)
REM sb-7.e10                                256 CRC(f4ade9a4) SHA1(62ad31d31d183cce213b03168daa035083b2f28e)
REM sb-8.k3                                 256 CRC(f6fad943) SHA1(b0a24ea7805272e8ebf72a99b08907bc00d5f82f)
REM sb-9.m11                                256 CRC(4921635c) SHA1(aee37d6cdc36acf0f11ff5f93e7b16e4b12f6c39)

set rom_path_src=..\..\..\..\roms\1942
set rom_path=..\..\..\..\build
set romgen_path=..\..\..\..\romgen_source

mkdir %rom_path%

REM 256 byte PROMS - these should really be 256x4
REM %romgen_path%\romgen %rom_path_src%\sb-0.f1   PROM_F1   8 a r   > %rom_path%\PROM_F1.vhd
REM %romgen_path%\romgen %rom_path_src%\sb-1.k6   PROM_K6   8 a r   > %rom_path%\PROM_K6.vhd
REM %romgen_path%\romgen %rom_path_src%\sb-2.d1   PROM_D1   7 a r   > %rom_path%\PROM_D1.vhd
REM %romgen_path%\romgen %rom_path_src%\sb-3.d2   PROM_D2   7 a r   > %rom_path%\PROM_D2.vhd
REM %romgen_path%\romgen %rom_path_src%\sb-4.d6   PROM_D6   8 a r   > %rom_path%\PROM_D6.vhd
REM %romgen_path%\romgen %rom_path_src%\sb-5.e8   PROM_E8   8 a r   > %rom_path%\PROM_E8.vhd
REM %romgen_path%\romgen %rom_path_src%\sb-6.e9   PROM_E9   8 a r   > %rom_path%\PROM_E9.vhd
REM %romgen_path%\romgen %rom_path_src%\sb-7.e10  PROM_E10  8 a r   > %rom_path%\PROM_E10.vhd
REM %romgen_path%\romgen %rom_path_src%\sb-8.k3   PROM_K3   8 a r   > %rom_path%\PROM_K3.vhd
REM %romgen_path%\romgen %rom_path_src%\sb-9.m11  PROM_M11  8 a r   > %rom_path%\PROM_M11.vhd

REM generate RAMB structures for larger ROMS

REM maincpu
%romgen_path%\romgen %rom_path_src%\srb-03.m3 ROM_M3  14 l r e  > %rom_path%\ROM_M3.vhd
%romgen_path%\romgen %rom_path_src%\srb-04.m4 ROM_M4  14 l r e  > %rom_path%\ROM_M4.vhd
%romgen_path%\romgen %rom_path_src%\srb-05.m5 ROM_M5  14 l r e  > %rom_path%\ROM_M5.vhd
%romgen_path%\romgen %rom_path_src%\srb-06.m6 ROM_M6  13 l r e  > %rom_path%\ROM_M6.vhd
%romgen_path%\romgen %rom_path_src%\srb-07.m7 ROM_M7  14 l r e  > %rom_path%\ROM_M7.vhd

REM audiocpu
%romgen_path%\romgen %rom_path_src%\sr-01.c11 ROM_C11 14 l r e  > %rom_path%\ROM_C11.vhd

REM gfx1 characters
%romgen_path%\romgen %rom_path_src%\sr-02.f2  ROM_F2  13 l r e  > %rom_path%\ROM_F2.vhd 

REM gfx2 tiles                                                                  
%romgen_path%\romgen %rom_path_src%\sr-08.a1  ROM_A1  13 l r e  > %rom_path%\ROM_A1.vhd
%romgen_path%\romgen %rom_path_src%\sr-09.a2  ROM_A2  13 l r e  > %rom_path%\ROM_A2.vhd
%romgen_path%\romgen %rom_path_src%\sr-10.a3  ROM_A3  13 l r e  > %rom_path%\ROM_A3.vhd
%romgen_path%\romgen %rom_path_src%\sr-11.a4  ROM_A4  13 l r e  > %rom_path%\ROM_A4.vhd
%romgen_path%\romgen %rom_path_src%\sr-12.a5  ROM_A5  13 l r e  > %rom_path%\ROM_A5.vhd
%romgen_path%\romgen %rom_path_src%\sr-13.a6  ROM_A6  13 l r e  > %rom_path%\ROM_A6.vhd

REM gfx3 sprites                                                                
%romgen_path%\romgen %rom_path_src%\sr-14.l1  ROM_L1  14 l r e  > %rom_path%\ROM_L1.vhd
%romgen_path%\romgen %rom_path_src%\sr-15.l2  ROM_L2  14 l r e  > %rom_path%\ROM_L2.vhd
%romgen_path%\romgen %rom_path_src%\sr-16.n1  ROM_N1  14 l r e  > %rom_path%\ROM_N1.vhd
%romgen_path%\romgen %rom_path_src%\sr-17.n2  ROM_N2  14 l r e  > %rom_path%\ROM_N2.vhd

echo done
pause
