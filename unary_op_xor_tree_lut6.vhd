library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity XorTreeStage is
	generic (N : natural);
	port(	I: in std_logic_vector(N - 1 downto 0);	-- vhodni vektor redukcije ima N vhodov
			O: out std_logic);	-- izhodni bit redukcije
end XorTreeStage;

library unisim;
use unisim.vcomponents.all;

architecture tree_of_xor_lut6 of XorTreeStage is

component XorTreeStage
	generic (N : natural);
	port(	I: in std_logic_vector(N - 1 downto 0);	-- vhodni vektor redukcije ima N vhodov
			O: out std_logic);	-- izhodni bit redukcije
end component;

begin
	--Stage 1
	Stage_Xor_1: if I'length = 1 generate
		O <= I(0);
	end generate Stage_Xor_1;
	
	--Stage 2
	Stage_Xor_2: if I'length = 2 generate
		O <= I(0) xor I(1);
	end generate Stage_Xor_2;
	
	--Stage 3
	Stage_Xor_3: if I'length = 3 generate
		XOR3_LUT3: LUT3
		generic map (INIT => X"96")
		port map(
			O => O,
			I0 => I(0),
			I1 => I(1),
			I2 => I(2)
		);
	end generate Stage_Xor_3;

	--Stage 4
	Stage_Xor_4: if I'length = 4 generate
		XOR4_LUT4: LUT4
		generic map (INIT => X"6996")
		port map(
			O => O,
			I0 => I(0),
			I1 => I(1),
			I2 => I(2),
			I3 => I(3)
		);
	end generate Stage_Xor_4;

	--Stage 5
	Stage_Xor_5: if I'length = 5 generate
		XOR5_LUT5: LUT5
		generic map (INIT => X"9669_6996")
		port map(
			O => O,
			I0 => I(0),
			I1 => I(1),
			I2 => I(2),
			I3 => I(3),
			I4 => I(4)
		);
	end generate Stage_Xor_5;

	--Stage 6
	Stage_Xor_6: if I'length = 6 generate
		XOR6_LUT6: LUT6
		generic map (INIT => X"6996_9669_9669_6996")
		port map (
			O => O,
			I0 => I(0),
			I1 => I(1),
			I2 => I(2),
			I3 => I(3),
			I4 => I(4),
			I5 => I(5)
		);
	end generate Stage_Xor_6;
	
	--Stage >6
	Stages: if I'length > 6 generate
		signal Xor_1, Xor_2, Xor_3, Xor_4, Xor_5, Xor_6: std_logic;
		signal Sixth1_in : std_logic_vector(I'length - 1 downto I'length * 5 / 6);
		signal Sixth2_in : std_logic_vector(I'length * 5 / 6 - 1 downto I'length * 4 / 6);
		signal Sixth3_in : std_logic_vector(I'length * 4 / 6 - 1 downto I'length * 3 / 6);
		signal Sixth4_in : std_logic_vector(I'length * 3 / 6 - 1 downto I'length * 2 / 6);
		signal Sixth5_in : std_logic_vector(I'length * 2 / 6 - 1 downto I'length / 6);
		signal Sixth6_in : std_logic_vector(I'length / 6 - 1 downto 0);
	begin
		Sixth1_in <= I(I'length - 1 downto I'length * 5 / 6);
		Sixth2_in <= I(I'length * 5 / 6 - 1 downto I'length * 4 / 6);
		Sixth3_in <= I(I'length * 4 / 6 - 1 downto I'length * 3 / 6);
		Sixth4_in <= I(I'length * 3 / 6 - 1 downto I'length * 2 / 6);
		Sixth5_in <= I(I'length * 2 / 6 - 1 downto I'length / 6);
		Sixth6_in <= I(I'length / 6 - 1 downto 0);
		
		Sixth1: XorTreeStage generic map (Sixth1_in'length) port map (Sixth1_in, Xor_1);
		Sixth2: XorTreeStage generic map (Sixth2_in'length) port map (Sixth2_in, Xor_2);
		Sixth3: XorTreeStage generic map (Sixth3_in'length) port map (Sixth3_in, Xor_3);
		Sixth4: XorTreeStage generic map (Sixth4_in'length) port map (Sixth4_in, Xor_4);
		Sixth5: XorTreeStage generic map (Sixth5_in'length) port map (Sixth5_in, Xor_5);
		Sixth6: XorTreeStage generic map (Sixth6_in'length) port map (Sixth6_in, Xor_6);
		
		XOR6_LUT6: LUT6
		generic map (INIT => X"6996_9669_9669_6996")
		port map (
			O => O,
			I0 => Xor_1,
			I1 => Xor_2,
			I2 => Xor_3,
			I3 => Xor_4,
			I4 => Xor_5,
			I5 => Xor_6
		);
	end generate Stages;
	
end tree_of_xor_lut6;