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
    input control_src,
    output reg branch,
    output reg memRead,
    output reg memToReg,
    output reg [1:0] ALUop,
    output reg memWrite,
    output reg ALUsrc,
    output reg regWrite,
    output reg jump,
    output reg jumpReturn

);
    always @(*) begin
        if (control_src == 1'b0) begin
            branch <= 1'b0;
            memRead <= 1'b0;
            memToReg <= 1'b0;
            ALUop <= 2'b00;
            memWrite <= 1'b0;
            ALUsrc <= 1'b0;
            regWrite <= 1'b0;
            jump <= 1'b0;
            jumpReturn <= 1'b0;
        end
        else case (opcode)
            // R-type
            7'b0110011: begin
                branch <= 1'b0;
                memRead <= 1'b0;
                memToReg <= 1'b0;
                ALUop <= 2'b10;
                memWrite <= 1'b0;
                ALUsrc <= 1'b0;
                regWrite <= 1'b1;
                jump <= 1'b0;
                jumpReturn <= 1'b0;
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
                jump <= 1'b0;
                jumpReturn <= 1'b0;
            end
            // addi, andi, slli, srli
            7'b0010011: begin
                branch <= 1'b0;
                memRead <= 1'b0;
                memToReg <= 1'b0;
                ALUop <= 2'b00;
                memWrite <= 1'b0;
                ALUsrc <= 1'b1;
                regWrite <= 1'b1;
                jump <= 1'b0;
                jumpReturn <= 1'b0;
            end
            // jalr
            7'b1100111: begin
                branch <= 1'b0;
                memRead <= 1'b0;
                memToReg <= 1'b0;
                ALUop <= 2'b00;
                memWrite <= 1'b0;
                ALUsrc <= 1'b1;
                regWrite <= 1'b1;
                jump <= 1'b0;
                jumpReturn <= 1'b1;
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
                jump <= 1'b0;
                jumpReturn <= 1'b0;
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
                jump <= 1'b0;
                jumpReturn <= 1'b0;
            end
            // J-type
            7'b1101111: begin
                branch <= 1'b0;
                memRead <= 1'b0;
                memToReg <= 1'b0;
                ALUop <= 2'b00;
                memWrite <= 1'b0;
                ALUsrc <= 1'b1;
                regWrite <= 1'b1;
                jump <= 1'b1;
                jumpReturn <= 1'b0;
            end
            default: begin
                branch <= 1'b0;
                memRead <= 1'b0;
                memToReg <= 1'b0;
                ALUop <= 2'b00;
                memWrite <= 1'b0;
                ALUsrc <= 1'b0;
                regWrite <= 1'b0;
                jump <= 1'b0;
                jumpReturn <= 1'b0;
            end
        endcase // opcode
    end
endmodule : Control

module ALUcontrol (
    input [3:0] instruction,
    input [1:0] ALUop,
    output reg [3:0] ALUctrl,
    output reg [1:0] bType,
    output reg asByte,
    output reg asUnsigned
    
);
    always @(*) begin
        case (ALUop)
            2'b00: begin
                // andi
                if (instruction[2:0] == 3'b111) begin
                    ALUctrl <= 4'b0000;
                    bType <= 2'b00;
                    asByte <= 1'b0;
                    asUnsigned <= 1'b0;
                end
                // slli
                else if (instruction[2:0] == 3'b001) begin
                    ALUctrl <= 4'b0011;
                    bType <= 2'b00;
                    asByte <= 1'b0;
                    asUnsigned <= 1'b0;
                end
                // srli
                else if (instruction[2:0] == 3'b101) begin
                    ALUctrl <= 4'b0111;
                    bType <= 2'b00;
                    asByte <= 1'b0;
                    asUnsigned <= 1'b0;
                end
                // lb, sb
                else if (instruction[2:0] == 3'b000) begin
                    ALUctrl <= 4'b0010;
                    bType <= 2'b00;
                    asByte <= 1'b1;
                    asUnsigned <= 1'b0;
                end
                // lbu
                else if (instruction[2:0] == 3'b100) begin
                    ALUctrl <= 4'b0010;
                    bType <= 2'b00;
                    asByte <= 1'b1;
                    asUnsigned <= 1'b1;
                end
                // lw, sw, addi, jal, jalr
                else begin
                    ALUctrl <= 4'b0010;
                    bType <= 2'b00;
                    asByte <= 1'b0;
                    asUnsigned <= 1'b0;
                end
            end
            2'b01: begin
                // beq
                if (instruction[2:0] == 3'b000) begin
                    ALUctrl <= 4'b0110;
                    bType <= 2'b00;
                    asByte <= 1'b0;
                    asUnsigned <= 1'b0;
                end
                // bType
                else if (instruction[2:0] == 3'b001) begin
                    ALUctrl <= 4'b0110;
                    bType <= 2'b01;
                    asByte <= 1'b0;
                    asUnsigned <= 1'b0;
                end
                // bge
                else if (instruction[2:0] == 3'b101) begin
                    ALUctrl <= 4'b0110;
                    bType <= 2'b10;
                    asByte <= 1'b0;
                    asUnsigned <= 1'b0;
                end
                // blt
                else if (instruction[2:0] == 3'b100) begin
                    ALUctrl <= 4'b0110;
                    bType <= 2'b11;
                    asByte <= 1'b0;
                    asUnsigned <= 1'b0;
                end
                else begin
                    ALUctrl <= 4'b0000;
                    bType <= 2'b00;
                    asByte <= 1'b0;
                    asUnsigned <= 1'b0;
                end
            end
            2'b10: begin
                // add
                if (instruction[2:0] == 3'b000 && instruction[3] == 1'b0) begin
                    ALUctrl <= 4'b0010;
                    bType <= 2'b00;
                    asByte <= 1'b0;
                    asUnsigned <= 1'b0;
                end
                // sub
                else if (instruction[2:0] == 3'b000 && instruction[3] == 1'b1) begin
                    ALUctrl <= 4'b0110;
                    bType <= 2'b00;
                    asByte <= 1'b0;
                    asUnsigned <= 1'b0;
                end
                // and
                else if (instruction[2:0] == 3'b111) begin
                    ALUctrl <= 4'b0000;
                    bType <= 2'b00;
                    asByte <= 1'b0;
                    asUnsigned <= 1'b0;
                end
                // or
                else if (instruction[2:0] == 3'b110) begin
                    ALUctrl <= 4'b0001;
                    bType <= 2'b00;
                    asByte <= 1'b0;
                    asUnsigned <= 1'b0;
                end
                // sll
                else if (instruction[2:0] == 3'b001) begin
                    ALUctrl <= 4'b0011;
                    bType <= 2'b00;
                    asByte <= 1'b0;
                    asUnsigned <= 1'b0;
                end
                // srl
                else if (instruction[2:0] == 3'b101 && instruction[3] == 1'b0) begin
                    ALUctrl <= 4'b0111;
                    bType <= 2'b00;
                    asByte <= 1'b0;
                    asUnsigned <= 1'b0;
                end
                // sra
                else if (instruction[2:0] == 3'b101 && instruction[3] == 1'b1) begin
                    ALUctrl <= 4'b1000;
                    bType <= 2'b00;
                    asByte <= 1'b0;
                    asUnsigned <= 1'b0;
                end
                else begin
                    ALUctrl <= 4'b0000;
                    bType <= 2'b00;
                    asByte <= 1'b0;
                    asUnsigned <= 1'b0;
                end
            end
            default: begin
                ALUctrl <= 4'b0000;
                bType <= 2'b00;
                asByte <= 1'b0;
                asUnsigned <= 1'b0;
            end
        endcase
    end
endmodule : ALUcontrol

module Mux32bit (
    input [31:0] a,
    input [31:0] b,
    input sel,
    output [31:0] out
    
);
    assign out = (sel)? b: a;
endmodule : Mux32bit

module Mux2_32bit (
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    input [1:0] sel,
    output reg [31:0] out
    
);
    always @ (*) begin
        case (sel)
            2'b00:
                out = a;
            2'b01:
                out = b;
            2'b10:
                out = c;
            default : out = a;
        endcase
    end
endmodule : Mux2_32bit