`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/20 22:57:51
// Design Name: 
// Module Name: Memory
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


module Memory(
    input write_en,
    input [9:0] addr_0,
    input [9:0] addr_1,
    input [9:0] addr_2,
    input [9:0] addr_3,
    input [31:0] write_data_0,
    input [31:0] write_data_1,
    input [31:0] write_data_2,
    input [31:0] write_data_3,
    output [31:0] read_data_0,
    output [31:0] read_data_1,
    output [31:0] read_data_2,
    output [31:0] read_data_3

);
    reg [31:0] mem [255:0];
    always @ (*) begin
        if (write_en) begin
            mem[(addr_0 >> 2)] <= write_data_0;
            mem[(addr_1 >> 2)] <= write_data_1;
            mem[(addr_2 >> 2)] <= write_data_2;
            mem[(addr_3 >> 2)] <= write_data_3;
        end
    end
    assign read_data_0 = mem[(addr_0 >> 2)];
    assign read_data_1 = mem[(addr_1 >> 2)];
    assign read_data_2 = mem[(addr_2 >> 2)];
    assign read_data_3 = mem[(addr_3 >> 2)];
endmodule : Memory
