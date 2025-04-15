module test1();
    reg clk;
    reg rst;
    wire [31:0] om;
    wire [31:0] iro;
    processor ARM(clk,rst,om,iro);
    initial begin
        $monitor("%b %b",om,iro);
        clk = 1'b0;
        #100;
        clk = 1'b1;
        rst = 1'b1;
        #100;
        clk = 1'b0;
        rst = 1'b0;
        #100;
        clk = 1'b1;
        #100;
        clk = 1'b0;
    end
endmodule