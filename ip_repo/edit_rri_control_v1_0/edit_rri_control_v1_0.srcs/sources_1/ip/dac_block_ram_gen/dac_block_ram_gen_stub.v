// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
// Date        : Wed Oct  5 13:51:06 2022
// Host        : pop-os running 64-bit Pop!_OS 22.04 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/damir/vivado_scripts/project_4_old/edit_rri_control_v1_0/edit_rri_control_v1_0.srcs/sources_1/ip/dac_block_ram_gen/dac_block_ram_gen_stub.v
// Design      : dac_block_ram_gen
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_5,Vivado 2022.1" *)
module dac_block_ram_gen(clka, ena, wea, addra, dina, clkb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[12:0],dina[13:0],clkb,addrb[12:0],doutb[13:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [12:0]addra;
  input [13:0]dina;
  input clkb;
  input [12:0]addrb;
  output [13:0]doutb;
endmodule
