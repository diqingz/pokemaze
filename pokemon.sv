module pokemon ( input	 		 Clk,                
											 Reset,             
											 frame_clk,          
							input [9:0]  DrawX, DrawY,       
							input [7:0]  keycode,
							input logic  bnceL,
							input logic  bnceR,
							input logic  bnceU,
							input logic  bnceD,
							input logic  spr_on,
							input logic  inc,
							output logic [19:0] Sprite_dx,
							output logic [19:0] Sprite_dy,
							output logic [9:0] sprite_W,
							output logic [9:0] sprite_H,
							output logic [19:0] sprite_xpos,
							output logic [19:0] sprite_ypos,
							output logic L,
							output logic R,
							output logic U,
							output logic D,
							output logic bcingL,
							output logic bcingR,
							output logic bcingU,
							output logic bcingD,
							output logic my_Sprite,
							output logic my_start,
							output logic my_end
);

	logic bcingl_i;
	logic bcingr_i;
	logic bcingu_i;
	logic bcingd_i;
	logic l_i;
	logic r_i;
	logic u_i;
	logic d_i;

	 parameter ss_Y = 10'd20;
	 parameter ss_X = 10'd20;
	 parameter s_XS = 10'b1;
	 parameter s_YS = 10'b1;
		
    logic [9:0] sx_pos, sx_mot, sy_pos, sy_mot;
    logic [9:0] sx_posi, sx_moti, sy_posi, sy_moti;
	 
	 assign sprite_W = ss_X;
	 assign sprite_H = ss_Y;
	 
	 assign sprite_xpos = sx_pos;
	 assign sprite_ypos = sy_pos;
	 
	 logic flag;
	 
	 
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end

    always_ff @ (posedge Clk)
    begin
        if (Reset || inc)
        begin
            sx_pos <= 10'd336;
            sy_pos <= 10'd33; 
            sx_mot <= 10'd0;				
            sy_mot <= 10'd0;				
        end
        else
        begin
            sx_pos <= sx_posi;
            sy_pos <= sy_posi;
            sx_mot <= sx_moti;
            sy_mot <= sy_moti;
        end
    end	
	 
	 always_ff @ (posedge Clk)
	 begin
		L    <= l_i;
		R    <= r_i;
		U    <= u_i;
		D    <= d_i;
		
		bcingL  <= bcingl_i;
		bcingR  <= bcingr_i;
		bcingU  <= bcingu_i;
		bcingD  <= bcingd_i;
	 end
	
	 always_comb
    begin
        sx_posi = sx_pos;
        sy_posi = sy_pos;
        sx_moti = sx_mot;
        sy_moti = sy_mot;
		  
		  l_i = L;
		  r_i = R;
		  u_i = U;
		  d_i = D;
		  
		  bcingl_i    = bcingL;
		  bcingr_i    = bcingR;
		  bcingu_i    = bcingU;
		  bcingd_i    = bcingD;
        
        if (frame_clk_rising_edge && spr_on)
        begin
		  
				if (keycode == 8'h04) //This will move the sprite down when we press A
					 begin
					 sx_moti = (~(s_XS) + 1'b1);  
					 sy_moti = 10'd0;							 
					 
					 l_i    = 1'b1;
					 r_i    = 1'b0;
					 u_i    = 1'b0;
					 d_i    = 1'b0;
					 end
					 
				else if (keycode == 8'h07) //This will move the sprite right when we press D
					 begin
					 sx_moti = s_XS;					 
					 sy_moti = 10'd0;							 
					 
					 l_i    = 1'b0;
					 r_i    = 1'b1;
					 u_i    = 1'b0;
					 d_i    = 1'b0;
					 end
					 
				else if (keycode == 8'h1A) //This will move the sprite up when we press W
					 begin
					 sy_moti = (~(s_YS) + 1'b1);  
					 sx_moti = 10'd0;							 
					 
					 l_i    = 1'b0;
					 r_i    = 1'b0;
					 u_i    = 1'b1;
					 d_i    = 1'b0;
					 end
					 
				else if (keycode == 8'h16) //This will move the sprite down when we press S
					 begin
					 sy_moti = s_YS;					 
					 sx_moti = 10'd0;							 
					 
					 l_i    = 1'b0;
					 r_i    = 1'b0;
					 u_i    = 1'b0;
					 d_i    = 1'b1;
					 end

					 if (bnceL) //This will move the sprite left when we press A
					 begin
					 sx_moti = (~(s_XS) + 1'b1);  
					 sy_moti = 10'd0;							 
					 
					 bcingl_i   = 1'b1;
					 bcingr_i   = 1'b0;
					 bcingu_i   = 1'b0;
					 bcingd_i   = 1'b0;
					 end
					 
				else if (bnceR) //This will move the sprite right when we press D
					 begin
					 sx_moti = s_XS;					
					 sy_moti = 10'd0;							
					 
					 bcingl_i   = 1'b0;
					 bcingr_i   = 1'b1;
					 bcingu_i   = 1'b0;
					 bcingd_i   = 1'b0;
					 end
				else if (bnceU) //This will move the sprite up when we press W
					 begin
					 sy_moti = (~(s_YS) + 1'b1);  
					 sx_moti = 10'd0;							 
					 
					 bcingl_i   = 1'b0;
					 bcingr_i   = 1'b0;
					 bcingu_i   = 1'b1;
					 bcingd_i   = 1'b0;
					 end
				else if (bnceD) //This will move the sprite down when we press S
					 begin
					 sy_moti = s_YS;					
					 sx_moti = 10'd0;							 
					 
					 bcingl_i  = 1'b0;
					 bcingr_i  = 1'b0;
					 bcingu_i  = 1'b0;
					 bcingd_i  = 1'b1;
					 end

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
	 
	 always_comb
	 begin
		if ((sy_pos < 10'd64) && spr_on)
			my_start = 1'b1;
		else
			my_start = 1'b0;
		
		if ((sy_pos > 10'd416) && spr_on)
			my_end = 1'b1;
		else
			my_end = 1'b0;
	 
	 end
	 
	 

endmodule 