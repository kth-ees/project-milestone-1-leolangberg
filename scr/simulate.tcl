vlog -sv ./rtl/alu.sv
vlog -sv ./tb/alu_tb.sv

vsim -voptargs=+acc work.alu_tb

# Add your waveforms signals here
# Adding all in one go...
add wave -r /*

run 100ns
