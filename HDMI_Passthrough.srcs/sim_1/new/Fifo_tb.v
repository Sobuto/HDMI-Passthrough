`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2019 11:25:34 PM
// Design Name: 
// Module Name: Fifo_tb
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


module Fifo_tb;
    
    reg clk, read, write, reset;
    reg [3:0] write_data, write_count;
    wire empty, full;
    wire [3:0] read_data;
    
    HDMI_Passthrough UUT( 
        .sysclk (clk),
        .o_rd_empty (empty),
        .i_rd_en (read),
        .o_rd_data (read_data), 
        .o_wr_full (full),
        .i_wr_en (write),
        .i_wr_data (write_data),
        .i_rst (reset)
        );    
    
    always #1 clk = ~clk;

    initial
    begin
        clk = 0;
        write_count = 0;
        read = 0;
        write = 0;
        write_data = 0;
        reset = 1;
        #4
        reset = 0;
        read = 1;
        #2
        read = 0;
        write_data = write_count;
        write = 1;
        while (write_count < 15)
        begin
            #2
            write_count = write_count + 1;
            write_data = write_count;
        end
        #2
        write_data = 6;
        #10
        write = 0;
        read = 1;
        #75
        read = 0;
        $finish;
    end


endmodule
