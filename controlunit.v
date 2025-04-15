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
output reg jump,
output reg wr_en_stk,
output reg br_inst,
output reg [1:0] flopinst,
output reg fen
    );
    
     always @(*) begin
        case (ir[31:29])
            3'd0 : //arithmetic
            begin
                br_inst = 1'b0;
                jump    = 1'b0;
                wr_en_stk = 1'b0;
                fen = 1'b0;
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
                jump    = 1'b0;
                wr_en_stk = 1'b0;
                br_inst = 1'b0;
                fen = 1'b0;
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
                fen = 1'b0;
                jump    = 1'b0;
                wr_en_stk = 1'b0;
                br_inst = 1'b0;
                ALU_inst =  (ir[28:27]+4'd7);
                i_r = 1'b0;
                write_reg_en = 1'b1;
                regfile_src_oalu_st = 1'b0;
            end
            3'd1 : //data
            begin
                fen = 1'b0;
                jump    = 1'b0;
                br_inst = 1'b0;
                if(ir[28:27] == 2'b11)
                begin//sub
                    ALU_inst=4'd2;
                    i_r = 1'b1;
                    write_reg_en = 1'b1;
                    regfile_src_oalu_st = 1'b0;
                    wr_en_stk = 1'b0;
                end
                else if(ir[28:27] == 2'b00)
                begin//lw
                    ALU_inst = 4'd0;
                    regfile_src_oalu_st = 1'b1;
                    write_reg_en = 1'b1;
                    i_r          = 1'b0;
                    wr_en_stk = 1'b0;
                end
                else if(ir[28:27] == 2'b01)
                begin//sw
                    ALU_inst = 4'd0;
                    // regfile_src_oalu_st = 1'b1;
                    write_reg_en = 1'b0;
                    i_r          = 1'b0;
                    wr_en_stk = 1'b1;
                end
                else
                begin//lui
                    ALU_inst = 4'd0;
                    // regfile_src_oalu_st = 1'b1;
                    write_reg_en = 1'b1;
                    i_r          = 1'b0;
                    wr_en_stk = 1'b0;
                end
            end
            3'd2 : //branch
            begin
                // absolutely crazy ! disable write and RE-USE slt and seq !! They will also send their output
                // ALU_go_ahead
                fen = 1'b0;
                br_inst = 1'b1;
                jump = 1'b0;
                wr_en_stk = 1'b0;
                write_reg_en = 1'b0;
                i_r = 1'b1;
                case(ir[28:27])
                    2'b00: //branch equal
                    begin
                        ALU_inst = 4'd12;
                    end
                    2'b01: //branch not equal
                    begin
                        ALU_inst = 4'd13;
                    end
                    2'b10: //branch less than
                    begin
                        ALU_inst = 4'd11;
                    end
                    2'b11: //branch less than unsigned
                    begin
                        ALU_inst = 4'd14;
                    end
                    endcase
            end
            3'd3 : //jump
            begin
                fen = 1'b0;
                jump = 1'b1;
                wr_en_stk = 1'b0;
                write_reg_en = 1'b0;
            end
            // if (ir[28]) 
            // begin
            // jump = 1'b1;
            // end
            // else
            // begin
            // jump = 1'b1;
            
            // end
            3'd4 : //comparison
            begin
                fen = 1'b0;
                jump = 1'b0;
                br_inst = 1'b0;
                write_reg_en = 1'b1;
                regfile_src_oalu_st = 1'b0;
                wr_en_stk = 1'b0;
                case(ir[28:27])
                    2'b11: //sub u
                    begin
                        ALU_inst = 4'd3;
                        i_r = 1'b1;
                    end
                    2'b00:
                    begin
                        ALU_inst = 4'd11;
                        i_r = 1'b1;
                    end
                    2'b01:
                    begin
                        ALU_inst = 4'd11;
                        i_r = 1'b0;
                    end
                    2'b10:
                    begin
                        ALU_inst = 4'd12;
                        i_r = 1'b0;
                    end
                endcase
            end
            3'd5 : 
            begin
                fen = 1'b1;
                flopinst = ir[28:27];
                jump = 1'b0;
                br_inst = 1'b0;
                write_reg_en = 1'b0;
                regfile_src_oalu_st = 1'b0;
                wr_en_stk = 1'b0;
                ALU_inst = 4'd0;
                i_r = 1'b0;
            end
        endcase
    end
    
    
endmodule
