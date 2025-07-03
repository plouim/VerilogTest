module axi2mem #(
    parameter ADDR_WIDTH=32,
    parameter DATA_WIDTH=32
) (
    // -------------- Global Signal --------------
    input wire i_w_aclk    ,
    input wire i_w_areset_n,
    // -------------- AW CHANNEL --------------
    input  wire                  i_w_awvalid,
    output wire                  o_w_awready,
    input  wire [ADDR_WIDTH-1:0] i_w_awaddr ,
    //input  wire [7:0] i_w_wlen  ,             // AXI4 Full
    //input  wire [2:0] i_w_wsize ,             // AXI4 Full
    //input  wire [1:0] i_w_wburst,             // AXI4 Full
    // -------------- W CHANNEL --------------
    input  wire                  i_w_wvalid,
    output wire                  o_w_wready,
    input  wire [DATA_WIDTH-1:0] i_w_wdata ,
    //input  wire [DATA_WIDTH/8-1:0]WSTRB ,     // AXI4 Full
    //input  wire WLAST , // AXI4 Full
    // -------------- B CHANNEL --------------
    output wire       o_w_bvalid,
    input  wire       i_w_bready,
    output wire [1:0] o_w_bresp ,
    // -------------- AR CHANNEL --------------
    input  wire                  i_w_arvalid,
    output wire                  o_w_arready,
    input  wire [ADDR_WIDTH-1:0] i_w_araddr ,
    //input  wire [7:0] i_w_arlen  ,             // AXI4 Full
    //input  wire [2:0] i_w_arsize ,             // AXI4 Full
    //input  wire [1:0] i_w_arburst,             // AXI4 Full
    // -------------- R CHANNEL --------------
    //input wire i_w_rlast,                      // AXI4 Full
    output wire                  o_w_rvalid,
    input  wire                  i_w_rready,
    output wire [1:0]            o_w_rresp ,
    output wire [DATA_WIDTH-1:0] o_w_rdata
);

wire                  mem_cs   ;
wire                  mem_we   ;
wire [ADDR_WIDTH-1:0] mem_addr ;
wire [DATA_WIDTH-1:0] mem_wdata;
reg  [DATA_WIDTH-1:0] mem_rdata;

// ==============================
//         INSTANTIATION
// ==============================
mem #(
    .ADDR_WIDTH(ADDR_WIDTH),
    .DATA_WIDTH(DATA_WIDTH)
) u_mem (
    .i_w_clk  (i_w_aclk ),
    .i_w_cs   (mem_cs   ),
    .i_w_we   (mem_we   ),
    .i_w_addr (mem_addr ),
    .i_w_wdata(mem_wdata),
    .o_w_rdata(mem_rdata)
);
endmodule
