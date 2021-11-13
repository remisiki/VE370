`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/12 23:02:09
// Design Name: 
// Module Name: DataMem
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


module DataMem(
    input clk,
    input reset,
    input write_en,
    input [31:0] read_addr,
    input [31:0] write_addr,
    input [31:0] write_data,
    output [31:0] read_data,
    input asByte,
    input asUnsigned

);
    reg [7:0] memori [31:0];
    wire [31:0] signed_value, unsigned_value, byte_value, word_value;
    integer i;
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                memori[i] <= 8'b0;
            end
        end
        else if (write_en && (~ asByte)) begin
            memori[write_addr] = write_data[7:0];
            memori[write_addr + 1] = write_data[15:8];
            memori[write_addr + 2] = write_data[23:16];
            memori[write_addr + 3] = write_data[31:24];
        end
        else if (write_en) begin
            memori[write_addr] = write_data[7:0];
        end
    end
    assign unsigned_value = {24'b0, memori[read_addr]};
    assign signed_value = {{24{memori[read_addr][7]}}, memori[read_addr]};
    assign word_value = {memori[read_addr + 3], memori[read_addr + 2], memori[read_addr + 1], memori[read_addr]};
    Mux32bit uut (signed_value,unsigned_value, asUnsigned, byte_value);
    Mux32bit uut0 (word_value, byte_value, asByte, read_data);
endmodule : DataMem
