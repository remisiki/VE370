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
    output reg [31:0] read_data,
    output reg mem_done

);
    reg [31:0] mem [255:0];
    always @ (*) begin
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
endmodule : Memory
