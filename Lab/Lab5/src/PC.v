`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/12 22:39:14
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input reset,
    input pc_write,
    input [31:0] pc_next,
    output reg [31:0] pc_current
);
    initial begin
        pc_current <= 32'b0;
    end

    always @(posedge clk) begin
        if (reset)
            pc_current = 32'b0;
        else if (pc_write)
            pc_current = pc_next;
    end
endmodule : PC

module AlterPC (
    input [31:0] pc_current,
    input [31:0] immediate,
    output [31:0] pc_destination
    
);
    assign pc_destination = pc_current + (immediate >> 1);
endmodule : AlterPC

module SelPC (
    input zero,
    input lt_zero,
    input [1:0] bType,
    input branch,
    output reg pcSrc
    
);
    initial pcSrc <= 1'b0;

    always @ (*) begin
        case (bType)
            2'b00:
                pcSrc = branch & zero;
            2'b01:
                pcSrc = branch & ~zero;
            2'b10:
                pcSrc = branch & ~lt_zero;
            2'b11:
                pcSrc = branch & lt_zero;
            default : pcSrc = 0;
        endcase
    end
endmodule : SelPC

module Jump (
    input jump,
    output reg pcSrc
    
);
    initial pcSrc <= 1'b0; 

    always @ (*)
        pcSrc = jump;
endmodule : Jump

module JumpReturn (
    input jump_return,
    output reg pcSrc
    
);
    initial pcSrc <= 1'b0;

    always @ (*)
        pcSrc = jump_return;
endmodule : JumpReturn

module RealPC (
    input [31:0] pc,
    output [31:0] pc_out
    
);
    assign pc_out = (pc << 2);
endmodule : RealPC