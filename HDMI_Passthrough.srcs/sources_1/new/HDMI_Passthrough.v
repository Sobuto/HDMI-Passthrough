`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 10:58:07 PM
// Design Name: 
// Module Name: HDMI_Passthrough
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HDMI_Passthrough(
    input wire sysclk
    );
    
    //FIFO Size
    integer i_fifo_depth = 64;
    integer i_fifo_width = 16;
    
    
    
    
    
    always@(posedge sysclk)
    begin
        //Do A Thing
    end
    
    
endmodule
