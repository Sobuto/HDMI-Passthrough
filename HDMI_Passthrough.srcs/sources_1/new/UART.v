`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2019 10:37:28 PM
// Design Name: 
// Module Name: UART
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


module UART(
    input wire i_clk,
    input wire i_tx_data,
    input wire [7:0] i_tx_byte,
    input wire o_tx_en,
    input wire o_tx_serial,
    input wire o_tx_done
    );
    
    
parameter baud_rate = 9600;
parameter data_bits = 8;
parameter parity = 0; //0 = no parity bit, 1 = parity bit
parameter stop_bit = 1;


   
endmodule
