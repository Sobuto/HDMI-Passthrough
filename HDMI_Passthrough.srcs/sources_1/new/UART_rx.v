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
    input wire i_rx_data,
    output wire [7:0] o_rx_data,     //Byte-size data received
    output reg o_rx_active,         //UART receiver is in use
    output reg o_rx_ready           //UART receiver is finished
    );
    
    
    parameter BAUD_RATE = 9600;
    parameter DATA_BITS = 10;
    parameter START_BIT = 0;
    parameter STOP_BIT = 0;
    
    parameter IDLE = 2'b00;
    parameter RX_START = 2'b01;
    parameter RX_DATA = 2'b10;
    parameter RX_DONE = 2'b11;
    
    reg [3:0] bit_count;
    reg [13:0] baud_count;          //14 bits to allow 9600 to 115200
    reg receive_en;                 //Receive at the set buad rate
    reg [data_bits-3:0] rx_shift;
    reg [1:0] rx_state;
    
    //Adjust clock speed to match the baud rate
    always @(posedge i_clk)
    begin
        if (i_rst) begin
            baud_count <= 0;
            receive_en <= 0;
        end
        else if (!receive_en && o_rx_active) begin
            if (baud_count == 13020) begin//13020 is for 9600 baud rate on 125MHz clk (change to variable)
                baud_count <= 0;
                receive_en <= 1;
            end
            else
                baud_count <= baud_count + 1;
        end
        else begin
            baud_count <= 0;
            receive_en <= 0;
        end                   
    end


    //UART Receiver
    always @(posedge i_clk) 
    begin
        if (i_rst) begin
            rx_shift <= 0;
            o_rx_active <= 1'b0;
            o_rx_ready <= 1'b0;
            bit_count <= DATA_BITS - 2;
        end
        else begin
            case (rx_state)
                IDLE:
                begin
                    o_rx_active <= 1'b0;
                    o_rx_ready <= 1'b0;
                    bit_count <= DATA_BITS - 2;
                    rx_state <= (i_rx_data == START_BIT) ? IDLE : RX_START;
                end            
                RX_START:
                begin
                    o_rx_active <= 1'b1;
                    rx_state <= RX_DATA;
                end                                    
                RX_DATA:                
                begin
                    if (receive_en) begin
                        bit_count <= bit_count - 1;
                        rx_shift[bit_count] <= i_rx_data;
                        if (bit_count == 0)
                            rx_state <= RX_DONE;
                    end
                    else
                        rx_state <= rx_state;
                end
                RX_DONE:
                begin
                    if (o_rx_ready) begin
                        o_rx_active <= 1'b0;
                        o_rx_ready <= 1'b0;
                        rx_state <= IDLE;
                    end
                    else if (receive_en && (i_rx_data == STOP_BIT)) begin
                        o_rx_active <= 1'b1;
                        o_rx_ready <= 1'b1;
                   end
                    else
                        rx_state <= rx_state;
                end
                default:
                begin
                    o_rx_active <= 1'b0;
                    o_rx_ready <= 1'b0;
                    bit_count <= DATA_BITS - 2;
                end
            endcase
       end
    end


assign o_rx_data = rx_shift;
   
endmodule
