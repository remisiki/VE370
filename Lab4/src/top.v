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
    wire [31:0] pc_next, ALU_in_1, write_data, write_data_jump, pc_branch, pc_jump;
    wire [31:0] pc_current_IF, pc_current_ID, pc_EX, pc_MEM, pc_WB;
    wire [31:0] instruction_IF, instruction_ID;
    wire branch_ID, branch_EX, branch_MEM;
    wire jump_ID, jump_EX, jump_MEM, jump_WB;
    wire jump_return_ID, jump_return_EX, jump_return_MEM, jump_return_WB;
    wire memRead_ID, memRead_EX, memRead_MEM;
    wire memToReg_ID, memToReg_EX, memToReg_MEM, memToReg_WB;
    wire memWrite_ID, memWrite_EX, memWrite_MEM;
    wire ALUsrc_ID, ALUsrc_EX;
    wire regWrite_ID, regWrite_EX, regWrite_MEM, regWrite_WB;
    wire [31:0] read_data_1_ID, read_data_1_EX;
    wire [31:0] read_data_2_ID, read_data_2_EX, read_data_2_MEM;
    wire [3:0] funct3_EX;
    wire [31:0] immediate_ID, immediate_EX;
    wire [4:0] rd_EX, rd_MEM, rd_WB;
    wire bne_EX, bne_MEM;
    wire zero_EX, zero_MEM;
    wire asByte_EX, asByte_MEM;
    wire asUnsigned_EX, asUnsigned_MEM;
    wire [1:0] ALUop_ID, ALUop_EX;
    wire [31:0] ALU_result_EX, ALU_result_MEM, ALU_result_WB;
    wire [3:0] ALUctrl;
    wire [31:0] branch_destination_EX, branch_destination_MEM;
    wire pcSrc, pcSrc_branch, pcSrc_jump;
    wire [31:0] read_data_MEM, read_data_WB;


    Reg uut (clk, regWrite_WB, instruction_ID[19:15], instruction_ID[24:20], rd_WB, write_data_jump, read_data_1_ID, read_data_2_ID);
    InstrMem uut1 (pc_current_IF, instruction_IF);
    PC uut2 (clk, pc_next, pc_current_IF);
    BranchPC uut3 (pc_EX, immediate_EX, branch_destination_EX);
    DataMem uut4 (clk, memWrite_MEM, ALU_result_MEM, ALU_result_MEM, read_data_2_MEM, read_data_MEM, asByte_MEM, asUnsigned_MEM);
    Control uut5 (instruction_ID[6:0], branch_ID, memRead_ID, memToReg_ID, ALUop_ID, memWrite_ID, ALUsrc_ID, regWrite_ID, jump_ID, jump_return_ID);
    ImmGen uut6 (instruction_ID, immediate_ID);
    ALUcontrol uut7 (funct3_EX, ALUop_EX, ALUctrl, bne_EX, asByte_EX, asUnsigned_EX);
    Mux32bit uut8 (read_data_2_EX, immediate_EX, ALUsrc_EX, ALU_in_1);
    ALU uut9 (read_data_1_EX, ALU_in_1, ALUctrl, zero_EX, ALU_result_EX);
    Mux32bit uut10 (ALU_result_WB, read_data_WB, memToReg_WB, write_data);
    Mux32bit uut13 (pc_current_IF + 1, branch_destination_MEM, pcSrc_branch, pc_branch);
    SelPC uut14 (zero_MEM, bne_MEM, branch_MEM, pcSrc_branch);
    Jump uut18 (jump_EX, pcSrc_jump);
    JumpReturn uut21 (jump_return_EX, pcSrc);
    Mux32bit uut17 (pc_branch, pc_EX + (immediate_EX >> 1), pcSrc_jump, pc_jump);
    Mux32bit uut19 (write_data, (pc_WB + 1) << 2, jump_WB, write_data_jump);
    Mux32bit uut20 (pc_jump, read_data_1_EX >> 2, pcSrc, pc_next);

    IF_ID uut11 (clk, pc_current_IF, pc_current_ID, instruction_IF, instruction_ID);
    ID_EX uut12 (clk, branch_ID, memRead_ID, memToReg_ID, ALUop_ID, memWrite_ID, ALUsrc_ID, regWrite_ID, jump_ID, jump_return_ID, branch_EX, memRead_EX, memToReg_EX, ALUop_EX, memWrite_EX, ALUsrc_EX, regWrite_EX, jump_EX, jump_return_EX, 
        pc_current_ID, pc_EX, read_data_1_ID, read_data_1_EX, read_data_2_ID, read_data_2_EX, immediate_ID, immediate_EX, {instruction_ID[30], instruction_ID[14:12]}, funct3_EX, instruction_ID[11:7], rd_EX);
    EX_MEM uut15 (clk, branch_EX, memRead_EX, memToReg_EX, memWrite_EX, regWrite_EX, jump_EX, branch_MEM, memRead_MEM, memToReg_MEM, memWrite_MEM, regWrite_MEM, jump_MEM, 
        pc_EX, pc_MEM, branch_destination_EX, branch_destination_MEM, zero_EX, zero_MEM, bne_EX, bne_MEM, asByte_EX, asByte_MEM, asUnsigned_EX, asUnsigned_MEM, ALU_result_EX, ALU_result_MEM, read_data_2_EX, read_data_2_MEM, rd_EX, rd_MEM);
    MEM_WB uut16 (clk, memToReg_MEM, regWrite_MEM, jump_MEM, memToReg_WB, regWrite_WB, jump_WB, 
        pc_MEM, pc_WB, read_data_MEM, read_data_WB, ALU_result_MEM, ALU_result_WB, rd_MEM, rd_WB);
endmodule
