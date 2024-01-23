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

    // assign X0R1R2 = (X0^R1)+R2;
    // assign W = (X0R1R2&31'h7fffffff) + (X0R1R2>>31);
    assign W = (X0^R1)+R2;
    // assign R1X1 = R1 + X1;
    // assign W1 = (R1X1&31'h7fffffff) + (R1X1>>31);
    assign W1 = R1+X1;
    assign W2 = R2^X2;
    assign W12 = {W1[15:0],W2[31:16]};
    assign W21 = {W2[15:0],W1[31:16]};
    assign L1 =  W12^({W12[29:0],W12[31:30]})^({W12[21:0],W12[31:22]})^({W12[13:0],W12[31:14]})^({W12[7:0],W12[31:8]});
    assign L2 =  W21^({W21[23:0],W21[31:24]})^({W21[17:0],W21[31:18]})^({W21[9:0],W21[31:10]})^({W21[1:0],W21[31:2]});

    sbox_0 sbox_00(L1[31:24],R1out[31:24]);
    sbox_1 sbox_01(L1[23:16],R1out[23:16]);
    sbox_0 sbox_02(L1[15:8],R1out[15:8]);
    sbox_1 sbox_03(L1[7:0],R1out[7:0]);

    sbox_0 sbox_10(L2[31:24],R2out[31:24]);
    sbox_1 sbox_11(L2[23:16],R2out[23:16]);
    sbox_0 sbox_12(L2[15:8],R2out[15:8]);
    sbox_1 sbox_13(L2[7:0],R2out[7:0]);

endmodule
