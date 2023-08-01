module menuscreen_rom (
	input logic clock,
	input logic [16:0] address,
	output logic [7:0] q
);

logic [7:0] memory [0:67499] /* synthesis ram_init_file = "./menuscreen/menuscreen.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
