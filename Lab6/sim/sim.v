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
    reg request, r_w_type, mem_done;
    reg [9:0] addr;
    reg [31:0] write_data;
    wire [31:0] read_data;
    wire hit;
    top uut(request, r_w_type, addr, write_data, mem_done, hit, read_data);
    initial begin
        /* lw mem[5] */
        #0 $readmemh("./memory.txt", uut.uut2.mem);
        #1 begin
            request <= 1'b1;
            r_w_type <= 1'b0;
            addr <= (8'd5 << 2);
            write_data <= 32'd0;
        end
        #1 begin
            mem_done <= ~hit;
            request <= 1'b0;
        end
        #1 begin
            mem_done <= 1'b0;
            request <= ~hit;
        end
        #1 begin
            request <= 1'b0;
        end
        /* lw mem[11] */
        #1 begin
           request <= 1'b1;
           r_w_type <= 1'b0;
           addr <= (8'd11 << 2);
           write_data <= 32'd0;
        end
        #1 begin
            mem_done <= ~hit;
            request <= 1'b0;
        end
        #1 begin
            mem_done <= 1'b0;
            request <= ~hit;
        end
        #1 begin
            request <= 1'b0;
        end
        /* sw mem[11] */
        #1 begin
           request <= 1'b1;
           r_w_type <= 1'b1;
           addr <= (8'd11 << 2);
           write_data <= 32'd111;
        end
        #1 begin
            mem_done <= ~hit;
            request <= 1'b0;
        end
        #1 begin
            mem_done <= 1'b0;
            request <= ~hit;
        end
        #1 begin
            request <= 1'b0;
        end
        /* sw mem[10] */
        #1 begin
           request <= 1'b1;
           r_w_type <= 1'b1;
           addr <= (8'd10 << 2);
           write_data <= 32'd110;
        end
        #1 begin
            mem_done <= ~hit;
            request <= 1'b0;
        end
        #1 begin
            mem_done <= 1'b0;
            request <= ~hit;
        end
        #1 begin
            request <= 1'b0;
        end
        /* lw mem[27] */
        #1 begin
           request <= 1'b1;
           r_w_type <= 1'b0;
           addr <= (8'd27 << 2);
           write_data <= 32'd0;
        end
        #1 begin
            mem_done <= ~hit;
            request <= 1'b0;
        end
        #1 begin
            mem_done <= 1'b0;
            request <= ~hit;
        end
        #1 begin
            request <= 1'b0;
        end
        /* sw mem[21] */
        #1 begin
           request <= 1'b1;
           r_w_type <= 1'b1;
           addr <= (8'd21 << 2);
           write_data <= 32'd709;
        end
        #1 begin
            mem_done <= ~hit;
            request <= 1'b0;
        end
        #1 begin
            mem_done <= 1'b0;
            request <= ~hit;
        end
        #1 begin
            request <= 1'b0;
        end
        /* lw mem[4] */
        #1 begin
           request <= 1'b1;
           r_w_type <= 1'b0;
           addr <= (8'd4 << 2);
           write_data <= 32'd0;
        end
        #1 begin
            mem_done <= ~hit;
            request <= 1'b0;
        end
        #1 begin
            mem_done <= 1'b0;
            request <= ~hit;
        end
        #1 begin
            request <= 1'b0;
        end
        /* lw mem[10] */
        #1 begin
           request <= 1'b1;
           r_w_type <= 1'b0;
           addr <= (8'd10 << 2);
           write_data <= 32'd0;
        end
        #1 begin
            mem_done <= ~hit;
            request <= 1'b0;
        end
        #1 begin
            mem_done <= 1'b0;
            request <= ~hit;
        end
        #1 begin
            request <= 1'b0;
        end
    end
    initial
        #40 $stop();
endmodule
