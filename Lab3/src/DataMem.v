`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/12 23:02:09
// Design Name: 
// Module Name: DataMem
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


module DataMem(
    input clk,
    input write_en,
    input [31:0] read_addr,
    input [31:0] write_addr,
    input [31:0] write_data,
    output [31:0] read_data

);
    reg [31:0] memori [31:0];
    always @(posedge clk) begin
        if (write_en)
            memori[write_addr >> 2] = write_data;
    end
    assign read_data = memori[read_addr >> 2];
endmodule : DataMem
