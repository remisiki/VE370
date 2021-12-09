`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/03 12:20:56
// Design Name: 
// Module Name: TLB
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


module TLB(
    input [5:0] virtual_page_number,
    input page_hit,
    input [1:0] physical_page_number_in,    // Read from page table when miss
    input r_w_type,
    output reg [1:0] physical_page_number_out,   // Output to cache
    output reg page_fault

);
    reg valid [3:0];
    reg dirty [3:0];
    reg [1:0] reference [3:0];
    reg [5:0] tag [3:0];
    reg [1:0] physical_page_number [3:0];
    reg hit;
    integer i, j;
    initial begin
        for (i = 0; i < 4; i = i + 1) valid[i] <= 1'b0;
        for (i = 0; i < 4; i = i + 1) dirty[i] <= 1'b0;
        for (i = 0; i < 4; i = i + 1) tag[i] <= 6'b0;
        for (i = 0; i < 4; i = i + 1) physical_page_number[i] <= 2'b0;
        for (i = 0; i < 4; i = i + 1) reference[i] <= 2'b0;
        hit <= 1'b0;
        page_fault <= 1'b0;
    end
    always @ (virtual_page_number) begin
        hit = 1'b0;
        for (i = 0; i < 4; i = i + 1) begin
            /* Scan all TLB */
            if ((tag[i] == virtual_page_number) && (valid[i] == 1'b1)) begin
                /* Hit */
                #1 physical_page_number_out = physical_page_number[i];
                hit = 1'b1;
                /* Update hit TLB to newest, all others downgrade */
                reference[i] = 2'b11;
                for (j = 0; j < 4; j = j + 1) begin
                    if (((i > j) || (i < j)) && (reference[j] > 0)) begin
                        reference[j] = reference[j] - 1;
                    end
                end
                dirty[i] = r_w_type;
            end
        end
        #1 if (hit == 1'b0) begin
            /* Miss */
            if (page_hit) begin
                i = 0;
                j = 0;
                /* Find empty TLB */
                while ((i < 4) && (j == 0)) begin
                    if (valid[i] == 1'b0) begin
                        j = 1;
                    end
                    i = i + 1;
                end
                if ((i == 4) && (j == 0)) begin
                    /* All TLB full, find oldest one */
                    i = 0;
                    j = 0;
                    while ((i < 4) && (j == 0)) begin
                        if (reference[i] == 2'b0) begin
                            j = 1;
                        end
                        i = i + 1;
                    end
                end
                i = i - 1;
                for (j = 0; j < 4; j = j + 1) begin
                    if (((i > j) || (i < j)) && (reference[j] > 0)) begin
                        reference[j] = reference[j] - 1;
                    end
                end
                physical_page_number[i] = physical_page_number_in;
                physical_page_number_out = physical_page_number_in;
                valid[i] = 1'b1;
                reference[i] = 2'b11;
                tag[i] = virtual_page_number;
                hit = 1'b1;
            end
            else begin
                /* Page fault */
                page_fault = 1'b1;
            end
        end
    end
endmodule
