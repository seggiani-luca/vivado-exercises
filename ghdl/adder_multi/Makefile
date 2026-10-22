.PHONY := work

work:
	ghdl -a --std=08 src/multi_dumb.vhd
	ghdl -a --std=08 src/multi_smart.vhd
	ghdl -a --std=08 tst/tb_multi.vhd

sim:
	ghdl -e --std=08 cfg_structural 
	ghdl -r --std=08 cfg_structural --stop-time=100ns --vcd=alu.vcd

wav:
	gtkwave alu.vcd
