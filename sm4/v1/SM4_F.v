`timescale 1ns/1ps

module SM4_F(
    input[WIDTH-1:0] X_0,
    input[WIDTH-1:0] X_1,
    input[WIDTH-1:0] X_2,
    input[WIDTH-1:0] X_3,
    input[WIDTH-1:0] rk_0,
    output[WIDTH-1:0] X_4
);
    parameter WIDTH = 32;
    // wire[WIDTH-1:0] sbox_0, sbox_1, sbox_2, sbox_3;
    wire[WIDTH-1:0] A,B,C;
    assign A = X_1^X_2^X_3^rk_0;

    SM4_sbox_parameter sbox0(A[7:0], B[7:0]);
    SM4_sbox_parameter sbox1(A[15:8], B[15:8]);
    SM4_sbox_parameter sbox2(A[23:16], B[23:16]);
    SM4_sbox_parameter sbox3(A[31:24], B[31:24]);

    // b ^ b<<<2 ^ b<<<10 ^ b <<< 18 ^ b<<<24
    assign C = B^({B[29:0],B[31:30]})^({B[21:0],B[31:22]})^({B[13:0],B[31:14]})^({B[7:0],B[31:8]});
    assign X_4 = C ^ X_0;
endmodule