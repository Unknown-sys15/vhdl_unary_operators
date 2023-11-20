library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reduction_operators_tb is
generic (	N: natural := 3 );
end reduction_operators_tb;

architecture test of reduction_operators_tb is
	--declare UUT component
	component reduction_operators is
		generic(
			-- Define the generics of the DUT
			-- For example: parameters or configurations
			N:natural := 10
		);
		port(
			-- Define the ports of the DUT
			-- For example: input signals, output signals
			A: in std_logic_vector (N-1 downto 0);
			reduced_OR, reduced_AND, reduced_XOR: out std_logic
		);
	end component;
	
	--deklaracija konstant in signalov
	constant bin0: std_logic_vector(N-1 downto 0) := (				others => '0');
	constant bin1: std_logic_vector(N-1 downto 0) := (0=>'1'		,others => '0');
	constant bin2: std_logic_vector(N-1 downto 0) := (1=>'1'		,others => '0');
	constant bin3: std_logic_vector(N-1 downto 0) := (0|1=>'1'	,others => '0');
	constant bin4: std_logic_vector(N-1 downto 0) := (2=>'1'		,others => '0');
	constant bin5: std_logic_vector(N-1 downto 0) := (0|2=>'1'	,others => '0');
	constant bin6: std_logic_vector(N-1 downto 0) := (1|2=>'1'	,others => '0');
	constant bin7: std_logic_vector(N-1 downto 0) := (0|1|2=>'1',others => '0');
	
	signal A: std_logic_vector (N-1 downto 0);
	signal reduced_OR, reduced_AND, reduced_XOR: std_logic;
	
begin
	-- Instantiate the UUT
  UUT: reduction_operators
	 generic map (N => N)
    port map (
      A => A,
      reduced_OR => reduced_OR,
		reduced_AND => reduced_AND,
		reduced_XOR => reduced_XOR
    );
	 
	stim_proc: process
	begin
		A <= bin0;
		wait for 150 ns;
		A <= bin1;
		wait for 50 ns;
		A <= bin2;
		wait for 100 ns;
		--A <= bin3;
		--wait for 0 ns;
		A <= bin4;
		wait for 50 ns;
		A <= bin5;
		wait for 50 ns;
		A <= bin6;
		wait for 50 ns;
		A <= bin7;
		wait;
	end process;
	
end test;