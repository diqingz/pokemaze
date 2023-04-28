module maze1_rom (
	input logic clock,
	input logic [12:0] address,
	output logic [11:0] q
);

logic [11:0] memory [0:4499] /* synthesis ram_init_file = "./maze1/maze1.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
