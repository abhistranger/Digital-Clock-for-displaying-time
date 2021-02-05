library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity digitalClock_part3 is --this part is for states and time setting manually
    port (clk_Master: in std_logic; --the main clock signal
        B1: in std_logic; --button1
        B2: in std_logic; --button2
        B3: in std_logic; --button3
        B4: in std_logic; --button4
        cnt: inout unsigned(24 downto 0); --to count 0.25sec 
        H_out1_bin: in unsigned(3 downto 0); -- detail in digitalClock_part2
        H_out0_bin: in unsigned(3 downto 0);
        M_out1_bin: in unsigned(3 downto 0);
        M_out0_bin: in unsigned(3 downto 0);
        S_out1_bin: in unsigned(3 downto 0);
        S_out0_bin: in unsigned(3 downto 0);
        H_in1_bin: out unsigned(3 downto 0);
        H_in0_bin: out unsigned(3 downto 0);
        M_in1_bin: out unsigned(3 downto 0);
        M_in0_bin: out unsigned(3 downto 0);
        S_in1_bin: out unsigned(3 downto 0);
        S_in0_bin: out unsigned(3 downto 0);
        out1_bin: out unsigned(3 downto 0);  --the out1_bin will be the fist of 4 digit out of 4 which will be displayed in 4-bit binary form
        out2_bin: out unsigned(3 downto 0);  --the out2_bin will be the second of 4 digit out of 4 which will be displayed in 4-bit binary form
        out3_bin: out unsigned(3 downto 0);  --the out3_bin will be the third of 4 digit out of 4 which will be displayed in 4-bit binary form
        out4_bin: out unsigned(3 downto 0)   --the out4_bin will be the forth of 4 digit out of 4 which will be displayed in 4-bit binary form
    );
end digitalClock_part3;

architecture main3 of digitalClock_part3 is
    type state_type is (A0,A1,A2,A3,A4);  -- defining 5 states A0,A1,A2,A3,A4 and states definition are given in overview
    signal state : state_type;
begin
    process (clk_Master)--process triggering on clk_Master change
    begin
        if (clk_Master'event AND clk_Master = '1') then --for every rising edge of clk_Master cnt will increse by 1 that will count 10 ns
            cnt <= cnt+1;
            if(cnt="1001100010010110100000000") then  -- button press will be seen for interval of 0.2sec so after 0.2sec of interval it will see any button is pressed or not
            cnt<="0000000000000000000000000";
            case state is --check case based on states
                when A0 => --As state A0 is for showing time in hr:min so input==output for every digit of hr,min,sec.
                    H_in1_bin <= H_out1_bin;
                    H_in0_bin <= H_out0_bin;
                    M_in1_bin <= M_out1_bin;
                    M_in0_bin <= M_out0_bin;
                    S_in1_bin <= S_out1_bin;
                    S_in0_bin <= S_out0_bin;
                    if (B1='1') then state <= A1; --when B1 is pressed the state will change from A0 to A1
                    elsif (B2='1') then state <=A2; --when B2 is pressed the state will change from A0 to A2
                    end if;
                when A1 => --As state A0 is for showing time in min:sec so input==output for every digit of hr,min,sec.
                    H_in1_bin <= H_out1_bin;
                    H_in0_bin <= H_out0_bin;
                    M_in1_bin <= M_out1_bin;
                    M_in0_bin <= M_out0_bin;
                    S_in1_bin <= S_out1_bin;
                    S_in0_bin <= S_out0_bin;
                    if (B1='1') then state <= A0; --when B1 is pressed the state will change from A1 to A0
                    elsif (B2='1') then state <=A2; --when B2 is pressed the state will change from A1 to A2
                    end if;
                when A2 =>
                    M_in1_bin <= M_out1_bin;
                    M_in0_bin <= M_out0_bin;
                    S_in1_bin <= S_out1_bin;
                    S_in0_bin <= S_out0_bin;
                    if (B1='1') then state <= A0; --when B1 is pressed the state will change from A2 to A0
                        H_in1_bin <= H_out1_bin;
                        H_in0_bin <= H_out0_bin;
                    elsif (B2='1') then state <= A3; --when B2 is pressed the state will change from A2 to A3
                        H_in1_bin <= H_out1_bin;
                        H_in0_bin <= H_out0_bin;
                    elsif (B3='1') then H_in1_bin <= H_out1_bin+1;  --when B3 is pressed the state will remain unchanged but the tenth digit of hr will increment by 1
                        H_in0_bin <= H_out0_bin;
                        if (H_in1_bin="0011") then H_in1_bin <= "0000";
                        end if;
                    elsif (B4='1') then H_in0_bin <= H_out0_bin+1;  --when B4 is pressed the state will remain unchanged but the ones digit of min will increment by 1
                        H_in1_bin <= H_out1_bin;
                        if (H_in0_bin="1010") then H_in0_bin <= "0000";
                        end if;
                    end if;
                when A3 =>
                    H_in1_bin <= H_out1_bin;
                    H_in0_bin <= H_out0_bin;
                    S_in1_bin <= S_out1_bin;
                    S_in0_bin <= S_out0_bin;
                    if (B1='1') then state <= A0; --when B1 is pressed the state will change from A3 to A0
                        M_in1_bin <= M_out1_bin;
                        M_in0_bin <= M_out0_bin;
                    elsif (B2='1') then state <= A4; --when B2 is pressed the state will change from A3 to A4
                        M_in1_bin <= M_out1_bin;
                        M_in0_bin <= M_out0_bin;
                    elsif (B3='1') then M_in1_bin <= M_out1_bin+1; --when B3 is pressed the state will remain unchanged but the tenth digit of min will increment by 1
                        M_in0_bin <= M_out0_bin;
                        if (M_in1_bin="0110") then M_in1_bin <= "0000";
                        end if;
                    elsif (B4='1') then M_in0_bin <= M_out0_bin+1; --when B4 is pressed the state will remain unchanged but the ones digit of min will increment by 1
                        M_in1_bin <= M_out1_bin;
                        if (M_in0_bin="1010") then M_in0_bin <= "0000";
                        end if;
                    end if;
                when A4 => 
                    H_in1_bin <= H_out1_bin;
                    H_in0_bin <= H_out0_bin;
                    M_in1_bin <= M_out1_bin;
                    M_in0_bin <= M_out0_bin;
                    if (B1='1') then state <= A0; --when B1 is pressed the state will change from A4 to A0
                        S_in1_bin <= S_out1_bin;
                        S_in0_bin <= S_out0_bin;
                    elsif (B2='1') then state <=A2; --when B2 is pressed the state will change from A4 to A2
                        S_in1_bin <= S_out1_bin;
                        S_in0_bin <= S_out0_bin;
                    elsif (B3='1') then S_in1_bin <= S_out1_bin+1; --when B3 is pressed the state will remain unchanged but the tenth digit of sec will increment by 1
                        S_in0_bin <= S_out0_bin;
                        if (S_in1_bin="0110") then S_in1_bin <= "0000";
                        end if;
                    elsif (B4='1') then S_in0_bin <= S_out0_bin+1; --when B4 is pressed the state will remain unchanged but the ones digit of min will increment by 1
                        S_in1_bin <= S_out1_bin;
                        if (S_in0_bin="1010") then S_in0_bin <= "0000";
                        end if;
                    end if;
            end case;
            else
                H_in1_bin <= H_out1_bin;
                H_in0_bin <= H_out0_bin;
                M_in1_bin <= M_out1_bin;
                M_in0_bin <= M_out0_bin;
                S_in1_bin <= S_out1_bin;
                S_in0_bin <= S_out0_bin;
            end if;
        end if;
    end process;   

    -- selecting the 4 output values out1_bin,out2_bin,out3_bin,out4_bin to show on display depending on states  
    with state select 
        out1_bin <= H_in1_bin when A0, 
                    M_in1_bin when A1,
                    "0000" when others;
    with state select
        out2_bin <= H_in0_bin when A0,
                    M_in0_bin when A1,
                    "0000" when others;
    with state select
        out3_bin <= M_in1_bin when A0,
                    S_in1_bin when A1,
                    H_in1_bin when A2,
                    M_in1_bin when A3,
                    S_in1_bin when A4;
	with state select
        out4_bin <= M_in0_bin when A0,
                    S_in0_bin when A1,
                    H_in0_bin when A2,
                    M_in0_bin when A3,
                    S_in0_bin when A4;
end main3;
