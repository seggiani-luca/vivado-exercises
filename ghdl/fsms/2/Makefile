.PHONY := work

work:
	ghdl -a --std=08 src/fsm.vhd
	ghdl -a --std=08 tst/tb_fsm.vhd

sim:
	ghdl -e --std=08 tb_fsm
	ghdl -r --std=08 tb_fsm --vcd=fsm.vcd

wav:
	gtkwave fsm.vcd
