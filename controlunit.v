`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2025 04:19:25 PM
// Design Name: 
// Module Name: control_unit
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


module control_unit(

input [31:0] ir,
output reg i_r,
output reg write_reg_en,
output reg regfile_src_oalu_st,
output reg [3:0] ALU_inst,
output reg jump
    );
    
     always begin
        case (ir[31:29])
            3'd0 : //arithmetic
            begin
            case (ir[28:27])
                2'd0:
                begin
                ALU_inst = 4'd0; // add is add in ALU
                i_r = 1'b1;
                write_reg_en = 1'b1;
                regfile_src_oalu_st = 1'b0;
                end
                2'd1:
                begin
                ALU_inst = 4'd0; //addi gets mapped to add in ALU
                i_r = 1'b0;
                write_reg_en = 1'b1;
                regfile_src_oalu_st = 1'b0;
                end
                2'd2:
                begin
                ALU_inst = 4'd1; //addu
                i_r = 1'b1;
                write_reg_en = 1'b1;
                regfile_src_oalu_st = 1'b0;
                end
                2'd3:
                begin
                ALU_inst = 4'd6; //mul
                i_r = 1'b1;
                write_reg_en = 1'b0;
                regfile_src_oalu_st = 1'b0;
                end
            endcase
            end
            3'd6 : //logic gate
            begin
            case (ir[28:27])
                2'd0:
                begin
                ALU_inst = 4'd4; // nand is nand in ALU
                i_r = 1'b1;
                write_reg_en = 1'b1;
                regfile_src_oalu_st = 1'b0;
                end
                2'd1:
                begin
                ALU_inst = 4'd5; //nor gets mapped to nor in ALU
                i_r = 1'b1;
                write_reg_en = 1'b1;
                regfile_src_oalu_st = 1'b0;
                end
                2'd2:
                begin
                ALU_inst = 4'd4; //nandi gets mapped to nand
                i_r = 1'b0;
                write_reg_en = 1'b1;
                regfile_src_oalu_st = 1'b0;
                end
                2'd3:
                begin
                ALU_inst = 4'd5; //nori gets mapped to nor
                i_r = 1'b0;
                write_reg_en = 1'b1;
                regfile_src_oalu_st = 1'b0;
                end
            endcase
            end
            3'd7 : //shift gate
            begin
                ALU_inst =  (ir[28:27]+4'd7);
                i_r = 1'b0;
                write_reg_en = 1'b1;
                regfile_src_oalu_st = 1'b0;
            end
            3'd1 : //data
            
            3'd2 : //branch
            3'd3 : //jump
            if (ir[28]) 
            begin
            jump = 1'b1;
            end
            else
            begin
            jump = 1'b1;
            
            end
            3'd4 : //comparison
            3'd5 : //FLOP
        endcase
    end
    
    
endmodule
