`timescale 1ns/1ps

module AES_BYTE_SUB(
    mode,
    S_0,
    S_1,
    S_2,
    S_3,
    S_0_next,
    S_1_next,
    S_2_next,
    S_3_next
);
    parameter WIDTH = 32;
    input mode;
    input[WIDTH-1:0] S_0;
    input[WIDTH-1:0] S_1;
    input[WIDTH-1:0] S_2;
    input[WIDTH-1:0] S_3;
    output[WIDTH-1:0] S_0_next;
    output[WIDTH-1:0] S_1_next;
    output[WIDTH-1:0] S_2_next;
    output[WIDTH-1:0] S_3_next;

    AES_sbox sbox01(mode,S_0[7:0],S_0_next[7:0]);
    AES_sbox sbox02(mode,S_0[15:8],S_0_next[15:8]);
    AES_sbox sbox03(mode,S_0[23:16],S_0_next[23:16]);
    AES_sbox sbox04(mode,S_0[31:24],S_0_next[31:24]);

    AES_sbox sbox11(mode,S_1[7:0],S_1_next[7:0]);
    AES_sbox sbox12(mode,S_1[15:8],S_1_next[15:8]);
    AES_sbox sbox13(mode,S_1[23:16],S_1_next[23:16]);
    AES_sbox sbox14(mode,S_1[31:24],S_1_next[31:24]);

    AES_sbox sbox21(mode,S_2[7:0],S_2_next[7:0]);
    AES_sbox sbox22(mode,S_2[15:8],S_2_next[15:8]);
    AES_sbox sbox23(mode,S_2[23:16],S_2_next[23:16]);
    AES_sbox sbox24(mode,S_2[31:24],S_2_next[31:24]);

    AES_sbox sbox31(mode,S_3[7:0],S_3_next[7:0]);
    AES_sbox sbox32(mode,S_3[15:8],S_3_next[15:8]);
    AES_sbox sbox33(mode,S_3[23:16],S_3_next[23:16]);
    AES_sbox sbox34(mode,S_3[31:24],S_3_next[31:24]);
endmodule

//`timescale 1ns/1ps

//module AES_BYTE_SUB(
//    S_0,
//    S_1,
//    S_2,
//    S_3,
//    S_0_next,
//    S_1_next,
//    S_2_next,
//    S_3_next
//);
//    parameter WIDTH = 32;
//    input[WIDTH-1:0] S_0;
//    input[WIDTH-1:0] S_1;
//    input[WIDTH-1:0] S_2;
//    input[WIDTH-1:0] S_3;
//    output[WIDTH-1:0] S_0_next;
//    output[WIDTH-1:0] S_1_next;
//    output[WIDTH-1:0] S_2_next;
//    output[WIDTH-1:0] S_3_next;

//    AES_sbox sbox01(S_0[7:0],S_0_next[7:0]);
//    AES_sbox sbox02(S_0[15:8],S_0_next[15:8]);
//    AES_sbox sbox03(S_0[23:16],S_0_next[23:16]);
//    AES_sbox sbox04(S_0[31:24],S_0_next[31:24]);

//    AES_sbox sbox11(S_1[7:0],S_1_next[7:0]);
//    AES_sbox sbox12(S_1[15:8],S_1_next[15:8]);
//    AES_sbox sbox13(S_1[23:16],S_1_next[23:16]);
//    AES_sbox sbox14(S_1[31:24],S_1_next[31:24]);

//    AES_sbox sbox21(S_2[7:0],S_2_next[7:0]);
//    AES_sbox sbox22(S_2[15:8],S_2_next[15:8]);
//    AES_sbox sbox23(S_2[23:16],S_2_next[23:16]);
//    AES_sbox sbox24(S_2[31:24],S_2_next[31:24]);

//    AES_sbox sbox31(S_3[7:0],S_3_next[7:0]);
//    AES_sbox sbox32(S_3[15:8],S_3_next[15:8]);
//    AES_sbox sbox33(S_3[23:16],S_3_next[23:16]);
//    AES_sbox sbox34(S_3[31:24],S_3_next[31:24]);
//endmodule