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
    wire [1:0] offset;
    wire [3:0] data_tag;
    integer i;
    initial begin
        for (i = 0; i < 4; i = i + 1) valid[i] <= 1'b0;
        for (i = 0; i < 4; i = i + 1) dirty[i] <= 1'b0;
        for (i = 0; i < 4; i = i + 1) tag[i] <= 4'b0;
        for (i = 0; i < 16; i = i + 1) data[i] <= 32'b0;
        r_w_type_out <= 1'b0;
    end
    always @ (*) begin
        // #1
        if (mem_done == 1'b0) begin
            /* Hit */
            if ((valid[index] == 1'b1) && (tag[index] == data_tag)) begin
                hit = 1'b1;
                if (r_w_type_in == 1'b0) begin    // Read from cache
                    read_data_out = data[(index * 4) + offset];
                    $display("data[%d] = %d", (index * 4) + offset, data[(index * 4) + offset]);
                    // addr_out_0 = {(addr_in >> 4), 4'b0000};
                    // addr_out_1 = {(addr_in >> 4), 4'b0100};
                    // addr_out_2 = {(addr_in >> 4), 4'b1000};
                    // addr_out_3 = {(addr_in >> 4), 4'b1100};
                end
                else begin          // Write to cache
                    data[(index * 4) + offset] = write_data_in;
                    $display("Write fuck %h to %d", write_data_in, data[(index * 4) + offset]);
                    // if (mem_done == 1'b0)
                    dirty[index] = 1'b1;
                end
            end
            /* Miss */
            else begin
                hit = 1'b0;
                /* Write back */
                if (dirty[index]) begin
                    r_w_type_out = 1'b0;
                    addr_out = {tag[index], index, 4'b0000};
                    // write_data_out = data[(index * 4) + ((addr_out / 4) % 4)];
                    // r_w_type_out = 1'b1;
                    
                end
                else begin
                    addr_out = {(addr_in >> 4), 4'b0000};
                    // addr_out_1 = {(addr_in >> 4), 4'b0100};
                    // addr_out_2 = {(addr_in >> 4), 4'b1000};
                    // addr_out_3 = {(addr_in >> 4), 4'b1100};
                    
                end
            end
        end
        /* Wait for memory access */
        else if (mem_done == 1'b1) begin
            // if (r_w_type_in == 1'b0) begin
            if (dirty[index]) begin
                for (i = 0; i < 4; i = i + 1) begin
                    #1 addr_out = (addr_out / 16) * 16 + (i * 4);
                    write_data_out = data[(index * 4) + ((addr_out / 4) % 4)];
                    r_w_type_out = 1'b1;
                    // #1 data[(index * 4) + ((addr_out / 4) % 4)] = read_data_in;
                end
            end
            /* Read from memory */
            #1 for (i = 0; i < 4; i = i + 1) begin
                r_w_type_out = 1'b0;
                addr_out = (addr_in / 16) * 16 + (i * 4);
                #1 data[(index * 4) + ((addr_out / 4) % 4)] = read_data_in;
            end
            valid[index] = 1'b1;
            dirty[index] = 1'b0;
            /* Update information */
            tag[index] = data_tag;
        // end
        // else if (r_w_type_in == 1'b1) begin
            // if ((addr_out & 4'b1111) == 4'b1100) begin
            //     valid[index] = 1'b1;
            //     dirty[index] = 1'b0;
            // end
            // else begin
            //     addr_out = addr_out + 4;
            //     valid[index] = 1'b0;
            // end
            // r_w_type_out = 1'b0;
            // data[(index * 4) + ((addr_out / 4) % 4)] = read_data_in;
            // write_data_out = data[(index * 4)];
        // end
        end
    end
    assign index = ((addr_in >> 4) & 3);
    assign data_tag = (addr_in >> 6);
    assign offset = ((addr_in >> 2) & 3);
endmodule : Cache
