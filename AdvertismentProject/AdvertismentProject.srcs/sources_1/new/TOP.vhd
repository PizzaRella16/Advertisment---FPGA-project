library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TOP is
    Port (
            ANODE:    out STD_LOGIC_VECTOR (3 downto 0);
            CATODE:   out STD_LOGIC_VECTOR (6 downto 0);
            CLK:       in STD_LOGIC;
            SEL:       in STD_LOGIC_VECTOR (1 downto 0);
            START:     in STD_LOGIC;
            RST:       in STD_LOGIC;
            EasterEgg: in STD_LOGIC_VECTOR (3 downto 0)
            );
end TOP;

architecture ARHI of TOP is
    signal refresh_counter : unsigned(27 downto 0) := (others => '0');
    signal shift_counter   : unsigned(4 downto 0) := (others => '0');
    signal shift_egg_counter: unsigned(22 downto 0) := (others => '0');
    signal shift_timer     : unsigned(25 downto 0) := (others => '0');
    signal digit_index     : unsigned(1 downto 0);         
    signal blink           : STD_LOGIC;
    signal shift_slide     : STD_LOGIC;
    signal shift_index     : integer range 0 to 15;
    signal shift_egg_index : integer range 0 to 50;
    --ptr o secunta, basys 3 are clock de 100Mhz, foloseste o constanta ca sa modificam valoarea

type alphabetMemory is array (37 downto 0) of std_logic_vector (6 downto 0);
constant alphabet: alphabetMemory :=(
    0  => "0000001", -- 0
    1  => "1001111", -- 1
    2  => "0010010", -- 2
    3  => "0000110", -- 3
    4  => "1101100", -- 4
    5  => "0100100", -- 5
    6  => "0100000", -- 6
    7  => "0001111", -- 7
    8  => "0000000", -- 8
    9  => "0000100", -- 9
    10 => "0001000", -- A
    11 => "0011111", -- B
    12 => "1110010", -- C 
    13 => "1000010", -- D
    14 => "0110000", -- E
    15 => "0111000", -- F
    16 => "0100001", -- G
    17 => "1101000", -- H 
    18 => "1111001", -- I
    19 => "1000111", -- J
    20 => "0101000", -- K
    21 => "1110001", -- L
    22 => "0101010", -- M
    23 => "1101010", -- N 
    24 => "1100010", -- O
    25 => "0011000", -- P
    26 => "0001100", -- Q 
    27 => "1111010", -- R
    28 => "0100100", -- S
    29 => "1110000", -- T 
    30 => "1000001", -- U
    31 => "1010101", -- V 
    32 => "1010100", -- W
    33 => "1001000", -- X
    34 => "1001100", -- Y
    35 => "0010011", -- Z
    36 => "1111110", -- -
    37 => "1111111"  -- blank space 
);

type startMemory is array (3 downto 0) of std_logic_vector (6 downto 0);
constant startAnimation: startMemory :=(
    0  => alphabet(24), -- O
    1  => alphabet(10), -- A
    2  => alphabet(23), -- N
    3  => alphabet(10)  -- A
);

type shiftMemory is array (7 downto 0) of std_logic_vector (6 downto 0);
constant shiftAnimation: shiftMemory :=(
    0  => alphabet(37), --
    1  => alphabet(37), -- 
    2  => alphabet(37), --
    3  => alphabet(37), --
    
    4  => alphabet(10), -- A
    5  => alphabet(23), -- N
    6  => alphabet(10), -- A
    7  => alphabet(24)  -- O
);

type shiftMemory2 is array (7 downto 0) of std_logic_vector (6 downto 0);
constant shiftAnimation2: shiftMemory2 :=(
    0  => alphabet(37), --
    1  => alphabet(37), -- 
    2  => alphabet(37), --
    3  => alphabet(37), --
    
    4  => alphabet(24), -- O
    5  => alphabet(10), -- A
    6  => alphabet(23), -- N
    7  => alphabet(10)  -- A
);

type easterEggMemory is array (31 downto 0) of std_logic_vector (6 downto 0);
constant easterEggAnim: easterEggMemory :=(
    0  => "1111111", -- _
    1  => "1111111", -- _
    2  => "1111111", -- _
    3  => "1111111", -- _
    4  => alphabet(30), -- U
    5  => alphabet(29), -- T
    6  => alphabet(12), -- C
    7  => alphabet(23), -- N
    8  => alphabet(37), -- _
    9  => alphabet(18), -- I
    10 => alphabet(28), -- S
    11 => alphabet(37), -- _
    12 => alphabet(18), -- I
    13 => alphabet(23), -- N
    14 => alphabet(37), -- _
    15 => alphabet(12), -- C
    16 => alphabet(21), -- L
    17 => alphabet(30), -- U
    18 => alphabet(19), -- J
    19 => alphabet(36), -- -
    20 => alphabet(23), -- N
    21 => alphabet(10), -- A
    22 => alphabet(25), -- P
    23 => alphabet(24), -- O
    24 => alphabet(12), -- C
    25 => alphabet(10), -- A
    26 => "1111111", -- _
    27 => "1111111", -- _
    28 => "1111111", -- _
    29 => "1111111", -- _
    30 => "1111111", -- _
    31 => "1111111" -- _
);

begin

process(CLK)
begin
    if rising_edge(CLK) then
        if RST = '1' then 
            refresh_counter <= (others => '0');
            shift_counter <= (others => '0');
 
        else 
            refresh_counter <= refresh_counter + 1;
            if shift_timer = X"E0000F" then 
                shift_timer <= (others => '0');
                if shift_counter = 18 then 
                    shift_counter <= (others => '0');
                else 
                    shift_counter <= shift_counter + 1;
                end if;
                
                if shift_egg_counter = 70 then
                    shift_egg_counter <= (others => '0');
                else
                    shift_egg_counter <= shift_egg_counter + 1;
                end if;
                
            else
                shift_timer <= shift_timer + 1;
            end if;
        end if;
    end if;
end process;

digit_index <= refresh_counter(19 downto 18);

process(digit_index, START, SEL, RST)
begin

--================-Reset on switch => blank display-================--
    case EasterEgg is
        when "1111" =>
                    shift_egg_index <= to_integer(shift_egg_counter);
                    case digit_index is
                        when "00" => 
                            ANODE  <= "1110"; 
                            CATODE <= easterEggAnim(shift_egg_index + 3);
                        when "01" => 
                            ANODE  <= "1101"; 
                            CATODE <= easterEggAnim(shift_egg_index + 2);
                        when "10" => 
                            ANODE  <= "1011"; 
                            CATODE <= easterEggAnim(shift_egg_index + 1);
                        when "11" => 
                            ANODE  <= "0111"; 
                            CATODE <= easterEggAnim(shift_egg_index);
                    end case;
        --when "1110" =>
                    
        when others =>
        --================-START on 1 - displays static message, disables animations-================--
        if START = '0' then
            case digit_index is
                when "00" =>
                    ANODE  <= "1110";
                    CATODE <= startAnimation(3);
                when "01" =>
                    ANODE  <= "1101";
                    CATODE <= startAnimation(2);
                when "10" =>
                    ANODE  <= "1011";
                    CATODE <= startAnimation(1);
                when "11" =>
                    ANODE  <= "0111";
                    CATODE <= startAnimation(0);
            end case;
        else
        --================-START on 0 - enables animations-================--
            case SEL is
            --================-Animation 1 - blink-================--
                when "00" =>
                    blink <= refresh_counter(25);
                    if blink = '0' then
                        case digit_index is
                            when "00" => 
                                ANODE  <= "1110"; 
                                CATODE <= startAnimation(3);
                            when "01" => 
                                ANODE  <= "1101"; 
                                CATODE <= startAnimation(2);
                            when "10" => 
                                ANODE  <= "1011"; 
                                CATODE <= startAnimation(1);
                            when "11" => 
                                ANODE  <= "0111"; 
                                CATODE <= startAnimation(0);
                        end case;
                    else
                        ANODE  <= "1111";  --full blank
                        CATODE <= (others => '1');
                    end if;
            --================-Animation 2 - slide to the right-================--
                when "01" =>
                    shift_index <= to_integer(shift_counter);
                    case digit_index is
                        when "00" => 
                            ANODE  <= "1110"; 
                            CATODE <= shiftAnimation(shift_index);
                        when "01" => 
                            ANODE  <= "1101"; 
                            CATODE <= shiftAnimation(shift_index + 1);
                        when "10" => 
                            ANODE  <= "1011"; 
                            CATODE <= shiftAnimation(shift_index + 2);
                        when "11" => 
                            ANODE  <= "0111"; 
                            CATODE <= shiftAnimation(shift_index + 3);
                    end case;
            --================-Animation 3 - slide to the left-================--
                when "10" =>
                    shift_index <= to_integer(shift_counter);
                    case digit_index is
                        when "00" => 
                            ANODE  <= "1110"; 
                            CATODE <= shiftAnimation2(shift_index + 3);
                        when "01" => 
                            ANODE  <= "1101"; 
                            CATODE <= shiftAnimation2(shift_index + 2);
                        when "10" => 
                            ANODE  <= "1011"; 
                            CATODE <= shiftAnimation2(shift_index + 1);
                        when "11" => 
                            ANODE  <= "0111"; 
                            CATODE <= shiftAnimation2(shift_index);
                    end case; 
            --================-Animation 4 - blink each character-================--      
                when "11" =>
                        blink <= refresh_counter(25);
                        if blink = '0' then
                            case digit_index is
                                when "00" =>
                                    ANODE  <= "1111";
                                    CATODE <= (others => '1');
                                when "01" =>
                                    ANODE  <= "1101";
                                    CATODE <= startAnimation(2);
                                when "10" =>
                                    ANODE  <= "1111";
                                    CATODE <= (others => '1');
                                when "11" =>
                                    ANODE  <= "0111";
                                    CATODE <= startAnimation(0);
                            end case;
                        else
                            case digit_index is
                                when "00" =>
                                    ANODE  <= "1110";
                                    CATODE <= startAnimation(3);
                                when "01" =>
                                    ANODE  <= "1111";
                                    CATODE <= (others => '1');
                                when "10" =>
                                    ANODE  <= "1011";
                                    CATODE <= startAnimation(1);
                                when "11" =>
                                    ANODE  <= "1111";
                                    CATODE <= (others => '1');
                            end case;
                        end if;
                end case;
        end if;
    end case;
end process;

end ARHI;