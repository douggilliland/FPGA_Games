onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /pacman_tb/u0/clk_6
add wave -noupdate -format Literal /pacman_tb/u0/hcnt
add wave -noupdate -format Logic /pacman_tb/u0/hcnt(1)
add wave -noupdate -format Logic /pacman_tb/u0/h1_inv
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal /pacman_tb/u0/cpu_vec_reg
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal /pacman_tb/u0/cpu_addr
add wave -noupdate -format Literal -radix hexadecimal /pacman_tb/u0/rom_data
add wave -noupdate -format Literal /pacman_tb/u0/cpu_data_out
add wave -noupdate -format Literal /pacman_tb/u0/cpu_data_in
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Logic /pacman_tb/u0/cpu_mreq_l
add wave -noupdate -format Logic /pacman_tb/u0/cpu_rd_l
add wave -noupdate -format Logic /pacman_tb/u0/cpu_wr_l
add wave -noupdate -format Logic /pacman_tb/u0/cpu_iorq_l
add wave -noupdate -format Logic /pacman_tb/u0/cpu_m1_l
add wave -noupdate -format Logic /pacman_tb/u0/cpu_rfsh_l
add wave -noupdate -format Logic /pacman_tb/u0/cpu_int_l
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Logic /pacman_tb/u0/sync_bus_cs_l
add wave -noupdate -format Logic /pacman_tb/u0/sync_bus_r_w_l
add wave -noupdate -format Logic /pacman_tb/u0/sync_bus_wreq_l
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Logic /pacman_tb/u0/u_video/vout_obj_on
add wave -noupdate -format Logic /pacman_tb/u0/u_video/vout_yflip
add wave -noupdate -format Logic /pacman_tb/u0/u_video/vout_hblank
add wave -noupdate -format Literal /pacman_tb/u0/u_video/vout_db
add wave -noupdate -format Literal /pacman_tb/u0/u_video/shift_op
add wave -noupdate -format Literal /pacman_tb/u0/u_video/lut_4a
add wave -noupdate -format Logic /pacman_tb/u0/u_video/hblank
add wave -noupdate -format Literal /pacman_tb/u0/u_video/db
add wave -noupdate -format Literal /pacman_tb/u0/u_video/ab
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal /pacman_tb/u0/u_video/dr
add wave -noupdate -format Logic /pacman_tb/u0/u_video/cntr_ld
add wave -noupdate -format Literal /pacman_tb/u0/u_video/ra
add wave -noupdate -format Literal /pacman_tb/u0/u_video/sprite_ram_addr
add wave -noupdate -format Literal /pacman_tb/u0/u_video/sprite_ram_op
add wave -noupdate -format Logic /pacman_tb/u0/u_video/video_op_sel
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal /pacman_tb/u0/u_video/sprite_ram_addr_t1
add wave -noupdate -format Literal /pacman_tb/u0/u_video/sprite_ram_ip
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {939236 ns} {655912 ns}
WaveRestoreZoom {0 ns} {2492160 ns}
configure wave -namecolwidth 270
configure wave -valuecolwidth 80
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
