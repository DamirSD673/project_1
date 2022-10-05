onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+dac_block_ram_gen -L xpm -L blk_mem_gen_v8_4_4 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.dac_block_ram_gen xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {dac_block_ram_gen.udo}

run -all

endsim

quit -force
