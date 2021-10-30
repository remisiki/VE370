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
    input write_en,
    input [4:0] read_addr_1,
    input [4:0] read_addr_2,
    input [4:0] write_addr,
    input [31:0] write_data,
    output [31:0] read_data_1,
    output [31:0] read_data_2

);
    reg [31:0] register [31:0];
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            register[i] = 32'b0;
        end
    end
    always @(negedge clk) begin
        if ((write_en) && (write_addr == 5'b0))
            register[write_addr] = 32'b0;
        else if (write_en)
            register[write_addr] = write_data;
    end
    assign read_data_1 = register[read_addr_1];
    assign read_data_2 = register[read_addr_2];
endmodule : Reg
