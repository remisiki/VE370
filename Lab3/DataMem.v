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
    input write_en,
    input [31:0] read_addr,
    input [31:0] write_addr,
    input [31:0] write_data,
    output [31:0] read_data
);
    reg [31:0] memori [31:0];
    integer f, i;
    initial begin
        $readmemb("./memory.dat", memori);
        f = $fopen("./memory.txt", "w");
        $fclose(f);
    end
    always @(posedge clk) begin
        f = $fopen("./memory.txt", "a");
        $fwrite(f, "time = %d\n", $time);
        for (i = 0; i < 32; i = i + 1)
            $fwrite(f, "\tmemory[%d] = %d\n", i, memori[i]);
        $fclose(f);
        if (write_en)
            memori[write_addr] = write_data;
    end
    assign read_data = memori[read_addr];
endmodule
