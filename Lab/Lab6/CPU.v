`timescale 1ns / 1ps

module CPU (
    input  hit_miss,
    input  clock,
    output read_write,
    output [9:0] address,
    output [31:0] write_data
);
    parameter  request_total = 5; // change this number to how many requests you want in your testbench
    reg [4:0]  request_num;
    reg        read_write_test[request_total-1:0];
    reg [9:0]  address_test[request_total-1:0];
    reg [31:0] write_data_test[request_total-1:0]; 
    initial begin
        #10 request_num = 0;
        read_write_test[0] = 0; address_test[0] = 10'b0110101001; write_data_test[0] = 0;
        read_write_test[1] = 1; address_test[1] = 10'b0110010101; write_data_test[1] = 10'hfac;
        read_write_test[2] = 0; address_test[2] = 10'b0110010101; write_data_test[2] = 0;
        read_write_test[3] = 0; address_test[3] = 10'b0101010100; write_data_test[3] = 0;
        read_write_test[4] = 0; address_test[4] = 10'b0110010101; write_data_test[4] = 0;
        /* add lines if necessary */
        
        
    end
    always @(posedge clock) begin
        if (hit_miss == 1) request_num = request_num + 1;
        else request_num = request_num;
    end
    assign address      = address_test[request_num];
    assign read_write   = read_write_test[request_num];
    assign write_data   = write_data_test[request_num]; 
endmodule