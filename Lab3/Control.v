`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/16 21:38:49
// Design Name: 
// Module Name: Control
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


module Control(
    input [6:0] opcode,
    output reg branch,
    output reg memRead,
    output reg memToReg,
    output reg [1:0] ALUop,
    output reg memWrite,
    output reg ALUsrc,
    output reg regWrite

);
    always @(*) begin
        case (opcode)
            // R-type
            7'b0110011: begin
                branch <= 1'b0;
                memRead <= 1'b0;
                memToReg <= 1'b0;
                ALUop <= 2'b10;
                memWrite <= 1'b0;
                ALUsrc <= 1'b0;
                regWrite <= 1'b1;
            end
            // I-type
            // lw
            7'b0000011: begin
                branch <= 1'b0;
                memRead <= 1'b1;
                memToReg <= 1'b1;
                ALUop <= 2'b00;
                memWrite <= 1'b0;
                ALUsrc <= 1'b1;
                regWrite <= 1'b1;
            end
            // addi
            7'b0010011: begin
                branch <= 1'b0;
                memRead <= 1'b0;
                memToReg <= 1'b0;
                ALUop <= 2'b00;
                memWrite <= 1'b0;
                ALUsrc <= 1'b1;
                regWrite <= 1'b1;
            end
            // S-type
            7'b0100011: begin
                branch <= 1'b0;
                memRead <= 1'b0;
                memToReg <= 1'b0;
                ALUop <= 2'b00;
                memWrite <= 1'b1;
                ALUsrc <= 1'b1;
                regWrite <= 1'b0;
            end
            // B-type
            7'b1100011: begin
                branch <= 1'b1;
                memRead <= 1'b0;
                memToReg <= 1'b0;
                ALUop <= 2'b01;
                memWrite <= 1'b0;
                ALUsrc <= 1'b0;
                regWrite <= 1'b0;
            end
            default: begin
                branch <= 1'b0;
                memRead <= 1'b0;
                memToReg <= 1'b0;
                ALUop <= 2'b00;
                memWrite <= 1'b0;
                ALUsrc <= 1'b0;
                regWrite <= 1'b0;
            end
        endcase // opcode
    end
endmodule : Control
