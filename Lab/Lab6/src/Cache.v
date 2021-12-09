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
    input [9:0] addr_in,
    input [31:0] write_data_in,
    input r_w_type_in,
    input [31:0] read_data_in,
    input mem_done,
    output reg [31:0] read_data_out,
    output reg hit,
    output reg r_w_type_out,
    output reg [9:0] addr_out,
    output reg [31:0] write_data_out

);
    reg valid [3:0];
    reg dirty [3:0];
    reg [3:0] tag [3:0];
    reg [31:0] data [15:0];
    wire [1:0] index;
    wire [3:0] word_index;
    wire [1:0] offset;
    wire [3:0] data_tag;
    wire [1:0] data_offset;
    wire asByte;
    reg [31:0] buffer;
    integer i;
    initial begin
        for (i = 0; i < 4; i = i + 1) valid[i] <= 1'b0;
        for (i = 0; i < 4; i = i + 1) dirty[i] <= 1'b0;
        for (i = 0; i < 4; i = i + 1) tag[i] <= 4'b0;
        for (i = 0; i < 16; i = i + 1) data[i] <= 32'b0;
        r_w_type_out <= 1'b0;
    end
    always @ (*) begin
        if (mem_done == 1'b0) begin
            /* Hit */
            if ((valid[index] == 1'b1) && (tag[index] == data_tag)) begin
                hit = 1'b1;
                if (r_w_type_in == 1'b0) begin
                    /* Read from cache */
                    read_data_out = (asByte) ? data[word_index][(data_offset * 8 + 7) -: 8]: data[word_index];
                end
                else begin
                    /* Write to cache */
                    buffer = data[word_index];
                    #1 if (asByte) begin
                        case (data_offset)
                            2'b01:
                                data[word_index] = {buffer[31:16], write_data_in[7:0], buffer[7:0]};
                            2'b10:
                            data[word_index] = {buffer[31:24], write_data_in[7:0], buffer[15:0]};
                            2'b11:
                            data[word_index] = {write_data_in[7:0], buffer[23:0]};
                        endcase
                    end
                    else
                        data[word_index] = write_data_in;
                    /* Update information */
                    dirty[index] = 1'b1;
                end
            end
            /* Miss */
            else begin
                hit = 1'b0;
                if (dirty[index]) begin
                    /* Write back */
                    r_w_type_out = 1'b0;
                    addr_out = {tag[index], index, 4'b0000};    
                end
                else begin
                    /* Directly overwrite */
                    addr_out = {(addr_in >> 4), 4'b0000};
                end
            end
        end
        /* Wait for memory access */
        else if (mem_done == 1'b1) begin
            if (dirty[index]) begin
                /* Write back */
                for (i = 0; i < 4; i = i + 1) begin
                    #1 addr_out = (addr_out / 16) * 16 + (i * 4);
                    write_data_out = data[(index * 4) + ((addr_out / 4) % 4)];
                    r_w_type_out = 1'b1;
                end
            end
            /* Read from memory */
            #1 for (i = 0; i < 4; i = i + 1) begin
                r_w_type_out = 1'b0;
                addr_out = (addr_in / 16) * 16 + (i * 4);
                #1 data[(index * 4) + ((addr_out / 4) % 4)] = read_data_in;
            end
            /* Update information */
            valid[index] = 1'b1;
            dirty[index] = 1'b0;
            tag[index] = data_tag;
        end
    end
    assign index = ((addr_in >> 4) & 2'b11);
    assign word_index = ((addr_in >> 2) & 4'b1111);
    assign data_tag = (addr_in >> 6);
    assign offset = ((addr_in >> 2) & 2'b11);
    assign data_offset = (addr_in & 2'b11);
    assign asByte = (data_offset > 0);
endmodule : Cache
