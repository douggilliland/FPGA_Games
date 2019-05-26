
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name FinalProject2 -dir "C:/Users/Nathaniel/Documents/school/2013 Fall/CMPEN417/Labs/FinalProject/FinalProject2/planAhead_run_2" -part xc6slx16csg324-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/Nathaniel/Documents/school/2013 Fall/CMPEN417/Labs/FinalProject/FinalProject2/FinalProjectMainWrapper.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/Nathaniel/Documents/school/2013 Fall/CMPEN417/Labs/FinalProject/FinalProject2} {ipcore_dir} }
set_property target_constrs_file "FinalProject_Constraints.ucf" [current_fileset -constrset]
add_files [list {FinalProject_Constraints.ucf}] -fileset [get_property constrset [current_run]]
link_design
