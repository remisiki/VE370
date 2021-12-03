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
    output [31:0] read_data,
    output page_fault

);
    wire hit, mem_done, page_hit;
    wire [1:0] physical_page_number_in, physical_page_number_out;
    wire [13:0] addr;
    wire [31:0] write_data;
    wire [31:0] read_bus;
    wire [9:0] addr_bus;
    wire [31:0] write_bus;
    wire r_w_type_mem, r_w_type;
    TLB uut3 (addr[13:8], page_hit, physical_page_number_in, physical_page_number_out, page_fault);
    Cache uut0 ({physical_page_number_out, addr[7:0]}, write_data, r_w_type, read_bus, mem_done, read_data, hit, r_w_type_mem, addr_bus, write_bus);
    Memory uut2 (r_w_type_mem, addr_bus, write_bus, addr[13:8], read_bus, mem_done, physical_page_number_in, page_hit);
    CPU uut1 (clk, hit, r_w_type, addr, write_data);
endmodule

module CPU (
    input  clk,
    input  hit,
    output r_w_type,
    output [13:0] address,
    output [31:0] write_data

);
    parameter  request_total = 20; // change this number to how many requests you want in your testbench
    reg [4:0]  request_num;
    reg        read_write_test[request_total-1:0];
    reg [13:0]  address_test[request_total-1:0];
    reg [31:0] write_data_test[request_total-1:0]; 
    initial begin
        #1 request_num = 0;
        /* lw mem[149]; 000001 010101 00 */
        read_write_test[0] = 0; address_test[0] = 14'h0154; write_data_test[0] = 0;
        /* lw mem[69]; 000000 000101 00 */
        read_write_test[1] = 0; address_test[1] = 14'h0014; write_data_test[1] = 0;
        /* sw mem[27]; 000010 011011 00 */
        read_write_test[2] = 1; address_test[2] = 14'h026C; write_data_test[2] = 32'h114514;
        /* sw mem[11]; 000011 001011 00 */
        read_write_test[3] = 1; address_test[3] = 14'h032C; write_data_test[3] = 32'h1919;
        /* lw mem[141]; 000001 001101 00 */
        read_write_test[4] = 0; address_test[4] = 14'h0134; write_data_test[4] = 0;
        // read_write_test[5] = 0; address_test[5] = (8'd27 << 2); write_data_test[5] = 0;
        /* lw mem[1]; 000100 000001 00 */
        read_write_test[5] = 0; address_test[5] = 14'h0404; write_data_test[5] = 0;
        /* load page fault; 000111 000101 00 */
        read_write_test[6] = 0; address_test[6] = 14'h0714; write_data_test[6] = 0;
        // read_write_test[7] = 0; address_test[7] = ((12'h0005 << 2) + 1); write_data_test[7] = 0;
        // read_write_test[8] = 0; address_test[8] = (12'h001B << 2); write_data_test[8] = 0;
        /* add lines if necessary */
        
        
    end
    always @(posedge clk) begin
        if (hit) request_num <= request_num + 1;
        else request_num <= request_num;
    end
    assign address      = address_test[request_num];
    assign r_w_type   = read_write_test[request_num];
    assign write_data   = write_data_test[request_num]; 
endmodule
