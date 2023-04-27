module ram_F 
		(
		input [23:0] data_In,
		input [18:0] write_address, read_address_F,
		input we, Clk,

		output logic [23:0] data_out_F
		);
		
		
logic [23:0] mem [0:399];

initial
begin
	$readmemh("my_FireballText.txt", mem);
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_out_F <= mem[read_address_F];
end

endmodule
