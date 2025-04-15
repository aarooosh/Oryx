module floptest();

    reg [31:0] f1 = 32'b00111111110000000000000000000000;
    reg [31:0] f2 = 32'b00111111101000000000000000000000;
    wire [31:0] f0;
    reg [1:0] flopinst = 2'b01;

    flop FLOP(f1,f2,flopinst,f0);
    initial begin
        $monitor("%b",f0);
    end
endmodule