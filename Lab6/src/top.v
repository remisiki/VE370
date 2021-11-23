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
    input clk,
    output [31:0] read_data

);
    wire hit, mem_done;
    wire [9:0] addr;
    wire [31:0] write_data;
    wire [31:0] read_bus;
    wire [9:0] addr_bus;
    wire [31:0] write_bus;
    wire r_w_type_mem, r_w_type;
    Cache uut0 (addr, write_data, r_w_type, read_bus, mem_done, read_data, hit, r_w_type_mem, addr_bus, write_bus);
    Memory uut2 (r_w_type_mem, addr_bus, write_bus, read_bus, mem_done);
    CPU uut1 (clk, hit, r_w_type, addr, write_data);
endmodule

module CPU (
    input  clk,
    input  hit,
    output r_w_type,
    output [9:0] address,
    output [31:0] write_data

);
    parameter  request_total = 20; // change this number to how many requests you want in your testbench
    reg [4:0]  request_num;
    reg        read_write_test[request_total-1:0];
    reg [9:0]  address_test[request_total-1:0];
    reg [31:0] write_data_test[request_total-1:0]; 
    initial begin
        #5 request_num = 0;
        read_write_test[0] = 0; address_test[0] = (8'd5 << 2); write_data_test[0] = 0;
        read_write_test[1] = 0; address_test[1] = (8'd11 << 2); write_data_test[1] = 0;
        read_write_test[2] = 1; address_test[2] = (8'd11 << 2); write_data_test[2] = 32'h114514;
        read_write_test[3] = 1; address_test[3] = (8'd10 << 2); write_data_test[3] = 32'h1919;
        read_write_test[4] = 0; address_test[4] = (8'd27 << 2); write_data_test[4] = 0;
        // read_write_test[5] = 0; address_test[5] = (8'd27 << 2); write_data_test[5] = 0;
        read_write_test[5] = 1; address_test[5] = (8'd21 << 2); write_data_test[5] = 32'h810;
        read_write_test[6] = 0; address_test[6] = (8'd10 << 2); write_data_test[6] = 0;
        read_write_test[7] = 0; address_test[7] = (8'd4 << 2); write_data_test[7] = 0;
        // read_write_test[8] = 0; address_test[8] = (8'd11 << 2); write_data_test[8] = 0;
        // read_write_test[1] = 1; address_test[1] = 10'b0110010100; write_data_test[1] = 10'hfac;
        // read_write_test[2] = 0; address_test[2] = 10'b0110010101; write_data_test[2] = 0;
        // read_write_test[3] = 0; address_test[3] = 10'b0101010100; write_data_test[3] = 0;
        // read_write_test[4] = 0; address_test[4] = 10'b0110010101; write_data_test[4] = 0;
        /* add lines if necessary */
        
        
    end
    always @(posedge clk) begin
        if (hit) request_num <= request_num + 1;
        // else request_num <= request_num;
    end
    assign address      = address_test[request_num];
    assign r_w_type   = read_write_test[request_num];
    assign write_data   = write_data_test[request_num]; 
endmodule
