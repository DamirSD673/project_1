----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/24/2022 12:29:25 PM
-- Design Name: 
-- Module Name: tb_rri_control - Behavioral
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

entity tb_rri_control is
    generic (  
            g_period_axi  : time := 20 ns;
            g_period_axis  : time := 8 ns;
            g_timeout : time :=  2 us
        );
--  Port ( );
end tb_rri_control;

architecture Behavioral of tb_rri_control is

    component rri_control_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S_AXI_LITE
		C_S_AXI_LITE_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_LITE_ADDR_WIDTH	: integer	:= 4;

		-- Parameters of Axi Slave Bus Interface S_ADC_AXIS
		C_S_ADC_AXIS_TDATA_WIDTH	: integer	:= 32;

		-- Parameters of Axi Master Bus Interface M_DMA_AXIS
		C_M_DMA_AXIS_TDATA_WIDTH	: integer	:= 32;
		C_M_DMA_AXIS_START_COUNT	: integer	:= 32;

		-- Parameters of Axi Master Bus Interface M_DAC_AXIS
		C_M_DAC_AXIS_TDATA_WIDTH	: integer	:= 16;
		C_M_DAC_AXIS_START_COUNT	: integer	:= 32
	);
	port (
		-- Users to add ports here

		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S_AXI_LITE
		s_axi_lite_aclk	: in std_logic;
		s_axi_lite_aresetn	: in std_logic;
		s_axi_lite_awaddr	: in std_logic_vector(C_S_AXI_LITE_ADDR_WIDTH-1 downto 0);
		s_axi_lite_awprot	: in std_logic_vector(2 downto 0);
		s_axi_lite_awvalid	: in std_logic;
		s_axi_lite_awready	: out std_logic;
		s_axi_lite_wdata	: in std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
		s_axi_lite_wstrb	: in std_logic_vector((C_S_AXI_LITE_DATA_WIDTH/8)-1 downto 0);
		s_axi_lite_wvalid	: in std_logic;
		s_axi_lite_wready	: out std_logic;
		s_axi_lite_bresp	: out std_logic_vector(1 downto 0);
		s_axi_lite_bvalid	: out std_logic;
		s_axi_lite_bready	: in std_logic;
		s_axi_lite_araddr	: in std_logic_vector(C_S_AXI_LITE_ADDR_WIDTH-1 downto 0);
		s_axi_lite_arprot	: in std_logic_vector(2 downto 0);
		s_axi_lite_arvalid	: in std_logic;
		s_axi_lite_arready	: out std_logic;
		s_axi_lite_rdata	: out std_logic_vector(C_S_AXI_LITE_DATA_WIDTH-1 downto 0);
		s_axi_lite_rresp	: out std_logic_vector(1 downto 0);
		s_axi_lite_rvalid	: out std_logic;
		s_axi_lite_rready	: in std_logic;

		-- Ports of Axi Slave Bus Interface S_ADC_AXIS
		s_adc_axis_aclk	: in std_logic;
		s_adc_axis_aresetn	: in std_logic;
		s_adc_axis_tready	: out std_logic;
		s_adc_axis_tdata	: in std_logic_vector(C_S_ADC_AXIS_TDATA_WIDTH-1 downto 0);
		s_adc_axis_tstrb	: in std_logic_vector((C_S_ADC_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s_adc_axis_tlast	: in std_logic;
		s_adc_axis_tvalid	: in std_logic;

		-- Ports of Axi Master Bus Interface M_DMA_AXIS
		m_dma_axis_aclk	: in std_logic;
		m_dma_axis_aresetn	: in std_logic;
		m_dma_axis_tvalid	: out std_logic;
		m_dma_axis_tdata	: out std_logic_vector(C_M_DMA_AXIS_TDATA_WIDTH-1 downto 0);
		m_dma_axis_tstrb	: out std_logic_vector((C_M_DMA_AXIS_TDATA_WIDTH/8)-1 downto 0);
		m_dma_axis_tlast	: out std_logic;
		m_dma_axis_tready	: in std_logic;

		-- Ports of Axi Master Bus Interface M_DAC_AXIS
		m_dac_axis_aclk	: in std_logic;
		m_dac_axis_aresetn	: in std_logic;
		m_dac_axis_tvalid	: out std_logic;
		m_dac_axis_tdata	: out std_logic_vector(C_M_DAC_AXIS_TDATA_WIDTH-1 downto 0);
		m_dac_axis_tstrb	: out std_logic_vector((C_M_DAC_AXIS_TDATA_WIDTH/8)-1 downto 0);
		m_dac_axis_tlast	: out std_logic;
		m_dac_axis_tready	: in std_logic
	);
    end component rri_control_v1_0;

    signal s_clk_axi : std_logic := '1';
    signal s_clk_axis : std_logic := '1';
    signal s_rst_axi : std_logic := '0';
    signal s_rst_axis : std_logic := '0';  
    
    signal s_s_axi_lite_aclk : std_logic;
    signal s_s_axi_lite_aresetn	: std_logic;
    signal s_s_axi_lite_awaddr	: std_logic_vector(3 downto 0);
    signal s_s_axi_lite_awprot	: std_logic_vector(2 downto 0);
    signal s_s_axi_lite_awvalid	: std_logic;
    signal s_s_axi_lite_awready	: std_logic;
    signal s_s_axi_lite_wdata	: std_logic_vector(31 downto 0);
    signal s_s_axi_lite_wstrb	: std_logic_vector(3 downto 0);
    signal s_s_axi_lite_wvalid	: std_logic;
    signal s_s_axi_lite_wready	: std_logic;
    signal s_s_axi_lite_bresp	: std_logic_vector(1 downto 0);
    signal s_s_axi_lite_bvalid	: std_logic;
    signal s_s_axi_lite_bready	: std_logic;
    signal s_s_axi_lite_araddr	: std_logic_vector(3 downto 0);
    signal s_s_axi_lite_arprot	: std_logic_vector(2 downto 0);
    signal s_s_axi_lite_arvalid	: std_logic;
    signal s_s_axi_lite_arready	: std_logic;
    signal s_s_axi_lite_rdata	: std_logic_vector(31 downto 0);
    signal s_s_axi_lite_rresp	: std_logic_vector(1 downto 0);
    signal s_s_axi_lite_rvalid	: std_logic;
    signal s_s_axi_lite_rready	: std_logic;

    -- Ports of Axi Slave Bus Interface S_ADC_AXIS
    signal s_s_adc_axis_aclk	: std_logic;
    signal s_s_adc_axis_aresetn	: std_logic;
    signal s_s_adc_axis_tready	: std_logic;
    signal s_s_adc_axis_tdata	: std_logic_vector(31 downto 0);
    signal s_s_adc_axis_tstrb	: std_logic_vector(3 downto 0);
    signal s_s_adc_axis_tlast	: std_logic;
    signal s_s_adc_axis_tvalid	: std_logic;

    -- Ports of Axi Master Bus Interface M_DMA_AXIS
    signal s_m_dma_axis_aclk	: std_logic;
    signal s_m_dma_axis_aresetn	: std_logic;
    signal s_m_dma_axis_tvalid	: std_logic;
    signal s_m_dma_axis_tdata	: std_logic_vector(63 downto 0);
    signal s_m_dma_axis_tstrb	: std_logic_vector(3 downto 0);
    signal s_m_dma_axis_tlast	: std_logic;
    signal s_m_dma_axis_tready	: std_logic;

    -- Ports of Axi Master Bus Interface M_DAC_AXIS
    signal s_m_dac_axis_aclk	: std_logic;
    signal s_m_dac_axis_aresetn	: std_logic;
    signal s_m_dac_axis_tvalid	: std_logic;
    signal s_m_dac_axis_tdata	: std_logic_vector(15 downto 0);
    signal s_m_dac_axis_tstrb	: std_logic_vector(1 downto 0);
    signal s_m_dac_axis_tlast	: std_logic;
    signal s_m_dac_axis_tready	: std_logic;

begin
    s_clk_axi <= not s_clk_axi after g_period_axi / 2;
    s_clk_axis <= not s_clk_axis after g_period_axis / 2;
    
    s_rst_axi <= '1' after 20 ns;
    s_rst_axis <= '1' after 30 ns;
    
    s_s_axi_lite_aclk <= s_clk_axi;
    s_s_adc_axis_aclk <= s_clk_axis;
    s_m_dac_axis_aclk <= s_clk_axis;
    s_m_dma_axis_aclk <= s_clk_axis;
    
    s_s_axi_lite_aresetn <= s_rst_axi;
    s_s_adc_axis_aresetn <= s_rst_axis;
    s_m_dma_axis_aresetn <= s_rst_axis;
    s_m_dac_axis_aresetn <= s_rst_axis;
    
    dut : rri_control_v1_0
        generic map (
		C_S_AXI_LITE_DATA_WIDTH	=> 32,
		C_S_AXI_LITE_ADDR_WIDTH	=> 4,

		-- Parameters of Axi Slave Bus Interface S_ADC_AXIS
		C_S_ADC_AXIS_TDATA_WIDTH => 32,

		-- Parameters of Axi Master Bus Interface M_DMA_AXIS
		C_M_DMA_AXIS_TDATA_WIDTH => 32,

		-- Parameters of Axi Master Bus Interface M_DAC_AXIS
		C_M_DAC_AXIS_TDATA_WIDTH => 16
	)
	port map (		
		-- Ports of Axi Master Bus Interface M_AXIS
		s_axi_lite_aclk	=> s_s_axi_lite_aclk,
		s_axi_lite_aresetn	=> s_s_axi_lite_aresetn,
		s_axi_lite_awaddr	=> s_s_axi_lite_awaddr,
		s_axi_lite_awprot	=> s_s_axi_lite_awprot,
		s_axi_lite_awvalid	=> s_s_axi_lite_awvalid,
		s_axi_lite_awready	=> s_s_axi_lite_awready,
		s_axi_lite_wdata	=> s_s_axi_lite_wdata,
		s_axi_lite_wstrb	=> s_s_axi_lite_wstrb,
		s_axi_lite_wvalid	=> s_s_axi_lite_wvalid,
		s_axi_lite_wready	=> s_s_axi_lite_wready,
		s_axi_lite_bresp	=> s_s_axi_lite_bresp,
		s_axi_lite_bvalid	=> s_s_axi_lite_bvalid,
		s_axi_lite_bready	=> s_s_axi_lite_bready,
		s_axi_lite_araddr	=> s_s_axi_lite_araddr,
		s_axi_lite_arprot	=> s_s_axi_lite_arprot,
		s_axi_lite_arvalid	=> s_s_axi_lite_arvalid,
		s_axi_lite_arready	=> s_s_axi_lite_arready,
		s_axi_lite_rdata	=> s_s_axi_lite_rdata,
		s_axi_lite_rresp	=> s_s_axi_lite_rresp,
		s_axi_lite_rvalid	=> s_s_axi_lite_rvalid,
		s_axi_lite_rready	=> s_s_axi_lite_rready,

		-- Ports of Axi Slave Bus Interface S_ADC_AXIS
		s_adc_axis_aclk	=> s_s_adc_axis_aclk,
		s_adc_axis_aresetn	=> s_s_adc_axis_aresetn,
		s_adc_axis_tready	=> s_s_adc_axis_tready,
		s_adc_axis_tdata	=> s_s_adc_axis_tdata,
		s_adc_axis_tstrb	=> s_s_adc_axis_tstrb,
		s_adc_axis_tlast	=> s_s_adc_axis_tlast,
		s_adc_axis_tvalid	=> s_s_adc_axis_tvalid,

		-- Ports of Axi Master Bus Interface M_DMA_AXIS
		m_dma_axis_aclk	=> s_m_dma_axis_aclk,
		m_dma_axis_aresetn	=> s_m_dma_axis_aresetn,
		m_dma_axis_tvalid	=> s_m_dma_axis_tvalid,
		m_dma_axis_tdata	=> s_m_dma_axis_tdata,
		m_dma_axis_tstrb	=> s_m_dma_axis_tstrb,
		m_dma_axis_tlast	=> s_m_dma_axis_tlast,
		m_dma_axis_tready	=> s_m_dma_axis_tready,

		-- Ports of Axi Master Bus Interface M_DAC_AXIS
		m_dac_axis_aclk	=> s_m_dac_axis_aclk,
		m_dac_axis_aresetn	=> s_m_dac_axis_aresetn,
		m_dac_axis_tvalid	=> s_m_dac_axis_tvalid,
		m_dac_axis_tdata	=> s_m_dac_axis_tdata,
		m_dac_axis_tstrb	=> s_m_dac_axis_tstrb,
		m_dac_axis_tlast	=> s_m_dac_axis_tlast,
		m_dac_axis_tready	=> s_m_dac_axis_tready
	);
	
	p_timeout : process
	begin
		wait for g_timeout;
		assert false report "timeout reached" severity failure;
		stop(1);
	end process;


end Behavioral;