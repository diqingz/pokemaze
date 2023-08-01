module pokeball (			  input 	  Clk,               
												  Reset,              
												  frame_clk,					
									  input spr_on,
									  input inc,         
									  input [9:0]   DrawX, DrawY,     
									  input [7:0]   keycode,
									  output logic [19:0] Sprite_dx,
					              output logic [19:0] Sprite_dy,
									  output logic [9:0] sprite_W,
									  output logic [9:0] sprite_H,
									  output logic [19:0] sprite_xpos,
									  output logic [19:0] sprite_ypos,
										
									 output logic  my_Sprite
					
					);
					
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end

	 parameter ss_Y = 10'd20;
	 parameter ss_X = 10'd20;
	 parameter sx_step = 10'b10;
	 parameter sy_step = 10'b0;
	 
	 parameter m = 10'b10;
	 parameter sy_pos = 10'd192;
	 
		
    logic [9:0] sx_pos, sx_mot, sy_mot; 
    logic [9:0] sx_posi, sx_motin, sy_posi, sy_motin;
	 
	 assign sprite_W = ss_X;
	 assign sprite_H = ss_Y;
	 
	 assign sprite_xpos = sx_pos;
	 assign sprite_ypos = sy_pos;
	 	 
    always_ff @ (posedge Clk)
    begin
        if (Reset || inc)
        begin
            sx_pos <= 10'd10;
            sx_mot <= 10'd0;				
            sy_mot <= 10'd0;				
        end
        else
        begin
            sx_pos <= sx_posi;
            sx_mot <= sx_motin;
            sy_mot <= sy_motin;
        end
    end	
	 
	 always_comb
    begin
        sx_posi = sx_pos;
        sy_posi = sy_pos;
        sx_motin = sx_mot;
        sy_motin = sy_mot;
		
		if (frame_clk_rising_edge && spr_on)
      begin  
			sx_motin = m;
			sy_motin = 10'd0;
	
			sx_posi = sx_pos + sx_mot;
         sy_posi = sy_pos + sy_mot;		
		end
	end
		
assign Sprite_dx = DrawX - sx_pos;
assign Sprite_dy = DrawY - sy_pos;

	 always_comb 
	 begin
		if((Sprite_dx <= ss_X) && (Sprite_dy <= ss_Y))
			my_Sprite = 1'b1;
		else
			my_Sprite = 1'b0;
	 end

endmodule
