`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/12 21:50:37
// Design Name: 
// Module Name: ImmGen
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


module ImmGen(
input [31:0] instruction,
    output reg [31:0] immediate

);
    always @(*)
        case (instruction[6:0])
            // R-type
            7'b0110011: assign immediate = 'bz;
            // I-type
            7'b0000011: assign immediate = {{20{instruction[31]}}, instruction[31:20]}; 
            7'b0001111: assign immediate = {{20{instruction[31]}}, instruction[31:20]};
            7'b0010011: assign immediate = {{20{instruction[31]}}, instruction[31:20]};
            7'b1100111: assign immediate = {{20{instruction[31]}}, instruction[31:20]};
            7'b1110011: assign immediate = {{20{instruction[31]}}, instruction[31:20]};
            // S-type
            7'b0100011: assign immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            // B-type
            7'b1100011: assign immediate = {{20{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
            // U-type
            7'b0010111: assign immediate = {{12{instruction[31]}}, instruction[31:12]};
            7'b0110111: assign immediate = {{12{instruction[31]}}, instruction[31:12]};
            // J-type
            7'b1101111: assign immediate = {{12{instruction[31]}}, instruction[31], instruction[19:12], 
                instruction[20], 
                instruction[30:21]};
            default: assign immediate = 'bz;
        endcase
endmodule : ImmGen
