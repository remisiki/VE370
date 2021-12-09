`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/13 14:03:27
// Design Name: 
// Module Name: ssd
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


module SSD(
    input [3:0] digit,
    output reg [6:0] ssd

);
    always @ (*) begin
        case (digit)
            4'b0000: ssd <= 7'b0000001;
            4'b0001: ssd <= 7'b1001111;
            4'b0010: ssd <= 7'b0010010;
            4'b0011: ssd <= 7'b0000110;
            4'b0100: ssd <= 7'b1001100;
            4'b0101: ssd <= 7'b0100100;
            4'b0110: ssd <= 7'b0100000;
            4'b0111: ssd <= 7'b0001111;
            4'b1000: ssd <= 7'b0000000;
            4'b1001: ssd <= 7'b0000100;
            4'b1010: ssd <= 7'b0001000;
            4'b1011: ssd <= 7'b1100000;
            4'b1100: ssd <= 7'b0110001;
            4'b1101: ssd <= 7'b1000010;
            4'b1110: ssd <= 7'b0110000;
            4'b1111: ssd <= 7'b0111000;
            default: ssd <= 7'b1111111;
        endcase // digit
    end
endmodule : SSD

module ring_counter_4_bit (
    input clk,
    input reset,
    output reg [3:0] AN = 4'b1110
    
);
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            AN <= 4'b1110;
        end // if (reset)
        else begin
            AN[0] <= AN[1];
            AN[1] <= AN[2];
            AN[2] <= AN[3];
            AN[3] <= AN[0];
        end
    end // always @ (posedge clk or posedge reset)
endmodule : ring_counter_4_bit

module clk_divider #(
    parameter magn = 10)
(
    input clk,
    input reset,
    output reg clk_d

);
    reg [$clog2(magn):0] cnt = 0;
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            clk_d <= 0;
            cnt <= 0;
        end
        else if (cnt == magn - 1) begin
            clk_d <= 1;
            cnt <= 0;
        end
        else begin
            clk_d <= 0;
            cnt <= cnt + 1;
        end
    end // always @ (posedge clk or posedge reset)
endmodule : clk_divider
