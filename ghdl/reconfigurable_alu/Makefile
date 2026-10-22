.PHONY := work

work:
	ghdl -a --std=08 src/alu.vhd
	ghdl -a --std=08 src/reconfigurable_alu.vhd
	ghdl -a --std=08 tst/tb_reconfigurable_alu.vhd

sim:
	ghdl -e --std=08 tb_reconfigurable_alu
	ghdl -r --std=08 tb_reconfigurable_alu --stop-time=100ns --vcd=wave.vcd

wav:
	gtkwave wave.vcd
