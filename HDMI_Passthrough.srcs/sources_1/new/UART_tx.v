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
    input wire i_clk,               //System clock, 125 MHz
    input wire i_rst,               //System reset
    input wire i_tx_write,          //Start sending data
    input wire [7:0] i_tx_byte,     //Byte-size data
    output reg o_tx_active,        //UART is transmitting
    output reg o_tx_data            //UART Data
    );
    
    
    parameter BAUD_RATE = 9600;
    parameter DATA_BITS = 10;
    parameter START_BIT = 0;
    parameter STOP_BIT = 0;
    
    reg [3:0] bit_count;
    reg [13:0] baud_count;        //14 bits to allow 9600 to 115200
    reg transmit_en;              //Transmit at the set buad rate
    reg [7:0] tx_shift;
    
    //Adjust clock speed to match the baud rate
    always @(posedge i_clk)
    begin
        if (i_rst) begin
            baud_count <= 0;
            transmit_en <= 0;
        end
        else if (!transmit_en && (i_tx_write || baud_count > 0 || bit_count > 0)) begin
            if (baud_count == 13020) begin//13020 is for 9600 baud rate on 125MHz clk (change to variable)
                baud_count <= 0;
                transmit_en <= 1;
            end
            else
                baud_count <= baud_count + 1;
        end
        else begin
            baud_count <= 0;
            transmit_en <= 0;
        end                   
    end
        
    //UART Transmit
    always @(posedge i_clk)
    begin 
        if (i_rst) begin
            o_tx_active = 1'b0;
            o_tx_data = !START_BIT;
            bit_count = 4'h0;   
            tx_shift = 8'h00;     
        end
        else if((i_tx_write || bit_count > 0) && transmit_en) begin //Change states at baud status 
            if (bit_count == 0) begin //Transmit Start Bit, Transmit is busy
                o_tx_active = 1'b1;
                o_tx_data = !START_BIT;
                tx_shift = i_tx_byte;
                bit_count = bit_count + 1;
            end
            else if (bit_count < DATA_BITS) begin //Transmit Data Send, 8 bits + (start & stop)
                o_tx_active = 1'b1;
                o_tx_data = tx_shift[0];
                tx_shift = tx_shift >> 1;
                bit_count = bit_count + 1;
            end
            else if (bit_count == DATA_BITS) begin  //Transmit Stop Bit
                o_tx_active = 1'b1;
                o_tx_data = STOP_BIT;
                bit_count = 1'b0;
            end
            else begin //Transmit is now ready
                o_tx_active = 1'b0;
                o_tx_data = !START_BIT;
                bit_count = 1'b0;
            end
         end
         else begin
            o_tx_active = o_tx_active;
            o_tx_data = o_tx_data;
            bit_count = bit_count;
            tx_shift = tx_shift;
         end
    end
   
   
endmodule
