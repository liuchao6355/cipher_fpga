`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/24 09:55:03
// Design Name: 
// Module Name: compress
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


module compress(
        input [255:0] V_in,
        input [31:0] W_i,
        input [31:0] W_,
        input [6:0] cnt,
        output [255:0] V_out
    );
    wire [31:0] A,B,C,D,E,F,G,H;
    wire [31:0] A_,B_,C_,D_,E_,F_,G_,H_;
    wire [31:0] SS1,SS2,AET,TT1,TT2;
    wire [31:0] T;
    wire [31:0] T_shift;
    wire [6:0] jmod32;

    assign {A,B,C,D,E,F,G,H} = V_in;
    assign jmod32 = cnt%32;
    assign T = cnt<=15?32'h79cc4519:32'h7a879d8a;
    shift shift(T,jmod32,T_shift);
    assign AET = {A[19:0],A[31:20]} + E + T_shift;
    assign SS1 = {AET[24:0],AET[31:25]};
    assign SS2 = SS1^({A[19:0],A[31:20]});

    assign TT1 = FF(A,B,C) + D + SS2 + W_;
    assign TT2 = GG(E,F,G) + H + SS1 + W_i;

    assign D_ = C;
    assign C_ = {B[22:0],B[31:23]};
    assign B_ = A;
    assign A_ = TT1;
    assign H_ = G;
    assign G_ = {F[12:0],F[31:13]};
    assign F_ = E;
    assign E_ = TT2^{TT2[22:0],TT2[31:23]}^{TT2[14:0],TT2[31:15]};

    assign V_out = {A_,B_,C_,D_,E_,F_,G_,H_};

    function [31:0] FF;
        input [31:0] X;
        input [31:0] Y;
        input [31:0] Z;
        begin
            FF = (cnt <= 15) ? (X^Y^Z):((X&Y)|(X&Z)|(Y&Z));
        end
    endfunction
    function [31:0] GG;
        input [31:0] X;
        input [31:0] Y;
        input [31:0] Z;
        begin
            GG = (cnt <= 15) ? (X^Y^Z):((X&Y)|((~X)&Z));
        end
    endfunction

endmodule
