`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/21 00:50:41
// Design Name: 
// Module Name: sim
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


module sim(

);
    wire [31:0] read_data;
    reg clk;
    top uut(clk, read_data);
    integer f;
    initial begin
        clk <= 1'b0;
        uut.uut2.mem_done <= 1'b0;
        f = $fopen("./result.txt", "w");
        $fclose(f);
        $readmemh("./memory.txt", uut.uut2.mem);
        #100 $stop();       
    end
    always @ (uut.uut1.request_num) begin
        if (uut.uut1.request_num > 0) begin
            f = $fopen("./result.txt", "a");
            $fdisplay(f, "===============================================");
            $fdisplay(f, "Request number %d", uut.uut1.request_num - 1);
            $fdisplay(f, "read_data = %h", uut.read_data);
            $fdisplay(f, "cache_data[00]: %h\t%h\t%h\t%h\t", uut.uut0.data[0], uut.uut0.data[1], uut.uut0.data[2], uut.uut0.data[3]);
            $fdisplay(f, "cache_data[01]: %h\t%h\t%h\t%h\t", uut.uut0.data[4], uut.uut0.data[5], uut.uut0.data[6], uut.uut0.data[7]);
            $fdisplay(f, "cache_data[10]: %h\t%h\t%h\t%h\t", uut.uut0.data[8], uut.uut0.data[9], uut.uut0.data[10], uut.uut0.data[11]);
            $fdisplay(f, "cache_data[11]: %h\t%h\t%h\t%h\t", uut.uut0.data[12], uut.uut0.data[13], uut.uut0.data[14], uut.uut0.data[15]);
            $fdisplay(f, "memory[08~11]: %h\t%h\t%h\t%h\t", uut.uut2.mem[8], uut.uut2.mem[9], uut.uut2.mem[10], uut.uut2.mem[11]);
            $fdisplay(f, "memory[24~27]: %h\t%h\t%h\t%h\t", uut.uut2.mem[24], uut.uut2.mem[25], uut.uut2.mem[26], uut.uut2.mem[27]);
            $fdisplay(f, "===============================================");
            $fclose(f);
        end
    end
    always
        #5 clk <= ~clk;
endmodule
