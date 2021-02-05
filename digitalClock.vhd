library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity digitalClock is   --main part consisting of all parts and the clk_Master is of 100MHz              ____________
	port (clk_Master: in std_logic;                                                         --clk_Master--|          |
   		B0: in std_logic;       --five button B0,B1,B2,B3,B4                                        --B0--|          |--Disp_seg--
   		B1: in std_logic;       --specification of button is in overview                            --B1--|   main   |
   		B2: in std_logic;                                                                           --B2--|   part   |--Disp_val--
   		B3: in std_logic;                                                                           --B3--|          |
   		B4: in std_logic;                                                                           --B4--|__________|
   		Disp_seg: out std_logic_vector(6 downto 0);   -- Cathode part -- 7 bit vector which will given to the basys board and this digit will be displayed for a time of refresh_rate/4.
   		Disp_val: out std_logic_vector(3 downto 0)    -- Anode part -- this will decide which out of 4 digit on display will be on.
   		);
end digitalClock;

architecture main of digitalClock is
    -- all the signal declaration which is used in this
    signal refresh_counter: unsigned(19 downto 0):= (others => '0');
    signal count : unsigned(26 downto 0):="000000000000000000000000000";
    signal H_in1_bin: unsigned(3 downto 0):="0000";
    signal H_in0_bin: unsigned(3 downto 0):="0000";
    signal M_in1_bin: unsigned(3 downto 0):="0000";
    signal M_in0_bin: unsigned(3 downto 0):="0000";
    signal S_in1_bin: unsigned(3 downto 0):="0000";
    signal S_in0_bin: unsigned(3 downto 0):="0000";
    signal H_out1_bin: unsigned(3 downto 0):="0000";
    signal H_out0_bin: unsigned(3 downto 0):="0000";
    signal M_out1_bin: unsigned(3 downto 0):="0000";
    signal M_out0_bin: unsigned(3 downto 0):="0000";
    signal S_out1_bin: unsigned(3 downto 0):="0000";
    signal S_out0_bin: unsigned(3 downto 0):="0000";
    signal out1_bin: unsigned(3 downto 0):="0000";
    signal out2_bin: unsigned(3 downto 0):="0000";
    signal out3_bin: unsigned(3 downto 0):="0000";
    signal out4_bin: unsigned(3 downto 0):="0000";
    -- component instantiation
    component digitalClock_part2 is --component1 is part2 
        port (clk_Master: in std_logic;
		B0: in std_logic;
        count : inout unsigned(26 downto 0);
        H_in1_bin: in unsigned(3 downto 0);
        H_in0_bin: in unsigned(3 downto 0);
        M_in1_bin: in unsigned(3 downto 0);
        M_in0_bin: in unsigned(3 downto 0);
        S_in1_bin: in unsigned(3 downto 0);
        S_in0_bin: in unsigned(3 downto 0);
		H_out1_bin: out unsigned(3 downto 0);
        H_out0_bin: out unsigned(3 downto 0);
        M_out1_bin: out unsigned(3 downto 0);
        M_out0_bin: out unsigned(3 downto 0);
        S_out1_bin: out unsigned(3 downto 0);
        S_out0_bin: out unsigned(3 downto 0)
   		);
    end component;
    component digitalClock_part3 is --component2 is part3
        port (clk_Master: in std_logic;
        B1: in std_logic;
        B2: in std_logic;
        B3: in std_logic;
        B4: in std_logic;
        H_out1_bin: in unsigned(3 downto 0);
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
        out1_bin: out unsigned(3 downto 0);
        out2_bin: out unsigned(3 downto 0);
        out3_bin: out unsigned(3 downto 0);
        out4_bin: out unsigned(3 downto 0)
        );
    end component;
    component digitalClock_part4 is --component3 is part4
        port (out1_bin: in unsigned(3 downto 0);
        out2_bin: in unsigned(3 downto 0);
        out3_bin: in unsigned(3 downto 0);
        out4_bin: in unsigned(3 downto 0);
        Disp_seg: out std_logic_vector(6 downto 0);
   		Disp_val: in std_logic_vector(3 downto 0)
   		);
    end component;
    component digitalClock_part6 is --component4 is part6
        port(clk_Master: in std_logic;
        B0: in std_logic;
        refresh_counter: inout unsigned(19 downto 0);
        Disp_val: out std_logic_vector(3 downto 0)
        );
    end component;
begin
    -- component call using port map 
    c1: digitalClock_part2 port map(clk_Master,B0,count,H_in1_bin,H_in0_bin,M_in1_bin,M_in0_bin,S_in1_bin,S_in0_bin,H_out1_bin,H_out0_bin,M_out1_bin,M_out0_bin,S_out1_bin,S_out0_bin); --component1 is part2
    c2: digitalClock_part3 port map(clk_Master,B1,B2,B3,B4,H_out1_bin,H_out0_bin,M_out1_bin,M_out0_bin,S_out1_bin,S_out0_bin,H_in1_bin,H_in0_bin,M_in1_bin,M_in0_bin,S_in1_bin,S_in0_bin,out1_bin,out2_bin,out3_bin,out4_bin); -- component2 is part3
    c3: digitalClock_part4 port map(out1_bin,out2_bin,out3_bin,out4_bin,Disp_seg,Disp_val); --component3 is part4
    c4: digitalClock_part6 port map(clk_Master,B0,refresh_counter,Disp_val); -- component4 is part6
end main;
