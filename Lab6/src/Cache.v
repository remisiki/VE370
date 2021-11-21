`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/20 22:55:41
// Design Name: 
// Module Name: Cache
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


module Cache(
    input cpu_request,
    input [9:0] addr_in,
    input [31:0] write_data_in,
    input r_w_type_in,
    input [31:0] read_data_in_0,
    input [31:0] read_data_in_1,
    input [31:0] read_data_in_2,
    input [31:0] read_data_in_3,
    input mem_done,
    output reg [31:0] read_data_out,
    output reg hit,
    output reg r_w_type_out,
    output [9:0] addr_out_0,
    output [9:0] addr_out_1,
    output [9:0] addr_out_2,
    output [9:0] addr_out_3,
    output reg [31:0] write_data_out_0,
    output reg [31:0] write_data_out_1,
    output reg [31:0] write_data_out_2,
    output reg [31:0] write_data_out_3

);
    reg valid [3:0];
    reg dirty [3:0];
    reg [3:0] tag [3:0];
    reg [31:0] data [15:0];
    wire [1:0] index;
    wire [1:0] offset;
    wire [3:0] data_tag;
    integer i;
    initial begin
        for (i = 0; i < 4; i = i + 1) valid[i] <= 1'b0;
        for (i = 0; i < 4; i = i + 1) dirty[i] <= 1'b0;
        for (i = 0; i < 4; i = i + 1) tag[i] <= 4'b0;
        for (i = 0; i < 16; i = i + 1) data[i] <= 32'b0;
    end
    always @ (*) begin
        if (cpu_request) begin
            /* Hit */
            if ((valid[index] == 1'b1) && (tag[index] == data_tag)) begin
                hit <= 1'b1;
                if (r_w_type_in == 1'b0)    // Read from cache
                    read_data_out <= data[(index * 4) + offset];
                else begin          // Write to cache
                    data[(index * 4) + offset] <= write_data_in;
                    dirty[index] <= 1'b1;
                end
            end
            /* Miss */
            else begin
                hit <= 1'b0;
                /* Write back */
                if (dirty[index]) begin
                    r_w_type_out <= 1'b1;
                    write_data_out_0 <= data[(index * 4)];
                    write_data_out_1 <= data[(index * 4) + 1];
                    write_data_out_2 <= data[(index * 4) + 2];
                    write_data_out_3 <= data[(index * 4) + 3];
                end
            end
        end
        /* Wait for memory access */
        else if (mem_done) begin
            /* Read from memory */
            r_w_type_out <= 1'b0;
            data[(index * 4)] <= read_data_in_0;
            data[(index * 4) + 1] <= read_data_in_1;
            data[(index * 4) + 2] <= read_data_in_2;
            data[(index * 4) + 3] <= read_data_in_3;
            /* Update information */
            valid[index] <= 1'b1;
            tag[index] <= data_tag;
            dirty[index] <= 1'b0;
        end
    end
    assign index = ((addr_in >> 4) & 3);
    assign data_tag = (addr_in >> 6);
    assign offset = ((addr_in >> 2) & 3);
    assign addr_out_0 = (dirty[index]) ? addr_out_0 : {tag[index], index, 4'b0000};
    assign addr_out_1 = (dirty[index]) ? addr_out_1 : {tag[index], index, 4'b0100};
    assign addr_out_2 = (dirty[index]) ? addr_out_2 : {tag[index], index, 4'b1000};
    assign addr_out_3 = (dirty[index]) ? addr_out_3 : {tag[index], index, 4'b1100};
endmodule : Cache
