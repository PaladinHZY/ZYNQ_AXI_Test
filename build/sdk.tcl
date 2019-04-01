sdk setws ../sdk/
sdk createhw -name AXI_Datalink_Test_hw_platform -hwspec ../sdk/design_1_wrapper.hdf
createbsp -name AXI_Datalink_Test_bsp -hwproject AXI_Datalink_Test_hw_platform -proc ps7_cortexa9_0 -os standalone
setlib -bsp AXI_Datalink_Test_bsp -lib xilffs
regenbsp -bsp AXI_Datalink_Test_bsp
createapp -name AXI_Datalink_Test -bsp AXI_Datalink_Test_bsp -app {Empty Application} -hwproject AXI_Datalink_Test_hw_platform -proc ps7_cortexa9_0
#createapp -name AXI_Datalink_Test -bsp AXI_Datalink_Test_bsp -hwproject AXI_Datalink_Test_hw_platform -proc ps7_cortexa9_0
importprojects ../sdk/AXI_Datalink_Test
