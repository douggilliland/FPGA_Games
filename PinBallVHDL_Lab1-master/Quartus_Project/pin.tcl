#============================================================
#============================================================


#project_open $proj_name
set_global_assignment -name FAMILY "Cyclone V"
set_global_assignment -name DEVICE 5CSXFC6D6F31C6



#============================================================
# CLOCK
#============================================================
#set_location_assignment PIN_AA16 -to CLOCK2_50
#set_location_assignment PIN_Y26 -to CLOCK3_50
#set_location_assignment PIN_K14 -to CLOCK4_50
set_location_assignment PIN_AF14 -to CLOCK_50

#============================================================
# KEY
#============================================================
set_location_assignment PIN_AJ4 -to resetN  ; # KEY[0]
set_location_assignment PIN_AK4 -to scored
set_location_assignment PIN_AA14 -to died
set_location_assignment PIN_AA15 -to start_shot

#============================================================
# SW
#============================================================
set_location_assignment PIN_AB30 -to recording ; #SW[0]
set_location_assignment PIN_Y27 -to playing ; #SW[1]
set_location_assignment PIN_AB28 -to turbo ; #SW[2]
set_location_assignment PIN_AC30 -to SW[3]
set_location_assignment PIN_W25 -to  SW[4]
set_location_assignment PIN_V25 -to  SW[5]
set_location_assignment PIN_AC28 -to  SW[6]
set_location_assignment PIN_AD30 -to freq[1] ;#SW[7]
set_location_assignment PIN_AC29 -to freq[2] ;#SW[8]
set_location_assignment PIN_AA30 -to MICROPHON_ON ; #SW[9]

#============================================================
# LED
#============================================================ #LEDR[0]
set_location_assignment PIN_AA24 -to play_check 
set_location_assignment PIN_AB23 -to game_over
set_location_assignment PIN_AC23 -to one_sec
set_location_assignment PIN_AD24 -to space
set_location_assignment PIN_AG25 -to LEDR[4]
set_location_assignment PIN_AF25 -to LEDR[5]
set_location_assignment PIN_AE24 -to LEDR[6]
set_location_assignment PIN_AF24 -to LEDR[7]
set_location_assignment PIN_AB22 -to LEDR[8]
set_location_assignment PIN_AC22 -to MICROPHON_LED ; #LEDR[9]

#============================================================
# Seg7
#============================================================
set_location_assignment PIN_W17 -to HEX0[0]
set_location_assignment PIN_V18 -to HEX0[1]
set_location_assignment PIN_AG17 -to HEX0[2]
set_location_assignment PIN_AG16 -to HEX0[3]
set_location_assignment PIN_AH17 -to HEX0[4]
set_location_assignment PIN_AG18 -to HEX0[5]
set_location_assignment PIN_AH18 -to HEX0[6]
set_location_assignment PIN_AF16 -to HEX1[0]
set_location_assignment PIN_V16 -to HEX1[1]
set_location_assignment PIN_AE16 -to HEX1[2]
set_location_assignment PIN_AD17 -to HEX1[3]
set_location_assignment PIN_AE18 -to HEX1[4]
set_location_assignment PIN_AE17 -to HEX1[5]
set_location_assignment PIN_V17 -to HEX1[6]
set_location_assignment PIN_AA21 -to HEX2[0]
set_location_assignment PIN_AB17 -to HEX2[1]
set_location_assignment PIN_AA18 -to HEX2[2]
set_location_assignment PIN_Y17 -to HEX2[3]
set_location_assignment PIN_Y18 -to HEX2[4]
set_location_assignment PIN_AF18 -to HEX2[5]
set_location_assignment PIN_W16 -to HEX2[6]
set_location_assignment PIN_Y19 -to HEX3[0]
set_location_assignment PIN_W19 -to HEX3[1]
set_location_assignment PIN_AD19 -to HEX3[2]
set_location_assignment PIN_AA20 -to HEX3[3]
set_location_assignment PIN_AC20 -to HEX3[4]
set_location_assignment PIN_AA19 -to HEX3[5]
set_location_assignment PIN_AD20 -to HEX3[6]
set_location_assignment PIN_AD21 -to HEX4[0]
set_location_assignment PIN_AG22 -to HEX4[1]
set_location_assignment PIN_AE22 -to HEX4[2]
set_location_assignment PIN_AE23 -to HEX4[3]
set_location_assignment PIN_AG23 -to HEX4[4]
set_location_assignment PIN_AF23 -to HEX4[5]
set_location_assignment PIN_AH22 -to HEX4[6]
set_location_assignment PIN_AF21 -to HEX5[0]
set_location_assignment PIN_AG21 -to HEX5[1]
set_location_assignment PIN_AF20 -to HEX5[2]
set_location_assignment PIN_AG20 -to HEX5[3]
set_location_assignment PIN_AE19 -to HEX5[4]
set_location_assignment PIN_AF19 -to HEX5[5]
set_location_assignment PIN_AB21 -to HEX5[6]

#============================================================
# SDRAM
#============================================================
# set_location_assignment PIN_AK14 -to DRAM_ADDR[0]
# set_location_assignment PIN_AH14 -to DRAM_ADDR[1]
# set_location_assignment PIN_AG15 -to DRAM_ADDR[2]
# set_location_assignment PIN_AE14 -to DRAM_ADDR[3]
# set_location_assignment PIN_AB15 -to DRAM_ADDR[4]
# set_location_assignment PIN_AC14 -to DRAM_ADDR[5]
# set_location_assignment PIN_AD14 -to DRAM_ADDR[6]
# set_location_assignment PIN_AF15 -to DRAM_ADDR[7]
# set_location_assignment PIN_AH15 -to DRAM_ADDR[8]
# set_location_assignment PIN_AG13 -to DRAM_ADDR[9]
# set_location_assignment PIN_AG12 -to DRAM_ADDR[10]
# set_location_assignment PIN_AH13 -to DRAM_ADDR[11]
# set_location_assignment PIN_AJ14 -to DRAM_ADDR[12]
# set_location_assignment PIN_AF13 -to DRAM_BA[0]
# set_location_assignment PIN_AJ12 -to DRAM_BA[1]
# set_location_assignment PIN_AF11 -to DRAM_CAS_N
# set_location_assignment PIN_AK13 -to DRAM_CKE
# set_location_assignment PIN_AH12 -to DRAM_CLK
# set_location_assignment PIN_AG11 -to DRAM_CS_N
# set_location_assignment PIN_AK6 -to DRAM_DQ[0]
# set_location_assignment PIN_AJ7 -to DRAM_DQ[1]
# set_location_assignment PIN_AK7 -to DRAM_DQ[2]
# set_location_assignment PIN_AK8 -to DRAM_DQ[3]
# set_location_assignment PIN_AK9 -to DRAM_DQ[4]
# set_location_assignment PIN_AG10 -to DRAM_DQ[5]
# set_location_assignment PIN_AK11 -to DRAM_DQ[6]
# set_location_assignment PIN_AJ11 -to DRAM_DQ[7]
# set_location_assignment PIN_AH10 -to DRAM_DQ[8]
# set_location_assignment PIN_AJ10 -to DRAM_DQ[9]
# set_location_assignment PIN_AJ9 -to DRAM_DQ[10]
# set_location_assignment PIN_AH9 -to DRAM_DQ[11]
# set_location_assignment PIN_AH8 -to DRAM_DQ[12]
# set_location_assignment PIN_AH7 -to DRAM_DQ[13]
# set_location_assignment PIN_AJ6 -to DRAM_DQ[14]
# set_location_assignment PIN_AJ5 -to DRAM_DQ[15]
# set_location_assignment PIN_AB13 -to DRAM_LDQM
# set_location_assignment PIN_AE13 -to DRAM_RAS_N
# set_location_assignment PIN_AK12 -to DRAM_UDQM
# set_location_assignment PIN_AA13 -to DRAM_WE_N

# ============================================================
# Video-In
# ============================================================
# set_location_assignment PIN_AC18 -to TD_CLK27
# set_location_assignment PIN_AG27 -to TD_DATA[0]
# set_location_assignment PIN_AF28 -to TD_DATA[1]
# set_location_assignment PIN_AE28 -to TD_DATA[2]
# set_location_assignment PIN_AE27 -to TD_DATA[3]
# set_location_assignment PIN_AE26 -to TD_DATA[4]
# set_location_assignment PIN_AD27 -to TD_DATA[5]
# set_location_assignment PIN_AD26 -to TD_DATA[6]
# set_location_assignment PIN_AD25 -to TD_DATA[7]
# set_location_assignment PIN_AH28 -to TD_HS
# set_location_assignment PIN_AC27 -to TD_RESET_N
# set_location_assignment PIN_AG28 -to TD_VS

#============================================================
# VGA
#============================================================
set_location_assignment PIN_AK22 -to VGA_BLANK_N
set_location_assignment PIN_AJ21 -to VGA_B[0]
set_location_assignment PIN_AJ20 -to VGA_B[1]
set_location_assignment PIN_AH20 -to VGA_B[2]
set_location_assignment PIN_AJ19 -to VGA_B[3]
set_location_assignment PIN_AH19 -to VGA_B[4]
set_location_assignment PIN_AJ17 -to VGA_B[5]
set_location_assignment PIN_AJ16 -to VGA_B[6]
set_location_assignment PIN_AK16 -to VGA_B[7]
set_location_assignment PIN_AK21 -to VGA_CLK
set_location_assignment PIN_AK26 -to VGA_G[0]
set_location_assignment PIN_AJ25 -to VGA_G[1]
set_location_assignment PIN_AH25 -to VGA_G[2]
set_location_assignment PIN_AK24 -to VGA_G[3]
set_location_assignment PIN_AJ24 -to VGA_G[4]
set_location_assignment PIN_AH24 -to VGA_G[5]
set_location_assignment PIN_AK23 -to VGA_G[6]
set_location_assignment PIN_AH23 -to VGA_G[7]
set_location_assignment PIN_AK19 -to VGA_HS
set_location_assignment PIN_AK29 -to VGA_R[0]
set_location_assignment PIN_AK28 -to VGA_R[1]
set_location_assignment PIN_AK27 -to VGA_R[2]
set_location_assignment PIN_AJ27 -to VGA_R[3]
set_location_assignment PIN_AH27 -to VGA_R[4]
set_location_assignment PIN_AF26 -to VGA_R[5]
set_location_assignment PIN_AG26 -to VGA_R[6]
set_location_assignment PIN_AJ26 -to VGA_R[7]
set_location_assignment PIN_AJ22 -to VGA_SYNC_N
set_location_assignment PIN_AK18 -to VGA_VS

#============================================================
# Audio
#============================================================
set_location_assignment PIN_AJ29 -to AUD_ADCDAT
set_location_assignment PIN_AH29 -to AUD_ADCLRCK
set_location_assignment PIN_AF30 -to AUD_BCLK
set_location_assignment PIN_AF29 -to AUD_DACDAT
set_location_assignment PIN_AG30 -to AUD_DACLRCK
set_location_assignment PIN_AH30 -to AUD_XCK

#============================================================
# PS2
#============================================================
set_location_assignment PIN_AB25 -to kbd_clk;#PS2_CLK
set_location_assignment PIN_AC25 -to PS2_CLK2
set_location_assignment PIN_AA25 -to kbd_data;#PS2_DAT
set_location_assignment PIN_AB26 -to PS2_DAT2

#============================================================
# ADC
#============================================================
set_location_assignment PIN_Y21 -to ADC_CONVST
set_location_assignment PIN_W22 -to ADC_DIN
set_location_assignment PIN_V23 -to ADC_DOUT
set_location_assignment PIN_W24 -to ADC_SCLK

#============================================================
# I2C for Audio and Video-In
#============================================================
set_location_assignment PIN_Y24 -to AUD_I2C_SCLK
set_location_assignment PIN_Y23 -to AUD_I2C_SDAT

#============================================================
# IR
#============================================================
# set_location_assignment PIN_W20 -to IRDA_RXD
# set_location_assignment PIN_W21 -to IRDA_TXD
#============================
#GPIO

# set_location_assignment PIN_W15 -to GPIO[0]
# set_location_assignment PIN_AK2 -to GPIO[1]
# set_location_assignment PIN_Y16 -to GPIO[2]
# set_location_assignment PIN_AK3 -to GPIO[3]
# set_location_assignment PIN_AJ1 -to GPIO[4]
# set_location_assignment PIN_AJ2 -to GPIO[5]
# set_location_assignment PIN_AH2 -to GPIO[6]
# set_location_assignment PIN_AH3 -to GPIO[7]
# set_location_assignment PIN_AH4 -to GPIO[8]
# set_location_assignment PIN_AH5 -to GPIO[9]
# set_location_assignment PIN_AG1 -to GPIO[10]
# set_location_assignment PIN_AG2 -to GPIO[11]
# set_location_assignment PIN_AG3 -to GPIO[12]
# set_location_assignment PIN_AG5 -to GPIO[13]
# set_location_assignment PIN_AG6 -to GPIO[14]
# set_location_assignment PIN_AG7 -to GPIO[15]
# set_location_assignment PIN_AG8 -to GPIO[16]
# set_location_assignment PIN_AF4 -to GPIO[17]
# set_location_assignment PIN_AF5 -to GPIO[18]
# set_location_assignment PIN_AF6 -to GPIO[19]
# set_location_assignment PIN_AF8 -to GPIO[20]
# set_location_assignment PIN_AF9 -to GPIO[21]
# set_location_assignment PIN_AF10 -to GPIO[22]
# set_location_assignment PIN_AE7 -to GPIO[23]
# set_location_assignment PIN_AE9 -to GPIO[24]
# set_location_assignment PIN_AE11 -to GPIO[25]
# set_location_assignment PIN_AE12 -to GPIO[26]
# set_location_assignment PIN_AD7 -to GPIO[27]
# set_location_assignment PIN_AD9 -to GPIO[28]
# set_location_assignment PIN_AD10 -to GPIO[29]
# set_location_assignment PIN_AD11 -to GPIO[30]
# set_location_assignment PIN_AD12 -to GPIO[31]
# set_location_assignment PIN_AC9 -to GPIO[32]
# set_location_assignment PIN_AC12 -to GPIO[33]
# set_location_assignment PIN_AB12 -to GPIO[34]
# set_location_assignment PIN_AA12 -to GPIO[35]

#============================================================
# End of pin assignments by Terasic System Builder
#============================================================
# Assigning 3.3 V to all pins


#source constraints/setup_pinlist.tcl
		  
set name_ids [get_names -filter * -node_type pin]

    foreach_in_collection name_id $name_ids {
        set pin_name [get_name_info -info full_path $name_id]
        post_message "Assigning 3.3-V LVTTL to $pin_name"
		set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to $pin_name
          }
		  
export_assignments
