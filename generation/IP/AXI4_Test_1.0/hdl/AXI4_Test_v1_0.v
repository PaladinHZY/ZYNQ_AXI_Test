
`timescale 1 ns / 1 ps

	module AXI4_Test_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Master Bus Interface M00_AXI
		parameter  C_M00_AXI_TARGET_SLAVE_BASE_ADDR	= 32'h30000000,
		parameter integer C_M00_AXI_BURST_LEN	= 16,
		parameter integer C_M00_AXI_ID_WIDTH	= 1,
		parameter integer C_M00_AXI_ADDR_WIDTH	= 32,
		parameter integer C_M00_AXI_DATA_WIDTH	= 32,
		parameter integer C_M00_AXI_AWUSER_WIDTH	= 0,
		parameter integer C_M00_AXI_ARUSER_WIDTH	= 0,
		parameter integer C_M00_AXI_WUSER_WIDTH	= 0,
		parameter integer C_M00_AXI_RUSER_WIDTH	= 0,
		parameter integer C_M00_AXI_BUSER_WIDTH	= 0,

		// Parameters of Axi Slave Bus Interface S_AXI_INTR
		parameter integer C_S_AXI_INTR_DATA_WIDTH	= 32,
		parameter integer C_S_AXI_INTR_ADDR_WIDTH	= 5,
		parameter integer C_NUM_OF_INTR	= 1,
		parameter  C_INTR_SENSITIVITY	= 32'hFFFFFFFF,
		parameter  C_INTR_ACTIVE_STATE	= 32'hFFFFFFFF,
		parameter integer C_IRQ_SENSITIVITY	= 1,
		parameter integer C_IRQ_ACTIVE_STATE	= 1
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Master Bus Interface M00_AXI
		(*mark_debug = "true"*)input wire  m00_axi_init_axi_txn,
		(*mark_debug = "true"*)output wire  m00_axi_txn_done,
		(*mark_debug = "true"*)output wire  m00_axi_error,
		(*mark_debug = "true"*)input wire  m00_axi_aclk,
		(*mark_debug = "true"*)input wire  m00_axi_aresetn,
		(*mark_debug = "true"*)output wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_awid,
		(*mark_debug = "true"*)output wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_awaddr,
		(*mark_debug = "true"*)output wire [7 : 0] m00_axi_awlen,
		(*mark_debug = "true"*)output wire [2 : 0] m00_axi_awsize,
		(*mark_debug = "true"*)output wire [1 : 0] m00_axi_awburst,
		(*mark_debug = "true"*)output wire  m00_axi_awlock,
		(*mark_debug = "true"*)output wire [3 : 0] m00_axi_awcache,
		(*mark_debug = "true"*)output wire [2 : 0] m00_axi_awprot,
		(*mark_debug = "true"*)output wire [3 : 0] m00_axi_awqos,
		(*mark_debug = "true"*)output wire [C_M00_AXI_AWUSER_WIDTH-1 : 0] m00_axi_awuser,
		(*mark_debug = "true"*)output wire  m00_axi_awvalid,
		(*mark_debug = "true"*)input wire  m00_axi_awready,
		(*mark_debug = "true"*)output wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_wdata,
		(*mark_debug = "true"*)output wire [C_M00_AXI_DATA_WIDTH/8-1 : 0] m00_axi_wstrb,
		(*mark_debug = "true"*)output wire  m00_axi_wlast,
		(*mark_debug = "true"*)output wire [C_M00_AXI_WUSER_WIDTH-1 : 0] m00_axi_wuser,
		(*mark_debug = "true"*)output wire  m00_axi_wvalid,
		(*mark_debug = "true"*)input wire  m00_axi_wready,
		(*mark_debug = "true"*)input wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_bid,
		(*mark_debug = "true"*)input wire [1 : 0] m00_axi_bresp,
		(*mark_debug = "true"*)input wire [C_M00_AXI_BUSER_WIDTH-1 : 0] m00_axi_buser,
		(*mark_debug = "true"*)input wire  m00_axi_bvalid,
		(*mark_debug = "true"*)output wire  m00_axi_bready,
		(*mark_debug = "true"*)output wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_arid,
		(*mark_debug = "true"*)output wire [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_araddr,
		(*mark_debug = "true"*)output wire [7 : 0] m00_axi_arlen,
		(*mark_debug = "true"*)output wire [2 : 0] m00_axi_arsize,
		(*mark_debug = "true"*)output wire [1 : 0] m00_axi_arburst,
		(*mark_debug = "true"*)output wire  m00_axi_arlock,
		(*mark_debug = "true"*)output wire [3 : 0] m00_axi_arcache,
		(*mark_debug = "true"*)output wire [2 : 0] m00_axi_arprot,
        (*mark_debug = "true"*)output wire [3 : 0] m00_axi_arqos,
		(*mark_debug = "true"*)output wire [C_M00_AXI_ARUSER_WIDTH-1 : 0] m00_axi_aruser,
		(*mark_debug = "true"*)output wire  m00_axi_arvalid,
		(*mark_debug = "true"*)input wire  m00_axi_arready,
		(*mark_debug = "true"*)input wire [C_M00_AXI_ID_WIDTH-1 : 0] m00_axi_rid,
		(*mark_debug = "true"*)input wire [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_rdata,
		(*mark_debug = "true"*)input wire [1 : 0] m00_axi_rresp,
		(*mark_debug = "true"*)input wire  m00_axi_rlast,
		(*mark_debug = "true"*)input wire [C_M00_AXI_RUSER_WIDTH-1 : 0] m00_axi_ruser,
		(*mark_debug = "true"*)input wire  m00_axi_rvalid,
		(*mark_debug = "true"*)output wire  m00_axi_rready,

		// Ports of Axi Slave Bus Interface S_AXI_INTR
		input wire  s_axi_intr_aclk,
		input wire  s_axi_intr_aresetn,
		input wire [C_S_AXI_INTR_ADDR_WIDTH-1 : 0] s_axi_intr_awaddr,
		input wire [2 : 0] s_axi_intr_awprot,
		input wire  s_axi_intr_awvalid,
		output wire  s_axi_intr_awready,
		input wire [C_S_AXI_INTR_DATA_WIDTH-1 : 0] s_axi_intr_wdata,
		input wire [(C_S_AXI_INTR_DATA_WIDTH/8)-1 : 0] s_axi_intr_wstrb,
		input wire  s_axi_intr_wvalid,
		output wire  s_axi_intr_wready,
		output wire [1 : 0] s_axi_intr_bresp,
		output wire  s_axi_intr_bvalid,
		input wire  s_axi_intr_bready,
		input wire [C_S_AXI_INTR_ADDR_WIDTH-1 : 0] s_axi_intr_araddr,
		input wire [2 : 0] s_axi_intr_arprot,
		input wire  s_axi_intr_arvalid,
		output wire  s_axi_intr_arready,
		output wire [C_S_AXI_INTR_DATA_WIDTH-1 : 0] s_axi_intr_rdata,
		output wire [1 : 0] s_axi_intr_rresp,
		output wire  s_axi_intr_rvalid,
		input wire  s_axi_intr_rready,
		output wire  irq,
		
		// customized I/O 
		input	wire	[31:0]	s_axi_tdata,
		input	wire			s_axi_tvalid,
		output	wire			s_axi_tready,
		input   wire            burst_enable
		
		
	);
	
	
	assign s_axi_tready = m00_axi_wready;
//	assign m00_axi_wvalid = s_axi_tvalid;
    assign m00_axi_wdata = s_axi_tdata;

    reg s_axi_tready_reg;
    always @(posedge m00_axi_aclk)
    begin
        if (!m00_axi_aresetn)
            s_axi_tready_reg <= 0;
        else
            s_axi_tready_reg <= m00_axi_wready;
    end 
        
        
    reg burst_enable_reg_1, burst_enable_reg_2;
    
    always @(posedge m00_axi_aclk)
    begin
        if (!m00_axi_aresetn)   begin
            burst_enable_reg_1 <= 0;
            burst_enable_reg_2 <= 0;
        end
        else    begin
            burst_enable_reg_1 <= burst_enable;
            burst_enable_reg_2 <= burst_enable_reg_1;
        end
        
        
    end
    
	

	
// Instantiation of Axi Bus Interface M00_AXI
	AXI4_Test_v1_0_M00_AXI # ( 
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
	) AXI4_Test_v1_0_M00_AXI_inst (
		// Customized Data and control
		.s_axi_tdata(s_axi_tdata),
	    .burst_enable (burst_enable_reg_2),
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
//		.M_AXI_WDATA(m00_axi_wdata),
		.M_AXI_WDATA(),
		.M_AXI_WSTRB(m00_axi_wstrb),
		.M_AXI_WLAST(m00_axi_wlast),
		.M_AXI_WUSER(m00_axi_wuser),
		.M_AXI_WVALID(m00_axi_wvalid),
//		.M_AXI_WVALID(a),
				
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

// Instantiation of Axi Bus Interface S_AXI_INTR
	AXI4_Test_v1_0_S_AXI_INTR # ( 
		.C_S_AXI_DATA_WIDTH(C_S_AXI_INTR_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S_AXI_INTR_ADDR_WIDTH),
		.C_NUM_OF_INTR(C_NUM_OF_INTR),
		.C_INTR_SENSITIVITY(C_INTR_SENSITIVITY),
		.C_INTR_ACTIVE_STATE(C_INTR_ACTIVE_STATE),
		.C_IRQ_SENSITIVITY(C_IRQ_SENSITIVITY),
		.C_IRQ_ACTIVE_STATE(C_IRQ_ACTIVE_STATE)
	) AXI4_Test_v1_0_S_AXI_INTR_inst (
		.S_AXI_ACLK(s_axi_intr_aclk),
		.S_AXI_ARESETN(s_axi_intr_aresetn),
		.S_AXI_AWADDR(s_axi_intr_awaddr),
		.S_AXI_AWPROT(s_axi_intr_awprot),
		.S_AXI_AWVALID(s_axi_intr_awvalid),
		.S_AXI_AWREADY(s_axi_intr_awready),
		.S_AXI_WDATA(s_axi_intr_wdata),
		.S_AXI_WSTRB(s_axi_intr_wstrb),
		.S_AXI_WVALID(s_axi_intr_wvalid),
		.S_AXI_WREADY(s_axi_intr_wready),
		.S_AXI_BRESP(s_axi_intr_bresp),
		.S_AXI_BVALID(s_axi_intr_bvalid),
		.S_AXI_BREADY(s_axi_intr_bready),
		.S_AXI_ARADDR(s_axi_intr_araddr),
		.S_AXI_ARPROT(s_axi_intr_arprot),
		.S_AXI_ARVALID(s_axi_intr_arvalid),
		.S_AXI_ARREADY(s_axi_intr_arready),
		.S_AXI_RDATA(s_axi_intr_rdata),
		.S_AXI_RRESP(s_axi_intr_rresp),
		.S_AXI_RVALID(s_axi_intr_rvalid),
		.S_AXI_RREADY(s_axi_intr_rready),
		.irq(irq)
	);

	// Add user logic here

	// User logic ends

	endmodule
