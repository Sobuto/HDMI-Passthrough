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
    input   wire    sysclk,
    output  wire    o_rd_empty,
    input   wire    i_rd_en,
    output  wire    o_rd_data[3:0], 
    output  wire    o_wr_full,
    input   wire    i_wr_en,
    input   wire    i_wr_data[3:0],
   	input 	wire	rst
    );
    
    //FIFO Size
    integer i_fifo_depth = 64;
    integer i_fifo_width = 16;
    
    //FIFO Output Registers
	reg r_rd_data[3:0];
	reg r_rd_empty;
	reg r_wr_full;
    
    
    
    
    
    
    
    
    always@(posedge sysclk)
    begin
        //Do A Thing
    end
    
	//Assign the outputs
    assign o_rd_data[3:0] <= r_rd_data[3:0];
	assign o_rd_empty <= r_rd_empty;
	assign o_wr_full <= r_wr_full;


endmodule
