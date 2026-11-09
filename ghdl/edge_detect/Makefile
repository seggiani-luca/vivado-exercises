.PHONY := work

work:
	ghdl -a --std=08 src/edge.vhd
	ghdl -a --std=08 src/edge_mealy.vhd
	ghdl -a --std=08 src/edge_moore.vhd
	ghdl -a --std=08 tst/tb_edge.vhd

sim: work
	ghdl -e --std=08 tb_edge
	ghdl -r --std=08 tb_edge --vcd=wave.vcd

wav: sim
	gtkwave settings.gtkw
