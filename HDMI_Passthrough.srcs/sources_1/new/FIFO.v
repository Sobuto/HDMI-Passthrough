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


module FIFO(
    input   wire    sysclk,
    output  wire    o_rd_empty,
    input   wire    i_rd_en,
    output  wire    [3:0]    o_rd_data, 
    output  wire    o_wr_full,
    input   wire    i_wr_en,
    input   wire    [3:0]   i_wr_data,
    input   wire    i_rst
    );
    
    //FIFO Size
	parameter i_fifo_depth = 64;
	parameter i_fifo_arr_depth = 6;
	parameter i_fifo_width = 16;
	parameter i_fifo_arr_width = 4;
    
    //FIFO Output Registers
	reg [3:0] r_rd_data;
	reg r_empty;
	reg r_empty_err;
	reg r_full;
	reg r_full_err;
    
    //FIFO Data, Counters, and Paramters
	reg [i_fifo_arr_width - 1 : 0] a_fifo_data [0 : i_fifo_depth - 1];
	reg [5:0] r_fifo_cap;
    //reg r_rd_almost_empty;
	//parameter i_almost_empty = 8;
	//reg r_wr_almost_full;
	//parameter i_almost_full = 4;
     
    always@(posedge sysclk)
    begin
        if (i_rst)
		begin
			r_empty = 1'b1;
			r_full = 1'b0;
			r_fifo_cap = 6'h00;
			r_empty_err = 1'b0;
			r_full_err = 1'b0;
		end
		else if (i_rd_en && !i_wr_en) //Read Enable Process
		begin
			if (r_empty)
				r_empty_err = 1'b1;
			else
			begin
				r_empty_err = 1'b0;
				r_rd_data = a_fifo_data[r_fifo_cap];
				r_fifo_cap = r_fifo_cap - 1; 
			end				
		end
		else if (!i_rd_en && i_wr_en) //Write Enable Process
		begin
			if (r_full)
				r_full_err = 1'b1;
			else
			begin
				r_full_err = 1'b0;
				a_fifo_data[r_fifo_cap] = i_wr_data;
				r_fifo_cap = r_fifo_cap + 1;
			end
		end
		else
		begin	
			r_empty = r_empty;
			r_full = r_full;
			r_fifo_cap = r_fifo_cap;
			r_empty_err = r_empty_err;
			r_full_err = r_full_err;
		end
    end
    
    always @(r_fifo_cap)
    begin
        if (r_fifo_cap <= 0)
            r_empty = 1'b1;
        else if (r_fifo_cap >= (i_fifo_depth - 1))
			r_full = 1'b1;
        else    
        begin        
            r_empty = 1'b0;
            r_full = 1'b0;
        end 
    end					        

	//Assign the outputs
	assign o_rd_data = r_rd_data;
	assign o_rd_empty = r_empty;
	assign o_wr_full = r_full;


endmodule

