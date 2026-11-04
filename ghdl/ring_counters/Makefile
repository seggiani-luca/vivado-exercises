.PHONY := work

work:
	ghdl -a --std=08 src/ring_counter.vhd
	ghdl -a --std=08 src/self_ring_counter.vhd
	ghdl -a --std=08 src/lin_feed_shift_reg.vhd
	ghdl -a --std=08 src/bruj_shift_reg.vhd
	ghdl -a --std=08 tst/tb_ring_counter.vhd

sim:
	ghdl -e --std=08 tb_ring_counter
	ghdl -r --std=08 tb_ring_counter --stop-time=2600ns --vcd=wave.vcd

wav:
	gtkwave wave.vcd
