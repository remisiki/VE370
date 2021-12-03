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
    input [9:0] addr,
    input [31:0] write_data,
    input [5:0] virtual_page_number,
    output reg [31:0] read_data,
    output reg mem_done,
    output [1:0] physical_page_number,
    output page_hit

);
    reg [31:0] mem [255:0];
    reg valid [63:0];
    integer i;
    initial begin
        for (i = 0; i < 5; i = i + 1) valid[i] <= 1'b1;
        for (i = 5; i < 64; i = i + 1) valid[i] <= 1'b0;
        mem_done <= 1'b0;
    end
    always @ (addr) begin
        if (write_en) begin
            mem[(addr >> 2)] = write_data;
            mem_done = 1'b1;
            #1 mem_done = 1'b0;
        end
        else if (write_en == 1'b0) begin
            read_data = mem[(addr >> 2)];
            mem_done = 1'b1;
            #1 mem_done = 1'b0;
        end
    end
    assign physical_page_number = mem[virtual_page_number + 192][1:0];
    assign page_hit = valid[virtual_page_number];
endmodule : Memory
