library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity digitalClock_part4 is --part4 is like a mux which will take 
	port (out1_bin: in unsigned(3 downto 0);  -- out1_bin, out2_bin, out3_bin, out4_bin are the unsigned 4 bit vector which is to be displayed on the display depend on the state(mode)
        out2_bin: in unsigned(3 downto 0);
        out3_bin: in unsigned(3 downto 0);
        out4_bin: in unsigned(3 downto 0);
        Disp_seg: out std_logic_vector(6 downto 0);  -- 7 bit vector which will given to the basys board and this digit will be displayed for a time of refresh_rate/4.
   		Disp_val: in std_logic_vector(3 downto 0)  -- this will decide which out of 4 digit on display will be on.
   		);
end entity digitalClock_part4;

architecture main4 of digitalClock_part4 is
    signal out1: std_logic_vector(6 downto 0);  -- out1, out2, out3, out4 are the 7 bit vector signals which is to be displayed on the display depend on the state(mode)
    signal out2: std_logic_vector(6 downto 0);
    signal out3: std_logic_vector(6 downto 0);
    signal out4: std_logic_vector(6 downto 0);
    component bintohex is            -- component instantiation for changing 4 bit to 7 bit to give the 7 bit to basys board
        port (Bin: in unsigned(3 downto 0);
        Hout: out std_logic_vector(6 downto 0)
        );
    end component;
begin
    c11: bintohex port map (out1_bin,out1);  --use of the component by port map to convert 4 bit out1_bin to 7 bit out1
    c12: bintohex port map (out2_bin,out2);  --use of the component by port map to convert 4 bit out1_bin to 7 bit out1
    c13: bintohex port map (out3_bin,out3);  --use of the component by port map to convert 4 bit out1_bin to 7 bit out1
    c14: bintohex port map (out4_bin,out4);  --use of the component by port map to convert 4 bit out1_bin to 7 bit out1
    process (out1,out2,out3,out4,Disp_val) 
    begin
        if (Disp_val="0111") then -- when Disp_val will be 0111 the first out of 4 digit on displayed
            Disp_seg <= out1;
        elsif (Disp_val="1011") then --when Disp_val will be 1011 the second out of 4 digit on displayed
            Disp_seg <= out2;
        elsif (Disp_val="1101") then --when Disp_val will be 1101 the third out of 4 digit on displayed
            Disp_seg <= out3;
        else                        --when Disp_val will be 1110 the forth out of 4 digit on displayed
            Disp_seg <= out4;
        end if;
    end process;
end main4;
