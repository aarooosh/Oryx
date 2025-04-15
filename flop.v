//i'll take the flop inputs from the normal regfile itself
module flop(
    input [31:0] f1,
    input [31:0] f2,
    input [1:0] flopinst,
    output reg [31:0] f0
    );
    reg cout;
    reg flag;
    reg [7:0] temp;
    always @(*) begin
        case(flopinst)
            2'b00: //add
            begin
                cout =1'b0;
                flag = f1[30:23]>f2[30:23]?1'b1:1'b0;
                temp = flag?f1[30:23]-f2[30:23]:f2[30:23]-f1[30:23];
                //for now only doing positive , no overflows , nothing
                f0[22:0] = flag?{cout,f1[22:0]}+({1'b1,f2[22:0]}>>temp):{cout,f2[22:0]}+({1'b1,f1[22:0]}>>temp);
                f0[30:23] = flag?f1[30:23]:f2[30:23];
                f0[31] = 1'b0; //for now
            end
            2'b01: //sub
            begin
                cout =1'b0;
                flag = f1[30:23]>f2[30:23]?1'b1:1'b0;
                temp = flag?f1[30:23]-f2[30:23]:f2[30:23]-f1[30:23];
                //for now only doing positive , no overflows , nothing
                f0[22:0] = flag?{cout,f1[22:0]}-({1'b1,f2[22:0]}>>temp):({1'b1,f1[22:0]}>>temp)-{cout,f2[22:0]};
                f0[30:23] = flag?f1[30:23]:f2[30:23];
                f0[31] = 1'b0; //for now
            end
        endcase
    end
endmodule