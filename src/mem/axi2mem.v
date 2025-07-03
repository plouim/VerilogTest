module axi2mem #(
    parameter ADDR_WIDTH=32,
    parameter DATA_WIDTH=32
) (
    // =======================================
    // ==============  INPUT IF ==============
    // =======================================
    input  wire                  i_mem_clk  ,
    input  wire                  i_mem_cs   ,
    input  wire                  i_mem_we   ,
    input  wire [ADDR_WIDTH-1:0] i_mem_addr ,
    input  wire [DATA_WIDTH-1:0] i_mem_wdata,
    output reg  [DATA_WIDTH-1:0] i_mem_rdata


    // =======================================
    // ============== OUTPUT IF ==============
    // =======================================
    // -------------- Global Signal --------------
    output wire o_w_aclk    ,
    output wire o_w_areset_n,
    // -------------- AW CHANNEL --------------
    output wire                  o_w_awvalid,
    output wire                  o_w_awready,
    output wire [ADDR_WIDTH-1:0] o_w_awaddr ,
    //output wire [7:0] o_w_wlen  , // AXI4 Full
    //output wire [2:0] o_w_wsize , // AXI4 Full
    //output wire [1:0] o_w_wburst, // AXI4 Full
    // -------------- W CHANNEL --------------
    output wire                  o_w_wvalid,
    output wire                  o_w_wready,
    output wire [DATA_WIDTH-1:0] o_w_wdata ,
    //output wire [DATA_WIDTH/8-1:0]WSTRB , // AXI4 Full
    //output wire WLAST , // AXI4 Full
    // -------------- B CHANNEL --------------
    output wire       o_w_bvalid,
    output wire       o_w_bready,
    output wire [1:0] o_w_bresp ,
    // -------------- AR CHANNEL --------------
    output wire                  o_w_arvalid,
    output wire                  o_w_arready,
    output wire [ADDR_WIDTH-1:0] o_w_araddr ,
    //output wire [7:0] o_w_arlen  , // AXI4 Full
    //output wire [2:0] o_w_arsize , // AXI4 Full
    //output wire [1:0] o_w_arburst, // AXI4 Full
    // -------------- R CHANNEL --------------
    //output wire RLAST, // AXI4 Full
    output wire                  o_w_rvalid,
    output wire                  o_w_rready,
    output wire [1:0]            o_w_rresp ,
    output wire [DATA_WIDTH-1:0] o_w_rdata
);
endmodule
