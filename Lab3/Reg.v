`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/12 21:47:20
// Design Name: 
// Module Name: Reg
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


module Reg(
    input clk,
    input read_en_1,
    input read_en_2,
    input write_en,
    input [4:0] read_addr_1,
    input [4:0] read_addr_2,
    input [4:0] write_addr,
    input [31:0] write_data,
    output reg [31:0] read_data_1,
    output reg [31:0] read_data_2

);
    reg [31:0] register [31:0];
        always @(posedge clk) begin
            read_data_1 = 'bz;
            read_data_2 = 'bz;
            if (write_en)
                register[write_addr] = write_data;
            else begin 
                if (read_en_1)
                    read_data_1 = register[read_addr_1];
                if (read_en_2)
                    read_data_2 = register[read_addr_2];
            end
        end
endmodule : Reg
