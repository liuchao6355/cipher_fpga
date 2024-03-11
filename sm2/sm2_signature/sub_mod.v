`timescale 1ns / 1ps

module sub_mod(
        input [255:0] a,
        input [255:0] b,
        input [255:0] n,
        output [255:0] q
    );
    // parameter n = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_7203DF6B_21C6052B_53BBF409_39D54123;
    wire [255:0] a1,b1,a2,b2,m;
    assign a1 = a;
    assign b1 = n;
    assign a2 = a;
    assign b2 = b;
    assign m = b;
    wire [255:0] s0,s1,s2;
    wire c0,c1,c2;
    assign {c0,s0} = a1+b1;
    assign {c1,s1} = s0-m;
    assign {c2,s2} = a2-b2;

    assign q = (c2==1'b1)?s1:s2;

endmodule
