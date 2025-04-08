`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2025 02:57:18 PM
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module adder(input [31:0] a,input [31:0] b,input cin,output wire [31:0] op);
assign op = a+b+cin;
endmodule
//this is the adder module , using muxes the inputs to it will be controlled


module alu(
input [31:0] a,
input [31:0] b,
output reg [31:0] hi,
output reg [31:0] lo,
input [3:0] inst,
output reg [31:0] o,
output cout,
output alu_go_ahead, //this is for the branch condition
output reg overflow //this is for the EPC
    );
    wire [31:0] d2;
    wire [31:0] aa;
    wire [31:0] bb;
    wire [31:0] om;
    wire cin;
    adder ADD(a,d2,cin,om);
    assign aa = ~a;
    assign bb = ~b;
    assign d2= (inst == 4'b0010 || inst == 4'b0011 || inst == 4'b1011|| inst == 4'b1110)?bb:b;
    assign cin= (inst == 4'b0010 || inst == 4'b0011  || inst == 4'b1011|| inst == 4'b1110)?1'b1:1'b0;
    //solve multi driven net using muxes
    always @(*) begin
    case (inst)
    4'b0000: //addu
    begin
           o = om;
           //overflow = (a[31]&&b[31]); screw it , no overflow for unsigned
    end
    4'b0001: //add
    begin
            o = om;
            overflow = (~(a[31]^b[31])&(b[31]^om[31]));
    end        
    4'b0010:
    begin
            o = om;
            overflow = (~(a[31]^b[31])&(b[31]^om[31]));
    end
    4'b0011:
    begin
            o = om;
    end
    4'b0100:
    begin
            o = (aa|bb);
    end
    4'b0101:
    begin
            o = (aa&bb);
    end
    4'b0110:
    begin
            {hi,lo} = a*b;
            o = 32'd0;
            //store this in hi and lo
    end
    4'b0111:
    begin
            o = a<<b;
    end
    4'b1000:
    begin
            o = a>>b;
    end
    4'b1001:
    begin
            o = $signed(a)<<<b;
    end
    4'b1010:
    begin
            o = $signed(a)>>>b;
    end
    4'b1011: //slt
    begin
        overflow = (~(a[31]^b[31])&(b[31]^om[31]));
        if(overflow)
        begin
                o = {31'd0,~a[31]};
                alu_go_ahead = ~a[31];
        end
        else
        begin
                o = {31'd0,(a[31]^b[31])?a[31]:1'b1};
                alu_go_ahead = (a[31]^b[31])?a[31]:1'b1;
        end
    end
    4'b1100:
    begin
        o = {31'd0,(a==b)?1'b1:1'b0};
        alu_go_ahead = (a==b)?1'b1:1'b0;
    end
    4'b1101:
    begin
        alu_go_ahead = (a==b)?1'b0:1'b1;
    end
    4'b1110:
    begin
        //deal with unsigned after quantum class 
    end
    endcase
end
endmodule
