module my_GameDesign (input Clk,
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
							output logic inc,
							output logic score_CU,
							output logic clr

						   );
		
enum logic [5:0] {done,Lev,Inc_S,Inc_S2,SC1,SC2,SC3,SC4,HALT} curr_State, goto_state;

logic inc_i;
logic my_logic;
logic score_CUI;
logic clr_i;

assign my_logic = my_end;

always_ff @ (posedge Clk)
	begin
	inc <= inc_i;
		if (Reset)
			curr_State <= HALT;
		else 
			curr_State <= goto_state;
			
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
	
	goto_state = curr_State;
	
	unique case (curr_State)
		HALT:
			if (keycode == 8'd44)
				goto_state = Lev;
		Lev:
			if (E_SIGNAL)
				goto_state = done;
				
			else if (coll_CU)
				goto_state = SC1;
				
				
			else if (my_logic)
				goto_state = Inc_S;
				
			else if (sprite_coll)
				goto_state = done;
				
			else if (F_LAG)
				goto_state = done;
				
				
		Inc_S:
			goto_state = Inc_S2;
			
		Inc_S2:
			goto_state = Lev;
			
		SC1:
			goto_state = SC2;
			
		SC2:
			goto_state = SC3;
			
		SC3:
			goto_state = SC4;
			
		SC4:
			goto_state = Lev;
			
		done:
			if (keycode[7:0] == 8'h29)
				goto_state = HALT;
		
		default : ;
	endcase
	
	case(curr_State)
		HALT :
			begin
				H_STATE = 1'b1;
				if (keycode == 8'd44)
					inc_i = 1'b1;
					clr_i = 1'b1;
			end
			
		Lev :
			begin
				inc_i = 1'b0;
				score_CUI = 1'b0;
			end
			
		Inc_S:
			begin
				inc_i = 1'b1;
			end
		
		Inc_S2:
			begin
				inc_i = 1'b0;
			end
		
		SC1:
			begin
				score_CUI = 1'b0;
			end
		
		SC2:
			begin
				score_CUI = 1'b0;
			end
		
		SC3:
			begin
				score_CUI = 1'b0;
			end
		
		SC4:
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

endmodule
