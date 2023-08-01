

module FSM (input Clk,
							input frame_clk,
							input [7:0] keycode,
							input E_SIGNAL,
							input Reset,
							input my_start,
							input my_end,
							input coll_CU,
							input [8:0] C_ones,
							input sprite_coll,
							input F_LAG,


							output logic H_STATE,
							output logic E_STATE,
							output logic inc,menu_screen,
							output logic [2:0] pokemon,
							output logic [3:0] pokeball,
							output logic score_CU,
							output logic clr

						   );
		
enum logic [5:0] {done,games,increment1,increment2,score1,score2,score3,score4,HALT, menu} curr_State, goto_state;
enum logic [2:0] {choose, pokemona,pokemonb,pokemonc}curstate, nextstate;
enum logic [2:0] {choose_, pokeballa,pokeballb,pokeballc,pokeballd} curstate_, nextstate_;

assign pokemon = curstate;

logic inc_i;
logic my_logic;
logic score_CUI;
logic clr_i;

assign my_logic = my_end;

always_ff @ (posedge Clk)
	begin
	inc <= inc_i;
		if (Reset)
		begin
			curr_State <= HALT;
			curstate <= choose;
			curstate_ <= choose_;
		end
		else 
		begin
			curr_State <= goto_state;
			curstate <= nextstate;
			curstate_<=nextstate_;
		end
	end
	
always_ff @ (posedge frame_clk) 
begin	
   clr <= clr_i;
	score_CU <= score_CUI;
end
	
	
always_comb 
begin

	H_STATE = 1'b0;
	E_STATE = 1'b0;
	inc_i = 1'b0;
	score_CUI = 1'b0;
	clr_i = 1'b0;
	menu_screen = 1'b0;
	goto_state = curr_State;
	nextstate=curstate;
//	pokemon = 3'b000;
	unique case (curr_State)
		HALT:
			if (keycode == 8'd44)
				goto_state = games;
			else if(keycode == 8'd16)
			   goto_state = menu;
				
		menu:
			if(keycode == 8'd40)
				goto_state = games;
		
		games:
			if (E_SIGNAL)
				goto_state = done;
				
			else if (coll_CU)
				goto_state = score1;
				
				
			else if (my_logic)
				goto_state = increment1;
				
			else if (sprite_coll)
				goto_state = done;
				
			else if (F_LAG)
				goto_state = done;
				
				
		increment1:
			goto_state = increment2;
			
		increment2:
			goto_state = games;
			
		score1:
			goto_state = score2;
			
		score2:
			goto_state = score3;
			
		score3:
			goto_state = score4;
			
		score4:
			goto_state = games;
			
		done:
			if (keycode[7:0] == 8'h29)
				goto_state = HALT;
		
		default : ;
	endcase
	
	case(curr_State)
		HALT :
			begin
				H_STATE = 1'b1;
				if (keycode == 8'd44||keycode ==8'd16)
					inc_i = 1'b1;
					clr_i = 1'b1;
			end
		menu:
		begin
			menu_screen = 1'b1;
//			pokemon = 3'b010;
			if ((keycode == 8'd13) && (!(keycode == 8'd14)) && (!(keycode == 8'd15))&& menu_screen)
				nextstate = pokemona;
			else if (!(keycode == 8'd13) && ((keycode == 8'd14)) && (!(keycode == 8'd15)) &&menu_screen)
				nextstate = pokemonb;
			else if (!(keycode == 8'd13) && (!(keycode == 8'd14)) && ((keycode == 8'd15)) &&menu_screen)
				nextstate = pokemonc;
			else
				nextstate=curstate;
			
		end
			
		games :
			begin
				inc_i = 1'b0;
				score_CUI = 1'b0;
			end
			
		increment1:
			begin
				inc_i = 1'b1;
			end
		
		increment2:
			begin
				inc_i = 1'b0;
			end
		
		score1:
			begin
				score_CUI = 1'b0;
			end
		
		score2:
			begin
				score_CUI = 1'b0;
			end
		
		score3:
			begin
				score_CUI = 1'b0;
			end
		
		score4:
			begin
				score_CUI = 1'b1;
			end
									
		done : 
			begin
				E_STATE = 1'b1;
			end
			
		default : ;
		
	endcase	
	

	
end	



///////FSM FOR POKEMON
//always_comb 
//begin
/////defaults
//	pokemon = 3'b000;
//	nextstate = curstate;
//	
////	if(menu_screen)
////	nextstate = curstate;
////	else
////	nextstate = nextstate;
//	
//	
//	unique case (curstate)
//	choose:
//	begin
//	if ((keycode == 8'd13) && (!(keycode == 8'd14)) && (!(keycode == 8'd15))&& menu_screen)
//	nextstate = pokemona;
//	else if (!(keycode == 8'd13) && ((keycode == 8'd14)) && (!(keycode == 8'd15)) &&menu_screen)
//	nextstate = pokemonb;
//	else if (!(keycode == 8'd13) && (!(keycode == 8'd14)) && ((keycode == 8'd15)) &&menu_screen)
//	nextstate = pokemonc;
//	end
//	
//	pokemona:
//	begin
//	if(menu_screen)
//	nextstate = choose;////comment out?
//	end
//	
//	pokemonb:
//	if(menu_screen)
//	nextstate = choose;
//	
//	pokemonc:
//	if(menu_screen)
//	nextstate = choose;
//	default:;
//	endcase
//
//	case(curr_State)
//	
//	choose:;
////	pokemon = 3'b001;
//
//	
//	pokemona:
//	pokemon = 3'b001;
//	
//	pokemonb:
//	pokemon = 3'b010;
//	
//	pokemonc:
//	pokemon = 3'b100;
//	
//	default:pokemon = 3'b010;
//	
//	endcase
//	
//
//end


////FSM FOR POKEBALL
always_comb 
begin
	pokeball = 4'b0000;
	
	
//	if(menu_screen)
	nextstate_ = curstate_;
	
	unique case (curstate_)
	choose_:
	begin
	if ((keycode == 8'd6) && (!(keycode == 8'd25)) && (!(keycode == 8'd5)) && (!(keycode == 8'd17)))
	nextstate_ = pokeballa;
	if (!(keycode == 8'd6) && ((keycode == 8'd25)) && (!(keycode == 8'd5)) && (!(keycode == 8'd17)))
	nextstate_ = pokeballb;
	if (!(keycode == 8'd6) && (!(keycode == 8'd25)) && ((keycode == 8'd5)) && (!(keycode == 8'd17)))
	nextstate_ = pokeballc;
	if (!(keycode == 8'd6) && (!(keycode == 8'd25)) && (!(keycode == 8'd5)) && ((keycode == 8'd17)))
	nextstate_ = pokeballd;
	end
	
	pokeballa:
	begin
	if(menu_screen)
	nextstate_ = choose_;
	end
	pokeballb:
	begin
	if(menu_screen)
	nextstate_ = choose_;
	end
	pokeballc:
	begin
	if(menu_screen)
	nextstate_ = choose_;
	end
	
	pokeballd:
	begin
	if(menu_screen)
	nextstate_ = choose_;
	end
	
	default:;
	endcase
	
	case(curstate_)
	
	choose_:;
	
	pokeballa:
	pokeball = 4'b0001;
	
	pokeballb:
	pokeball = 4'b0010;
	
	pokeballc:
	pokeball = 4'b0100;
	
	pokeballd:
	pokeball = 4'b1000;
	
	default:
	pokeball = 4'b1000;
	endcase

end

endmodule
