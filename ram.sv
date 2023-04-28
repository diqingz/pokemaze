module  frameRAM
(
		input [23:0] data_In,
		input [18:0] write_address, read_address,
		input we, Clk,

		output logic [23:0] data_Out
);

logic [23:0] mem [0:399];

initial
begin
	$readmemh("Star.txt", mem);
	
end


always_ff @ (posedge Clk) begin
	if (we)
		mem[write_address] <= data_In;
	data_Out<= mem[read_address];
end

endmodule
