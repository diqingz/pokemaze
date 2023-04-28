module lab8( input               Clk,
             input        [1:0]  KEY,         
             output logic [6:0]  HEX0, HEX1,
             output logic [3:0]  VGA_R,        
                                 VGA_G,       
                                 VGA_B,       
             output logic        VGA_CLK,      
             output              VGA_VS,       
                                 VGA_HS,       

             output logic [12:0] DRAM_ADDR,    
             inout  wire  [15:0] DRAM_DQ,      
             output logic [1:0]  DRAM_BA,      
             output logic        DRAM_LDQM,     
				 output logic        DRAM_UDQM,     
             output logic        DRAM_RAS_N,   
                                 DRAM_CAS_N,   
                                 DRAM_CKE,     
                                 DRAM_WE_N,    
                                 DRAM_CS_N,    
                                 DRAM_CLK,      
				///////// ARDUINO /////////
				inout    [15: 0]   ARDUINO_IO,
				inout              ARDUINO_RESET_N
                    );
    


logic Reset_h, vssig, blank, sync, VGA_Clk;
	 
//=======================================================
//  REG/WIRE declarations
//=======================================================
	logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST;
	logic [3:0] hex_num_4, hex_num_3, hex_num_1, hex_num_0; //4 bit input hex digits
	logic [1:0] signs;
	logic [1:0] hundreds;
	logic [9:0] drawxsig, drawysig, ballxsig, ballysig, ballsizesig;
	logic [7:0] Red, Blue, Green;
	logic [7:0] keycode;
	
	
//=======================================================
//  Structural coding
//=======================================================
	assign ARDUINO_IO[10] = SPI0_CS_N;
	assign ARDUINO_IO[13] = SPI0_SCLK;
	assign ARDUINO_IO[11] = SPI0_MOSI;
	assign ARDUINO_IO[12] = 1'bZ;
	assign SPI0_MISO = ARDUINO_IO[12];
	
	assign ARDUINO_IO[9] = 1'bZ; 
	assign USB_IRQ = ARDUINO_IO[9];
		
	assign ARDUINO_RESET_N = USB_RST;
	assign ARDUINO_IO[7] = USB_RST;//USB reset 
	assign ARDUINO_IO[8] = 1'bZ; //this is GPX (set to input)
	assign USB_GPX = 1'b0;//GPX is not needed for standard USB host - set to 0 to prevent interrupt
	
	assign ARDUINO_IO[6] = 1'b1;
	
	
//	assign VGA_R = Red[7:4];
//	assign VGA_B = Blue[7:4];
//	assign VGA_G = Green[7:4];

	assign VGA_R = Red[3:0];
	assign VGA_B = Blue[3:0];
	assign VGA_G = Green[3:0];
	
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        
    end
	 
	 logic Reset_h_frameclock;
	 always_ff @ (posedge VGA_VS) begin
        Reset_h_frameclock <= ~(KEY[0]);        
    end
	 	 
     
	lab8_soc u0 (
		.clk_clk                           (Clk),            //clk.clk
		.reset_reset_n                     (1'b1),           //reset.reset_n
		.altpll_0_locked_conduit_export    (),               //altpll_0_locked_conduit.export
		.altpll_0_phasedone_conduit_export (),               //altpll_0_phasedone_conduit.export
		.altpll_0_areset_conduit_export    (),               //altpll_0_areset_conduit.export
		.key_external_connection_export    (KEY),            //key_external_connection.export

		//SDRAM
		.clk_sdram_clk(DRAM_CLK),                            //clk_sdram.clk
		.sdram_wire_addr(DRAM_ADDR),                         //sdram_wire.addr
		.sdram_wire_ba(DRAM_BA),                             //.ba
		.sdram_wire_cas_n(DRAM_CAS_N),                       //.cas_n
		.sdram_wire_cke(DRAM_CKE),                           //.cke
		.sdram_wire_cs_n(DRAM_CS_N),                         //.cs_n
		.sdram_wire_dq(DRAM_DQ),                             //.dq
		.sdram_wire_dqm({DRAM_UDQM,DRAM_LDQM}),              //.dqm
		.sdram_wire_ras_n(DRAM_RAS_N),                       //.ras_n
		.sdram_wire_we_n(DRAM_WE_N),                         //.we_n

		//USB SPI	
		.spi0_SS_n(SPI0_CS_N),
		.spi0_MOSI(SPI0_MOSI),
		.spi0_MISO(SPI0_MISO),
		.spi0_SCLK(SPI0_SCLK),
		
		//USB GPIO
		.usb_rst_export(USB_RST),
		.usb_irq_export(USB_IRQ),
		.usb_gpx_export(USB_GPX),
		
		//LEDs and HEX
		.hex_digits_export({hex_num_4, hex_num_3, hex_num_1, hex_num_0}),
		.leds_export({hundreds, signs, LEDR}),
		.keycode_export(keycode)
		);
		
logic myBall;	
logic [23:0] D_out;
logic [23:0] D_outfire;
logic [23:0] D_outfiretwo;
logic my_Sprite;	
logic my_SpriteFire;
logic my_SpriteFireTWO;
logic H_STATE;
logic E_STATE;
logic [3071:0] C_pic;
logic [0:4799] ones;
logic [0:4799] tens;

logic [3071:0] C_map; 
logic [9:0] sprite_W;
logic [9:0] sprite_H;
logic [19:0] sprite_xpos;
logic [19:0] sprite_ypos;
logic D;
logic U;
logic L;
logic R;
logic bcingU;
logic bcingD;
logic bcingL;
logic bcingR;
logic bnceL;
logic bnceR;
logic bnceU;
logic bnceD;
logic coll_CU;
always_comb
begin
if (count > 3'b011)
	E_SIGNAL = 1'b1;
else 
	E_SIGNAL = 1'b0;
end

logic [19:0] read_addrfireTWO;
assign read_addrfireTWO = (Sprite_DYF2 * sprite_WF2) + Sprite_DXF2;
logic [19:0] read_addrfire;
assign read_addrfire = (Sprite_DYF * sprite_WF) + Sprite_DXF;
logic [19:0] read_aram;
assign read_aram = (Sprite_dy * sprite_W) + Sprite_dx;

logic [9:0] sprite_WF;
logic [9:0] sprite_HF;
logic [19:0] sprite_xposF;
logic [19:0] sprite_yposF;
logic [9:0] sprite_WF2;
logic [9:0] sprite_HF2;
logic [19:0] sprite_xposF2;
logic [19:0] sprite_yposF2;
logic spr_on;
assign spr_on = !(H_STATE || E_STATE);
logic sprite_coll;

logic inc;
logic [19:0] Sprite_DXF2;
logic [19:0] Sprite_DYF2;
logic [19:0] Sprite_DXF;
logic [19:0] Sprite_DYF;

logic my_start;
logic my_end;
logic [19:0] Sprite_dx;
logic [19:0] Sprite_dy;

logic [2:0] count;
logic F_LAG;
logic [8:0] C_tens;
logic [8:0] C_ones;
logic C_up;
logic clr;
logic E_SIGNAL;

    my_GameDesign my_GD(   .Clk(Clk), 
								   .frame_clk(VGA_VS),
									.keycode(keycode),
									.E_SIGNAL(E_SIGNAL), 
									.Reset(Reset_h), 
									.my_start(my_start), 
									.my_end(my_end),
									.coll_CU(coll_CU),
									.C_ones(C_ones),
									.sprite_coll(sprite_coll), 
									.F_LAG(F_LAG),
								   .H_STATE(H_STATE), 
									.E_STATE(E_STATE),
									.inc(inc), 
									.score_CU(C_up), 
									.clr(clr)
							);
										
										
    my_Counter my_C(     .Clk(Clk), 
								 .Reset(Reset_h || ((keycode[7:0] == 8'h29) && (!spr_on))), 
								 .inc(inc),
								 .C_out(count)
						 );

	 ScoreTracker myST (	 .Clk(Clk),
								 .frame_clk(VGA_VS),
								 .Reset(1'b0), 
								 .clr(clr),
								 .C_up(C_up),
								 .C_tens(C_tens),
								 .C_ones(C_ones)
							 );
													
    scorenumM myScoreM(  .C_tens(C_tens), 
								 .C_ones(C_ones), 
								 .ones(ones),
								 .tens(tens), 
								 .F_LAG(F_LAG)
							 );

	 my_maps my_map (    .count(count),
							   .E_STATE(E_STATE),
							   .C_map(C_map)
						 );

    sprite_inst my_SI(	.Clk(Clk), 
							   .Reset(Reset_h), 
							   .frame_clk(VGA_VS), 
							   .DrawX(drawxsig), 
							   .DrawY(drawysig), 
								.keycode(keycode), 
								.bnceL(bnceL),
								.bnceR(bnceR),
								.bnceU(bnceU),
								.bnceD(bnceD),
								.Sprite_dx(Sprite_dx),
								.Sprite_dy(Sprite_dy),
								.sprite_W(sprite_W),
								.sprite_H(sprite_H),
								.sprite_xpos(sprite_xpos), 
								.sprite_ypos(sprite_ypos),
								.L(L),
								.R(R),
								.U(U),
								.D(D),
								.spr_on(spr_on),
								.inc(inc),
								.bcingL(bcingL),
								.bcingR(bcingR),
								.bcingU(bcingU), 
								.bcingD(bcingD),
								.my_Sprite(my_Sprite),
								.my_start(my_start), 
								.my_end(my_end)
						   );

											 
    fire_balli fball(	.Clk(Clk), 
								.Reset(Reset_h), 
								.frame_clk(VGA_VS),
								.DrawX(drawxsig), 
								.DrawY(drawysig),
								.keycode(keycode), 
								.spr_on(spr_on),
								.inc(inc),
								.Sprite_dx(Sprite_DXF), 
								.Sprite_dy(Sprite_DYF),
								.sprite_W(sprite_WF),
								.sprite_H(sprite_HF), 
								.sprite_xpos(sprite_xposF), 
								.sprite_ypos(sprite_yposF),
								.my_Sprite(my_SpriteFire)
						 );

    fire_balli #(.m(10'b1111111110), .sy_pos(10'd256)) fball2( .Clk(Clk),
																				   .Reset(Reset_h), 
																				   .frame_clk(VGA_VS),
																					.DrawX(drawxsig),
																				   .DrawY(drawysig),
																					.keycode(keycode), 
																					.spr_on(spr_on),
																					.inc(inc),
																					.Sprite_dx(Sprite_DXF2),
																					.Sprite_dy(Sprite_DYF2),
																					.sprite_W(sprite_WF2),
																					.sprite_H(sprite_HF2), 
																				   .sprite_xpos(sprite_xposF2), 
																					.sprite_ypos(sprite_yposF2), 
																					.my_Sprite(my_SpriteFireTWO)
																				);

											
	 sprite_colli my_SC(						     .sprite_xpos(sprite_xpos),
													     .sprite_ypos(sprite_ypos), 
														  .sprite_W(sprite_W),
														  .sprite_H(sprite_H),
														  .sprite_WF(sprite_WF), 
														  .sprite_HF(sprite_HF), 
														  .sprite_xposF(sprite_xposF), 
														  .sprite_yposF(sprite_yposF), 
														  .sprite_WF2(sprite_WF2),
														  .sprite_HF2(sprite_HF2),  
														  .sprite_xposF2(sprite_xposF2),
														  .sprite_yposF2(sprite_yposF2),
														  .spr_on(spr_on), 
														  .sprite_coll(sprite_coll)
							);										
											 
											 
											 
    frameRAM tetris(							     .data_In(24'b0),
														  .write_address(0), 
														  .read_address(read_aram),
														  .we(0),
														  .Clk(Clk),
														  .data_Out(D_out)
					    );
						  
    ram_F fire1(							        .data_In(24'b0),
														  .write_address(0),
														  .read_address_F(read_addrfire),
														  .we(0),
														  .Clk(Clk),
														  .data_out_F(D_outfire)
					);
	 
    ram_F fire2(					              .data_In(24'b0),
														  .write_address(0),
														  .read_address_F(read_addrfireTWO),
														  .we(0),
														  .Clk(Clk),
														  .data_out_F(D_outfiretwo)
					 );
								 
	 
	 my_wallBouncer myWB(
														  .C_map(C_map),
													     .sprite_W(sprite_W),
														  .sprite_H(sprite_H),
														  .sprite_xpos(sprite_xpos),
														  .sprite_ypos(sprite_ypos),
														  .D(D),
														  .L(L), 
														  .U(U), 
														  .R(R), 
														  .bcingR(bcingR),
														  .bcingL(bcingL),
														  .bcingU(bcingU), 
														  .bcingD(bcingD),
														  .bnceL(bnceL),
														  .bnceR(bnceR),
														  .bnceU(bnceU),
														  .bnceD(bnceD),
													     .C_pic(C_pic),
														  .coll_CU(coll_CU)
						  );
	 
    

    
    vga_controller myVGA( 					     .Clk(Clk), 
														  .Reset(Reset_h), 
														  .hs(VGA_HS), 
														  .vs(VGA_VS), 
														  .pixel_clk(VGA_CLK), 
														  .blank(blank),
														  .sync(sync),
														  .DrawX(drawxsig),
														  .DrawY(drawysig)
														 );
														 
														 
    
    color_mapper myColorMapper(				  .myBall(myBall),
														  .blank(blank),
														  .vga_clk(VGA_CLK),
														  .DrawX(drawxsig), 
														  .DrawY(drawysig),
														  .ram_OUT(D_out),
														  .fire_OUT(D_outfire),
														  .fireTwo_OUT(D_outfiretwo),
														  .my_Sprite(my_Sprite), 
														  .my_SpriteFire(my_SpriteFire), 
														  .my_SpriteFireTWO(my_SpriteFireTWO),
														  .H_STATE(H_STATE),
														  .E_STATE(E_STATE), 
														  .C_pic(C_pic),
														  .ones(ones), 
														  .tens(tens),
														  .VGA_R(Red), 
														  .VGA_G(Green),
														  .VGA_B(Blue)
										);
    
    HexDriver hex_inst_0 (keycode[3:0], HEX0);
    HexDriver hex_inst_1 (keycode[7:4], HEX1);
    
    vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));

endmodule

