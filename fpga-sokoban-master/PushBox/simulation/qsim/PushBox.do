onerror {quit -f}
vlib work
vlog -work work PushBox.vo
vlog -work work PushBox.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.PushBox_vlg_vec_tst
vcd file -direction PushBox.msim.vcd
vcd add -internal PushBox_vlg_vec_tst/*
vcd add -internal PushBox_vlg_vec_tst/i1/*
add wave /*
run -all
