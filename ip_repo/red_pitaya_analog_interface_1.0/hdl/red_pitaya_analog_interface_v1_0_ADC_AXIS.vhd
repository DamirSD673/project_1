library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity red_pitaya_analog_interface_v1_0_ADC_AXIS is
	generic (
		-- Users to add parameters here
		C_ADC_DATA_WIDTH : integer := 16;

		-- User parameters ends
		-- Do not modify the parameters beyond this line

		-- Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
		C_M_AXIS_TDATA_WIDTH	: integer	:= 32
	);
	port (
		-- Users to add ports here
		ADC_DATA_A : in std_logic_vector(C_ADC_DATA_WIDTH-1 downto 0);
		--
		ADC_DATA_B : in std_logic_vector(C_ADC_DATA_WIDTH-1 downto 0);
		
		ADC_CSN : out std_logic;
		
		PLL_LOCKED : in std_logic;

		-- User ports ends
		-- Do not modify the ports beyond this line

		-- Global ports
		M_AXIS_ACLK	: in std_logic;
		-- 
		M_AXIS_ARESETN	: in std_logic;
		-- Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted. 
		M_AXIS_TVALID	: out std_logic;
		-- TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
		M_AXIS_TDATA	: out std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
		-- TREADY indicates that the slave can accept a transfer in the current cycle.
		M_AXIS_TREADY	: in std_logic
	);
end red_pitaya_analog_interface_v1_0_ADC_AXIS;

architecture implementation of red_pitaya_analog_interface_v1_0_ADC_AXIS is
	-- AXI Stream internal signals
	--streaming data valid
	signal axis_tvalid	: std_logic := '0';
	--FIFO implementation signals
	signal stream_data_out	: std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0) := (others => '0');

begin
	-- I/O Connections assignments

	M_AXIS_TVALID	<= axis_tvalid;
	M_AXIS_TDATA	<= stream_data_out;
	                                                       

	-- Add user logic here
	
	process(M_AXIS_ACLK)                                                          
	  variable  sig_one : integer := 1;                                             
	  begin                                                                         
	    if (rising_edge (M_AXIS_ACLK)) then                                         
	      if ((M_AXIS_ARESETN = '0') or (PLL_LOCKED = '0')) then                                             
	    	stream_data_out <= (others => '0');
	    	axis_tvalid <= '0';
	      else                    
	        stream_data_out <= ADC_DATA_A & ADC_DATA_B;
	        axis_tvalid <= '1';
	      end if;                                                                   
	    end if;                                                                    
	  end process;
	   
	ADC_CSN <= '1';

	-- User logic ends

end implementation;
