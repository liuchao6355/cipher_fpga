`timescale 1ns / 1ps

module add_mod(
        input [255:0] a,
        input [255:0] b,
        input [255:0] n,
        output [255:0] q
    );
    wire [256:0] ab;
    assign ab = a+b;
    assign q = (ab>n)?(ab-n):(ab);
    // parameter n = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_7203DF6B_21C6052B_53BBF409_39D54123;
    
    // wire c0,c1;
    // wire [255:0] s0,s1;
    // assign {c0,s0} = a+b;
    // assign {c1,s1} = s0-n;
    // assign q = (c1==1'b1)?s0:s1;
endmodule
