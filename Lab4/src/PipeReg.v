`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/30 11:43:24
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(
    input clk,
    input [31:0] pc_in,
    output reg [31:0] pc_out,
    input [31:0] instruction_in,
    output reg [31:0] instruction_out

);
    always @ (posedge clk) begin
        pc_out <= pc_in;
        instruction_out <= instruction_in;
    end
endmodule : IF_ID

module ID_EX (
    input clk,
    /* Control Signals */
    input branch_in,
    input memRead_in,
    input memToReg_in,
    input [1:0] ALUop_in,
    input memWrite_in,
    input ALUsrc_in,
    input regWrite_in,
    input jump_in,
    input jump_return_in,

    output reg branch_out,
    output reg memRead_out,
    output reg memToReg_out,
    output reg [1:0] ALUop_out,
    output reg memWrite_out,
    output reg ALUsrc_out,
    output reg regWrite_out,
    output reg jump_out,
    output reg jump_return_out,
    /* Control Signals */
    
    input [31:0] pc_in,
    output reg [31:0] pc_out,
    input [31:0] read_data_1_in,
    output reg [31:0] read_data_1_out,
    input [31:0] read_data_2_in,
    output reg [31:0] read_data_2_out,
    input [31:0] immediate_in,
    output reg [31:0] immediate_out,
    input [3:0] funct3_in,
    output reg [3:0] funct3_out,
    input [4:0] rd_in,
    output reg [4:0] rd_out

);
    always @ (posedge clk) begin
        branch_out <= branch_in;
        memRead_out <= memRead_in;
        memToReg_out <= memToReg_in;
        ALUop_out <= ALUop_in;
        memWrite_out <= memWrite_in;
        ALUsrc_out <= ALUsrc_in;
        regWrite_out <= regWrite_in;
        jump_out <= jump_in;
        jump_return_out <= jump_return_in;

        pc_out <= pc_in;
        read_data_1_out <= read_data_1_in;
        read_data_2_out <= read_data_2_in;
        immediate_out <= immediate_in;
        funct3_out <= funct3_in;
        rd_out <= rd_in;
    end
endmodule : ID_EX

module EX_MEM (
    input clk,
    /* Control Signals */
    input branch_in,
    input memRead_in,
    input memToReg_in,
    input memWrite_in,
    input regWrite_in,
    input jump_in,

    output reg branch_out,
    output reg memRead_out,
    output reg memToReg_out,
    output reg memWrite_out,
    output reg regWrite_out,
    output reg jump_out,
    /* Control Signals */
    
    input [31:0] pc_in,
    output reg [31:0] pc_out,
    input [31:0] branch_destination_in,
    output reg [31:0] branch_destination_out,
    input zero_in,
    output reg zero_out,
    input lt_zero_in,
    output reg lt_zero_out,
    input [1:0] bType_in,
    output reg [1:0] bType_out,
    input asByte_in,
    output reg asByte_out,
    input asUnsigned_in,
    output reg asUnsigned_out,
    input [31:0] ALU_result_in,
    output reg [31:0] ALU_result_out,
    input [31:0] read_data_2_in,
    output reg [31:0] read_data_2_out,
    input [4:0] rd_in,
    output reg [31:0] rd_out

);
    always @ (posedge clk) begin
        branch_out <= branch_in;
        memRead_out <= memRead_in;
        memToReg_out <= memToReg_in;
        memWrite_out <= memWrite_in;
        regWrite_out <= regWrite_in;
        jump_out <= jump_in;

        pc_out  <= pc_in;
        branch_destination_out <= branch_destination_in;
        zero_out <= zero_in;
        lt_zero_out <= lt_zero_in;
        bType_out <= bType_in;
        asByte_out <= asByte_in;
        asUnsigned_out <= asUnsigned_in;
        ALU_result_out <= ALU_result_in;
        read_data_2_out <= read_data_2_in;
        rd_out <= rd_in;
    end
endmodule : EX_MEM

module MEM_WB (
    input clk,
    /* Control Signals */
    input memToReg_in,
    input regWrite_in,
    input jump_in,

    output reg memToReg_out,
    output reg regWrite_out,
    output reg jump_out,
    /* Control Signals */
    
    input [31:0] pc_in,
    output reg [31:0] pc_out,
    input [31:0] read_data_in,
    output reg [31:0] read_data_out,
    input [31:0] ALU_result_in,
    output reg [31:0] ALU_result_out,
    input [4:0] rd_in,
    output reg [31:0] rd_out

);
    always @ (posedge clk) begin
            memToReg_out <= memToReg_in;
            regWrite_out <= regWrite_in;
            jump_out <= jump_in;

            pc_out  <= pc_in;
            read_data_out <= read_data_in;
            ALU_result_out <= ALU_result_in;
            rd_out <= rd_in;
        end
endmodule : MEM_WB