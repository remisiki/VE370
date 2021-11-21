`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/21 00:38:01
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
    input request,
    input r_w_type,
    input [9:0] addr,
    input [31:0] write_data,
    input mem_done,
    output hit,
    output [31:0] read_data

);
    wire [1:0] state_current, state_next;
    wire [31:0] read_bus [3:0];
    wire [9:0] addr_bus [3:0];
    wire [31:0] write_bus [3:0];
    wire r_w_type_mem;
    Cache uut0 (request, addr, write_data, r_w_type, read_bus[0], read_bus[1], read_bus[2], read_bus[3], mem_done, read_data, hit, r_w_type_mem, addr_bus[0], addr_bus[1], addr_bus[2], addr_bus[3], write_bus[0], write_bus[1], write_bus[2], write_bus[3] );
    Memory uut2 (r_w_type_mem, addr_bus[0], addr_bus[1], addr_bus[2], addr_bus[3], write_bus[0], write_bus[1], write_bus[2], write_bus[3], read_bus[0], read_bus[1], read_bus[2], read_bus[3]);
endmodule
