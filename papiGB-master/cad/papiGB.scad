
 //All distances are in milimeters!
	

 case_w=140;
 case_h=case_w*0.5714;
 case_thickness=case_w/70;
 case_depth = case_w*0.12;

//---------------------------------------------------------------------------------
module papiGB_case_top()
{

   //Let's start by setting some basic sizes
  

   lcd_w= case_w*0.535;
   lcd_h= case_h*0.6875;

   lcd_x = (case_w-lcd_w)/2;
   lcd_y = (case_h-lcd_h)/2;	
   pad_diameter    = case_w/14;
   button_diameter =case_w/28;

	
   pad_pos = [ lcd_x/2, (2*case_h)/3, 0];

   button_a_pos = [ case_w - (case_w - lcd_w)/5, (7*case_h)/10, 0];
   button_b_pos = [ case_w - (case_w - lcd_w)/3, (5*case_h)/10, 0];

   button_start_pos = [ lcd_x/4, (2*case_h)/10, 0];
   button_select_pos = [ lcd_x/4, (3*case_h)/10, 0];

	speaker_hole_0 = [ case_w - (case_w - lcd_w)/2.75, (2*case_h)/10, 0];

	speaker_hole_1 = [ case_w - (case_w - lcd_w)/2.5, (2.3*case_h)/10, 0];

	speaker_hole_2 = [ case_w - (case_w - lcd_w)/2.5, (2.6*case_h)/10, 0];
	
	speaker_hole_3 = [ case_w - (case_w - lcd_w)/2.75, (2.9*case_h)/10, 0];


difference()
{
	//Create the enclosure body
	color("LightGray") square([case_w,case_h]);

	
	//Create the hole to place the LCD 7.5mm x 5.5mm
	translate([lcd_x, lcd_y, 0]) square([lcd_w, lcd_h ]);


	//Create the hole to place the joystick
	translate(pad_pos) scale(pad_diameter) circle( $fn=8 );

	//Place the A button
	translate(button_a_pos) scale(button_diameter) circle( $fn=16 );

	//Place the B button
	translate(button_b_pos) scale(button_diameter) circle( $fn=16 );
	
	//Place the start button
	translate(button_start_pos) scale(button_diameter) square([3,1]);

	//Place the select button
	translate(button_select_pos) scale(button_diameter) square([3,1]);

	//Place the speaker holes
	translate(speaker_hole_0) scale(button_diameter) square([3,0.20]);
	translate(speaker_hole_1) scale(button_diameter) square([4,0.20]);
	translate(speaker_hole_2) scale(button_diameter) square([4,0.20]);
	translate(speaker_hole_3) scale(button_diameter) square([3,0.20]);


};
};
//---------------------------------------------------------------------------------
module papiGB_case_side()
{

	
 
	difference()
	{
//     	cubeX(size=[case_w,case_h,case_depth],radius=10,center=true );

		cube(size=[case_w,case_h,case_depth]); 
		translate( [case_thickness,case_thickness,-1] ) 
		cube(size=[case_w-2*case_thickness,case_h-2*case_thickness,case_depth+case_thickness]); 
	};
}
//---------------------------------------------------------------------------------
//Instantiate the case
papiGB_case_top();
translate([0,0,-case_depth]) papiGB_case_side();

