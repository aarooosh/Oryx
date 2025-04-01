module stack(
    input [31:0] addr,
    input [31:0] w_data,
    input wr_en,
    input clk,
    output [31:0] r_data
);
reg [31:0] regs [1023:0];
always @(posedge clk) begin
    if (wr_en) begin
        regs[addr] <= w_data;
    end
end
assign r_data = regs[addr];
endmodule