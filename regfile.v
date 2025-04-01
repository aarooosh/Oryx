module regfile(clk,rst,wr_en,r1,r2,w1,data,rout1,rout2);
    reg [31:0] regs [0:31];
    input [4:0] r1,r2,w1;
    input [31:0] data;
    input wr_en,clk,rst;
    output [31:0] rout1,rout2;
    integer i;
    always @ (posedge clk) begin
        if(rst) begin
            for(i=0;i<32;i=i+1) begin
                regs[i] <= 32'd0;
            end
        end
        //first reg is hardcoded to 0 each time
        else if (wr_en && w1!=5'd0) begin
        regs[w1] <= data;
        end
    end
    assign rout1 = regs[r1];
    assign rout2 = regs[r2];
endmodule