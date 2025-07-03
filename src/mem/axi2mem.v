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
    // ============== OUTPUT IF ==============
    // -------------- Global Signal --------------
    output wire ACLK   ,
    output wire ARESETn,
    // -------------- AW CHANNEL --------------
    output wire                  AWVALID,
    output wire                  AWREADY,
    output wire [ADDR_WIDTH-1:0] AWADDR ,
    //output wire [7:0] AWLEN  , // AXI4 Full
    //output wire [2:0] AWSIZE , // AXI4 Full
    //output wire [1:0] AWBURST, // AXI4 Full
    // -------------- W CHANNEL --------------
    output wire                  WVALID,
    output wire                  WREADY,
    output wire [DATA_WIDTH-1:0] WDATA ,
    //output wire [DATA_WIDTH/8-1:0]WSTRB , // AXI4 Full
    //output wire WLAST , // AXI4 Full
    // -------------- B CHANNEL --------------
    output wire       BVALID,
    output wire       BREADY,
    output wire [1:0] BRESP ,
    // -------------- AR CHANNEL --------------
    output wire                  ARVALID,
    output wire                  ARREADY,
    output wire [ADDR_WIDTH-1:0] ARADDR ,
    //output wire [7:0] ARLEN  , // AXI4 Full
    //output wire [2:0] ARSIZE , // AXI4 Full
    //output wire [1:0] ARBURST, // AXI4 Full
    // -------------- R CHANNEL --------------
    //output wire RLAST, // AXI4 Full
    output wire                 RVALID,
    output wire                 RREADY,
    output wire [1:0]           RRESP ,
    output wire [DATA_WIDTH-1:0] RDATA
);
endmodule
