`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2019 03:18:00 PM
// Design Name: 
// Module Name: asyn_reset
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


module asyn_reset(
	input	wire	clk,
	input	wire	rst_n,
	output	wire	rst_nr

    );
	
	reg	rst_nr_1, rst_nr_2;
	
	always @(posedge clk or negedge rst_n)
	begin
		if (!rst_n)	begin
			rst_nr_1 <= 0;
			rst_nr_2 <= 0;
		end
		else	begin
			rst_nr_1 <= 1;
			rst_nr_2 <= rst_nr_1;
		end
	end
	
	assign	rst_nr = rst_nr_2;
			
endmodule
