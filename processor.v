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
    
    //control signals
    wire branch;
    wire i_r;
    wire write_reg_en;
    wire regfile_src_oalu_st;
    reg [31:0] temp;
    wire jump;

    //connecting wires
    wire [31:0] rs_out; //read o/p from register file
    wire [31:0] rt_out; //read o/p from register file
    wire [31:0] o;      //o/p from ALU

    //    regfile();
    inst_rom inst_rom(pc,~clk,ir); // this is combinational ! constant update
    regfile regfile(clk,rst,wr_en,r1,r2,w1,w_data_reg,rs_out,rt_out);
    stack stack(addr,rs_out,wr_en_stk,clk,r_data_stk);

        //for now i'm doing it here instead of a separate module
        //each case will set specific control signals like branch,i/r,r/w,wr_en,ALU_go_ahead etc
    
    control_unit CU(
        ir,
        i_r,
        write_reg_en,
        regfile_src_oalu_st,
        ALU_inst,
        jump
    );

    alu ALU(
        rs_out,
        rt_imm,
        hi,
        lo,
        inst,
        o,
        cout,
        alu_go_ahead, //this is for the branch condition
        overflow //this is for the EPC
            );

    //first set of MUXes
    assign rt_imm = i_r?rt_out:sgn_ext_imm;
    assign w_data_reg = write_reg_en?r_data_stk:o;

    //setting up the wires

    always @(negedge clk) 
    begin
        pc = pc+32'd4;//update PC is happening by default everywhere
        if (rst) //setting reset
        begin
            pc <= 32'd0;
        end
        
        //set control signals , done combinationally outside always

        //do ALU stuff (since sequential)

        else 
        begin
        if (branch==1'b1 && jump==1'b0) 
            begin
                //this is if branch is true and it is not a jump
                temp[17:2] = ir[15:0];
                temp[1:0] = 2'b00;
                temp[31:18] = {ir[16],ir[16],ir[16],ir[16],ir[16],ir[16],ir[16],ir[16],ir[16],ir[16],ir[16],ir[16],ir[16],ir[16]};
                // do this using wires
                //sign extending (highly cursed) and adding separately
                pc = pc+temp;
            end
        
        else if(jump) 
            begin
            if (branch == 1'b0)
                pc[29:0] = {ir[27:0],2'b00};
                //replace last 30 bits of PC to jump
            else
                pc = rs_out;
            end
        end
        
        
    end


endmodule
