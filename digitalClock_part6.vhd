library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity digitalClock_part6 is --this part is to create refresh rate of 10.5ms so that each digit out of 4 will be displayed for 10.5/4 ms.
    port(clk_Master: in std_logic;
        B0: in std_logic;
        refresh_counter: inout unsigned(19 downto 0);
        Disp_val: out std_logic_vector(3 downto 0));
end digitalClock_part6;

-- creating refresh rate of 10.5ms
architecture main6 of digitalClock_part6 is
    signal t: unsigned(1 downto 0); --a 2-bit signal t
begin
    process (clk_Master)
    begin
        if (B0='1') then -- when reset button is pressed the refresh_counter will become 0
            refresh_counter <= (others => '0');
        elsif (clk_Master'event AND clk_Master = '1') then -- for each rising edge of clock refresh_counter will increse 1 and as we know the clk_Master has time period of 10ns
            refresh_counter <= refresh_counter+1;          -- so this refresh_will tell me when time become refresh_rate/4 = 10.5ms/4 = 0.375 which is approx 2^18 * 10ns(time period)
        end if;
    end process;
    t <= refresh_counter(19 downto 18); --last 18 bit count 10.5/4 ms and the first 2 bit will decide the Disp_val
    process (t)
    begin
        case t is
            when "00" =>
                Disp_val <= "0111"; --will display 1st digit
            when "01" =>
                Disp_val <= "1011"; --will display 2nd digit
            when "10" =>
                Disp_val <= "1101"; --will display 3nd digit
            when others =>
                Disp_val <= "1110"; --will display 4nd digit
        end case;
    end process;
end main6;
