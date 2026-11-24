.PHONY := work

work:
	ghdl -a --std=08 src/sqrt_approx.vhd
	ghdl -a --std=08 tst/tb_sqrt_approx.vhd

sim: work
	ghdl -e --std=08 tb_sqrt_approx
	ghdl -r --std=08 tb_sqrt_approx --vcd=wave.vcd

wav: sim
	gtkwave settings.gtkw 
