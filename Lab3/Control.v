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

module ALUcontrol (
    input [3:0] instruction,
    input [1:0] ALUop,
    output reg [3:0] ALUctrl,
    output reg bne
    
);
    always @(*) begin
        case (ALUop)
            2'b00: begin
                ALUctrl <= 4'b0010;
                bne <= 1'b0;
            end
            2'b01: begin
                if (instruction[2:0] == 3'b000) begin
                    ALUctrl <= 4'b0110;
                    bne <= 1'b0;
                end
                else if (instruction[2:0] == 3'b001) begin
                    ALUctrl <= 4'b0110;
                    bne <= 1'b1;
                end
                else begin
                    ALUctrl <= 4'b0000;
                    bne <= 1'b0;
                end
            end
            2'b10: begin
                if (instruction[2:0] == 3'b000 && instruction[3] == 1'b0) begin
                    ALUctrl <= 4'b0010;
                    bne <= 1'b0;
                end
                else if (instruction[2:0] == 3'b000 && instruction[3] == 1'b1) begin
                    ALUctrl <= 4'b0110;
                    bne <= 1'b0;
                end
                else if (instruction[2:0] == 3'b111) begin
                    ALUctrl <= 4'b0000;
                    bne <= 1'b0;
                end
                else if (instruction[2:0] == 3'b110) begin
                    ALUctrl <= 4'b0001;
                    bne <= 1'b0;
                end
                else begin
                    ALUctrl <= 4'b0000;
                    bne <= 1'b0;
                end
            end
            default: begin
                ALUctrl <= 4'b0000;
                bne <= 1'b0;
            end
        endcase
    end
endmodule : ALUcontrol

module Mux32bit (
    input [31:0] a,
    input [31:0] b,
    input sel,
    output reg [31:0] out
    
);
    always @(*)
        out = (sel)? b: a;
endmodule : Mux32bit