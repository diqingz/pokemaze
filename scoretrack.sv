module scoretrack
						 (input Clk,
						  input frame_clk,
						  input clear,
						  input logic Reset,
						  input logic collisonUp,
						  
						  output logic [7:0] bounce,

						  output logic [8:0] tens,
						  output logic [8:0] ones
						  );
						  
logic [8:0] c_ten;
logic [8:0] c_one;


always_ff @ (posedge frame_clk) 
begin
		
		if(collisonUp)
		begin
			bounce <= bounce + 1;
			if (ones == 9'b000011110) 
			begin
				ones <= 9'b000000000;
				tens <= tens + 9'b00000011;
			end
						
			else
			begin
				ones <= ones + 9'b000000001;
				tens <= tens;
			end
		end
			
		else if (clear)
		begin
			bounce <= '0;
			ones <= 9'b000000000;
			tens <= 9'b000000000;
		end
		
		else
		begin
			ones <= ones;
			tens <= tens;
		end
			
end

always_comb 
begin
	tens = tens;
	ones = ones;
end

endmodule
