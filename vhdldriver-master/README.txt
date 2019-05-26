author: Kevan Pigott
class: ece 287
school: miami university oxford

Contributors:  
	Scott Larson 
		provided the building block for my code, controller for vga 		output in vdhl. found his code on 		EEwiki.net/pages/viewpage.action?pageId=15925278
	Andrew Hadet
		ece 287 classmate, looked at my code and helped my find a 		bug
	Dr. Rajasekhar
		my ece 287 prof! borrowed some code from her class website 		(canvas)


about:

	This project is designed to be uploaded to an fpga. it plays a 	driving game in which the user can drive left or right, and is ment 	to dodge other cars. (other cars have not been added)

	Folders:

		Java: contains a code written in the java language, I made 			the code to help me type repatative declerations in my 				program.

		vga_VHDL: contains the bulk of the vhdl programs, including 			those written by scott larson

	files:
		farleftpush: outputs integer 0, used to define the farthest 		left the block can go (unused)

		numpusherLR: used to output multiple integers. defines 		limits for each block position left and right limits
		
		numpusherbottom: outputs integer, used to define the bottom 			position of the boxes	

		numpushertop: outputs integer, used to define the top 				position of the boxes

		
		vga_with_hw_test_image_v1_0_restored: legacy
		
		


