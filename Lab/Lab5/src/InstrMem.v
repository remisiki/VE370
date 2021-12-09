`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/12 21:58:54
// Design Name: 
// Module Name: InstrMem
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


module InstrMem(
    input [31:0] PC,
    output [31:0] instruction

);
    wire [31:0] memori_instr [99:0];
    // initial
    //     $readmemb("./instructions.prog", memori_instr);
    assign memori_instr[0] = 32'b00111001100100000000001100010011;
    assign memori_instr[1] = 32'b00000000011000000010001000100011;
    assign memori_instr[2] = 32'b00000000010000000000001010000011;
    assign memori_instr[3] = 32'b00000000010100000010000000100011;
    assign memori_instr[4] = 32'b00000010000000110000000001100011;
    assign memori_instr[5] = 32'b00000000000000000010111000000011;
    assign memori_instr[6] = 32'b00000001110000101001110001100011;
    assign memori_instr[7] = 32'b00000001110000101000001110110011;
    assign memori_instr[8] = 32'b00000001110000111111001100110011;
    assign memori_instr[9] = 32'b00000000000000111111001100010011;
    assign memori_instr[10] = 32'b01000000000000110000001010110011;
    assign memori_instr[11] = 32'b00000000011000101101010001100011;
    assign memori_instr[12] = 32'b00000000000000000000001110110011;
    assign memori_instr[13] = 32'b00000000110000000000000011101111;
    assign memori_instr[14] = 32'b00000001010000000000000011101111;
    assign memori_instr[15] = 32'b00000000000000000000111000110011;
    assign memori_instr[16] = 32'b00000000011111100110111000110011;
    assign memori_instr[17] = 32'b00000000000000001000000001100111;
    assign memori_instr[18] = 32'b00000100100000000000001100010011;
    assign memori_instr[19] = 32'b00001010110000000000001010010011;

    assign instruction = memori_instr[PC];
endmodule: InstrMem
