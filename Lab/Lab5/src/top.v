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
    input clk_100MHz,
    input clk,
    input reset,
    input [4:0] register_index,
    input pc_read,
    output reg [6:0] ssd,
    output [3:0] a

);
    wire [31:0] pc_next, pc_branch, pc_jump, ALU_in_1, ALU_in_2, write_data, write_data_jump, write_data_mem, comp_in_1, comp_in_2;
    wire [31:0] pc_IF,/**/ pc_ID, pc_EX, pc_MEM, pc_WB, pc_out;
    wire [31:0] instruction_IF, instruction_ID;
    wire branch_ID, branch_EX, branch_MEM;
    wire jump_ID, jump_EX, jump_MEM, jump_WB;
    wire jump_return_ID, jump_return_EX, jump_return_MEM, jump_return_WB;
    wire memRead_ID, memRead_EX, memRead_MEM, memRead_WB;
    wire memToReg_ID, memToReg_EX, memToReg_MEM, memToReg_WB;
    wire memWrite_ID, memWrite_EX, memWrite_MEM;
    wire ALUsrc_ID, ALUsrc_EX;
    wire regWrite_ID, regWrite_EX, regWrite_MEM, regWrite_WB;
    wire [31:0] read_data_1_ID, read_data_1_EX;
    wire [31:0] read_data_2_ID, read_data_2_ID_copy, read_data_2_EX, read_data_2_EX_new, read_data_2_MEM;
    wire [3:0] funct3_EX;
    wire [31:0] immediate_ID, immediate_EX;
    wire [4:0] rd_EX, rd_MEM, rd_WB;
    wire [1:0] bType_ID, bType_EX, bType_MEM;
    wire zero_EX, zero_MEM, zero_BR;
    wire lt_zero_EX, lt_zero_MEM, lt_zero_BR;
    wire asByte_EX, asByte_MEM;
    wire asUnsigned_EX, asUnsigned_MEM;
    wire [1:0] ALUop_ID, ALUop_EX;
    wire [31:0] ALU_result_EX, ALU_result_MEM, ALU_result_WB;
    wire [3:0] ALUctrl;
    wire [31:0] alter_destination_ID, alter_destination_EX, alter_destination_MEM;
    wire pcSrc, pcSrc_branch, pcSrc_jump;
    wire [31:0] read_data_MEM, read_data_WB;
    wire [1:0] forward_A, forward_B, forward_A_comp, forward_B_comp;
    wire [4:0] rs1_EX, rs2_EX, rs2_MEM;
    wire pc_write, IF_ID_write, control_src, rs2_src, mem_src, flush;

    /* FPGA Board Display */
    wire clk_500Hz;
    wire [6:0] ssd0, ssd1, ssd2, ssd3;
    clk_divider #200000 clk1 (clk_100MHz, reset, clk_500Hz);
    ring_counter_4_bit r1 (clk_500Hz, reset, a);
    SSD uut30 ((pc_read) ? pc_out[3:0] : uut2.register[register_index][3:0], ssd0);
    SSD uut31 ((pc_read) ? pc_out[7:4] : uut2.register[register_index][7:4], ssd1);
    SSD uut32 ((pc_read) ? pc_out[11:8] : uut2.register[register_index][11:8], ssd2);
    SSD uut33 ((pc_read) ? pc_out[15:12] : uut2.register[register_index][15:12], ssd3);
    always @ (posedge clk_500Hz) begin
        case (a)
            4'b0111: ssd = ssd0;
            4'b1011: ssd = ssd1;
            4'b1101: ssd = ssd2;
            4'b1110: ssd = ssd3;
            default: ssd = 7'b1111111;
        endcase
    end
    /* FPGA Board Display */

    // IF
    PC uut (clk, reset, pc_write, pc_next, pc_IF);
    RealPC uut38 (pc_IF, pc_out);
    InstrMem uut0 (pc_IF, instruction_IF);

    // ID
    Control uut1 (instruction_ID[6:0], control_src, branch_ID, memRead_ID, memToReg_ID, ALUop_ID, memWrite_ID, ALUsrc_ID, regWrite_ID, jump_ID, jump_return_ID);
    Reg uut2 (clk, reset, regWrite_WB, instruction_ID[19:15], instruction_ID[24:20], rd_WB, write_data_jump, read_data_1_ID, read_data_2_ID_copy);
    Mux32bit uut25 (read_data_2_ID_copy, ALU_result_EX, rs2_src, read_data_2_ID);
    ImmGen uut3 (instruction_ID, immediate_ID);

    LoadHazard uut24 ((instruction_ID[6:0] == 7'b1100011), regWrite_EX, memRead_EX, memRead_MEM, (instruction_ID[6:0] == 7'b0100011), rd_EX, rd_MEM, instruction_ID[19:15], instruction_ID[24:20], control_src, pc_write, IF_ID_write);

    /* PC related */
    AlterPC uut4 (pc_ID, immediate_ID, alter_destination_ID);
    Jump uut8 (jump_ID, pcSrc_jump);
    JumpReturn uut9 (jump_return_ID, pcSrc);
    Mux32bit uut10 (pc_IF + 1, alter_destination_ID, pcSrc_branch, pc_branch);
    Mux32bit uut11 (pc_branch, alter_destination_ID, pcSrc_jump, pc_jump);
    Mux32bit uut12 (pc_jump, (read_data_1_ID >> 2), pcSrc, pc_next);
    SelPC uut13 (zero_BR, lt_zero_BR, bType_ID, branch_ID, pcSrc_branch);
    Mux2_32bit uut36 (read_data_1, write_data, ALU_result_MEM, forward_A_comp, comp_in_1);
    Mux2_32bit uut37 (read_data_2_ID_copy, write_data, ALU_result_MEM, forward_B_comp, comp_in_2);
    Comparator uut34 (comp_in_1, comp_in_2, zero_BR, lt_zero_BR);
    BranchCheck uut35({instruction_ID[30], instruction_ID[14:12]}, ALUop_ID, bType_ID);
    /* PC related */

    // EX
    IF_FLUSH uut28 (pcSrc_jump, pcSrc, pcSrc_branch, flush);
    Forward uut23 ((instruction_ID[6:0] == 7'b1100011), regWrite_MEM, regWrite_WB, memWrite_EX, rd_MEM, rd_WB, rs1_EX, rs2_EX, instruction_ID[19:15], instruction_ID[24:20], forward_A, forward_B, forward_A_comp, forward_B_comp);
    SaveHazard uut26 (memWrite_ID, rd_EX, instruction_ID[24:20], rs2_src);

    ALUcontrol uut5 (funct3_EX, ALUop_EX, ALUctrl, bType_EX, asByte_EX, asUnsigned_EX);
    Mux32bit uut6 (read_data_2_EX, immediate_EX, ALUsrc_EX, read_data_2_EX_new);
    Mux2_32bit uut21 (read_data_1_EX, write_data, ALU_result_MEM, forward_A, ALU_in_1);
    Mux2_32bit uut22 (read_data_2_EX_new, write_data, ALU_result_MEM, forward_B, ALU_in_2);
    ALU uut7 (ALU_in_1, ALU_in_2, ALUctrl, zero_EX, lt_zero_EX, ALU_result_EX);

    // MEM

    Mux32bit uut27 (read_data_2_MEM, read_data_WB, mem_src, write_data_mem);
    DataMem uut14 (clk, reset, memWrite_MEM, ALU_result_MEM, ALU_result_MEM, write_data_mem, read_data_MEM, asByte_MEM, asUnsigned_MEM);
    LoadSaveHazard uut29 (memWrite_MEM, memRead_WB, rd_WB, rs2_MEM, mem_src);

    // WB
    Mux32bit uut15 (ALU_result_WB, read_data_WB, memToReg_WB, write_data);
    Mux32bit uut16 (write_data, (pc_WB + 1) << 2, jump_WB, write_data_jump);

    // Pipeline Registers
    IF_ID uut17 (clk, IF_ID_write, flush, pc_IF, pc_ID, instruction_IF, instruction_ID);
    ID_EX uut18 (clk, branch_ID, memRead_ID, memToReg_ID, ALUop_ID, memWrite_ID, ALUsrc_ID, regWrite_ID, jump_ID, jump_return_ID, 
        branch_EX, memRead_EX, memToReg_EX, ALUop_EX, memWrite_EX, ALUsrc_EX, regWrite_EX, jump_EX, jump_return_EX, 
        pc_ID, pc_EX, read_data_1_ID, read_data_1_EX, read_data_2_ID, read_data_2_EX, 
        immediate_ID, immediate_EX, {instruction_ID[30], instruction_ID[14:12]}, funct3_EX, instruction_ID[11:7], rd_EX,
        instruction_ID[19:15], rs1_EX, instruction_ID[24:20], rs2_EX);
    EX_MEM uut19 (clk, branch_EX, memRead_EX, memToReg_EX, memWrite_EX, regWrite_EX, jump_EX, jump_return_EX, 
        branch_MEM, memRead_MEM, memToReg_MEM, memWrite_MEM, regWrite_MEM, jump_MEM, jump_return_MEM, 
        pc_EX, pc_MEM, alter_destination_EX, alter_destination_MEM, zero_EX, zero_MEM, lt_zero_EX, lt_zero_MEM, bType_EX, bType_MEM, 
        asByte_EX, asByte_MEM, asUnsigned_EX, asUnsigned_MEM, ALU_result_EX, ALU_result_MEM, read_data_2_EX, read_data_2_MEM, rd_EX, rd_MEM, rs2_EX, rs2_MEM);
    MEM_WB uut20 (clk, memToReg_MEM, regWrite_MEM, jump_MEM, memRead_MEM, 
        memToReg_WB, regWrite_WB, jump_WB, memRead_WB, 
        pc_MEM, pc_WB, read_data_MEM, read_data_WB, ALU_result_MEM, ALU_result_WB, rd_MEM, rd_WB);
endmodule
