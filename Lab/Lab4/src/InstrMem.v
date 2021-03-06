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
    reg [31:0] memori_instr [99:0];
    // Initial block should be deleted in synthesis
    initial
        $readmemb("./instructions.prog", memori_instr);
    // 

    assign instruction = memori_instr[PC];
endmodule: InstrMem
