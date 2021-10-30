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
    input [31:0] pc_next,
    output reg [31:0] pc_current
);
    initial begin
        pc_current = 32'b0;
    end
    always @(posedge clk) begin
        pc_current = pc_next;
    end
endmodule : PC

module NextPC (
    input [31:0] pc_current,
    input [31:0] immediate,
    input branch,
    input zero,
    input bne,
    output [31:0] pc_next
    
);
    wire sel;
    wire [31:0] branch_destination;
    assign sel = (bne)? (branch & ~zero): (branch & zero);
    BranchPC uut0 (pc_current, immediate, branch_destination);
    Mux32bit uut (pc_current + 1, branch_destination, sel, pc_next);
endmodule : NextPC

module BranchPC (
    input [31:0] pc_current,
    input [31:0] immediate,
    output [31:0] branch_destination
    
);
    assign branch_destination = pc_current + (immediate >> 1);
endmodule : BranchPC

module SelPC (
    input zero,
    input bne,
    input branch,
    output reg pcSrc
    
);
    initial pcSrc = 1'b0;
    always @ (*)
        pcSrc = (bne)? (branch & ~zero): (branch & zero);
endmodule : SelPC