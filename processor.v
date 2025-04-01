module processor(
    input clk,
    input rst
);

    reg [31:0] pc;
    reg [31:0] ir;

    regfile();
    inst_rom(pc,ir); // this is combinational ! constant update
    stack();
    ALU();

    initial begin
        pc = 32'd0;
    end
    //for now i'm doing it here instead of a separate module
    //each case will set specific control signals like branch,i/r,r/w,wr_en,ALU_go_ahead etc
    always begin
        case (ir[31:29])
            3'd0 : //arithmetic
            3'd6 : //logic gate
            3'd7 : //shift gate
            3'd1 : //data
            3'd2 : //branch
            3'd3 : //jump
            3'd4 : //comparison
            3'd5 : //FLOP
        endcase
    end
    
    always @(posedge clk) begin
        if (rst) begin
            pc <= 32'd0;
        end
        //implement only the PC update logic and writing (to mem or reg) here
    end


endmodule