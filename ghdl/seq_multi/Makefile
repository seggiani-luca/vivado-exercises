.PHONY := work

work:
	ghdl -a --std=08 src/seq_multi.vhd
	ghdl -a --std=08 tst/tb_seq_multi.vhd

sim: work
	ghdl -e --std=08 tb_seq_multi
	ghdl -r --std=08 tb_seq_multi --vcd=wave.vcd

wav: sim
	gtkwave settings.gtkw 
