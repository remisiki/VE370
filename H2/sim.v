`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/02 15:54:29
// Design Name: 
// Module Name: sim
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


module sim(

    );
    wire [31:0] read_data_1, read_data_2;
    reg [4:0] read_addr_1, read_addr_2, write_addr;
    reg [31:0] write_data;
    reg clk, read_en_1, read_en_2, write_en;
    Reg32bit uut (clk, read_en_1, read_en_2, write_en, read_addr_1, read_addr_2, write_addr, write_data, read_data_1, read_data_2);
    initial begin
        #0  clk = 0;
            read_addr_1 = 5'b10010;
            read_addr_2 = 5'b00111;
            write_data = 32'd3108;
            read_en_1 = 0;
            read_en_2 = 0;
            write_en = 0;
            write_addr = 5'b10010;
        #50 write_en = 1;
        #50 write_en = 0;
            read_en_1 = 1;
        #50 read_en_1 = 0;
            write_en = 1;
            write_addr = 5'b00111;
            write_data = 32'd191;
        #50 write_en = 0;
        #50 read_en_1 = 1;
            read_en_2 = 1;
        #50 read_en_1 = 0;
            read_en_2 = 0;
            write_en = 1;
            write_data = 32'hffffffff;
        #50 write_en = 0;
            read_en_2 = 1;
        #50 read_en_2 = 0;
            read_addr_1 = 5'b01011;
            write_addr = 5'b01011;
            write_data = 32'b0;
        #50 write_en = 1;
        #50 write_en = 0;
            read_en_1 = 1;
        #50 read_en_1 = 0;
    end
    initial begin
        forever #10 clk = ~ clk;
    end
endmodule
