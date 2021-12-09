`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/17 00:58:10
// Design Name: 
// Module Name: top
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


module top(
    input clk

);
    wire [31:0] read_data_1, read_data_2, instruction, pc_current, pc_next, read_data, immediate, ALU_in_1, ALU_result, write_data;
    wire branch, memRead, memToReg,  memWrite, ALUsrc, regWrite, bne, zero;
    wire [1:0] ALUop;
    wire [3:0] ALUctrl;
    Reg uut (clk, regWrite, instruction[19:15], instruction[24:20], instruction[11:7], write_data, read_data_1, read_data_2);
    InstrMem uut1 (pc_current, instruction);
    PC uut2 (clk, pc_next, pc_current);
    nextPC uut3 (pc_current, immediate, branch, zero, bne, pc_next);
    DataMem uut4 (clk, memWrite, ALU_result, ALU_result, read_data_2, read_data);
    Control uut5 (instruction[6:0], branch, memRead, memToReg, ALUop, memWrite, ALUsrc, regWrite);
    ImmGen uut6 (instruction, immediate);
    ALUcontrol uut7 ({instruction[30], instruction[14:12]}, ALUop, ALUctrl, bne);
    Mux32bit uut8 (read_data_2, immediate, ALUsrc, ALU_in_1);
    ALU uut9 (read_data_1, ALU_in_1, ALUctrl, zero, ALU_result);
    Mux32bit uut10 (ALU_result, read_data, memToReg, write_data);
endmodule
