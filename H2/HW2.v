`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/02 15:39:52
// Design Name: 
// Module Name: HW2
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


module HW2(

    );
endmodule

module Reg32bit (
    input clk,
    input read_en_1,
    input read_en_2,
    input write_en,
    input [4:0] read_addr_1,
    input [4:0] read_addr_2,
    input [4:0] write_addr,
    input [31:0] write_data,
    output reg [31:0] read_data_1,
    output reg [31:0] read_data_2
    
);
    reg [31:0] register [31:0];
    always @(posedge clk) begin
        read_data_1 = 'bz;
        read_data_2 = 'bz;
        if (write_en)
            register[write_addr] = write_data;
        else begin 
            if (read_en_1)
                read_data_1 = register[read_addr_1];
            if (read_en_2)
                read_data_2 = register[read_addr_2];
        end
    end
endmodule : Reg32bit

module ImmGen32bit (
    input [31:0] instruction,
    output reg [31:0] immediate

);
    always @(*)
        case (instruction[6:0])
            // R-type
            7'b0110011: assign immediate = 'bz;
            // I-type
            7'b0000011: assign immediate = {{20{instruction[31]}}, instruction[31:20]}; 
            7'b0001111: assign immediate = {{20{instruction[31]}}, instruction[31:20]};
            7'b0010011: assign immediate = {{20{instruction[31]}}, instruction[31:20]};
            7'b1100111: assign immediate = {{20{instruction[31]}}, instruction[31:20]};
            7'b1110011: assign immediate = {{20{instruction[31]}}, instruction[31:20]};
            // S-type
            7'b0100011: assign immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
            // B-type
            7'b1100011: assign immediate = {{20{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8]};
            // U-type
            7'b0010111: assign immediate = {{12{instruction[31]}}, instruction[31:12]};
            7'b0110111: assign immediate = {{12{instruction[31]}}, instruction[31:12]};
            // J-type
            7'b1101111: assign immediate = {{12{instruction[31]}}, instruction[31], instruction[19:12], 
                instruction[20], 
                instruction[30:21]};
            default: assign immediate = 'bz;
        endcase
endmodule : ImmGen32bit