`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2025 02:08:30 PM
// Design Name: 
// Module Name: processor
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


module processor(
    input clk,
    input rst
);

    reg [31:0] pc;
    reg [31:0] ir;
    reg [31:0] hi;
    reg [31:0] lo;
    reg [3:0] ALU_inst;
    reg branch;
    
    //control singals
    reg i_r;
    reg write_reg_en;
    reg regfile_src_oalu_st;
    reg [31:0] temp;
    reg jump;

//    regfile();
//    inst_rom(pc,ir); // this is combinational ! constant update
//    stack();
//    ALU();

//    initial begin
//        pc = 32'd0;
//    end
    //for now i'm doing it here instead of a separate module
    //each case will set specific control signals like branch,i/r,r/w,wr_en,ALU_go_ahead etc
   
    
    always @(posedge clk) 
    begin
        pc = pc+32'd4;
        if (rst) 
        begin
            pc <= 32'd0;
        end
        
        else 
        begin
        if (branch==1'b1 && jump==1'b0) 
            begin
                temp[17:2] = ir[15:0];
                temp[1:0] = 2'b00;
                temp[31:18] = {ir[16],ir[16],ir[16],ir[16],ir[16],ir[16],ir[16],ir[16],ir[16],ir[16],ir[16],ir[16],ir[16],ir[16]};
                // do this using wires
                pc = pc+temp;
            end
        
        else if(jump) 
            begin
            if (branch == 1'b0)
                pc[29:0] = {ir[27:0],2'b00};
            else
                //implement jr part
            end
        end
        //implement only the PC update logic here
    end


endmodule
