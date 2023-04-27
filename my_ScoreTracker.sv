module ScoreTracker
						 (input Clk,
						  input frame_clk,
						  input clr,
						  input logic Reset,
						  input logic C_up,

						  output logic [8:0] C_tens,
						  output logic [8:0] C_ones
						  );
						  
logic [8:0] c_ten;
logic [8:0] c_one;


always_ff @ (posedge frame_clk) 
begin
		
		if(C_up)
		begin		
			if (c_one == 9'b000011110) 
			begin
				c_one <= 9'b000000000;
				c_ten <= c_ten + 9'b00000011;
			end
						
			else
			begin
				c_one <= c_one + 9'b000000001;
				c_ten <= c_ten;
			end
		end
			
		else if (clr)
		begin
			c_one <= 9'b000000000;
			c_ten <= 9'b000000000;
		end
		
		else
		begin
			c_one <= c_one;
			c_ten <= c_ten;
		end
			
end

always_comb 
begin
	C_tens = c_ten;
	C_ones = c_one;
end

endmodule
