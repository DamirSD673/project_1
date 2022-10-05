----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/08/2022 12:45:14 PM
-- Design Name: 
-- Module Name: tb_red_pitaya_analog_interface_v1_0 - Behavioral
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

use std.env.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

use std.textio.all;
use ieee.std_logic_textio.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_red_pitaya_analog_interface_v1_0 is
    generic (  
            g_period  : time := 8 ns;
            g_timeout : time :=  2 us
    );
end tb_red_pitaya_analog_interface_v1_0;

architecture Behavioral of tb_red_pitaya_analog_interface_v1_0 is

    component red_pitaya_analog_interface_v1_0 is
        generic (
            -- Users to add parameters here
    
            -- User parameters ends
            -- Do not modify the parameters beyond this line
            C_ADC_DATA_WIDTH : integer  := 16;
            C_DAC_DATA_WIDTH : integer	:= 14;
    
    
            -- Parameters of Axi Slave Bus Interface DAC_AXIS
            C_DAC_AXIS_TDATA_WIDTH	: integer	:= 32;
    
            -- Parameters of Axi Master Bus Interface ADC_AXIS
            C_ADC_AXIS_TDATA_WIDTH	: integer	:= 32;
            C_ADC_AXIS_START_COUNT	: integer	:= 32
        );
        port (
            -- Users to add ports here
            adc_clk_p : in std_logic;
            adc_clk_n : in std_logic;
            
            adc_data_a : in std_logic_vector(15 downto 0);
            adc_data_b : in std_logic_vector(15 downto 0);
            
            adc_csn : out std_logic;
            
            dac_clk : out std_logic;
            dac_rst : out std_logic;
            dac_sel : out std_logic;
            dac_wrt : out std_logic;
            dac_data : out std_logic_vector(C_DAC_DATA_WIDTH-1 downto 0);
    
            -- Ports of Axi Slave Bus Interface DAC_AXIS
            dac_axis_aclk	: in std_logic;
            dac_axis_aresetn	: in std_logic;
            dac_axis_tready	: out std_logic;
            dac_axis_tdata	: in std_logic_vector(C_DAC_AXIS_TDATA_WIDTH-1 downto 0);
            dac_axis_tvalid	: in std_logic;
    
            -- Ports of Axi Master Bus Interface ADC_AXIS
            adc_axis_aclk	: out std_logic;
            adc_axis_aresetn	: in std_logic;
            adc_axis_tvalid	: out std_logic;
            adc_axis_tdata	: out std_logic_vector(C_ADC_AXIS_TDATA_WIDTH-1 downto 0);
            adc_axis_tready	: in std_logic
        );
    end component red_pitaya_analog_interface_v1_0;
	
	  
    signal s_clk : std_logic := '1';
    signal s_rst : std_logic := '0';
    
    signal s_adc_clk_p : std_logic;
    signal s_adc_clk_n : std_logic;
    
    signal s_adc_data_counter : unsigned(13 downto 0) := (others => '0');
    
    signal s_adc_data_a : std_logic_vector(15 downto 0) := (others => '0');
    signal s_adc_data_b : std_logic_vector(15 downto 0) := (others => '0');
    
    signal s_adc_csn : std_logic;
    
    signal s_dac_clk : std_logic;
    signal s_dac_rst : std_logic;
    signal s_dac_sel : std_logic;
    signal s_dac_wrt : std_logic;
    signal s_dac_data : std_logic_vector(13 downto 0);
    
    signal s_adc_axis_aclk : std_logic;
    signal s_adc_axis_aresetn : std_logic;
    signal s_adc_axis_tvalid : std_logic;
    signal s_adc_axis_tdata : std_logic_vector(31 downto 0);
    signal s_adc_axis_tready : std_logic := '1';
    
    
    signal s_dac_axis_aclk : std_logic;
    signal s_dac_axis_aresetn : std_logic;
    signal s_dac_axis_tvalid : std_logic := '1';
    signal s_dac_axis_tdata : std_logic_vector(31 downto 0);
    signal s_dac_axis_tready : std_logic;
    
    signal value_counter : signed(15 downto 0) := to_signed(0, 16);

begin
    s_clk <= not s_clk after g_period / 2;
    
    s_rst <= '1' after 20 ns;
    
    s_adc_clk_p <= s_clk;
    s_adc_clk_n <= not s_clk;
    
    s_dac_axis_aclk <= s_adc_axis_aclk;
    
    dut : red_pitaya_analog_interface_v1_0
    generic map (
    C_ADC_DATA_WIDTH => 16,
      C_DAC_DATA_WIDTH => 14,
      -- Parameters of Axi Slave Bus Interface DAC_AXIS
      C_DAC_AXIS_TDATA_WIDTH	=> 32,
    
      -- Parameters of Axi Master Bus Interface ADC_AXIS
      C_ADC_AXIS_TDATA_WIDTH	=>32 
    )
    port map (
        adc_clk_p => s_adc_clk_p,
        adc_clk_n => s_adc_clk_n,
        
        adc_data_a => s_adc_data_a,
        adc_data_b => s_adc_data_b,
        
        adc_csn => s_adc_csn,
        
        dac_clk => s_dac_clk,
        dac_rst  => s_dac_rst,
        dac_sel => s_dac_sel,
        dac_wrt => s_dac_wrt,
        dac_data => s_dac_data,

        -- Ports of Axi Slave Bus Interface DAC_AXIS
        dac_axis_aclk	=> s_dac_axis_aclk,
        dac_axis_aresetn	=> s_dac_axis_aresetn,
        dac_axis_tready	=> s_dac_axis_tready,
        dac_axis_tdata	=> s_dac_axis_tdata,
        dac_axis_tvalid	=> s_dac_axis_tvalid,

        -- Ports of Axi Master Bus Interface ADC_AXIS
        adc_axis_aclk	=> s_adc_axis_aclk,
        adc_axis_aresetn    => s_adc_axis_aresetn,
        adc_axis_tvalid	=> s_adc_axis_tvalid,
        adc_axis_tdata	=> s_adc_axis_tdata,
        adc_axis_tready	=> s_adc_axis_tready
    );
    
    gen_adc_reset : process
    begin
        s_adc_axis_aresetn <= '0';
        wait for 50 ns;
        s_adc_axis_aresetn <= '1';
        wait;
	end process;
    
    gen_dac_reset : process
    begin
        s_dac_axis_aresetn <= '0';
        wait for 20 ns;
        s_dac_axis_aresetn <= '1';

        wait for g_timeout;
		  assert false report "timeout reached" severity failure;
		  stop(1);
	end process;
    
    p_adc_counter : process(s_clk)
	begin
	   if (rising_edge(s_clk)) then
	       s_adc_data_counter <= s_adc_data_counter + 1;
	   end if;
	end process;
	
	s_adc_data_a(13 downto 0) <= std_logic_vector(s_adc_data_counter);
	s_adc_data_b(13 downto 0) <= not std_logic_vector(s_adc_data_counter);
    
    p_dac_counter : process(s_dac_axis_aclk)
	begin
	   if (rising_edge (s_dac_axis_aclk)) then
	       if (value_counter > 16383) then
	           value_counter <= to_signed(-16384, 16);
	       else
	           value_counter <= value_counter + 512;
	       end if;
	   end if;
	end process;
	
	s_dac_axis_tdata(31 downto 16) <= std_logic_vector(value_counter);
	s_dac_axis_tdata(15 downto 0) <= not std_logic_vector(value_counter);


end Behavioral;
