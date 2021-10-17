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
    reg [31:0] memori_instr [17:0];
    initial begin
        // $readmemb("./instructions.prog", memori_instr);
        memori_instr[0] = 32'b11111111011000000000001010010011;
        memori_instr[1] = 32'b00000000010100101000001100110011;
        memori_instr[2] = 32'b01000000011000101000001110110011;
        memori_instr[3] = 32'b00000000000000110111111000110011;
        memori_instr[4] = 32'b00000000010100110110111010110011;
        memori_instr[5] = 32'b00000001110100000010000000100011;
        memori_instr[6] = 32'b00000000010100000010001000100011;
        memori_instr[7] = 32'b00000000000000101000010001100011;
        memori_instr[8] = 32'b00000000000000110000111010110011;
        memori_instr[9] = 32'b00000001110100110001010001100011;
        memori_instr[10] = 32'b00000001110000110001010001100011;
        memori_instr[11] = 32'b00000000000000000000001110110011;
        memori_instr[12] = 32'b00000000000000000010010000000011;
        memori_instr[13] = 32'b00000000010000000010010010000011;
        memori_instr[14] = 32'b00000000100001001000010010010011;
        memori_instr[15] = 32'b00000000100101000000010001100011;
        memori_instr[16] = 32'b00000000000000000000001110110011;
        memori_instr[17] = 32'b00000000011100111000001110110011;
    end
    assign instruction = memori_instr[PC];
endmodule: InstrMem
