`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/13 05:38:10
// Design Name: 
// Module Name: Forward
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


module Forward(
    input regWrite_EX_MEM,
    input regWrite_MEM_WB,
    input memWrite_ID_EX,
    input [4:0] rd_EX_MEM,
    input [4:0] rd_MEM_WB,
    input [4:0] rs1_ID_EX,
    input [4:0] rs2_ID_EX,
    output reg [1:0] forward_A,
    output reg [1:0] forward_B

);
    always @ (*) begin
        if ((regWrite_EX_MEM) && (rd_EX_MEM > 0) && (rd_EX_MEM == rs1_ID_EX)) begin
            forward_A = 2'b10;
            $display("EX hazard at rs1 x%d\n", rs1_ID_EX);
        end
        else if ((regWrite_MEM_WB) && (rd_MEM_WB > 0) && (rd_MEM_WB == rs1_ID_EX)) begin
            forward_A = 2'b01;
            $display("MEM hazard at rs1 x%d\n", rs1_ID_EX);
        end
        else
            forward_A = 2'b00;
        if ((regWrite_EX_MEM) && (rd_EX_MEM > 0) && (rd_EX_MEM == rs2_ID_EX) && (~memWrite_ID_EX)) begin
            forward_B = 2'b10;
            $display("EX hazard at rs2 x%d\n", rs2_ID_EX);
        end
        else if ((regWrite_MEM_WB) && (rd_MEM_WB > 0) && (rd_MEM_WB == rs2_ID_EX) && (~memWrite_ID_EX)) begin
            forward_B = 2'b01;
            $display("MEM hazard at rs2 x%d\n", rs2_ID_EX);
        end
        else begin
            forward_B = 2'b00;
        end
    end
endmodule : Forward

module LoadHazard (
    input memRead_ID_EX,
    input memWrite_IF_ID,
    input [4:0] rd_ID_EX,
    input [4:0] rs1_IF_ID,
    input [4:0] rs2_IF_ID,
    output reg control_src,
    output reg pc_write,
    output reg IF_ID_write
    
);
    initial begin
        control_src <= 1'b1;
        pc_write <= 1'b1;
        IF_ID_write <= 1'b1;
    end
    always @ (*) begin
        if (memRead_ID_EX && ((rd_ID_EX == rs1_IF_ID) || (rd_ID_EX == rs2_IF_ID)) && (~ (memWrite_IF_ID))/**/) begin
            control_src <= 1'b0;
            pc_write <= 1'b0;
            IF_ID_write <= 1'b0;
            $display("LoadHazard at x%d\n", rd_ID_EX);
        end
        else begin
            control_src <= 1'b1;
            pc_write <= 1'b1;
            IF_ID_write <= 1'b1;
        end
    end
endmodule : LoadHazard

module SaveHazard (
    input memWrite_IF_ID,
    input [4:0] rd_ID_EX,
    input [4:0] rs2_IF_ID,
    output reg rs2_src
    
);
    initial begin
        rs2_src <= 1'b0;
    end
    always @ (*) begin
        if (memWrite_IF_ID && (rd_ID_EX > 0) && (rd_ID_EX == rs2_IF_ID)) begin
            rs2_src <= 1'b1;
            $display("SaveHazard at x%d\n", rd_ID_EX);
        end
        else begin
            rs2_src <= 1'b0;
        end
    end
endmodule : SaveHazard

module LoadSaveHazard (
    input memWrite_EX_MEM,
    input memRead_MEM_WB,
    input [4:0] rd_MEM_WB,
    input [4:0] rs2_EX_MEM,
    output reg mem_src
    
);
    initial begin
        mem_src <= 1'b0;
    end
    always @ (*) begin
        if (memWrite_EX_MEM && memRead_MEM_WB && (rd_MEM_WB == rs2_EX_MEM)) begin
            mem_src <= 1'b1;
            $display("LoadSaveHazard at x\n");
        end
        else begin
            mem_src <= 1'b0;
        end
    end
endmodule : LoadSaveHazard