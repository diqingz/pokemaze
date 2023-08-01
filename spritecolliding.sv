module sprite_colli ( 	 input [9:0] sprite_WF,
								 input [9:0] sprite_HF,
								 input [19:0] sprite_xposF,
								 input [19:0] sprite_yposF,
								 input [9:0] sprite_WF2,
								 input [9:0] sprite_HF2,
								 input [19:0] sprite_xposF2,
								 input [19:0] sprite_yposF2,
								 input [19:0] sprite_xpos,
								 input [19:0] sprite_ypos,
								 input [9:0] sprite_W,
								 input [9:0] sprite_H,
								 input spr_on,
								 output logic sprite_coll
								 );
								 
logic [19:0] D_X;
logic [19:0] D_Y;
logic [19:0] D_Y2;
logic [19:0] D_X2;

assign D_Y = (sprite_ypos + 10'd20) - sprite_yposF;
assign D_X = sprite_xpos - sprite_xposF;	



assign D_Y2 = (sprite_ypos + 10'd20) - sprite_yposF2;
assign D_X2 = sprite_xpos - sprite_xposF2;
				 								 
always_comb begin		
		if(((D_Y >= 1'b0 && D_Y <= 10'd40) && (D_X >= 1'b0 && D_X <= 10'd20)) || 
			((D_Y2 >= 1'b0 && D_Y2 <= 10'd40) && (D_X2 >= 1'b0 && D_X2 <= 10'd20)) )
			sprite_coll = 1'b1;
		else 
			sprite_coll = 1'b0;
end
endmodule 

