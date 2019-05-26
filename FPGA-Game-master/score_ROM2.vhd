----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:40:35 05/19/2015 
-- Design Name: 
-- Module Name:    score_ROM2 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity score_ROM2 is
     Port ( digit_value  : in  STD_LOGIC_VECTOR(3 downto 0);
	       --  digit_value_f: in STD_LOGIC_VECTOR(3 downto 0);
			  start_game  : in STD_LOGIC;
	        Hposition    : in  STD_LOGIC_VECTOR (10 downto 0);
           Vposition    : in  STD_LOGIC_VECTOR (9 downto 0);
			  obj_on       : out  STD_LOGIC;
           obj_rgb      : out  STD_LOGIC );
end score_ROM2;


architecture Behavioral of score_ROM2 is

constant Hstart : std_logic_vector(9 downto 0) :="1100000111"; -- 775
constant Vstart : std_logic_vector(8 downto 0) := "000111100"; -- 60

constant Hstart_f : std_logic_vector(9 downto 0) :="1111010100"; -- 980
constant Vstart_f : std_logic_vector(9 downto 0) := "1001011000"; -- 600

signal obj_row :  STD_LOGIC_VECTOR (10 downto 0);
signal obj_col :  STD_LOGIC_VECTOR (9 downto 0);

signal obj_on_sig : std_logic := '0';

type ROM is array (0 to 199) of std_logic_vector(19 downto 0);
constant content : ROM := (
0  =>"00001111111111111100",
1  =>"00011111111111111110",
2  =>"00111111111111111111",
3  =>"00111100000000001111",
4  =>"00111000000000000111",
5  =>"00111000000000000111",
6  =>"00111000000000000111",
7  =>"00111000000000000111",
8  =>"00111000000000000111",
9  =>"00111000000000000111",
10 =>"00111000000000000111",
11 =>"00111000000000000111",
12 =>"00111000000000000111",
13 =>"00111000000000000111",
14 =>"00111000000000000111",
15 =>"00111000000000000111",
16 =>"00111100000000001111",
17 =>"00111111111111111111",
18 =>"00011111111111111110",
19 =>"00001111111111111100",
20 =>"00000000001111110000",
21 =>"00000000011111110000",
22 =>"00000000111111110000",
23 =>"00000001111111110000",
24 =>"00000011111111110000",
25 =>"00000111111111110000",
26 =>"00000000000111110000",
27 =>"00000000000111110000",
28 =>"00000000000111110000",
29 =>"00000000000111110000",
30 =>"00000000000111110000",
31 =>"00000000000111110000",
32 =>"00000000000111110000",
33 =>"00000000000111110000",
34 =>"00000000000111110000",
35 =>"00000000000111110000",
36 =>"00000000000111110000",
37 =>"00000011111111111111",
38 =>"00000011111111111111",
39 =>"00000011111111111111",
40 =>"00111111111111111111",
41 =>"00111111111111111111",
42 =>"00111111111111111111",
43 =>"00000000000000011111",
44 =>"00000000000000011111",
45 =>"00000000000000011111",
46 =>"00000000000000011111",
47 =>"00000000000000011111",
48 =>"00000000000000011111",
49 =>"00011111111111111111",
50 =>"00111111111111111111",
51 =>"00111110000000000000",
52 =>"00111110000000000000",
53 =>"00111110000000000000",
54 =>"00111110000000000000",
55 =>"00111110000000000000",
56 =>"00111110000000000000",
57 =>"00111111111111111110",
58 =>"00111111111111111111",
59 =>"00111111111111111111",
60 =>"00111111111111111111",
61 =>"00111111111111111111",
62 =>"00111111111111111111",
63 =>"00000000000000011111",
64 =>"00000000000000011111",
65 =>"00000000000000011111",
66 =>"00000000000000011111",
67 =>"00000000000000011111",
68 =>"00000000000000011111",
69 =>"00000000000000011111",
70 =>"00000000000000011111",
71 =>"00000000001111111111",
72 =>"00000000001111111111",
73 =>"00000000000000011111",
74 =>"00000000000000011111",
75 =>"00000000000000011111",
76 =>"00000000000000011111",
77 =>"00111111111111111111",
78 =>"00111111111111111111",
79 =>"00111111111111111111",
80 =>"00111110000000011111",
81 =>"00111110000000011111",
82 =>"00111110000000011111",
83 =>"00111110000000011111",
84 =>"00111110000000011111",
85 =>"00111110000000011111",
86 =>"00111110000000011111",
87 =>"00111110000000011111",
88 =>"00111110000000011111",
89 =>"00111111111111111111",
90 =>"00111111111111111111",
91 =>"00000000000000011111",
92 =>"00000000000000011111",
93 =>"00000000000000011111",
94 =>"00000000000000011111",
95 =>"00000000000000011111",
96 =>"00000000000000011111",
97 =>"00000000000000011111",
98 =>"00000000000000011111",
99 =>"00000000000000011111",
100=>"00111111111111111111",
101=>"00111111111111111111",
102=>"00111111111111111111",
103=>"00111110000000000000",
104=>"00111110000000000000",
105=>"00111110000000000000",
106=>"00111110000000000000",
107=>"00111110000000000000",
108=>"00111110000000000000",
109=>"00111110000000000000",
110=>"00111111111111111111",
111=>"00111111111111111111",
112=>"00000000000000011111",
113=>"00000000000000011111",
114=>"00000000000000011111",
115=>"00000000000000011111",
116=>"00000000000000011111",
117=>"00111111111111111111",
118=>"00111111111111111111",
119=>"00111111111111111111",
120=>"00111111111111111111",
121=>"00111111111111111111",
122=>"00111111111111111111",
123=>"00111110000000000000",
124=>"00111110000000000000",
125=>"00111110000000000000",
126=>"00111110000000000000",
127=>"00111110000000000000",
128=>"00111110000000000000",
129=>"00111110000000000000",
130=>"00111111111111111111",
131=>"00111111111111111111",
132=>"00111110000000011111",
133=>"00111110000000011111",
134=>"00111110000000011111",
135=>"00111110000000011111",
136=>"00111110000000011111",
137=>"00111111111111111111",
138=>"00111111111111111111",
139=>"00111111111111111111",
140=>"00111111111111111111",
141=>"00111111111111111111",
142=>"00111111111111111111",
143=>"00000000000000011111",
144=>"00000000000000011111",
145=>"00000000000000011111",
146=>"00000000000000011111",
147=>"00000000000000011111",
148=>"00000000000000011111",
149=>"00000000000000011111",
150=>"00000000000000011111",
151=>"00000000000000011111",
152=>"00000000000000011111",
153=>"00000000000000011111",
154=>"00000000000000011111",
155=>"00000000000000011111",
156=>"00000000000000011111",
157=>"00000000000000011111",
158=>"00000000000000011111",
159=>"00000000000000011111",
160=>"00111111111111111111",
161=>"00111111111111111111",
162=>"00111111111111111111",
163=>"00111110000000011111",
164=>"00111110000000011111",
165=>"00111110000000011111",
166=>"00111110000000011111",
167=>"00111110000000011111",
168=>"00111110000000011111",
169=>"00111110000000011111",
170=>"00111111111111111111",
171=>"00111111111111111111",
172=>"00111110000000011111",
173=>"00111110000000011111",
174=>"00111110000000011111",
175=>"00111110000000011111",
176=>"00111110000000011111",
177=>"00111111111111111111",
178=>"00111111111111111111",
179=>"00111111111111111111",
180=>"00111111111111111111",
181=>"00111111111111111111",
182=>"00111111111111111111",
183=>"00111110000000011111",
184=>"00111110000000011111",
185=>"00111110000000011111",
186=>"00111110000000011111",
187=>"00111110000000011111",
188=>"00111111111111111111",
189=>"00111111111111111111",
190=>"00000000000000011111",
191=>"00000000000000011111",
192=>"00000000000000011111",
193=>"00000000000000011111",
194=>"00000000000000011111",
195=>"00000000000000011111",
196=>"00000000000000011111",
197=>"00111111111111111111",
198=>"00111111111111111111",
199=>"00111111111111111111" );

signal data_line : std_logic_vector(0 to 19);
signal object_rgb : std_logic;

begin
process(obj_on_sig, obj_col, data_line, obj_row)
begin

    object_rgb <= '0';
	 obj_on_sig <= '0';
	 
 --if start_game = '1' then
    
	 
			 if (Hposition >= Hstart and Hposition < Hstart + "10100") and 
				 (Vposition >= Vstart and Vposition < Vstart + "10100") then
					obj_on_sig <= '1';
					obj_row <= (Hposition-Hstart);
					obj_col <= (Vposition-Vstart);
			 end if;
			 if obj_on_sig = '1' then
					data_line <= content(conv_integer(obj_col) + (20 * conv_integer(digit_value)));
					object_rgb <= data_line(conv_integer(obj_row));
			 end if;
			 
	--elsif start_game = '0' then
	 
--	 
--	 if (Hposition >= Hstart_f and Hposition < Hstart + "10100") and 
--				 (Vposition >= Vstart_f and Vposition < Vstart + "10100") then
--					obj_on_sig <= '1';
--					obj_row <= (Hposition-Hstart_f);
--					obj_col <= (Vposition-Vstart_f);
--			 end if;
--			 if obj_on_sig = '1' then
--					data_line <= content(conv_integer(obj_col) + (20 * conv_integer(digit_value)));
--					object_rgb <= data_line(conv_integer(obj_row));
--			 end if;
--	 
--	 
	 --end if ;
	 
end process;

obj_rgb <= object_rgb;
obj_on <= obj_on_sig;

end Behavioral;





