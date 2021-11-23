`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/21 00:50:41
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
    wire [31:0] read_data;
    reg clk;
    top uut(clk, read_data);
    initial begin
        clk <= 1'b0;
        uut.uut2.mem_done <= 1'b0;
        $readmemh("./memory.txt", uut.uut2.mem);
        #100 $stop();       
    end
    always
        #5 clk <= ~clk;
endmodule
