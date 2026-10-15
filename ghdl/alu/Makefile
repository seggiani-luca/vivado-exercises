.PHONY := work

work:
	ghdl -a --std=08 src/alu.vhd
	ghdl -a --std=08 tst/tb_alu.vhd

sim:
	ghdl -e --std=08 tb_alu
	ghdl -r --std=08 tb_alu --stop-time=100ns --vcd=alu.vcd

wav:
	gtkwave alu.vcd
