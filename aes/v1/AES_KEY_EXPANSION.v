`timescale 1ns/1ps

module AES_KET_EXPANSION(
    W_0,
    W_1,
    W_2,
    W_3,
    cnt,
    W_0_next,
    W_1_next,
    W_2_next,
    W_3_next
);
    parameter WIDTH = 32;
    input[WIDTH-1:0] W_0;
    input[WIDTH-1:0] W_1;
    input[WIDTH-1:0] W_2;
    input[WIDTH-1:0] W_3;
    input[3:0] cnt;
    output reg[WIDTH-1:0] W_0_next;
    output reg[WIDTH-1:0] W_1_next;
    output reg[WIDTH-1:0] W_2_next;
    output reg[WIDTH-1:0] W_3_next;

    wire[WIDTH-1:0] W_3_reg;
    wire[WIDTH-1:0] W_3_Sbox; 
    assign W_3_reg = {W_3[23:0],W_3[31:24]};
    AES_sbox sbox1(0,W_3_reg[31:24],W_3_Sbox[31:24]);
    AES_sbox sbox2(0,W_3_reg[23:16],W_3_Sbox[23:16]);
    AES_sbox sbox3(0,W_3_reg[15:8],W_3_Sbox[15:8]);
    AES_sbox sbox4(0,W_3_reg[7:0],W_3_Sbox[7:0]);

    wire[WIDTH-1:0] rcon;
    AES_Rcon rcon0(cnt,rcon);

    always @(*) begin
                W_0_next = W_0 ^ (W_3_Sbox^rcon);
                W_1_next = W_1 ^ W_0_next;
                W_2_next = W_2 ^ W_1_next;
                W_3_next = W_3 ^ W_2_next;
           
    end
endmodule