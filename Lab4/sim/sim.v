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
    integer f, i, j;
    initial begin
        #0 begin
            f = $fopen("./control.txt", "w");
            $fclose(f);
            f = $fopen("./memory.txt", "w");
            $fclose(f);
            f = $fopen("./register.txt", "w");
            $fclose(f);
        end
    end
    initial begin
        forever #10 begin
            // f = $fopen("./control.txt", "a");
            // $fwrite(f, "time = %d\n", $time);
            // $fwrite(f, "\tbranch = %b\n", uut.branch, 
            //     "\tmemRead = %b\n", uut.memRead, 
            //     "\tmemToReg = %b\n", uut.memToReg, 
            //     "\tALUop = %b\n", uut.ALUop, 
            //     "\tmemWrite = %b\n", uut.memWrite, 
            //     "\tALUsrc = %b\n", uut.ALUsrc, 
            //     "\tregWrite = %b\n", uut.regWrite);
            // $fclose(f);
            f = $fopen("./memory.txt", "a");
            $fwrite(f, "time = %3dns\n", $time);
            for (i = 0; i < 8; i = i + 1) begin
                for (j = 0; j < 4; j = j + 1)
                    $fwrite(f, "\tmemory[%2d] = %2d ", 4 * i + j, uut.uut4.memori[4 * i + j]);
                $fwrite(f, "\n");
            end
            $fclose(f);
            f = $fopen("./register.txt", "a");
            $fwrite(f, "time = %3d\n", $time);
            for (i = 0; i < 8; i = i + 1) begin
                for (j = 0; j < 4; j = j + 1)
                    $fwrite(f, "\tregister[%2d] = %2d ", 4 * i + j, uut.uut.register[4 * i + j]);
                $fwrite(f, "\n");
            end
            $fclose(f);
        end
    end
    initial
        #500 $stop;
endmodule
