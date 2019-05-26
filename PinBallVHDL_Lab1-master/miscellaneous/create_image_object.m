function [] = create_image_object(object_name,image, width, height, filter)
%CREATE_IMAGE_OBJECT Summary of this function goes here
%   Detailed explanation goes here
file_name = strcat(object_name,'.vhd');
[IMAGE,MASK] = im_hex( image, width, height, filter );

file_string1 = sprintf('library IEEE;\nuse IEEE.STD_LOGIC_1164.all;\nentity %s is\nport 	(\n		\n	   CLK  		: in std_logic;\n		RESETn		: in std_logic;\n		oCoord_X	: in integer;\n		oCoord_Y	: in integer;\n		ObjectStartX	: in integer;\n		ObjectStartY 	: in integer;\n		drawing_request	: out std_logic ;\n		mVGA_RGB 	: out std_logic_vector(7 downto 0) \n	);\nend entity;\n\n\n',object_name);
file_string2 = sprintf('architecture behav of %s is \n\nconstant object_X_size : integer := %d;\nconstant object_Y_size : integer := %d;\n',object_name,width,height);
file_string3 = sprintf('type ram_array is array(0 to object_Y_size - 1 , 0 to object_X_size - 1) of std_logic_vector(7 downto 0);\nconstant object_colors: ram_array := (\n%s\n);\n\nconstant object : object_form := (\n%s\n);\n\n',IMAGE,MASK);
file_string4 = sprintf('signal bCoord_X : integer := 0;-- offset from start position \nsignal bCoord_Y : integer := 0;\n\nsignal drawing_X : std_logic := ''0'';\nsignal drawing_Y : std_logic := ''0'';\n	\nsignal objectEndX : integer;\nsignal objectEndY : integer;\n\nbegin\n\n-- Calculate object end boundaries\nobjectEndX	<= object_X_size+ObjectStartX;\nobjectEndY	<= object_Y_size+ObjectStartY;\n\n-- Signals drawing_X[Y] are active when obects coordinates are being crossed\n\n-- test if ooCoord is in the rectangle defined by Start and End \n	drawing_X	<= ''1'' when  (oCoord_X  >= ObjectStartX) and  (oCoord_X < objectEndX) else ''0'';\n    drawing_Y	<= ''1'' when  (oCoord_Y  >= ObjectStartY) and  (oCoord_Y < objectEndY) else ''0'';\n\n-- calculate offset from start corner \n	bCoord_X 	<= (oCoord_X - ObjectStartX) when ( drawing_X = ''1'' and  drawing_Y = ''1''  ) else 0 ; \n	bCoord_Y 	<= (oCoord_Y - ObjectStartY) when ( drawing_X = ''1'' and  drawing_Y = ''1''  ) else 0 ; \n\n\nprocess ( RESETn, CLK)\n\n  		\n   begin\n	if RESETn = ''0'' then\n	    mVGA_RGB	<=  (others => ''0'') ; 	\n		drawing_request	<=  ''0'' ;\n\n		elsif rising_edge(CLK) then\n			mVGA_RGB	<=  object_colors(bCoord_Y , bCoord_X);	--get from colors table \n			drawing_request	<= object(bCoord_Y , bCoord_X) and drawing_X and drawing_Y ; -- get from mask table if inside rectangle  \n	end if;\n\n  end process;\n\n		\nend behav;\n');


fileID = fopen(file_name,'wt');
fprintf(fileID,file_string1);
fprintf(fileID,file_string2);
fprintf(fileID,file_string3);
fprintf(fileID,file_string4);
fclose(fileID);

end

