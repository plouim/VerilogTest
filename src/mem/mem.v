module mem #(
    parameter ADDR_WIDTH=8,
    parameter DATA_WIDTH=8,
    parameter DEPTH=1<<ADDR_WIDTH
) (
    input  wire                  i_w_clk  ,
    input  wire                  i_w_cs   ,
    input  wire                  i_w_we   ,
    input  wire [ADDR_WIDTH-1:0] i_w_addr ,
    input  wire [DATA_WIDTH-1:0] i_w_wdata,
    output reg  [DATA_WIDTH-1:0] o_w_rdata
);
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    always@(posedge i_w_clk) begin
        if (i_w_cs) begin
            if (i_w_we) begin // WRITE
                mem[i_w_addr] <= i_w_wdata;
            end else begin // READ
                o_w_rdata <= mem[i_w_addr];
            end
        end
    end
endmodule
