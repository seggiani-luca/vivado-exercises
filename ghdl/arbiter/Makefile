.PHONY := work

work:
	ghdl -a --std=08 src/arbiter.vhd
	ghdl -a --std=08 src/arbiter_fcfs.vhd
	ghdl -a --std=08 src/arbiter_fixed.vhd
	ghdl -a --std=08 tst/tb_arbiter.vhd

sim: work
	ghdl -e --std=08 tb_arbiter
	ghdl -r --std=08 tb_arbiter --stop-time=100ns --vcd=wave.vcd

wav: sim
	gtkwave wave.vcd 
