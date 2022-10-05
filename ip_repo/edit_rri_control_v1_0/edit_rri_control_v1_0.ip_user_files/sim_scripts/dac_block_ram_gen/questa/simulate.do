onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib dac_block_ram_gen_opt

do {wave.do}

view wave
view structure
view signals

do {dac_block_ram_gen.udo}

run -all

quit -force
