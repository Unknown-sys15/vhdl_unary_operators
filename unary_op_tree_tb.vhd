library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Unary_Op_Bin_Tree_tb is
generic (	N: natural := 16 );
end Unary_Op_Bin_Tree_tb;

architecture test of Unary_Op_Bin_Tree_tb is

	component Unary_Op_Bin_Tree IS
	generic (N : natural := 64);
	port (	I : std_logic_vector(N - 1 downto 0);
				O_Xor : OUT std_logic);
	END component;

	constant ZERO : std_logic_vector(N-1 DOWNTO 0) := (others => '0');	-- vsi elementi na 0

	signal I : std_logic_vector (N-1 DOWNTO 0) := ZERO;
	signal O_Xor : STD_LOGIC;
			
begin
	UUT: Unary_Op_Bin_Tree
	generic map ( N )
	port map (I, O_Xor);
	
	stim_proc: process
	variable O_Comp : std_logic;
	begin
		--Generate inputs for UUT
		for idx in 0 to 2**N - 1 loop
			I <= std_logic_vector(to_unsigned(idx, I'length));
			wait for 50 ns;
		end loop;
		wait;
	end process;
end test;