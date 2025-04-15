module alutest();
            // input [31:0] a,
            // input [31:0] b,
            // output reg [31:0] hi,
            // output reg [31:0] lo,
            // input [3:0] inst,
            // output reg [31:0] o,
            // output cout,
            // output reg alu_go_ahead, //this is for the branch condition
            // output reg overflow //this is for the EPC
    wire [31:0] a;
    wire [31:0] b;
    wire [3:0] inst;
    assign a = 32'd1;
    assign b = 32'd1;
    assign inst = 4'd0;
    wire [31:0] hi;
    wire [31:0] lo;
    wire [31:0] o;
    wire cout;
    wire over;
    wire aga;
    alu ALU(a,b,hi,lo,inst,o,cout,aga,over);
    initial begin
        $monitor("%b",o);
    end
endmodule