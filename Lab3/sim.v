`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/12 21:53:49
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
    reg clk;
    top uut (clk);
    initial begin
        #5 clk = 0;
        forever #5   clk = ~ clk;
    end
    integer f, i;
    initial begin
        #0 begin
            f = $fopen("./control.txt", "w");
            $fclose(f);
        end
    end
    initial begin
        forever #10 begin
            f = $fopen("./control.txt", "a");
            $fwrite(f, "time = %d\n", $time);
            $fwrite(f, "\tbranch = %d\n", uut.branch, 
                "\tmemRead = %d\n", uut.memRead, 
                "\tmemToReg = %d\n", uut.memToReg, 
                "\tALUop = %d\n", uut.ALUop, 
                "\tmemWrite = %d\n", uut.memWrite, 
                "\tALUsrc = %d\n", uut.ALUsrc, 
                "\tregWrite = %d\n", uut.regWrite);
            $fclose(f);
        end
    end
    initial
        #200 $stop;
endmodule
