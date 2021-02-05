library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity bintohex is    -- this part will change BCD to hex so that the hex will be given to Basys board
    port (Bin: in unsigned(3 downto 0);      -- entity contain input  Bin which is unsigned 4 bit vector and output is Hout which is hex given to basys board
    Hout: out std_logic_vector(6 downto 0));
end bintohex;

architecture Behavioral of bintohex is --architecture part
begin
 process(Bin)
 begin
  case(Bin) is
   when "0000" =>  Hout <= "1000000"; --when 0
   when "0001" =>  Hout <= "1111001"; --when 1
   when "0010" =>  Hout <= "0100100"; --when 2
   when "0011" =>  Hout <= "0110000"; --when 3
   when "0100" =>  Hout <= "0011001"; --when 4
   when "0101" =>  Hout <= "0010010"; --when 5    
   when "0110" =>  Hout <= "0000010"; --when 6
   when "0111" =>  Hout <= "1111000"; --when 7  
   when "1000" =>  Hout <= "0000000"; --when 8
   when "1001" =>  Hout <= "0010000"; --when 9
   when "1010" =>  Hout <= "0001000"; --a--
   when "1011" =>  Hout <= "0000011"; --b--
   when "1100" =>  Hout <= "1000110"; --c--
   when "1101" =>  Hout <= "0100001"; --d--
   when "1110" =>  Hout <= "0000110"; --e--
   when others =>  Hout <= "0001110"; 
   end case;
 end process;
end Behavioral;
