module inst_rom(
    input [31:0] addr,
    input clk,
    output reg [31:0] inst
    );

    reg [7:0] insts [0:4095];
    wire [11:0] addr2;

    //assuming machine code is stored in exec.txt
    //inside which , data is stored byte by byte
    //on separate lines
    initial begin
        $readmemh("exec.txt", insts);
    end

    assign addr2 = addr[9:0]<<2;
    always @(posedge clk) begin
    inst = {insts[addr2], insts[addr2+12'd1], insts[addr2+12'd2],insts[addr2+12'd3]};
    end
endmodule