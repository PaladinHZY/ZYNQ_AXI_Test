`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2019 09:34:26 PM
// Design Name: 
// Module Name: AXI4_Test_Module_simu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module AXI4_Test_Module_simu; 
	reg 	clk, rst_n, m_axis_tready; 
	wire  	m_axis_tvalid; 
	wire	[31:0]	m_axis_tdata;
	wire	init_axi_txn;
       
 AXI4_Test_Module U0 ( 
	.clk    (clk), 
	.rst_n  (rst_n), 
	.m_axis_tready (m_axis_tready), 
	.m_axis_tdata  (m_axis_tdata),
	.m_axis_tvalid(m_axis_tvalid),
	.init_axi_txn(init_axi_txn)
    ); 
   
   initial 
   begin 
     clk = 0; 
     rst_n = 1; 
	 m_axis_tready = 1;
	 # 10
	 rst_n = 0;
	# 10
	 rst_n = 1;
	 m_axis_tready = 0;
	 
    #10
	#15
	   m_axis_tready = 1;
    #200
        m_axis_tready = 0;

	#30
	   m_axis_tready = 1;
    #200
        m_axis_tready = 0;
	#30
       m_axis_tready = 1;
    #200
        m_axis_tready = 0;	   
	 
   end 
     
   always 
      #5  clk =  ! clk; 
     
 endmodule 
