.PHONY := work

work:
	ghdl -a --std=08 src/alu.vhd
	ghdl -a --std=08 src/majority_vote_alu.vhd
	ghdl -a --std=08 tst/tb_majority_vote_alu.vhd

sim:
	ghdl -e --std=08 tb_majority_vote_alu
	ghdl -r --std=08 tb_majority_vote_alu --stop-time=100ns --vcd=wave.vcd

wav:
	gtkwave wave.vcd
