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
    // Initial block should be deleted in synthesis
    // initial begin
        // $readmemb("./instructions.prog", memori_instr);
    // assign memori_instr[0] = 32'b00011001001100000000001010010011;
    // assign memori_instr[1] = 32'b00000000000000000000000000010011;
    // assign memori_instr[2] = 32'b00000000000000000000000000010011;
    // assign memori_instr[3] = 32'b00000000010100101000001100110011;
    // assign memori_instr[4] = 32'b00000000000000000000000000010011;
    // assign memori_instr[5] = 32'b00000000000000000000000000010011;
    // assign memori_instr[6] = 32'b01000000011000000000001110110011;
    // assign memori_instr[7] = 32'b00000000011000101111111000110011;
    // assign memori_instr[8] = 32'b00000000001000000000111000010011;
    // assign memori_instr[9] = 32'b00000000000000000000000000010011;
    // assign memori_instr[10] = 32'b00000000000000000000000000010011;
    // assign memori_instr[11] = 32'b00000001110000110001001100110011;
    // assign memori_instr[12] = 32'b00000000000000000000000000010011;
    // assign memori_instr[13] = 32'b00000000000000000000000000010011;
    // assign memori_instr[14] = 32'b00000000011000111110001110110011;
    // assign memori_instr[15] = 32'b00000000000000000000000000010011;
    // assign memori_instr[16] = 32'b00000000000000000000000000010011;
    // assign memori_instr[17] = 32'b01110011001000111111111010010011;
    // assign memori_instr[18] = 32'b00000000000000000000000000010011;
    // assign memori_instr[19] = 32'b00000000000000000000000000010011;
    // assign memori_instr[20] = 32'b00000000010111101101111010010011;
    // assign memori_instr[21] = 32'b00000000000000000000000000010011;
    // assign memori_instr[22] = 32'b00000000000000000000000000010011;
    // assign memori_instr[23] = 32'b00000001110000111101001110110011;
    // assign memori_instr[24] = 32'b00000000000000000000000000010011;
    // assign memori_instr[25] = 32'b00000000000000000000000000010011;
    // assign memori_instr[26] = 32'b00000001000000111001001110010011;
    // assign memori_instr[27] = 32'b00000000000000000000000000010011;
    // assign memori_instr[28] = 32'b00000000000000000000000000010011;
    // assign memori_instr[29] = 32'b01000001110000111101001110110011;
    // assign memori_instr[30] = 32'b00000000011000101001100001100011;
    // assign memori_instr[31] = 32'b00000000000000000000000000010011;
    // assign memori_instr[32] = 32'b00000000000000000000000000010011;
    // assign memori_instr[33] = 32'b00000000000000000000001110110011;
    // assign memori_instr[34] = 32'b00000010000000111000100001100011;
    // assign memori_instr[35] = 32'b00000000000000000000000000010011;
    // assign memori_instr[36] = 32'b00000000000000000000000000010011;
    // assign memori_instr[37] = 32'b00000011110100111101001001100011;
    // assign memori_instr[38] = 32'b00000000000000000000000000010011;
    // assign memori_instr[39] = 32'b00000000000000000000000000010011;
    // assign memori_instr[40] = 32'b00000000000000111000001010110011;
    // assign memori_instr[41] = 32'b00000000000000000000000000010011;
    // assign memori_instr[42] = 32'b00000000000000000000000000010011;
    // assign memori_instr[43] = 32'b00000001110100111100100001100011;
    // assign memori_instr[44] = 32'b00000000000000000000000000010011;
    // assign memori_instr[45] = 32'b00000000000000000000000000010011;
    // assign memori_instr[46] = 32'b00000000000000000000001010110011;
    // assign memori_instr[47] = 32'b00000000010100111001110001100011;
    // assign memori_instr[48] = 32'b00000000000000000000000000010011;
    // assign memori_instr[49] = 32'b00000000000000000000000000010011;
    // assign memori_instr[50] = 32'b00000000010100111000100001100011;
    // assign memori_instr[51] = 32'b00000000000000000000000000010011;
    // assign memori_instr[52] = 32'b00000000000000000000000000010011;
    // assign memori_instr[53] = 32'b00000000000000000000001100110011;
    // assign memori_instr[54] = 32'b00000001110100110100110001100011;
    // assign memori_instr[55] = 32'b00000000000000000000000000010011;
    // assign memori_instr[56] = 32'b00000000000000000000000000010011;
    // assign memori_instr[57] = 32'b00000001110000110101100001100011;
    // assign memori_instr[58] = 32'b00000000000000000000000000010011;
    // assign memori_instr[59] = 32'b00000000000000000000000000010011;
    // assign memori_instr[60] = 32'b00000000000000000000111000110011;
    // assign memori_instr[61] = 32'b00000000000000000000111010110011;
    // assign memori_instr[62] = 32'b00000001100000000000000011101111;
    // assign memori_instr[63] = 32'b00000000000000000000000000010011;
    // assign memori_instr[64] = 32'b00000000000000000000000000010011;
    // assign memori_instr[65] = 32'b00000010011100101000100001100011;
    // assign memori_instr[66] = 32'b00000000000000000000000000010011;
    // assign memori_instr[67] = 32'b00000000000000000000000000010011;
    // assign memori_instr[68] = 32'b00000000010100010010000000100011;
    // assign memori_instr[69] = 32'b00000000011000010000001000100011;
    // assign memori_instr[70] = 32'b00000000000000010010111010000011;
    // assign memori_instr[71] = 32'b00000000010000010000111010000011;
    // assign memori_instr[72] = 32'b00000000010000010100111010000011;
    // assign memori_instr[73] = 32'b00000000000000001000000001100111;
    // assign memori_instr[74] = 32'b00000000000000000000000000010011;
    // assign memori_instr[75] = 32'b00000000000000000000000000010011;
    // assign memori_instr[76] = 32'b00000000000000000000000010110011;
    // assign memori_instr[77] = 32'b00000000000000000000001110110011;



    // 

    assign instruction = memori_instr[PC];
endmodule: InstrMem
