module my_Counter (input logic Clk,
						  input logic Reset,
						  input logic clr,
						  input logic inc,
						  output logic [2:0] C_out
						  );
						  
logic [2:0] c;

always_ff @ (posedge Clk) begin

	if(inc)
		c <= c + 3'b001;
		
	else if (Reset || clr)
		c <= 3'b000;
		
	else
		c <= c;
end

always_comb 
begin
	C_out = c;
end

endmodule
						  
						 