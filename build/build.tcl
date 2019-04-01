open_project project_1/project_1.xpr
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1 
write_hwdef -force ../sdk/ZYBO_AXI_Test.hdf
