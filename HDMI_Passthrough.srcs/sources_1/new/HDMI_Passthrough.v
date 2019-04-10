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
    input   wire    i_rst,
    //HDMI Inputs
    input wire hdmi_rx_cec,
    input wire hdmi_rx_clk_n,
    input wire hdmi_rx_clk_p,
    input wire hdmi_rx_d_n [0:2],
    input wire hdmi_rx_d_p [0:2],
    input wire hdmi_rx_hpd,
    input wire hdmi_rx_scl,
    input wire hdmi_rx_sda,
    //HDMI Outputs
    output wire hdmi_tx_clk_n,
    output wire hdmi_tx_clk_p,
    output wire hdmi_tx_d_n [0:2],
    output wire hdmi_hx_d_p [0:2],
    output wire hdmi_tx_hpdn
    );
    
//Video Generator 640x480 (actual 800x525)
parameter width = 800;
parameter width_bit = 10; 
parameter height = 525;
parameter height_bit = 10;

reg [width_bit - 1 : 0] r_count_width;
reg [height_bit - 1 : 0] r_count_height;


    

endmodule











//Extra spacing
