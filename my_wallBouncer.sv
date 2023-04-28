module my_wallBouncer (
						 input [3071:0] C_map,
						 input [9:0] sprite_W,
						 input [9:0] sprite_H,
						 input [19:0] sprite_xpos,
						 input [19:0] sprite_ypos,
						 input D,
						 input U,
						 input L,
						 input R,
						 input bcingU,
						 input bcingD,
						 input bcingL,
						 input bcingR,
						 output logic bnceL,
						 output logic bnceD,
						 output logic bnceU,
						 output logic bnceR,
						 output logic [3071:0] C_pic,
						 output logic coll_CU
						 );

assign C_pic = C_map[3071:0];
//logic [9:0] A_left;
//logic [9:0] A_right;
//logic [9:0] B_right;
//logic [9:0] B_left;
//logic [9:0] Y_resize;
//logic [9:0] X_resize;
//logic [12:0] WX_resize;
//logic [12:0] HY_resize;

logic [11:0] A_left;
logic [11:0] A_right;
logic [11:0] B_right;
logic [11:0] B_left;
logic [11:0] Y_resize;
logic [11:0] X_resize;
logic [13:0] WX_resize;
logic [13:0] HY_resize;


always_comb begin

Y_resize = (sprite_ypos /10); 
X_resize = (sprite_xpos /10); 
WX_resize = ((sprite_W + sprite_xpos) /10);
HY_resize = ((sprite_H + sprite_ypos) /10);
A_left  = (Y_resize * 7'd64) + X_resize;
A_right = (Y_resize * 7'd64) + WX_resize;
B_left  = ((HY_resize) * 7'd64) + X_resize;
B_right = ((HY_resize) * 7'd64) + WX_resize;

//Y_resize = (sprite_ypos >> 5'd5); 
//X_resize = (sprite_xpos >> 5'd5); 
//WX_resize = ((sprite_W + sprite_xpos) >> 5'd5);
//HY_resize = ((sprite_H + sprite_ypos) >> 5'd5);
//A_left  = (Y_resize * 5'd20) + X_resize;
//A_right = (Y_resize * 5'd20) + WX_resize;
//B_left  = ((HY_resize) * 5'd20) + X_resize;
//B_right = ((HY_resize) * 5'd20) + WX_resize;

	bnceL  = 1'b0;
	bnceD  = 1'b0;
   bnceU  = 1'b0;
	bnceR  = 1'b0;


	if (C_map[A_left] == 1'b1)
	begin
		if(L)
			bnceR = 1'b1;
	   else if (U)
			bnceD = 1'b1;
	end
	
   else if (C_map[A_right] == 1'b1)
	begin
		if (R)
			bnceL = 1'b1;
	   else if (U)
			bnceD = 1'b1;
	end

   else if (C_map[B_left] == 1'b1)
	begin
		if(L)
			bnceR = 1'b1;
	   else if (D)
			bnceU = 1'b1;
	end

   else if (C_map[B_right] == 1'b1)
	begin
	   if (R)
			bnceL = 1'b1;
	   else if (D)
			bnceU = 1'b1;
	end
	
	
	if (C_map[A_left] == 1'b1)
	begin
		if(bcingL)
			bnceR = 1'b1;
	   else if (bcingU)
			bnceD = 1'b1;
	end
	
   else if (C_map[A_right] == 1'b1)
	begin
		if (bcingR)
			bnceL = 1'b1;
	   else if (bcingU)
			bnceD = 1'b1;
	end

   else if (C_map[B_left] == 1'b1)
	begin
		if(bcingL)
			bnceR = 1'b1;
	   else if (bcingD)
			bnceU = 1'b1;
	end

   else if (C_map[B_right] == 1'b1)
	begin
	   if (bcingR)
			bnceL = 1'b1;
	   else if (bcingD)
			bnceU = 1'b1;
	end

end

assign coll_CU = bnceR || bnceU || bnceD || bnceL;
	
endmodule 