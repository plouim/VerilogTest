`timescale 1ns / 1ps

module mem_tb;

    // 파라미터 및 신호 선언 (이전과 동일)
    localparam ADDR_WIDTH = 8;
    localparam DATA_WIDTH = 8;
    localparam CLK_PERIOD = 10;

    reg                          i_w_clk;
    reg                          i_w_cs;
    reg                          i_w_we;
    reg  [ADDR_WIDTH-1:0]        i_w_addr;
    reg  [DATA_WIDTH-1:0]        i_w_wdata;
    wire [DATA_WIDTH-1:0]        o_w_rdata;

    // DUT 인스턴스화 (이전과 동일)
    mem #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH))
    uut (.i_w_clk(i_w_clk), .i_w_cs(i_w_cs), .i_w_we(i_w_we),
         .i_w_addr(i_w_addr), .i_w_wdata(i_w_wdata), .o_w_rdata(o_w_rdata));

    // 클럭 생성 (이전과 동일)
    initial begin
        i_w_clk = 0;
        forever #(CLK_PERIOD / 2) i_w_clk = ~i_w_clk;
    end

    // ================= Task 정의 =================
    // Task 1: 메모리 쓰기
    task write_mem(input [ADDR_WIDTH-1:0] addr, input [DATA_WIDTH-1:0] data);
        begin
            @(posedge i_w_clk);
            i_w_cs    <= 1;
            i_w_we    <= 1;
            i_w_addr  <= addr;
            i_w_wdata <= data;
            $display("[%0t] WRITE: Addr=0x%h, Data=0x%h", $time, addr, data);
            @(posedge i_w_clk);
            i_w_cs    <= 0; // 사이클 종료 후 비활성화
        end
    endtask

    // Task 2: 메모리 읽기 및 검증
    task read_mem_and_check(input [ADDR_WIDTH-1:0] addr, input [DATA_WIDTH-1:0] expected_data);
        begin
            @(posedge i_w_clk);
            i_w_cs   <= 1;
            i_w_we   <= 0; // 읽기 모드
            i_w_addr <= addr;
            $display("[%0t] READ:  Addr=0x%h, Expected=0x%h", $time, addr, expected_data);
            
            @(posedge i_w_clk); // 데이터가 출력될 때까지 대기
            @(posedge i_w_clk); // 데이터가 출력될 때까지 대기
            
            if (o_w_rdata === expected_data) begin
                $display("[%0t]  └> SUCCESS: Read Data 0x%h", $time, o_w_rdata);
            end else begin
                $error("[%0t]  └> FAILED: Read Data 0x%h", $time, o_w_rdata);
            end
            i_w_cs <= 0; // 사이클 종료 후 비활성화
        end
    endtask

    // ================= 테스트 시나리오 =================
    initial begin
        // Waveform(VCD) 파일 생성
        $dumpfile("tb_mem.vcd");
        $dumpvars(0, mem_tb);

        // 신호 초기화
        i_w_cs <= 0; i_w_we <= 0; i_w_addr <= 0; i_w_wdata <= 0;
        $display("====== Test Started ======");
        #(CLK_PERIOD * 2);

        // TC 1: 기본적인 쓰기 및 읽기
        write_mem(8'h10, 8'hAA);
        read_mem_and_check(8'h10, 8'hAA);
        write_mem(8'h2A, 8'hBB);
        read_mem_and_check(8'h2A, 8'hBB);

        // TC 2: 덮어쓰기 검증
        write_mem(8'h10, 8'hCC); // 8'h10 주소에 새로운 값 쓰기
        read_mem_and_check(8'h10, 8'hCC); // 덮어쓴 값 확인

        // TC 3: Chip Select(cs) 비활성화 시 동작 안함 검증
        @(posedge i_w_clk);
        i_w_cs    <= 0; // CS 비활성화
        i_w_we    <= 1;
        i_w_addr  <= 8'h30;
        i_w_wdata <= 8'hFF;
        $display("[%0t] INFO:  Testing write operation while CS is low", $time);
        @(posedge i_w_clk);
        // CS가 low일 때 쓰기가 동작하지 않았으므로, 읽었을 때 X (초기값)가 나와야 함
        read_mem_and_check(8'h30, {DATA_WIDTH{1'bx}});

        $display("====== Test Finished ======");
        $finish;
    end

endmodule
