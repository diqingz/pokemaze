//module my_Counter (input logic Clk,
//						  input logic Reset,
//						  input logic clr,
//						  input logic inc,
//						  output logic [2:0] C_out
//						  );
//						  

module counter(
  input logic clk, 
   input logic reset,
   input logic clear,
   input logic increment, //obtained from the FSM, indicates which maze to show onto the screen


  output logic [2:0] count
);


  logic [2:0] state;



   // Always block to update counter state
   always_ff @(posedge clk) begin
     if (reset || clear)
      begin
         state <= '0;
      end 
     else if (increment) 
       begin
         state <= state + 1;
      end
   end

  always_comb
  begin 
      // Assign initial state and output value
   count = state;

  end
endmodule 