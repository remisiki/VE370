`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/16 23:29:52
// Design Name: 
// Module Name: ALU
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


module ALU(
    input signed [31:0] a,
    input signed [31:0] b,
    input [3:0] ALUctrl,
    output zero,
    output lt_zero,
    output reg signed [31:0] result

);
    always @(*) begin
        case (ALUctrl)
            4'b0000: result = a & b;
            4'b0001: result = a | b;
            4'b0010: result = a + b;
            4'b0011: result = a << b;
            4'b0110: result = a - b;
            4'b0111: result = a >> b;
            4'b1000: result = a >>> b;
            default: result = 32'b0;
        endcase

    end
    assign zero = (result == 0);
    assign lt_zero = (result < 0);
endmodule

module Comparator (
    input signed [31:0] a,
    input signed [31:0] b,
    output zero,
    output lt_zero
    
);
    assign zero = (a == b);
    assign lt_zero = (a < b);
endmodule : Comparator