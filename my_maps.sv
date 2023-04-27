module my_maps (input [2:0] count,
					  input E_STATE,
					  output logic [299:0] C_map
					  );


always_comb begin

	if (count == 3'b000)
	begin
	C_map[19:0]    = 20'h00000;  
	C_map[39:20]   = 20'h00000;  
	C_map[59:40]   = 20'h00000;  
	C_map[79:60]   = 20'h00000;  
	C_map[99:80]   = 20'b01111011101110100010;  
	C_map[119:100] = 20'b00001010001010110110; 
	C_map[139:120] = 20'b01111001001110101010;  
	C_map[159:140] = 20'b00001000101010100010;  
	C_map[179:160] = 20'b01111011101010100010;  
	C_map[199:180] = 20'h00000;  
	C_map[219:200] = 20'h00000; 
	C_map[239:220] = 20'h00000;  
	C_map[259:240] = 20'h00000;  
	C_map[279:260] = 20'h00000;  
	C_map[299:280] = 20'h00000;  
	end
	
	else if (E_STATE)
	begin
	C_map[19:0]    = 20'h00000;  
	C_map[39:20]   = 20'h00000;  
	C_map[59:40]   = 20'h00000;  
	C_map[79:60]   = 20'h00000;  
	C_map[99:80]   = 20'h00000;  
	C_map[119:100] = 20'b00111000100010001110; 
	C_map[139:120] = 20'b01001000100110000010;  
	C_map[159:140] = 20'b01001000101010001110;  
	C_map[179:160] = 20'b01001000110010000010;  
	C_map[199:180] = 20'b00111000100010001110; 
	C_map[219:200] = 20'h00000; 
	C_map[239:220] = 20'h00000;  
	C_map[259:240] = 20'h00000;  
	C_map[279:260] = 20'h00000;  
	C_map[299:280] = 20'h00000;  
	end
	

	else if (count == 3'b001)
	begin
	C_map[19:0]    = 20'b11111111111111111111;  
	C_map[39:20]   = 20'b11110000001111111111;  
	C_map[59:40]   = 20'b00010110000000000000;  
	C_map[79:60]   = 20'b00010111111100010110;  
	C_map[99:80]   = 20'b00010111111100010110;  
	C_map[119:100] = 20'b00010110000001100110;  
	C_map[139:120] = 20'b00010110011111111110;  
	C_map[159:140] = 20'b00110110000011111110;  
	C_map[179:160] = 20'b00000110000001100000; 
	C_map[199:180] = 20'b00111111011001100000;  
	C_map[219:200] = 20'b00000110011001100000;  
	C_map[239:220] = 20'b00000110011000000000;  
	C_map[259:240] = 20'b11111110011111111111;  
	C_map[279:260] = 20'b10000000000000000011;  
	C_map[299:280] = 20'b11111111111111111111;  
	end
	
	else if (count == 3'b010)
	begin						  
	C_map[19:0]    = 20'b11111111111111111111;  
	C_map[39:20]   = 20'b10000000000000000111;  
	C_map[59:40]   = 20'b11111001110011111111;  
	C_map[79:60]   = 20'b00001000000011000001;  
	C_map[99:80]   = 20'b00001001111111011001;  
	C_map[119:100] = 20'b00001000000011011001;  
	C_map[139:120] = 20'b00001000111000011001;  
	C_map[159:140] = 20'b00001111101111111001;  
	C_map[179:160] = 20'b00000000000000011001;  
	C_map[199:180] = 20'b11111111111111111001;  
	C_map[219:200] = 20'b11000000000000000001;  
	C_map[239:220] = 20'b11101111111111111111;  
	C_map[259:240] = 20'b11000000000000000011;  
	C_map[279:260] = 20'b11000000000000000011; 
	C_map[299:280] = 20'b11111111111111111111; 
	end
	
	else if (count == 3'b011)
	begin
	C_map[19:0]    = 20'h00000;  
	C_map[39:20]   = 20'h00000;  
	C_map[59:40]   = 20'h0FF00; 
	C_map[79:60]   = 20'h00900;  
	C_map[99:80]   = 20'h00900;  
	C_map[119:100] = 20'h00020;  
	C_map[139:120] = 20'h00000;  
	C_map[159:140] = 20'h00000; 
	C_map[179:160] = 20'h00000;  
	C_map[199:180] = 20'h00000;  
	C_map[219:200] = 20'h00000;  
	C_map[239:220] = 20'h00FF0;  
	C_map[259:240] = 20'h0F000;  
	C_map[279:260] = 20'h00000;  
	C_map[299:280] = 20'h00000; 
	end
	
	else
	begin
	C_map[19:0]    = 20'h00000;  
	C_map[39:20]   = 20'h00000; 
	C_map[59:40]   = 20'h00000;  
	C_map[79:60]   = 20'h00000;  
	C_map[99:80]   = 20'h00000; 
	C_map[119:100] = 20'b00111000100010001110;  
	C_map[139:120] = 20'b01001000100110000010;  
	C_map[159:140] = 20'b01001000101010001110;  
	C_map[179:160] = 20'b01001000110010000010;  
	C_map[199:180] = 20'b00111000100010001110;  
	C_map[219:200] = 20'h00000;  
	C_map[239:220] = 20'h00000; 
	C_map[259:240] = 20'h00000;  
	C_map[279:260] = 20'h00000;  
	C_map[299:280] = 20'h00000;  
	end
	

	
	
end

endmodule
