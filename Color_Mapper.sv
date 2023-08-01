module  color_mapper ( input myBall,  
							  input blank,
							  input vga_clk,
//							  input clk,
                       input [9:0] DrawX, DrawY,       
							  input logic [19:0] Sprite_dx, Sprite_dy, Sprite_DXF, Sprite_DYF, Sprite_DXF2, Sprite_DYF2,
							  input logic [2:0] pokemon,
							  input logic [3:0] pokeball,
							  
							  input [23:0] ram_OUT,
							  input [23:0] fire_OUT, 
							  input [23:0] fireTwo_OUT, 
							  input my_Sprite,
							  input my_SpriteFire, 
							  input my_SpriteFireTWO,
							  input H_STATE,
							  input E_STATE,
							  input menu_screen,
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
	 

	 assign X_resize = DrawX /10; 
	 assign Y_resize = DrawY /10;

	 
	 assign numX_resize = DrawX /8;
	 assign numY_resize = DrawY /8;
	///////////////////////////////////////////
	
	
	
	 assign curr_score = (numY_resize * 10'd80) + numX_resize;
	 
//	 assign curr_pix = (Y_resize * 5'd20) + X_resize;//?
	assign curr_pix = (Y_resize * 7'd64) + X_resize;
	 
    assign VGA_R = R;
    assign VGA_G = G;
    assign VGA_B = B;
	 logic[3:0] maze_R,maze_G,maze_B, char_R, char_G, char_B, poke_R,poke_G,poke_B,poke_R2,poke_G2,poke_B2, menu_R, menu_G, menu_B;
	 logic[3:0] poke_Ra,poke_Ga,poke_Ba,poke_R2a,poke_G2a,poke_B2a,poke_Rb,poke_Gb,poke_Bb,poke_R2b,poke_G2b,poke_B2b;
	 logic[3:0] poke_Rc,poke_Gc,poke_Bc,poke_R2c,poke_G2c,poke_B2c,poke_Rd,poke_Gd,poke_Bd,poke_R2d,poke_G2d,poke_B2d;
	 logic[3:0] pokemon_Ra,pokemon_Ga,pokemon_Ba,pokemon_Rb,pokemon_Gb,pokemon_Bb,pokemon_Rc,pokemon_Gc,pokemon_Bc;
	 
	maze1_example maze1(
	.vga_clk(vga_clk),
	.DrawX(DrawX),
	.DrawY(DrawY),
	.blank(blank),
	.red(maze_R),
	.green(maze_G), 
	.blue(maze_B)
);

	menuscreen_example menu1(
	.vga_clk(vga_clk),
	.DrawX(DrawX),
	.DrawY(DrawY),
	.blank(blank),
	.red(menu_R),
	.green(menu_G), 
	.blue(menu_B)
);
 
//pokeballA---original 
	 pokeball_example pokeball1(
	.vga_clk(vga_clk),
	.DistX(Sprite_DXF), 
	.DistY(Sprite_DYF),
	.blank(blank),
	.red(poke_Ra), 
	.green(poke_Ga), 
	.blue(poke_Ba)
);
	 pokeball_example pokeball2(
	.vga_clk(vga_clk),
	.DistX(Sprite_DXF2), 
	.DistY(Sprite_DYF2),
	.blank(blank),
	.red(poke_R2a), 
	.green(poke_G2a), 
	.blue(poke_B2a)
);
//pokeballB---blue
	 blueball_example pokeball1b(
	.vga_clk(vga_clk),
	.DistX(Sprite_DXF), 
	.DistY(Sprite_DYF),
	.blank(blank),
	.red(poke_Rb), 
	.green(poke_Gb), 
	.blue(poke_Bb)
);
	 blueball_example pokeball2b(
	.vga_clk(vga_clk),
	.DistX(Sprite_DXF2), 
	.DistY(Sprite_DYF2),
	.blank(blank),
	.red(poke_R2b), 
	.green(poke_G2b), 
	.blue(poke_B2b)
);

//pokeballC---yellow
	 yellowball_example pokeball1c(
	.vga_clk(vga_clk),
	.DistX(Sprite_DXF), 
	.DistY(Sprite_DYF),
	.blank(blank),
	.red(poke_Rc), 
	.green(poke_Gc), 
	.blue(poke_Bc)
);
	 yellowball_example pokeball2c(
	.vga_clk(vga_clk),
	.DistX(Sprite_DXF2), 
	.DistY(Sprite_DYF2),
	.blank(blank),
	.red(poke_R2c), 
	.green(poke_G2c), 
	.blue(poke_B2c)
);

//pokeballD---pink
	 pinkball_example pokeball1d(
	.vga_clk(vga_clk),
	.DistX(Sprite_DXF), 
	.DistY(Sprite_DYF),
	.blank(blank),
	.red(poke_Rd), 
	.green(poke_Gd), 
	.blue(poke_Bd)
);
	 pinkball_example pokeball2d(
	.vga_clk(vga_clk),
	.DistX(Sprite_DXF2), 
	.DistY(Sprite_DYF2),
	.blank(blank),
	.red(poke_R2d), 
	.green(poke_G2d), 
	.blue(poke_B2d)
);


 /////////////////////////////////////////
//pokemonA---charmander 
	 charmander_example chara(
	.vga_clk(vga_clk),
	.DistX(Sprite_dx), 
	.DistY(Sprite_dy),
	.blank(blank),
	.red(pokemon_Ra), 
	.green(pokemon_Ga), 
	.blue(pokemon_Ba)
); 
 
//pokemonB---squirtle 
	 squirtle_example charb(
	.vga_clk(vga_clk),
	.DistX(Sprite_dx), 
	.DistY(Sprite_dy),
	.blank(blank),
	.red(pokemon_Rb), 
	.green(pokemon_Gb), 
	.blue(pokemon_Bb)
); 

//pokemonC---piplup
	 piplup_example charc(
	.vga_clk(vga_clk),
	.DistX(Sprite_dx), 
	.DistY(Sprite_dy),
	.blank(blank),
	.red(pokemon_Rc), 
	.green(pokemon_Gc), 
	.blue(pokemon_Bc)
); 
  always_comb
  begin
  if(pokeball[0])
			begin
			poke_R = poke_Ra;
			poke_G = poke_Ga;
			poke_B = poke_Ba;
			poke_R2 = poke_R2a;
			poke_G2 = poke_G2a;
			poke_B2 = poke_B2a;
			end
	else if(pokeball[1])
			begin
			poke_R = poke_Rb;
			poke_G = poke_Gb;
			poke_B = poke_Bb;
			poke_R2 = poke_R2b;
			poke_G2 = poke_G2b;
			poke_B2 = poke_B2b;
			end
	else if(pokeball[2])
			begin
			poke_R = poke_Rc;
			poke_G = poke_Gc;
			poke_B = poke_Bc;
			poke_R2 = poke_R2c;
			poke_G2 = poke_G2c;
			poke_B2 = poke_B2c;
			end
	else if(pokeball[3])
			begin
			poke_R = poke_Rc;
			poke_G = poke_Gc;
			poke_B = poke_Bc;
			poke_R2 = poke_R2c;
			poke_G2 = poke_G2c;
			poke_B2 = poke_B2c;
			end
	else 
	begin
			poke_R = poke_Ra;
			poke_G = poke_Ga;
			poke_B = poke_Ba;
			poke_R2 = poke_R2a;
			poke_G2 = poke_G2a;
			poke_B2 = poke_B2a;
	end
	
	end
//	
	always_comb
	begin
		////setting rgb for pokemon
		if(pokemon == 3'd1)
			begin
			char_R = pokemon_Ra;
			char_G = pokemon_Ga;
			char_B = pokemon_Ba;
			end
		else if(pokemon == 3'd2)
		begin
		char_R = pokemon_Rb;
		char_G = pokemon_Gb;
		char_B = pokemon_Bb;
		end
		else if(pokemon ==3'd3)
			begin
			char_R = pokemon_Rc;
			char_G = pokemon_Gc;
			char_B = pokemon_Bc;
			end
		else 
			begin
			char_R = pokemon_Ra;
			char_G = pokemon_Ga;
			char_B = pokemon_Ba;
			end
			
  end
 
    always_comb
    begin
		//////setting rgb for pokeball
//		case(pokeball)
//		4'b0001:
//		begin
//		poke_R = poke_Ra;
//		poke_G = poke_Ga;
//		poke_B = poke_Ba;
//		poke_R2 = poke_R2a;
//		poke_G2 = poke_G2a;
//		poke_B2 = poke_B2a;
//		end
//		default:;
//		endcase
//		
//		if(pokeball[0])
//			begin
//			poke_R = poke_Ra;
//			poke_G = poke_Ga;
//			poke_B = poke_Ba;
//			poke_R2 = poke_R2a;
//			poke_G2 = poke_G2a;
//			poke_B2 = poke_B2a;
//			end
//		if(pokeball[1])
//			begin
//			poke_R = poke_Rb;
//			poke_G = poke_Gb;
//			poke_B = poke_Bb;
//			poke_R2 = poke_R2b;
//			poke_G2 = poke_G2b;
//			poke_B2 = poke_B2b;
//			end
//		if(pokeball[2])
//			begin
//			poke_R = poke_Rc;
//			poke_G = poke_Gc;
//			poke_B = poke_Bc;
//			poke_R2 = poke_R2c;
//			poke_G2 = poke_G2c;
//			poke_B2 = poke_B2c;
//			end
//		if(pokeball[3])
//			begin
//			poke_R = poke_Rc;
//			poke_G = poke_Gc;
//			poke_B = poke_Bc;
//			poke_R2 = poke_R2c;
//			poke_G2 = poke_G2c;
//			poke_B2 = poke_B2c;
//			end
//		////setting rgb for pokemon
//		case(pokemon)
//		3'b001:
//		begin
//			char_R = pokemon_Ra;
//			char_G = pokemon_Ga;
//			char_B = pokemon_Ba;
//		end
//		default:;
//		endcase
//		
//		if(pokemon[0])
//			begin
//			char_R = pokemon_Ra;
//			char_G = pokemon_Ga;
//			char_B = pokemon_Ba;
//			end
//		if(pokemon[1])
//		begin
//		char_R = pokemon_Rb;
//		char_G = pokemon_Gb;
//		char_B = pokemon_Bb;
//		end
//		if(pokemon[2])
//			begin
//			char_R = pokemon_Rc;
//			char_G = pokemon_Gc;
//			char_B = pokemon_Bc;
//			end
//			
///////////////////////////////////////			
		if(blank==1'b0)
		begin
		  R = 8'b0;
		  G = 8'b0;
		  B = 8'b0;
		end
		
		else
		begin
		  if ((my_SpriteFire == 1'b1) && ({poke_R, poke_G, poke_B} != 12'hffff) &&({poke_R, poke_G, poke_B} != 12'h0000) && !(H_STATE || E_STATE||menu_screen))
//		  if ((my_SpriteFire == 1'b1) && ({poke_Ra, poke_Ga, poke_Ba} != 12'hffff) &&({poke_Ra, poke_Ga, poke_Ba} != 12'h0000) && !(H_STATE || E_STATE||menu_screen))
		  begin
				R   = {poke_R,4'b0};
				G   = {poke_G,4'b0};
				B   = {poke_B,4'b0};
//				R   = {poke_Ra,4'b0};
//				G   = {poke_Ga,4'b0};
//				B   = {poke_Ba,4'b0};
		  end
		  
		  else if ((my_SpriteFireTWO == 1'b1) && ({poke_R2, poke_G2, poke_B2} != 12'hffff) &&({poke_R2, poke_G2, poke_B2} != 12'h0000) && !(H_STATE || E_STATE||menu_screen))
//		  else if ((my_SpriteFireTWO == 1'b1) && ({poke_R2a, poke_G2a, poke_B2a} != 12'hffff) &&({poke_R2a, poke_G2a, poke_B2a} != 12'h0000) && !(H_STATE || E_STATE||menu_screen))
		  begin
//				R   = {poke_R2a,4'b0};
//				G   = {poke_G2a,4'b0};
//				B   = {poke_B2a,4'b0};
				R   = {poke_R2,4'b0};
				G   = {poke_G2,4'b0};
				B   = {poke_B2,4'b0};
		  end
		  
		  else if ((my_Sprite == 1'b1) && ({char_R, char_G, char_B} != 12'hffff) && !(H_STATE || E_STATE||menu_screen))
// else if ((my_Sprite == 1'b1)  && !(H_STATE || E_STATE||menu_screen) && (pokemon[0]||pokemon[1]||pokemon[2]))//HARDWIRE
//		  else if ((my_Sprite == 1'b1) && ({char_R, char_G, char_B} != 12'hffff) && !(H_STATE || E_STATE||menu_screen) && (pokemon[0]||pokemon[1]||pokemon[2]))//HARDWIRE
		  begin
//				R   = {pokemon_Ra,4'b0};
//				G   = {pokemon_Ga, 4'b0};
//				B   = {pokemon_Ba, 4'b0};
				R   = {char_R,4'b0};
				G   = {char_G, 4'b0};
				B   = {char_B, 4'b0};

		  end
		  
		  

		  
		  else if ((ones[curr_score] == 1'b1) && !(H_STATE || E_STATE||menu_screen))
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
					R = {maze_R, 4'b0};
					G = {maze_G, 4'b0};
					B = {maze_B, 4'b0};
				
					end
				else if (menu_screen)
					begin
					R = {menu_R, 4'b0};
					G = {menu_G,4'b0};
					B = {menu_B, 4'b0};
					
					end
				
				else 
					begin
//					R = 8'h81;
//					G = 8'h78;
//					B = 8'h71;
					R = {maze_R, 4'b0};
					G = {maze_G, 4'b0};
					B = {maze_B, 4'b0};
					end
		  end
		  
		  
		  else if ((DrawY < 10'd64) && !(H_STATE || E_STATE||menu_screen) )
				begin
					R = 8'hf7;
					G = 8'heb;
					B = 8'h94;
//					R = 8'hff;
//					G = 8'he6;
//					B = 8'hc9;
				end
				
		  else if ((DrawY > 10'd416) && !(H_STATE || E_STATE||menu_screen))
				begin
					R = 8'hff;
					G = 8'hf0;
					B = 8'h00;
//					R = 8'hff;
//					G = 8'he6;
//					B = 8'haa;
					
				end
		  
        else 
        begin
				  R = 8'hff; 
              G = 8'hf0 - {1'b0, DrawY[9:3]};
              B = 8'h00;

//					R = 8'hff;
//					G = 8'he6;
//					B = 8'haa - {1'b0, DrawY[9:3]};
        end
		 end 
//				R   = ram_OUT[23:16];
//				G   = ram_OUT[15:8];
//				B   = ram_OUT[7:0];
//				R   = {peach_R,4'b0};
//				G   = {peach_G, 4'b0};
//				B   = {peach_B, 4'b0};
    end 
	 
	 
    
endmodule
