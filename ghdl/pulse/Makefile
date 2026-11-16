.PHONY := work

work:
	ghdl -a --std=08 src/pulse.vhd
	ghdl -a --std=08 src/pulse_hlsm.vhd
	ghdl -a --std=08 src/pulse_dc.vhd
	ghdl -a --std=08 tst/tb_pulse.vhd

sim: work
	ghdl -e --std=08 tb_pulse
	ghdl -r --std=08 tb_pulse --vcd=wave.vcd

wav: sim
	gtkwave settings.gtkw 
