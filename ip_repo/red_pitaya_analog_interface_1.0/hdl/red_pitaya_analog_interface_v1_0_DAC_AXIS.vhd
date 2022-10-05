library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;

entity red_pitaya_analog_interface_v1_0_DAC_AXIS is
	generic (
		-- Users to add parameters here
		C_DAC_DATA_WIDTH : integer	:= 14;

		-- User parameters ends
		-- Do not modify the parameters beyond this line

		-- AXI4Stream sink: Data Width
		C_S_AXIS_TDATA_WIDTH	: integer	:= 32
	);
	port (
		-- Users to add ports here
		aclk : in std_logic;
		ddr_clk : in std_logic;
		wrt_clk : in std_logic;
		locked : in std_logic;
		 
		dac_clk : out std_logic;
		dac_rst : out std_logic;
		dac_sel : out std_logic;
		dac_wrt : out std_logic;
		dac_data : out std_logic_vector(C_DAC_DATA_WIDTH-1 downto 0);

		-- User ports ends
		-- Do not modify the ports beyond this line

		-- AXI4Stream sink: Clock
		S_AXIS_ACLK	: in std_logic;
		-- AXI4Stream sink: Reset
		S_AXIS_ARESETN	: in std_logic;
		-- Ready to accept data in
		S_AXIS_TREADY	: out std_logic;
		-- Data in
		S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
		-- Data is in valid
		S_AXIS_TVALID	: in std_logic
	);
end red_pitaya_analog_interface_v1_0_DAC_AXIS;

architecture arch_imp of red_pitaya_analog_interface_v1_0_DAC_AXIS is
	-- function called clogb2 that returns an integer which has the 
	-- value of the ceiling of the log base 2.

	signal axis_tready	: std_logic := '0';
	
	signal dac_data_a_input_reg : std_logic_vector(C_S_AXIS_TDATA_WIDTH/2-1 downto 0) := (others => '0');
	signal dac_data_b_input_reg : std_logic_vector(C_S_AXIS_TDATA_WIDTH/2-1 downto 0) := (others => '0');
	
	signal dac_data_a_int_reg : std_logic_vector(C_S_AXIS_TDATA_WIDTH/2-1 downto 0) := (others => '0');
	signal dac_data_b_int_reg : std_logic_vector(C_S_AXIS_TDATA_WIDTH/2-1 downto 0) := (others => '0');
	
	signal dac_data_a_limit_reg : std_logic_vector(C_DAC_DATA_WIDTH-1 downto 0) := (others => '0');
	signal dac_data_b_limit_reg : std_logic_vector(C_DAC_DATA_WIDTH-1 downto 0) := (others => '0');
	
	signal int_reset_reg : std_logic := '1';
	-- State variable
begin
	-- I/O Connections assignments

	S_AXIS_TREADY	<= axis_tready;
	
	process(S_AXIS_ACLK)                                                                        
	begin                                                                                     
	  if (rising_edge (S_AXIS_ACLK)) then
	       dac_data_a_input_reg <= S_AXIS_TDATA(C_S_AXIS_TDATA_WIDTH/2-1 downto 0);
	       dac_data_b_input_reg <= S_AXIS_TDATA((C_S_AXIS_TDATA_WIDTH-1) downto (C_S_AXIS_TDATA_WIDTH/2));
	  end if;
	end process;
	
	process(aclk)
	begin
	   if rising_edge (aclk) then
	       if ((locked = '0') or (S_AXIS_TVALID = '0')) then
	           int_reset_reg <= '1';
	           dac_data_a_int_reg <= (others => '0');
	           dac_data_b_int_reg <= (others => '0');
	       else
	           int_reset_reg <= '0';
	           dac_data_a_int_reg <= dac_data_a_input_reg;
	           dac_data_b_int_reg <= dac_data_b_input_reg;
	           -- Channel A
	           if (dac_data_a_int_reg(15) = '1') then
                   if (signed(dac_data_a_int_reg) < -8192) then
                        dac_data_a_limit_reg <= (others => '0');
                   else
                        dac_data_a_limit_reg(13) <= '0';
                        dac_data_a_limit_reg(12 downto 0) <= dac_data_a_int_reg(12 downto 0);
                   end if;
               else
                   if (signed(dac_data_a_int_reg) > 8191) then
                        dac_data_a_limit_reg <= (others => '1');
                   else
                        dac_data_a_limit_reg(13) <= '1';
                        dac_data_a_limit_reg(12 downto 0) <= dac_data_a_int_reg(12 downto 0);
                   end if;
               end if;
               
               -- Channel B
	           if (dac_data_b_int_reg(15) = '1') then
                   if (signed(dac_data_b_int_reg) < -8192) then
                        dac_data_b_limit_reg <= (others => '0');
                   else
                        dac_data_b_limit_reg(13) <= '0';
                        dac_data_b_limit_reg(12 downto 0) <= dac_data_b_int_reg(12 downto 0);
                   end if;
               else
                   if (signed(dac_data_b_int_reg) > 8191) then
                        dac_data_b_limit_reg <= (others => '1');
                   else
                        dac_data_b_limit_reg(13) <= '1';
                        dac_data_b_limit_reg(12 downto 0) <= dac_data_b_int_reg(12 downto 0);
                   end if;
               end if;
	       end if;
	   end if;
	end process;
	
	process(aclk)
	begin
	   if rising_edge (aclk) then
	       axis_tready <= locked;
	   end if;
	end process;
	
	
	
	ODDR_dac_rst_inst : ODDR
    generic map(
        DDR_CLK_EDGE => "SAME_EDGE", -- "OPPOSITE_EDGE" or "SAME_EDGE"
        INIT => '0')   -- Initial value for Q port ('1' or '0')
    port map (
        Q => dac_rst,   -- 1-bit DDR output
        C => aclk,    -- 1-bit clock input
        CE => '1',  -- 1-bit clock enable input
        D1 => int_reset_reg,  -- 1-bit data input (positive edge)
        D2 => int_reset_reg,  -- 1-bit data input (negative edge)
        R => '0',    -- 1-bit reset input
        S => '0'     -- 1-bit set input
    );
    
    ODDR_dac_sel_inst : ODDR
    generic map(
        DDR_CLK_EDGE => "SAME_EDGE", -- "OPPOSITE_EDGE" or "SAME_EDGE"
        INIT => '0')   -- Initial value for Q port ('1' or '0')
    port map (
        Q => dac_sel,   -- 1-bit DDR output
        C => aclk,    -- 1-bit clock input
        CE => '1',  -- 1-bit clock enable input
        D1 => '1',  -- 1-bit data input (positive edge)
        D2 => '0',  -- 1-bit data input (negative edge)
        R => '0',    -- 1-bit reset input
        S => '0'     -- 1-bit set input
    );
	
	ODDR_dac_clk_inst : ODDR
    generic map(
        DDR_CLK_EDGE => "SAME_EDGE", -- "OPPOSITE_EDGE" or "SAME_EDGE"
        INIT => '0')   -- Initial value for Q port ('1' or '0')
    port map (
        Q => dac_clk,   -- 1-bit DDR output
        C => ddr_clk,    -- 1-bit clock input
        CE => '1',  -- 1-bit clock enable input
        D1 => '1',  -- 1-bit data input (positive edge)
        D2 => '0',  -- 1-bit data input (negative edge)
        R => '0',    -- 1-bit reset input
        S => '0'     -- 1-bit set input
    );
    
    ODDR_dac_wrt_inst : ODDR
    generic map(
        DDR_CLK_EDGE => "SAME_EDGE", -- "OPPOSITE_EDGE" or "SAME_EDGE"
        INIT => '0')   -- Initial value for Q port ('1' or '0')
    port map (
        Q => dac_wrt,   -- 1-bit DDR output
        C => wrt_clk,    -- 1-bit clock input
        CE => '1',  -- 1-bit clock enable input
        D1 => '1',  -- 1-bit data input (positive edge)
        D2 => '0',  -- 1-bit data input (negative edge)
        R => '0',    -- 1-bit reset input
        S => '0'     -- 1-bit set input
    );
    
     GEN_ODDR_1 : for ODDR_I in 0 to C_DAC_DATA_WIDTH-1 generate
         ODDR_data : ODDR 
         generic map(
            DDR_CLK_EDGE => "SAME_EDGE", -- "OPPOSITE_EDGE" or "SAME_EDGE"
            INIT => '0')   -- Initial value for Q port ('1' or '0')
         port map (
            Q => dac_data(ODDR_I),   -- 1-bit DDR output
            C => aclk,    -- 1-bit clock input
            CE => '1',  -- 1-bit clock enable input
            D1 => dac_data_b_limit_reg(ODDR_I),  -- 1-bit data input (positive edge)
            D2 => dac_data_a_limit_reg(ODDR_I),  -- 1-bit data input (negative edge)
            R => '0',    -- 1-bit reset input
            S => '0'     -- 1-bit set input
         );
     end generate;


	

end arch_imp;
