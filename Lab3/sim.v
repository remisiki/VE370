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
    wire [31:0] read_data_1, read_data_2, instruction, pc_current, pc_next, read_data, immediate, ALU_in_1, ALU_result, write_data;
    wire branch, memRead, memToReg,  memWrite, ALUsrc, regWrite, bne, zero;
    wire [1:0] ALUop;
    wire [3:0] ALUctrl;
    reg clk;
    // reg [4:0] read_addr_1, read_addr_2, write_addr, read_addr;
    // reg [31:0] write_addr_mem, read_addr_mem;
    // reg [31:0] write_data;
    // reg clk, write_en_reg, write_en_mem;
    Reg uut (clk, regWrite, instruction[19:15], instruction[24:20], instruction[11:7], write_data, read_data_1, read_data_2);
    InstrMem uut1 (pc_current, instruction);
    PC uut2 (clk, pc_next, pc_current);
    nextPC uut3 (pc_current, immediate, branch, zero, bne, pc_next);
    DataMem uut4 (clk, memWrite, ALU_result, ALU_result, read_data_2, read_data);
    Control uut5 (instruction[6:0], branch, memRead, memToReg, ALUop, memWrite, ALUsrc, regWrite);
    // wire [31:0] immediate;
    ImmGen uut6 (instruction, immediate);
    ALUcontrol uut7 ({instruction[30], instruction[14:12]}, ALUop, ALUctrl, bne);
    Mux32bit uut8 (read_data_2, immediate, ALUsrc, ALU_in_1);
    ALU uut9 (read_data_1, ALU_in_1, ALUctrl, zero, ALU_result);
    Mux32bit uut10 (ALU_result, read_data, memToReg, write_data);
    initial begin
        // #10 read_addr_mem = 0;
            // read_en_mem = 1;
        // #0  clk = 0;
        // #50 PC = 32'b0;
        // #0 instruction = 32'b00000000110000000000100100110011; // add x18, x0, x12
        // #50 instruction = 32'b11111110000000010010101010000011; // lw x21, -32(sp)
        // #50 instruction = 32'b00000000000100010010010000100011; // sw x1, 8(sp)
        // #50 instruction = 32'b00000000010100000100010001100011; // blt x0, x5, 8
        // #50 instruction = 32'b00010000000000000000010100110111; // lui x10, 0x10000
        // #50 instruction = 32'b11111111000111111111000001101111; // jal x0, -16
        //     read_addr_1 = 5'b10010;
        //     read_addr_2 = 5'b00111;
        //     write_data = 32'd3108;
        //     read_en_1 = 0;
        //     read_en_2 = 0;
        //     write_en = 0;
        //     write_addr = 5'b10010;
        // #50 write_en = 1;
        // #50 write_en = 0;
        //     read_en_1 = 1;
        // #50 read_en_1 = 0;
        //     write_en = 1;
        //     write_addr = 5'b00111;
        //     write_data = 32'd191;
        // #50 write_en = 0;
        // #50 read_en_1 = 1;
        //     read_en_2 = 1;
        // #50 read_en_1 = 0;
        //     read_en_2 = 0;
        //     write_en = 1;
        //     write_data = 32'hffffffff;
        // #50 write_en = 0;
        //     read_en_2 = 1;
        // #50 read_en_2 = 0;
        //     read_addr_1 = 5'b01011;
        //     write_addr = 5'b01011;
        //     write_data = 32'b0;
        // #50 write_en = 1;
        // #50 write_en = 0;
        //     read_en_1 = 1;
        // #50 read_en_1 = 0;
    end
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
            $fwrite(f, "\tbranch = %d\n", branch, 
                "\tmemRead = %d\n", memRead, 
                "\tmemToReg = %d\n", memToReg, 
                "\tALUop = %d\n", ALUop, 
                "\tmemWrite = %d\n", memWrite, 
                "\tALUsrc = %d\n", ALUsrc, 
                "\tregWrite = %d\n", regWrite);
            $fclose(f);
        end
    end
    initial
        #200 $stop;
endmodule
