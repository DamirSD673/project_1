-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
-- Date        : Thu Aug 11 16:31:28 2022
-- Host        : mb-pms321 running 64-bit unknown
-- Command     : write_vhdl -force -mode synth_stub
--               /home/alex/zynq/red-pitaya/ip_repo/edit_rri_control_v1_0/edit_rri_control_v1_0.srcs/sources_1/ip/dac_block_ram_gen/dac_block_ram_gen_stub.vhdl
-- Design      : dac_block_ram_gen
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dac_block_ram_gen is
  Port ( 
    clka : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 12 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 13 downto 0 );
    clkb : in STD_LOGIC;
    addrb : in STD_LOGIC_VECTOR ( 12 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 13 downto 0 )
  );

end dac_block_ram_gen;

architecture stub of dac_block_ram_gen is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,ena,wea[0:0],addra[12:0],dina[13:0],clkb,addrb[12:0],doutb[13:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_4,Vivado 2019.2";
begin
end;
