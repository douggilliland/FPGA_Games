set_global_assignment -entity "gb_clocks" -library "lib_gb_clocks" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "gb_clocks" -library "lib_gb_clocks" -name IP_TOOL_VERSION "17.1"
set_global_assignment -entity "gb_clocks" -library "lib_gb_clocks" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_gb_clocks" -name SPD_FILE [file join $::quartus(sip_path) "gb_clocks.spd"]

set_global_assignment -library "lib_gb_clocks" -name MISC_FILE [file join $::quartus(sip_path) "gb_clocks_sim/gb_clocks.vo"]
