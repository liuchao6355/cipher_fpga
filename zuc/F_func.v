`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/21 17:26:06
// Design Name: 
// Module Name: F_func
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


module F_func(
        input [31:0] X0,
        input [31:0] X1,
        input [31:0] X2,
        input [31:0] R1,
        input [31:0] R2,
        output [31:0] W,
        output [31:0] R1out,
        output [31:0] R2out
    );

    wire [31:0] X0R1R2,R1X1,W1, W2, W12,W21,L1, L2;

    assign X0R1R2 = (X0^R1)+R2;
    assign W = (X0R1R2&31'h7fffffff) + {31'd0,X0R1R2[31]};

    assign R1X1 = R1 + X1;
    assign W1 = (R1X1&31'h7fffffff) + {31'd0,R1X1[31]};
    assign W2 = R2^X2;
    assign W12 = {W1[15:0],W2[31:16]};
    assign W21 = {W2[12:0],W1[31:16]};
    assign L1 =  W12^({W12[29:0],W12[31:30]})^({W12[21:0],W12[31:22]})^({W12[13:0],W12[31:14]})^({W12[7:0],W12[31:8]});
    assign L2 =  W21^({W21[29:0],W21[31:30]})^({W21[21:0],W21[31:22]})^({W21[13:0],W21[31:14]})^({W21[7:0],W21[31:8]});

endmodule
