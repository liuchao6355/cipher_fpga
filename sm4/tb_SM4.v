`timescale 1ns / 1ps
module tb_SM4;

    reg clk, reset, mode;
    reg[127:0] MK,X;
    wire[127:0] Y;
    wire finish;

    always #5 clk = ~clk;
    SM4 sm4(
        clk,
        reset,
        mode,
        MK,
        X,
        Y,
        finish
    );
    initial begin
        MK = 128'h0123456789ABCDEFFEDCBA9876543210;
        X = 128'h681EDF34D206965E86b3324F536E4246;
//        X = 128'h0123456789ABCDEFFEDCBA9876543210;
        clk = 0;
        mode = 0;
        #5 reset = 1;
        #5 reset = 0; 
    end

endmodule
