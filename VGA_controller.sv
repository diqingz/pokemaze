module  vga_controller (input              Clk,         // 50 MHz clock
                                           Reset,       // reset signal
                        output logic       hs,     
                                           vs,     
                        input              pixel_clk,     
                        output logic       blank, 
                                           sync,  
                        output logic [9:0] DrawX,      
                                           DrawY        
                        );     
    

    parameter [9:0] H_T = 10'd800;
    parameter [9:0] V_T = 10'd525;
    
    logic hs_IN, vs_IN, blank_IN;
    logic [9:0] hc, vc;
    logic [9:0] hc_IN, vc_IN;
    
    assign sync = 1'b0;
    assign DrawX = hc;
    assign DrawY = vc;
    
    always_ff @ (posedge pixel_clk)
    begin
        if (Reset)
        begin
            hs <= 1'b0;
            vs <= 1'b0;
            blank <= 1'b0;
            hc <= 10'd0;
            vc <= 10'd0;
        end
        else
        begin
            hs <= hs_IN;
            vs <= vs_IN;
            blank <= blank_IN;
            hc <= hc_IN;
            vc <= vc_IN;
        end
    end
    
    always_comb
    begin
        hc_IN = hc + 10'd1;
        vc_IN = vc;
        if(hc + 10'd1 == H_T)
        begin
            hc_IN = 10'd0;
            if(vc + 10'd1 == V_T)
                vc_IN = 10'd0;
            else
                vc_IN = vc + 10'd1;
        end

        hs_IN = 1'b1;
        if(hc_IN >= 10'd656 && hc_IN < 10'd752)
            hs_IN = 1'b0;

        vs_IN = 1'b1;
        if(vc_IN >= 10'd490 && vc_IN < 10'd492)
            vs_IN = 1'b0;
        blank_IN = 1'b0;
        if(hc_IN < 10'd640 && vc_IN < 10'd480)
            blank_IN = 1'b1;
    end
    
endmodule
