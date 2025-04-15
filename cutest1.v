module cutest();
    // input [31:0] ir,
    // output reg i_r,
    // output reg write_reg_en,
    // output reg regfile_src_oalu_st,
    // output reg [3:0] ALU_inst,
    // output reg jump,
    // output reg wr_en_stk,
    // output reg br_inst,
    // output reg [1:0] flopinst,
    // output reg fen
    reg clk;
    wire [31:0] ir;
    wire i_r;
    wire write_reg_en;
    wire regfile_src_oalu_st;
    wire jump;
    wire wr_en_stk;
    wire br_inst;
    wire fen;
    wire [3:0] ALU_inst;
    wire [1:0] flopinst;
    assign ir = 32'b00001000010000000000000000001000;
    control_unit cu(
        ir,
        i_r,
        write_reg_en,
        regfile_src_oalu_st,
        ALU_inst,
        jump,
        wr_en_stk,
        br_inst,
        flopinst,
        fen
    );
    initial begin
        clk = 0;
        #100;
        clk = 1;
        $monitor("%b\n%b\n%b\n%b\n%b\n%b\n%b\n",i_r,write_reg_en,regfile_src_oalu_st,ALU_inst,jump,wr_en_stk,br_inst,flopinst,fen);
    end
endmodule