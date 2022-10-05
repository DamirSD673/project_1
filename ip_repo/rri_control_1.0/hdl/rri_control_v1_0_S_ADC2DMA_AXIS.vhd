library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rri_control_v1_0_S_ADC2DMA_AXIS is
	generic (
		-- Users to add parameters here

        -- DMA DATA Width		
		C_M_AXIS_TDATA_WIDTH	: integer	:= 64;

		-- AXI4Stream sink: Data Width
		C_S_AXIS_TDATA_WIDTH	: integer	:= 32
		
	);
	port (
		-- Users to add ports here
		dma_output_enable : in std_logic;
		
		dma_last_value : in std_logic;

		-- AXI4Stream Clock
		AXIS_ACLK	: in std_logic;
		-- AXI4Stream sink: Reset
		S_AXIS_ARESETN	: in std_logic;
		-- Ready to accept data in
		S_AXIS_TREADY	: out std_logic;
		-- Data in
		S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
		-- Byte qualifier
		S_AXIS_TSTRB	: in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
		-- Indicates boundary of last packet
		S_AXIS_TLAST	: in std_logic;
		-- Data is in valid
		S_AXIS_TVALID	: in std_logic;
		
		M_AXIS_ARESETN	: in std_logic;
		-- Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted. 
		M_AXIS_TVALID	: out std_logic;
		-- TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
		M_AXIS_TDATA	: out std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
		-- TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
		M_AXIS_TSTRB	: out std_logic_vector((C_M_AXIS_TDATA_WIDTH/8)-1 downto 0);
		-- TLAST indicates the boundary of a packet.
		M_AXIS_TLAST	: out std_logic;
		-- TREADY indicates that the slave can accept a transfer in the current cycle.
		M_AXIS_TREADY	: in std_logic
	);
end rri_control_v1_0_S_ADC2DMA_AXIS;

architecture arch_imp of rri_control_v1_0_S_ADC2DMA_AXIS is
	-- Total number of input data.
	constant NUMBER_OF_INPUT_WORDS  : integer := 8;
	-- bit_num gives the minimum number of bits needed to address 'NUMBER_OF_INPUT_WORDS' size of FIFO.
	-- Define the states of state machine
	-- The control state machine oversees the writing of input streaming data to the FIFO,
	-- and outputs the streaming data from the FIFO
	type state is ( IDLE,        -- This is the initial/idle state 
	                WRITE_FIFO); -- In this state FIFO is written with the
	                             -- input stream data S_AXIS_TDATA 
	signal axis_tready	: std_logic;
	-- State variable
	signal  mst_exec_state : state;  
	-- FIFO implementation signals
	signal  data_in_reg: std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
	
	signal data_counter : integer range 0 to 3;
	
	signal dma_data_valid : std_logic;
	signal dma_data_last : std_logic;
	signal dma_data : std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
	
	signal dma_enable_delay : std_logic := '0';
	
	signal write_enable : std_logic := '0';
	
begin
	-- I/O Connections assignments
	M_AXIS_TDATA <= dma_data;
	M_AXIS_TVALID <= dma_data_valid;
	M_AXIS_TLAST <= dma_data_last;
	

	S_AXIS_TREADY	<= axis_tready;
	
	process (AXIS_ACLK)
	begin
	  if rising_edge(AXIS_ACLK) then 
	    if S_AXIS_ARESETN = '0' then
	      data_counter <= 0;
	      dma_enable_delay <= '0';
	    else
	       dma_enable_delay <= dma_output_enable;
	       if (dma_output_enable = '1') then
	           case data_counter is
	               when 0 =>
	                   data_in_reg(15 downto 0) <= S_AXIS_TDATA(15 downto 0);
	               when 1 =>
	                   data_in_reg(31 downto 16) <= S_AXIS_TDATA(15 downto 0);
	               when 2 =>
	                   data_in_reg(47 downto 32) <= S_AXIS_TDATA(15 downto 0);
	               when 3 =>
	                   data_in_reg(47 downto 32) <= S_AXIS_TDATA(15 downto 0);
	           end case;
	           data_counter <= data_counter+1;
	       else
	           data_counter <= 0;
	       end if;
	    end if;
	  end if;
	end process;
	
	process (AXIS_ACLK)
	begin
	  if rising_edge(AXIS_ACLK) then 
	    if S_AXIS_ARESETN = '0' then
	      write_enable <= '0';
	    else
	       if (dma_last_value='0' and dma_output_enable='0' and dma_enable_delay = '1') or (dma_last_value='0' and dma_output_enable='1' and dma_enable_delay = '1' and data_counter=3) or (dma_last_value='1' and dma_output_enable='1' and dma_enable_delay = '1' ) then
	           write_enable <= '1';
	       else
	           write_enable <= '0';
	       end if;
	    end if;
	  end if;
	end process;
	

end arch_imp;
