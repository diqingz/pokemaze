
module bouncing (
                         input [3071:0] map,
                         input [9:0] spriteWidth,
                         input [9:0] spriteHeight,
                         input [19:0] spriteX, 
                         input [19:0] spriteY, //the x and y positions of the sprite

                         input left, right, up, down, bouncingLeft, bouncingRight, bouncingUp, bouncingDown, //inputs the signals

                         output bounceLeft, bounceDown, bounceUp, bounceRight,
                         output [3071:0] MAP, 
 
                         output collisionUp //output signal on whether the sprite was bounced or not
                         );

assign MAP = map[3071:0];

logic [11:0] left_endpointA;
logic [11:0] right_endpointA;
logic [11:0] right_endpointB;
logic [11:0] left_endpointB;
logic [11:0] horizontal_change;
logic [11:0] vertical_change;
logic [13:0] width_change;
logic [13:0] height_change;


always_comb begin


//resizing math
vertical_change = (spriteY /10); 
horizontal_change = (spriteX /10); 
width_change = ((spriteWidth + spriteX) /10);
height_change = ((spriteHeight + spriteY) /10);


left_endpointA  = (vertical_change * 7'd64) + horizontal_change;
right_endpointA = (vertical_change * 7'd64) + width_change;
left_endpointB  = ((height_change) * 7'd64) + horizontal_change;
right_endpointB = ((height_change) * 7'd64) + width_change;



//set the bouncing signals initally to zero
    bounceLeft  = 1'b0;
    bounceRight  = 1'b0;
    bounceDown  = 1'b0;
    bounceUp  = 1'b0;


//finding the conditions that should output bouncing signals accordingly 
    if (map[left_endpointA] == 1'b1)

    begin

        if(left)

            bounceRight = 1'b1;
       else if (up)
            bounceDown = 1'b1;
    end
else if (map[right_endpointA] == 1'b1)
    begin
        if (right)
            bounceLeft = 1'b1;
       else if (up)
            bounceDown = 1'b1;
    end

   else if (map[left_endpointB] == 1'b1)
    begin
        if(left)
            bounceRight = 1'b1;
       else if (down)
            bounceUp = 1'b1;
    end

   else if (map[right_endpointB] == 1'b1)
    begin
       if (right)
            bounceLeft = 1'b1;
       else if (down)
            bounceUp = 1'b1;
    end


    if (map[left_endpointA] == 1'b1)
    begin
        if(bouncingLeft)
            bounceRight = 1'b1;
       else if (bouncingUp)
            bounceDown = 1'b1;
    end

   else if (map[right_endpointA] == 1'b1)
    begin
        if (bouncingRight)
            bounceLeft = 1'b1;
       else if (bouncingUp)
            bounceDown = 1'b1;
    end

   else if (map[left_endpointB] == 1'b1)
    begin
        if(bouncingLeft)
            bounceRight = 1'b1;
       else if (bouncingDown)
            bounceUp = 1'b1;
    end

   else if (map[right_endpointB] == 1'b1)
    begin
       if (bouncingRight)
            bounceLeft = 1'b1;
       else if (bouncingDown)
            bounceUp = 1'b1;
    end

end

always_comb
begin

collisionUp = bounceRight || bounceUp || bounceDown || bounceLeft;

end
endmodule
