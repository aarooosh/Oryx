module test1();
    reg clk;
    reg rst;
    wire [31:0] om;
    wire [31:0] iro;
    wire [31:0] rso;
    wire [31:0] rto;
    wire [3:0] aluinst;
    processor ARM(clk,rst,om,iro,rso,rto,aluinst);
    initial begin
        $monitor("%b %b %b %b %b",om,iro,rso,rto,aluinst);
        clk = 1'b0;
        #100;
        clk = 1'b1;
        rst = 1'b1;
        $display("%b %b",om,iro);
        #100;
        clk = 1'b0;
        rst = 1'b0;
        #100;
        $display("%b %b",om,iro);
        clk = 1'b1;
        #100;
        clk = 1'b0;
        $display("%b %b",om,iro);
    end
endmodule