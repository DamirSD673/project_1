library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity red_pitaya_analog_interface_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line
		C_ADC_DATA_WIDTH : integer	:= 16;
        C_DAC_DATA_WIDTH : integer	:= 14;

		-- Parameters of Axi Slave Bus Interface DAC_AXIS
		C_DAC_AXIS_TDATA_WIDTH	: integer	:= 32;

		-- Parameters of Axi Master Bus Interface ADC_AXIS
		C_ADC_AXIS_TDATA_WIDTH	: integer	:= 32
	);
	port (
		-- Users to add ports here
		adc_clk_p : in std_logic;
		adc_clk_n : in std_logic;
		
		adc_data_a : in std_logic_vector(C_ADC_DATA_WIDTH-1 downto 0);
		adc_data_b : in std_logic_vector(C_ADC_DATA_WIDTH-1 downto 0);
		
		adc_csn : out std_logic;
		
		-- DAC Ports
		dac_clk : out std_logic;
		dac_rst : out std_logic;
		dac_sel : out std_logic;
		dac_wrt : out std_logic;
		dac_data : out std_logic_vector(C_DAC_DATA_WIDTH-1 downto 0);
		

		-- User ports ends
		-- Do not modify the ports beyond this line


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
end red_pitaya_analog_interface_v1_0;

architecture arch_imp of red_pitaya_analog_interface_v1_0 is

	-- component declaration
	component red_pitaya_analog_interface_v1_0_DAC_AXIS is
		generic (
		C_DAC_DATA_WIDTH : integer	:= 14;
		C_S_AXIS_TDATA_WIDTH	: integer	:= 32
		);
		port (
		aclk : in std_logic;
		ddr_clk : in std_logic;
		wrt_clk : in std_logic;
		locked : in std_logic;
		dac_clk : out std_logic;
		dac_rst : out std_logic;
		dac_sel : out std_logic;
		dac_wrt : out std_logic;
		dac_data : out std_logic_vector(C_DAC_DATA_WIDTH-1 downto 0);
		S_AXIS_ACLK	: in std_logic;
		S_AXIS_ARESETN	: in std_logic;
		S_AXIS_TREADY	: out std_logic;
		S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
		S_AXIS_TVALID	: in std_logic
		);
	end component red_pitaya_analog_interface_v1_0_DAC_AXIS;

	component red_pitaya_analog_interface_v1_0_ADC_AXIS is
		generic (
		C_ADC_DATA_WIDTH : integer := 16;
		C_M_AXIS_TDATA_WIDTH	: integer	:= 32
		);
		port (
		ADC_DATA_A : in std_logic_vector(C_ADC_DATA_WIDTH-1 downto 0);
		ADC_DATA_B : in std_logic_vector(C_ADC_DATA_WIDTH-1 downto 0);
		ADC_CSN : out std_logic;
		PLL_LOCKED : in std_logic;
		M_AXIS_ACLK	: in std_logic;
		M_AXIS_ARESETN	: in std_logic;
		M_AXIS_TVALID	: out std_logic;
		M_AXIS_TDATA	: out std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
		M_AXIS_TREADY	: in std_logic
		);
	end component red_pitaya_analog_interface_v1_0_ADC_AXIS;
	
	signal adc_clock_in : std_logic;
	signal pll_locked : std_logic;
	signal aclk : std_logic;
	signal ddr_clk: std_logic;
	signal iqclk: std_logic;
	signal clkfbout : std_logic;

begin

-- Instantiation of Axi Bus Interface DAC_AXIS
red_pitaya_analog_interface_v1_0_DAC_AXIS_inst : red_pitaya_analog_interface_v1_0_DAC_AXIS
	generic map (
		C_S_AXIS_TDATA_WIDTH	=> C_DAC_AXIS_TDATA_WIDTH
	)
	port map (	
	    aclk => aclk,
		ddr_clk => ddr_clk,
		wrt_clk => iqclk,
		locked => pll_locked,
	    dac_clk => dac_clk,
		dac_rst => dac_rst,
		dac_sel => dac_sel,
		dac_wrt => dac_wrt,
		dac_data => dac_data,
		S_AXIS_ACLK	=> dac_axis_aclk,
		S_AXIS_ARESETN	=> dac_axis_aresetn,
		S_AXIS_TREADY	=> dac_axis_tready,
		S_AXIS_TDATA	=> dac_axis_tdata,
		S_AXIS_TVALID	=> dac_axis_tvalid
	);

-- Instantiation of Axi Bus Interface ADC_AXIS
red_pitaya_analog_interface_v1_0_ADC_AXIS_inst : red_pitaya_analog_interface_v1_0_ADC_AXIS
	generic map (
	    C_ADC_DATA_WIDTH => 16,
		C_M_AXIS_TDATA_WIDTH	=> C_ADC_AXIS_TDATA_WIDTH
	)
	port map (
	    ADC_DATA_A => adc_data_a,
	    ADC_DATA_B =>adc_data_b,
	    ADC_CSN => adc_csn,
	    PLL_LOCKED => pll_locked,
		M_AXIS_ACLK	=> aclk,
		M_AXIS_ARESETN	=> adc_axis_aresetn,
		M_AXIS_TVALID	=> adc_axis_tvalid,
		M_AXIS_TDATA	=> adc_axis_tdata,
		M_AXIS_TREADY	=> adc_axis_tready
	);

	-- Add user logic here
	
	adc_IBUFGDS_inst : IBUFGDS
    generic map (
        DIFF_TERM => TRUE, -- Differential Termination
        IBUF_LOW_PWR => FALSE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
        IOSTANDARD => "DIFF_HSTL_II")
    port map (
        O => adc_clock_in, -- Clock buffer output
        I => adc_clk_p, -- Diff_p clock buffer input (connect directly to top-level port)
        IB => adc_clk_n -- Diff_n clock buffer input (connect directly to top-level port)
    );
	
	PLLE2_BASE_inst : PLLE2_BASE
    generic map (
        BANDWIDTH => "OPTIMIZED",  -- OPTIMIZED, HIGH, LOW
        CLKFBOUT_MULT => 8,        -- Multiply value for all CLKOUT, (2-64)
        CLKFBOUT_PHASE => 0.0,     -- Phase offset in degrees of CLKFB, (-360.000-360.000).
        CLKIN1_PERIOD => 8.0,      -- Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
        -- CLKOUT0_DIVIDE - CLKOUT5_DIVIDE: Divide amount for each CLKOUT (1-128)
        CLKOUT0_DIVIDE => 8,
        CLKOUT1_DIVIDE => 4,
        CLKOUT2_DIVIDE => 4,
        -- CLKOUT0_DUTY_CYCLE - CLKOUT5_DUTY_CYCLE: Duty cycle for each CLKOUT (0.001-0.999).
        CLKOUT0_DUTY_CYCLE => 0.5,
        CLKOUT1_DUTY_CYCLE => 0.5,
        CLKOUT2_DUTY_CYCLE => 0.5,
        -- CLKOUT0_PHASE - CLKOUT5_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
        CLKOUT0_PHASE => 0.0,
        CLKOUT1_PHASE => 157.5,
        CLKOUT2_PHASE => 202.5,
        DIVCLK_DIVIDE => 1,        -- Master division value, (1-56)
        REF_JITTER1 => 0.01,        -- Reference input jitter in UI, (0.000-0.999).
        STARTUP_WAIT => "TRUE"    -- Delay DONE until PLL Locks, ("TRUE"/"FALSE")
    )
    port map (
        -- Clock Outputs: 1-bit (each) output: User configurable clock outputs
        CLKOUT0 => aclk,   -- 1-bit output: CLKOUT0
        CLKOUT1 => ddr_clk,   -- 1-bit output: CLKOUT1
        CLKOUT2 => iqclk,   -- 1-bit output: CLKOUT2
        -- Feedback Clocks: 1-bit (each) output: Clock feedback ports
        clkfbin  => clkfbout,
        clkfbout => clkfbout,
        pwrdwn   => '0',
        LOCKED => pll_locked,     -- 1-bit output: LOCK
        CLKIN1 => adc_clock_in,     -- 1-bit input: Input clock
        -- Control Ports: 1-bit (each) input: PLL control ports
        RST => '0'           -- 1-bit input: Reset
   );
   
   adc_axis_aclk <= aclk;

	-- User logic ends

end arch_imp;
