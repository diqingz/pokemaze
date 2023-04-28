module  color_mapper ( input myBall,  
							  input blank,
							  input vga_clk,
                       input [9:0] DrawX, DrawY,       
//							  input [11:0] DrawX, DrawY,  
							  
							  input [23:0] ram_OUT,
							  input [23:0] fire_OUT, 
							  input [23:0] fireTwo_OUT, 
							  input my_Sprite,
							  input my_SpriteFire, 
							  input my_SpriteFireTWO,
							  input H_STATE,
							  input E_STATE,
							  input logic [0:4799] ones,
							  input logic [0:4799] tens,
							  input logic [3071:0] C_pic,
                       output logic [7:0] VGA_R, VGA_G, VGA_B 
                     );
    

//    logic [9:0] X_resize;
//	 logic [9:0] Y_resize;
//	 logic [7:0] R,G,B;
//	 logic [9:0] curr_pix;

    logic [11:0] X_resize;
	 logic [11:0] Y_resize;
	 logic [7:0] R,G,B;
	 logic [11:0] curr_pix;
	 
	 
	 
	 logic [12:0] numX_resize;
	 logic [12:0] numY_resize;
	 
	 logic [13:0] curr_score;
	 
//	 assign X_resize = DrawX >> 3'd5; 
//	 assign Y_resize = DrawY >> 3'd5;
//	 
	 assign X_resize = DrawX /10; 
	 assign Y_resize = DrawY /10;
//
//	 assign X_resize = DrawX >> 3'd3; 
//	 assign Y_resize = DrawY >> 3'd3;
	 
//	 assign numX_resize = DrawX /2 ;
//	 assign numY_resize = DrawY /2 ;
	 
	 assign numX_resize = DrawX /8;
	 assign numY_resize = DrawY /8;
	///////////////////////////////////////////
	
	
	
	 assign curr_score = (numY_resize * 10'd80) + numX_resize;/////?????????
//	 assign curr_score = (numY_resize * 10'd80) + numX_resize;
	 
//	 assign curr_pix = (Y_resize * 5'd20) + X_resize;//?
	assign curr_pix = (Y_resize * 7'd64) + X_resize;
	 
    assign VGA_R = R;
    assign VGA_G = G;
    assign VGA_B = B;
	 logic[3:0] maze_R,maze_G,maze_B;
	 
	maze1_example maze1(
	.vga_clk(vga_clk),
	.DrawX(DrawX),
	.DrawY(DrawY),
	.blank(blank),
	.red(maze_R),
	.green(maze_G), 
	.blue(maze_B)
);
	 
    
    always_comb
    begin

		  if ((my_SpriteFire == 1'b1) && (fire_OUT[23:0] != 24'hffffff) && (fire_OUT[23:0] != 24'h0000) && !(H_STATE || E_STATE))
		  begin
				R   = fire_OUT[23:16];
				G   = fire_OUT[15:8];
				B   = fire_OUT[7:0];
		  end
		  
		  else if ((my_SpriteFireTWO == 1'b1) && (fireTwo_OUT[23:0] != 24'hffffff) && (fireTwo_OUT[23:0] != 24'h0000) && !(H_STATE || E_STATE))
		  begin
				R   = fireTwo_OUT[23:16];
				G   = fireTwo_OUT[15:8];
				B   = fireTwo_OUT[7:0];
		  end
		  
		  else if ((my_Sprite == 1'b1) && (ram_OUT[23:0] != 24'h0000) && !(H_STATE || E_STATE))
		  begin
				R   = ram_OUT[23:16];
				G   = ram_OUT[15:8];
				B   = ram_OUT[7:0];
		  end
		  
		  

		  
		  else if ((ones[curr_score] == 1'b1) && !(H_STATE || E_STATE))
		  begin
		  			R = 8'hfe;
					G = 8'h95;
					B = 8'h33;
		  end
		  
		  
		  else if (C_pic[curr_pix])
		  begin
				if (H_STATE || E_STATE) 
					begin
//					R = 8'h05;
//					G = 8'h0f;
//					B = 8'hfe - {1'b0, DrawX[9:3]};
					R = maze_R;
					G = maze_G;
					B = maze_B;
					end
				else 
					begin
//					R = 8'h81;
//					G = 8'h78;
//					B = 8'h71;
					R = maze_R;
					G = maze_G;
					B = maze_B;
					end
		  end
		  
		  
		  else if ((DrawY < 10'd64) && !(H_STATE || E_STATE) )
				begin
//					R = 8'h00;
//					G = 8'hff;
//					B = 8'h00;
					R = 8'hff;
					G = 8'he6;
					B = 8'hc9;
				end
				
		  else if ((DrawY > 10'd416) && !(H_STATE || E_STATE))
				begin
//					R = 8'hff;
//					G = 8'hf0;
//					B = 8'h00;
					R = 8'hff;
					G = 8'he6;
					B = 8'haa;
					
				end
		  
        else 
        begin
//				  R = 8'hff; 
//              G = 8'hf0 - {1'b0, DrawY[9:3]};
//              B = 8'h00;

					R = 8'hff;
					G = 8'he6;
					B = 8'haa - {1'b0, DrawY[9:3]};
        end
//		  
//		  R = maze_R;
//					G = maze_G;
//					B = maze_B;
    end 
	 
	 
    
endmodule
