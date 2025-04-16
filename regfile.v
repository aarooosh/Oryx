module regfile(clk,rst,wr_en,r1,r2,w1,data,rout1,rout2);
    reg [31:0] regs [0:31];
    input [4:0] r1,r2,w1;
    input [31:0] data;
    input wr_en,clk,rst;
    output [31:0] rout1,rout2;
    always @ (posedge clk) begin
        
        //first reg is hardcoded to 0 each time
        if (wr_en) begin
        regs[w1] = data;
        end
    end
    assign rout1 = (r1==5'd0)?32'd0:regs[r1];
    assign rout2 = (r2==5'd0)?32'd0:regs[r2];
    // assign rout1 = 32'd0;
    // assign rout2 = 32'd0;
endmodule
