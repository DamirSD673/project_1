library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rri_control_v1_0 is
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
		
		axis_aclk	: in std_logic;

		-- Ports of Axi Slave Bus Interface S_ADC_AXIS
		
		s_adc_axis_aresetn	: in std_logic;
		s_adc_axis_tready	: out std_logic;
		s_adc_axis_tdata	: in std_logic_vector(C_S_ADC_AXIS_TDATA_WIDTH-1 downto 0);
		s_adc_axis_tstrb	: in std_logic_vector((C_S_ADC_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s_adc_axis_tlast	: in std_logic;
		s_adc_axis_tvalid	: in std_logic;

		-- Ports of Axi Master Bus Interface M_DMA_AXIS
		m_dma_axis_aresetn	: in std_logic;
		m_dma_axis_tvalid	: out std_logic;
		m_dma_axis_tdata	: out std_logic_vector(C_M_DMA_AXIS_TDATA_WIDTH-1 downto 0);
		m_dma_axis_tstrb	: out std_logic_vector((C_M_DMA_AXIS_TDATA_WIDTH/8)-1 downto 0);
		m_dma_axis_tlast	: out std_logic;
		m_dma_axis_tready	: in std_logic;

		-- Ports of Axi Master Bus Interface M_DAC_AXIS
		m_dac_axis_aresetn	: in std_logic;
		m_dac_axis_tvalid	: out std_logic;
		m_dac_axis_tdata	: out std_logic_vector(C_M_DAC_AXIS_TDATA_WIDTH-1 downto 0);
		m_dac_axis_tstrb	: out std_logic_vector((C_M_DAC_AXIS_TDATA_WIDTH/8)-1 downto 0);
		m_dac_axis_tlast	: out std_logic;
		m_dac_axis_tready	: in std_logic
	);
end rri_control_v1_0;

architecture arch_imp of rri_control_v1_0 is

	-- component declaration
	component rri_control_v1_0_S_AXI_LITE is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component rri_control_v1_0_S_AXI_LITE;

	component rri_control_v1_0_S_ADC2DMA_AXIS is
		generic (
		C_M_AXIS_TDATA_WIDTH	: integer	:= 32;
		C_S_AXIS_TDATA_WIDTH	: integer	:= 32
		);
		port (
		AXIS_ACLK	: in std_logic;
		M_AXIS_ARESETN	: in std_logic;
		M_AXIS_TVALID	: out std_logic;
		M_AXIS_TDATA	: out std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
		M_AXIS_TSTRB	: out std_logic_vector((C_M_AXIS_TDATA_WIDTH/8)-1 downto 0);
		M_AXIS_TLAST	: out std_logic;
		M_AXIS_TREADY	: in std_logic;
		S_AXIS_ARESETN	: in std_logic;
		S_AXIS_TREADY	: out std_logic;
		S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
		S_AXIS_TSTRB	: in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
		S_AXIS_TLAST	: in std_logic;
		S_AXIS_TVALID	: in std_logic
		);
	end component rri_control_v1_0_S_ADC2DMA_AXIS;

	component rri_control_v1_0_M_DAC_AXIS is
		generic (
		C_DAC_RAM_DATA_WIDTH : integer := 14;
		C_DAC_RAM_ADDR_WIDTH : integer := 13;
		C_M_AXIS_TDATA_WIDTH	: integer	:= 16;
		C_M_START_COUNT	: integer	:= 32
		);
		port (
		M_AXIS_ACLK	: in std_logic;
		M_AXIS_ARESETN	: in std_logic;
		M_AXIS_TVALID	: out std_logic;
		M_AXIS_TDATA	: out std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
		M_AXIS_TREADY	: in std_logic;
		dac_ram_data : in std_logic_vector (C_DAC_RAM_DATA_WIDTH-1 downto 0);
		output_enable : in std_logic
		);
	end component rri_control_v1_0_M_DAC_AXIS;
	
	component dac_block_ram_gen IS
        port (
            clka : in std_logic;
            ena : in std_logic;
            wea : in std_logic_vector(0 DOWNTO 0);
            addra : in std_logic_vector(12 DOWNTO 0);
            dina : in std_logic_vector(13 DOWNTO 0);
            clkb : in std_logic;
            addrb : in std_logic_vector(12 DOWNTO 0);
            doutb : out std_logic_vector(13 DOWNTO 0)
        );
    end component dac_block_ram_gen;
     
    signal dac_ram_data_rd : std_logic_vector (13 downto 0) := (others => '0');
    signal dac_ram_addr_rd : std_logic_vector (12 downto 0) := (others => '0');
    signal dac_ram_data_wrt : std_logic_vector (13 downto 0);
    signal dac_ram_write_ena : std_logic;
    signal dac_ram_addr_wrt : std_logic_vector (12 downto 0);

begin

-- Instantiation of Axi Bus Interface S_AXI_LITE
rri_control_v1_0_S_AXI_LITE_inst : rri_control_v1_0_S_AXI_LITE
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S_AXI_LITE_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S_AXI_LITE_ADDR_WIDTH
	)
	port map (
		S_AXI_ACLK	=> axis_aclk,
		S_AXI_ARESETN	=> s_axi_lite_aresetn,
		S_AXI_AWADDR	=> s_axi_lite_awaddr,
		S_AXI_AWPROT	=> s_axi_lite_awprot,
		S_AXI_AWVALID	=> s_axi_lite_awvalid,
		S_AXI_AWREADY	=> s_axi_lite_awready,
		S_AXI_WDATA	=> s_axi_lite_wdata,
		S_AXI_WSTRB	=> s_axi_lite_wstrb,
		S_AXI_WVALID	=> s_axi_lite_wvalid,
		S_AXI_WREADY	=> s_axi_lite_wready,
		S_AXI_BRESP	=> s_axi_lite_bresp,
		S_AXI_BVALID	=> s_axi_lite_bvalid,
		S_AXI_BREADY	=> s_axi_lite_bready,
		S_AXI_ARADDR	=> s_axi_lite_araddr,
		S_AXI_ARPROT	=> s_axi_lite_arprot,
		S_AXI_ARVALID	=> s_axi_lite_arvalid,
		S_AXI_ARREADY	=> s_axi_lite_arready,
		S_AXI_RDATA	=> s_axi_lite_rdata,
		S_AXI_RRESP	=> s_axi_lite_rresp,
		S_AXI_RVALID	=> s_axi_lite_rvalid,
		S_AXI_RREADY	=> s_axi_lite_rready
	);

-- Instantiation of Axi Bus Interface S_ADC_AXIS
rri_control_v1_0_S_ADC2DMA_AXIS_inst : rri_control_v1_0_S_ADC2DMA_AXIS
	generic map (
	C_M_AXIS_TDATA_WIDTH	=> C_M_DMA_AXIS_TDATA_WIDTH,
		C_S_AXIS_TDATA_WIDTH	=> C_S_ADC_AXIS_TDATA_WIDTH
	)
	port map (
	    AXIS_ACLK	=> axis_aclk,
		M_AXIS_ARESETN	=> m_dma_axis_aresetn,
		M_AXIS_TVALID	=> m_dma_axis_tvalid,
		M_AXIS_TDATA	=> m_dma_axis_tdata,
		M_AXIS_TSTRB	=> m_dma_axis_tstrb,
		M_AXIS_TLAST	=> m_dma_axis_tlast,
		M_AXIS_TREADY	=> m_dma_axis_tready,
		S_AXIS_ARESETN	=> s_adc_axis_aresetn,
		S_AXIS_TREADY	=> s_adc_axis_tready,
		S_AXIS_TDATA	=> s_adc_axis_tdata,
		S_AXIS_TSTRB	=> s_adc_axis_tstrb,
		S_AXIS_TLAST	=> s_adc_axis_tlast,
		S_AXIS_TVALID	=> s_adc_axis_tvalid
	);

-- Instantiation of Axi Bus Interface M_DAC_AXIS
rri_control_v1_0_M_DAC_AXIS_inst : rri_control_v1_0_M_DAC_AXIS
	generic map (
	    C_DAC_RAM_DATA_WIDTH => 14,
		C_DAC_RAM_ADDR_WIDTH => 13,
		C_M_AXIS_TDATA_WIDTH	=> C_M_DAC_AXIS_TDATA_WIDTH,
		C_M_START_COUNT	=> C_M_DAC_AXIS_START_COUNT
	)
	port map (
		M_AXIS_ACLK	=> axis_aclk,
		M_AXIS_ARESETN	=> m_dac_axis_aresetn,
		M_AXIS_TVALID	=> m_dac_axis_tvalid,
		M_AXIS_TDATA	=> m_dac_axis_tdata,
		M_AXIS_TREADY	=> m_dac_axis_tready,		
		dac_ram_data => dac_ram_data_rd,
		output_enable => '1'
	);
	
	

	-- Add user logic here
	
    dac_block_ram_inst : dac_block_ram_gen
    port map (
        clka => axis_aclk,
        clkb => axis_aclk,
        wea(0) => dac_ram_write_ena,
        ena => '1',
        addra => dac_ram_addr_wrt,
        addrb => dac_ram_addr_rd,
        dina => dac_ram_data_rd,
        doutb => dac_ram_data_rd
    );

	-- User logic ends

end arch_imp;
