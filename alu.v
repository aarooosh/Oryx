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

module adder(input [31:0] a,input [31:0] b,input cin,output reg [31:0] op);
always begin
op <= a+b+cin;
end
endmodule


module alu(
input [31:0] a,
input [31:0] b,
output reg [31:0] hi,
output reg [31:0] lo,
input [3:0] inst,
output reg [31:0] o,
output cout,
output alu_go_ahead,
output reg overflow
    );
    reg [31:0] d1;
    reg [31:0] d2;
    wire [31:0] om;
    reg cin;
    adder ADD(d1,d2,cin,om);
    
    always begin
    o = om;
    //solve multi driven net using muxes
    case (inst)
    4'b0000: //addu
    begin
           d1 = a;d2=b;
    end
    4'b0001://add
    begin
            d1=a;d2=b;
            overflow = (~(a[31]^b[31])&(b[31]^o[31]));
    end        
    4'b0010:
    begin
            d1=a;d2=~b;cin=1;
    end
    4'b0011:
    begin
            d1=a;d2=~b;cin=1;
            overflow = (~(a[31]^b[31])&(b[31]^o[31]));
    end
    4'b0100:
    begin
            o = ~(a&b);
    end
    4'b0101:
    begin
            o = ~(a|b);
    end
    4'b0110:
    begin
            {hi,lo} = a*b;
            //store this in hi and lo
    end
    4'b0111:
    begin
            o = a<<b;
    end
    4'b1000:
    begin
            o <= a>>b;
    end
    4'b1001:
    begin
            o <= {a[31],a[30:0]<<b};
    end
    4'b1010:
    begin
            o <= {a[31],a[30:0]>>b};
    end
    endcase
    end
    assign op = o;
endmodule
