`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/12 21:47:20
// Design Name: 
// Module Name: Reg
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


module Reg(
    input clk,
    input write_en,
    input [4:0] read_addr_1,
    input [4:0] read_addr_2,
    input [4:0] write_addr,
    input [31:0] write_data,
    output [31:0] read_data_1,
    output [31:0] read_data_2

);
    reg [31:0] register [31:0];
    integer f, i;
    initial begin
        f = $fopen("./register.txt", "w");
        $fclose(f);
        for (i = 0; i < 32; i = i + 1) register[i] = 32'b0;
    end
    always @(posedge clk) begin
        f = $fopen("./register.txt", "a");
        $fwrite(f, "time = %d\n", $time);
        for (i = 0; i < 32; i = i + 1)
            $fwrite(f, "\tregister[%d] = %d\n", i, register[i]);
        $fclose(f);
        if (write_en)
            register[write_addr] = write_data;
    end
    assign read_data_1 = register[read_addr_1];
    assign read_data_2 = register[read_addr_2];
endmodule : Reg
