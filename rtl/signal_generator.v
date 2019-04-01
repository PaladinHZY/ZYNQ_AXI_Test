`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2019 10:08:37 PM
// Design Name: 
// Module Name: signal_generator
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


module signal_generator(

	input	wire	clk,
	input	wire	rst_n,
	input	wire	m_axis_tready,
	
	output	wire	[31:0]	m_axis_tdata,
	output	wire	m_axis_tvalid,
	output	wire	init_axi_txn, 
	output 	wire	[3:0]	led,
	input   wire   [31:0]   en_gpio
	
    );
	
	wire	rst_nr; // Asyn reset and Syn deassertion, global reset for FPGA fabric
	
	asyn_reset asyn_reset_syn_dess(
	.clk(clk),
	.rst_n(rst_n),
	.rst_nr(rst_nr)
	);
	
	reg	[31:0]	period_cnt;
	reg			signal_valid;
	reg	[3:0]	frame_cnt;
	reg			init_axi_txnr_reg;
	reg	[9:0]	init_axi_txn_cnt;
	
	
	assign init_axi_txn = (en_gpio == 32'hFFFFFFFF && init_axi_txn_cnt == 127)? 1 : 0;
	
	always @(posedge clk or negedge rst_nr)
	begin
		if (!rst_nr)	begin
			init_axi_txn_cnt <= 0;
		end
		else	begin
			if (en_gpio == 32'hFFFFFFFF)	begin
				if (init_axi_txn_cnt == 127)
					init_axi_txn_cnt <= init_axi_txn_cnt;
				else
					init_axi_txn_cnt <= init_axi_txn_cnt + 1;
			end
		end
	end
	
	
	
	always @(posedge clk or negedge rst_nr)
	begin
		if (!rst_nr)
			period_cnt <= 0;
		else	begin
			if (period_cnt == 32'd10000 - 31'd1)
				period_cnt <= period_cnt;
			else
				period_cnt <= period_cnt + 1;
		end
	end
	

	
	always @(posedge clk or negedge rst_nr)
	begin
		if (!rst_nr)	
			frame_cnt <= 0;
		else	begin
			if (period_cnt == 32'd0)	begin
				if (frame_cnt == 4'd10)	
					frame_cnt <= frame_cnt;
				else
					frame_cnt <= frame_cnt + 1;
			end		
		end			
	end
	
	always @(posedge clk or negedge rst_nr)
	begin
		if (!rst_nr)
			init_axi_txnr_reg <= 0;
		else	begin
			if (frame_cnt == 10 - 1 && period_cnt == 32'd10000 - 31'd1)
				init_axi_txnr_reg <= 1;
			else
				init_axi_txnr_reg <= 0;
		end
	end
	
	
	reg	[9:0]	burst_len_cnt;
	reg			m_axis_tvalid_reg;
	reg	[9:0]	burst_number_cnt;
	reg	[31:0]	m_axis_tdata_reg;
	
	always @(posedge clk or negedge rst_nr)
	begin
		if (!rst_nr)	begin
			burst_len_cnt <= 0;
		end
		else	begin
            if (en_gpio == 32'hFFFFFFFF)  begin
                if (burst_len_cnt == 38 - 1)
                    burst_len_cnt <= 0;
                else
                    burst_len_cnt <= burst_len_cnt + 1;
            end
            else    begin
                burst_len_cnt <= 0;
            end
		end
	end
	
	always @(posedge clk or negedge rst_nr)
	begin
		if (!rst_nr)
			m_axis_tvalid_reg <= 0;
		else
		begin
			if (en_gpio == 32'hFFFFFFFF && burst_len_cnt >= 0 && burst_len_cnt <= 16-1) // burst length is 16
				m_axis_tvalid_reg <= 1;
			else
				m_axis_tvalid_reg <= 0;
		end
	end
	
	assign m_axis_tvalid =  m_axis_tvalid_reg;
	
//	assign m_axis_tvalid = (m_axis_tready == 1)? 1'b1:1'b0;
	
	always @(posedge clk or negedge rst_nr)	
	begin
		if (!rst_nr)
			burst_number_cnt <= 0;
		else
		begin
			if (en_gpio == 32'hFFFFFFFF && burst_len_cnt == 0)	begin
				if (burst_number_cnt == 100)
					burst_number_cnt <= 100;
				else
					burst_number_cnt <= burst_number_cnt + 1;
			end			
		end
	end
	
	// axi data 
	always @(posedge clk or negedge rst_nr)
	begin
		if (!rst_nr)	
			m_axis_tdata_reg <= 0;
		else	begin
			if (m_axis_tready && m_axis_tvalid)	begin
                if (m_axis_tdata_reg == 128-1)
                    m_axis_tdata_reg <= 0;
                else
                    m_axis_tdata_reg <= m_axis_tdata_reg + 1;
            end
            else
                m_axis_tdata_reg <= m_axis_tdata_reg;
		end
			
	end
	
	assign m_axis_tdata = m_axis_tdata_reg;
	
	
	
	assign led = (burst_number_cnt == 100)? 4'b1111:4'b0000;
//	assign burst_enable = (burst_number_cnt > 0 && burst_number_cnt <= 100 && burst_len_cnt == 0)? 1'b1: 1'b0;
	
	
endmodule
