# 컴파일러 및 툴 설정
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# 소스 파일 및 타겟 이름 설정
V_FILES = mem.v tb_mem.v
TARGET = tb_mem
VCD_FILE = $(TARGET).vcd

# 기본 목표: 컴파일하고 시뮬레이션 실행
all: run

# 컴파일 규칙: Verilog 파일들을 컴파일하여 시뮬레이션용 실행 파일 생성
$(TARGET): $(V_FILES)
	$(IVERILOG) -o $@ $^

# 시뮬레이션 실행 규칙
run: $(TARGET)
	$(VVP) $<

# GTKWave 실행 규칙
wave: $(VCD_FILE)
	$(GTKWAVE) $< &

# VCD 파일 생성 규칙: 시뮬레이션을 실행하여 VCD 파일 생성
$(VCD_FILE):
	$(MAKE) run

# 생성된 파일 삭제 규칙
clean:
	rm -f $(TARGET) $(VCD_FILE)

# phony targets: 파일 이름과 겹치지 않도록 설정
.PHONY: all run wave clean
