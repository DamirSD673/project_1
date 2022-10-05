----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/17/2022 03:46:29 PM
-- Design Name: 
-- Module Name: rri_counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rri_counter is
    Port ( dac_enable : in STD_LOGIC;
           adc_enable : in STD_LOGIC;
           adc_dma_enable : out STD_LOGIC;
           adc_dma_last : out STD_LOGIC;
           adc_length : in STD_LOGIC_VECTOR (31 downto 0);
           dac_length : in STD_LOGIC_VECTOR (15 downto 0);
           dac_addr : out STD_LOGIC_VECTOR (15 downto 0));
end rri_counter;

architecture Behavioral of rri_counter is
    signal dac_counter	: std_logic_vector(15 downto 0);
    signal adc_counter	: std_logic_vector(31 downto 0);

begin
    


end Behavioral;
