`timescale 1ns/1ps
module SM4_RoundKey(
    input[WIDTH-1:0] K_0,
    input[WIDTH-1:0] K_1,
    input[WIDTH-1:0] K_2,
    input[WIDTH-1:0] K_3,
    input[4:0] counter,
    output[WIDTH-1:0] K_4
);
    parameter WIDTH=32;
    wire[WIDTH-1:0] A,B,C, CK;
    
    SM4_CK_parameter ck(counter, CK);

    assign A = K_1^K_2^K_3^CK;

    SM4_sbox_parameter sbox01(A[7:0], B[7:0]);
    SM4_sbox_parameter sbox02(A[15:8], B[15:8]);
    SM4_sbox_parameter sbox03(A[23:16], B[23:16]);
    SM4_sbox_parameter sbox04(A[31:24], B[31:24]);

    // b ^ b<<<13 ^ b<<<23 
    assign C = B^({B[18:0],B[31:19]})^({B[8:0],B[31:9]});
    assign K_4 = C ^ K_0;

endmodule