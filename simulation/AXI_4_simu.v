`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2019 02:42:32 PM
// Design Name: 
// Module Name: AXI_4_simu
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


module AXI_4_simu;
	parameter  C_M00_AXI_TARGET_SLAVE_BASE_ADDR	= 32'h30000000;
	parameter integer C_M00_AXI_BURST_LEN	= 16;
	parameter integer C_M00_AXI_ID_WIDTH	= 1;
	parameter integer C_M00_AXI_ADDR_WIDTH	= 32;
	parameter integer C_M00_AXI_DATA_WIDTH	= 32;
	parameter integer C_M00_AXI_AWUSER_WIDTH	= 0;
	parameter integer C_M00_AXI_ARUSER_WIDTH	= 0;
	parameter integer C_M00_AXI_WUSER_WIDTH	= 0;
	parameter integer C_M00_AXI_RUSER_WIDTH	= 0;
	parameter integer C_M00_AXI_BUSER_WIDTH	= 0;

	// Parameters of Axi Slave Bus Interface S_AXI_INTR
	parameter integer C_S_AXI_INTR_DATA_WIDTH	= 32;
	parameter integer C_S_AXI_INTR_ADDR_WIDTH	= 5;
	parameter integer C_NUM_OF_INTR	= 1;
	parameter  C_INTR_SENSITIVITY	= 32'hFFFFFFFF;
	parameter  C_INTR_ACTIVE_STATE	= 32'hFFFFFFFF;
	parameter integer C_IRQ_SENSITIVITY	= 1;
	parameter integer C_IRQ_ACTIVE_STATE	= 1;
	
	
		reg  m00_axi_init_axi_txn;
		wire  m00_axi_txn_done;
		wire  m00_axi_error;
		reg  m00_axi_aclk;
		reg  m00_axi_aresetn;
		wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_awid;
		wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_awaddr;
		wire [7 : 0] m00_axi_awlen;
		wire [2 : 0] m00_axi_awsize;
		wire [1 : 0] m00_axi_awburst;
		wire  m00_axi_awlock;
		wire [3 : 0] m00_axi_awcache;
		wire [2 : 0] m00_axi_awprot;
		wire [3 : 0] m00_axi_awqos;
		wire [C_M00_AXI_AWUSER_WIDTH-1 : 0] m00_axi_awuser;
		wire  m00_axi_awvalid;
		reg  m00_axi_awready;
		wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_wdata;
		wire [C_M00_AXI_DATA_WIDTH/8-1 : 0] m00_axi_wstrb;
		wire  m00_axi_wlast;
		wire [C_M00_AXI_WUSER_WIDTH-1 : 0] m00_axi_wuser;
		wire  m00_axi_wvalid;
		reg  m00_axi_wready;
		reg [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_bid;
		reg [1 : 0] m00_axi_bresp;
		reg [C_M00_AXI_BUSER_WIDTH-1 : 0] m00_axi_buser;
		reg  m00_axi_bvalid;
		wire  m00_axi_bready;
		wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_arid;
		wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_araddr;
		wire [7 : 0] m00_axi_arlen;
		wire [2 : 0] m00_axi_arsize;
		wire [1 : 0] m00_axi_arburst;
		wire  m00_axi_arlock;
		wire [3 : 0] m00_axi_arcache;
		wire [2 : 0] m00_axi_arprot;
		wire [3 : 0] m00_axi_arqos;
		wire [C_M00_AXI_ARUSER_WIDTH-1 : 0] m00_axi_aruser;
		wire  m00_axi_arvalid;
		reg  m00_axi_arready;
		reg [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_rid;
		reg [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_rdata;
		reg [1 : 0] m00_axi_rresp;
		reg  m00_axi_rlast;
		reg [C_M00_AXI_RUSER_WIDTH-1 : 0] m00_axi_ruser;
		reg  m00_axi_rvalid;
		wire  m00_axi_rready;

		// Ports of Axi Slave Bus Interface S_AXI_INTR
		reg  s_axi_intr_aclk;
		reg  s_axi_intr_aresetn;
		reg [C_S_AXI_INTR_ADDR_WIDTH-1 : 0] s_axi_intr_awaddr;
		reg [2 : 0] s_axi_intr_awprot;
		reg  s_axi_intr_awvalid;
		wire  s_axi_intr_awready;
		reg [C_S_AXI_INTR_DATA_WIDTH-1 : 0] s_axi_intr_wdata;
		reg [(C_S_AXI_INTR_DATA_WIDTH/8)-1 : 0] s_axi_intr_wstrb;
		reg  s_axi_intr_wvalid;
		wire  s_axi_intr_wready;
		wire [1 : 0] s_axi_intr_bresp;
		wire  s_axi_intr_bvalid;
		reg  s_axi_intr_bready;
		reg [C_S_AXI_INTR_ADDR_WIDTH-1 : 0] s_axi_intr_araddr;
		reg [2 : 0] s_axi_intr_arprot;
		reg  s_axi_intr_arvalid;
		wire  s_axi_intr_arready;
		wire [C_S_AXI_INTR_DATA_WIDTH-1 : 0] s_axi_intr_rdata;
		wire [1 : 0] s_axi_intr_rresp;
		wire  s_axi_intr_rvalid;
		reg  s_axi_intr_rready;
		wire  irq;
		
		// customized I/O 
		reg	[31:0]	s_axi_tdata;
		reg			s_axi_tvalid;
		wire			s_axi_tready;
	
	initial begin
		m00_axi_aclk = 0;
		m00_axi_aresetn = 1;
		m00_axi_init_axi_txn = 0;
		m00_axi_awready = 1;
		m00_axi_wready = 1;
		m00_axi_bvalid = 0;
		#10
		m00_axi_aresetn = 0;
		
		#10
		m00_axi_aresetn = 1;
		m00_axi_init_axi_txn = 1;	

		#10 
		m00_axi_init_axi_txn = 0;			
		m00_axi_awready = 1;
		m00_axi_wready = 1;	
		// m00_axi_bvalid = 1;
		
		#285
		m00_axi_bvalid = 1;
		#20
		m00_axi_bvalid = 0;
		#285
		m00_axi_bvalid = 1;	
		#20
		m00_axi_bvalid = 0;		
		#285
		m00_axi_bvalid = 1;
		#20
		m00_axi_bvalid = 0;
		#285
		m00_axi_bvalid = 1;	
		#20
		m00_axi_bvalid = 0;				
		#285
		m00_axi_bvalid = 1;
		#20
		m00_axi_bvalid = 0;
		#285
		m00_axi_bvalid = 1;	
		#20
		m00_axi_bvalid = 0;				
		
	end
	
	always 
	#5	m00_axi_aclk = !m00_axi_aclk;
	
	// always 
		// #180
		// m00_axi_bvalid = 1;
		// #10
		// m00_axi_bvalid = 0;

	
	
	
	AXI_Controller # ( 
		.C_M_TARGET_SLAVE_BASE_ADDR(C_M00_AXI_TARGET_SLAVE_BASE_ADDR),
		.C_M_AXI_BURST_LEN(C_M00_AXI_BURST_LEN),
		.C_M_AXI_ID_WIDTH(C_M00_AXI_ID_WIDTH),
		.C_M_AXI_ADDR_WIDTH(C_M00_AXI_ADDR_WIDTH),
		.C_M_AXI_DATA_WIDTH(C_M00_AXI_DATA_WIDTH),
		.C_M_AXI_AWUSER_WIDTH(C_M00_AXI_AWUSER_WIDTH),
		.C_M_AXI_ARUSER_WIDTH(C_M00_AXI_ARUSER_WIDTH),
		.C_M_AXI_WUSER_WIDTH(C_M00_AXI_WUSER_WIDTH),
		.C_M_AXI_RUSER_WIDTH(C_M00_AXI_RUSER_WIDTH),
		.C_M_AXI_BUSER_WIDTH(C_M00_AXI_BUSER_WIDTH)
	) AXI_Controller_inst (
		// Customized Data and control
		.s_axi_tdata(s_axi_tdata),
	
		.INIT_AXI_TXN(m00_axi_init_axi_txn),
		.TXN_DONE(m00_axi_txn_done),
		.ERROR(m00_axi_error),
		.M_AXI_ACLK(m00_axi_aclk),
		.M_AXI_ARESETN(m00_axi_aresetn),
		.M_AXI_AWID(m00_axi_awid),
		.M_AXI_AWADDR(m00_axi_awaddr),
		.M_AXI_AWLEN(m00_axi_awlen),
		.M_AXI_AWSIZE(m00_axi_awsize),
		.M_AXI_AWBURST(m00_axi_awburst),
		.M_AXI_AWLOCK(m00_axi_awlock),
		.M_AXI_AWCACHE(m00_axi_awcache),
		.M_AXI_AWPROT(m00_axi_awprot),
		.M_AXI_AWQOS(m00_axi_awqos),
		.M_AXI_AWUSER(m00_axi_awuser),
		.M_AXI_AWVALID(m00_axi_awvalid),
		.M_AXI_AWREADY(m00_axi_awready),
		.M_AXI_WDATA(m00_axi_wdata),
		.M_AXI_WSTRB(m00_axi_wstrb),
		.M_AXI_WLAST(m00_axi_wlast),
		.M_AXI_WUSER(m00_axi_wuser),
		.M_AXI_WVALID(m00_axi_wvalid),
		.M_AXI_WREADY(m00_axi_wready),
		.M_AXI_BID(m00_axi_bid),
		.M_AXI_BRESP(m00_axi_bresp),
		.M_AXI_BUSER(m00_axi_buser),
		.M_AXI_BVALID(m00_axi_bvalid),
		.M_AXI_BREADY(m00_axi_bready),
		.M_AXI_ARID(m00_axi_arid),
		.M_AXI_ARADDR(m00_axi_araddr),
		.M_AXI_ARLEN(m00_axi_arlen),
		.M_AXI_ARSIZE(m00_axi_arsize),
		.M_AXI_ARBURST(m00_axi_arburst),
		.M_AXI_ARLOCK(m00_axi_arlock),
		.M_AXI_ARCACHE(m00_axi_arcache),
		.M_AXI_ARPROT(m00_axi_arprot),
		.M_AXI_ARQOS(m00_axi_arqos),
		.M_AXI_ARUSER(m00_axi_aruser),
		.M_AXI_ARVALID(m00_axi_arvalid),
		.M_AXI_ARREADY(m00_axi_arready),
		.M_AXI_RID(m00_axi_rid),
		.M_AXI_RDATA(m00_axi_rdata),
		.M_AXI_RRESP(m00_axi_rresp),
		.M_AXI_RLAST(m00_axi_rlast),
		.M_AXI_RUSER(m00_axi_ruser),
		.M_AXI_RVALID(m00_axi_rvalid),
		.M_AXI_RREADY(m00_axi_rready)
	);	
	
	
	
	
	
	
	
	
	
endmodule
