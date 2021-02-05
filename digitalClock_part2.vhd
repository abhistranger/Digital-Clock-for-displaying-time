library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity digitalClock_part2 is --part2 is for time increment as 
	port (clk_Master: in std_logic;
		B0: in std_logic;
        count : inout unsigned(26 downto 0); --count signal
        H_in1_bin: in unsigned(3 downto 0);  -- Tenth place value of hr in 4-bit vector which is input to this part and it is coming from digitalClock_part3
        H_in0_bin: in unsigned(3 downto 0);  -- Ones place value of hr in 4-bit vector which is input to this part and it is coming from digitalClock_part3
        M_in1_bin: in unsigned(3 downto 0);  -- Tenth place value of min in 4-bit vector which is input to this part and it is coming from digitalClock_part3
        M_in0_bin: in unsigned(3 downto 0);  -- Ones place value of min in 4-bit vector which is input to this part and it is coming from digitalClock_part3
        S_in1_bin: in unsigned(3 downto 0);  -- Tenth place value of sec in 4-bit vector which is input to this part and it is coming from digitalClock_part3
        S_in0_bin: in unsigned(3 downto 0);  -- Ones place value of sec in 4-bit vector which is input to this part and it is coming from digitalClock_part3
		H_out1_bin: out unsigned(3 downto 0);  -- Tenth place value of hr in 4-bit vector which is output from this part and input for digitalClock_part3
        H_out0_bin: out unsigned(3 downto 0);  -- Ones place value of hr in 4-bit vector which is output from this part and input for digitalClock_part3
        M_out1_bin: out unsigned(3 downto 0);  -- Tenth place value of min in 4-bit vector which is output from this part and input for digitalClock_part3
        M_out0_bin: out unsigned(3 downto 0);  -- Ones place value of min in 4-bit vector which is output from this part and input for digitalClock_part3
        S_out1_bin: out unsigned(3 downto 0);  -- Tenth place value of sec in 4-bit vector which is output from this part and input for digitalClock_part3
        S_out0_bin: out unsigned(3 downto 0)   -- Ones place value of sec in 4-bit vector which is output from this part and input for digitalClock_part3
   		);
end digitalClock_part2;

ARCHITECTURE main2 OF digitalClock_part2 IS
begin
	process(clk_Master,B0) begin
		if(B0 = '1') then  -- when reset button will be pressed all will become 0 and rsest button is button0
        count <= "000000000000000000000000000";
		H_out0_bin <= "0000";
        H_out1_bin <= "0000";
 		M_out0_bin <= "0000";
        M_out1_bin <= "0000";
 		S_out0_bin <= "0000";
        S_out1_bin <= "0000";
		elsif(clk_Master'event AND clk_Master = '1') then -- for every rising edge of clk_Master the count will increment 1
		count <= count + 1;
     		if(count = "101111101011110000100000000") then --when count become this value it actually become 1s so now count will become 0 and ones digit of sec will increase 1
            count <= "000000000000000000000000000";
     		S_out0_bin <= S_in0_bin + 1;
            if(S_out0_bin = "1010") then --if the ones digit of sec after increment become 10 so this become 0 and tenth digit of sec increase by 1
            S_out1_bin <= S_in1_bin+1;
            S_out0_bin <= "0000";
     		if(S_out1_bin = "0110") then --if sec after increment become 60 so it will become 00 and ones digit of min will increase by 1
     		M_out0_bin <= M_in0_bin+1;
     		S_out1_bin <= "0000";
     		if(M_out0_bin = "1010") then --if the ones digit of min after increment become 10 so this become 0 and tenth digit of min increase by 1
            M_out1_bin <= M_in1_bin+1;
            M_out0_bin <= "0000";
            if(M_out1_bin ="0110") then  --if min after increment become 60 so it will become 00 and ones digit of hr will increase by 1
            H_out0_bin <= H_in0_bin+1;
     		M_out1_bin <= "0000";
            if(H_out0_bin ="1010") then  --if the ones digit of hr after increment become 10 so this become 0 and tenth digit of min increase by 1
            H_out1_bin <= H_in1_bin+1;
            H_out0_bin <= "0000";
            elsif(H_out0_bin ="0100") then --if the ones digit of hr after increment become 4 and tenth digit of hr is 2 so this both become 0
                if (H_in1_bin ="0010") then
                H_out0_bin <= "0000";
                H_out1_bin <= "0000";
                else
                    H_out1_bin <= H_in1_bin;
                end if;
            else                            --these are just other assignments depending on if condition
                H_out1_bin <= H_in1_bin;
            end if;
            else
                H_out1_bin <= H_in1_bin;
                H_out0_bin <= H_in0_bin;
            end if;
            else
                H_out1_bin <= H_in1_bin;
                H_out0_bin <= H_in0_bin;
                M_out1_bin <= M_in1_bin;
            end if;
            else
                H_out1_bin <= H_in1_bin;
                H_out0_bin <= H_in0_bin;
                M_out1_bin <= M_in1_bin;
                M_out0_bin <= M_in0_bin;
     		end if;
            else
                H_out1_bin <= H_in1_bin;
                H_out0_bin <= H_in0_bin;
                M_out1_bin <= M_in1_bin;
                M_out0_bin <= M_in0_bin;
                S_out1_bin <= S_in1_bin;
     		end if;
            else 
                H_out1_bin <= H_in1_bin;
                H_out0_bin <= H_in0_bin;
                M_out1_bin <= M_in1_bin;
                M_out0_bin <= M_in0_bin;
                S_out1_bin <= S_in1_bin;
                S_out0_bin <= S_in0_bin;
     		end if;
 		end if;
	end process;
end main2;
		

