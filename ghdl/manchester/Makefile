.PHONY := work

work:
	ghdl -a --std=08 src/manchester.vhd
	ghdl -a --std=08 tst/tb_manchester.vhd

sim: work
	ghdl -e --std=08 tb_manchester
	ghdl -r --std=08 tb_manchester --vcd=wave.vcd

wav: sim
	gtkwave wave.vcd 
