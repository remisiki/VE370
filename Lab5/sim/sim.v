`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/13 13:05:14
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
    wire clk_100MHz;
    reg reset;
    wire [4:0] register_index;
    wire [6:0] ssd;
    wire [3:0] a;
    wire [31:0] pc;
    top uut (clk_100MHz, clk, reset, register_index, ssd, a);
    initial begin
        #0 clk = 0;
        forever #5   clk = ~ clk;
    end
    integer f, i, j;
    initial begin
        #0 begin
            reset = 1'b0;
            // f = $fopen("./control.txt", "w");
            // $fclose(f);
            f = $fopen("./memory.txt", "w");
            $fclose(f);
            f = $fopen("./register.txt", "w");
            $fclose(f);
            // $readmemb("./instructions.prog", uut.uut0.memori_instr);
            // for (i = 0; i < 32; i = i + 1) begin
            //     uut.uut2.register[i] <= 32'b0;
            // end
            // uut.uut13.pcSrc <= 1'b0;
            // uut.uut8.pcSrc <= 1'b0;
            // uut.uut9.pcSrc <= 1'b0;
            // uut.uut.pc_current <= 32'b0;
        end
        #400 reset = 1'b1;
        #10 reset = 1'b0;
    end
    initial begin
        forever #10 begin
            f = $fopen("./memory.txt", "a");
            $fwrite(f, "time = %3dns\n", $time);
            for (i = 0; i < 8; i = i + 1) begin
                for (j = 0; j < 4; j = j + 1)
                    $fwrite(f, "\tmemory[%2d] = %2d ", 4 * i + j, uut.uut14.memori[4 * i + j]);
                $fwrite(f, "\n");
            end
            $fclose(f);
            f = $fopen("./register.txt", "a");
            $fwrite(f, "time = %3d\t pc = %h\n", $time, uut.pc_IF);
            // for (i = 0; i < 8; i = i + 1) begin
            //     for (j = 0; j < 4; j = j + 1)
            //         $fwrite(f, "\tregister[%2d] = %2d ", 4 * i + j, $signed(uut.uut2.register[4 * i + j]));
                $fwrite(f, "\tregister[%2d] = %h\t ", 1, $signed(uut.uut2.register[1]));
                $fwrite(f, "\tregister[%2d] = %h\t ", 5, $signed(uut.uut2.register[5]));
                $fwrite(f, "\tregister[%2d] = %h\t ", 6, $signed(uut.uut2.register[6]));
                $fwrite(f, "\tregister[%2d] = %h\t ", 7, $signed(uut.uut2.register[7]));
                $fwrite(f, "\tregister[%2d] = %h\t ", 28, $signed(uut.uut2.register[28]));
                $fwrite(f, "\tregister[%2d] = %h\t ", 29, $signed(uut.uut2.register[29]));
                $fwrite(f, "\n ");
            // end
            // fwrite(f,, "a");
            $fclose(f);
        end
    end
    initial
        #500 $stop;
endmodule