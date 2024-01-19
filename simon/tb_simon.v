`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/18 17:29:49
// Design Name: 
// Module Name: tb_simon
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


module tb_simon();
    //            N/M  T  j
    // 32/64      16/4 32 0
    // 48/72      24/3 36 0
    // 48/96      24/4 36 1
    // 64/96      32/3 42 2
    // 64/128     32/4 44 3
    // 96/96      48/2 52 2
    // 96/144     48/3 54 3
    // 128/128    64/2 68 2
    // 128/192    64/3 69 3
    // 128/256    64 4 72 4
    parameter N=64,M=4,T=72,j=4;
    reg clk;
    reg rst_n;
    reg[2*N-1:0] din;
    reg[M*N-1:0] key;
    wire[2*N-1:0] dout;
    wire done;

    initial begin
        rst_n = 0;
        key = 64'h1918111009080100;
        din = 32'hc69be9bb;
        // din = 32'h65656877;
        din = 128'h8d2b5579afc8a3a03bf72a87efe7b868;
        // din = 128'h74206e69206d6f6f6d69732061207369;
        key = 256'h1f1e1d1c1b1a191817161514131211100f0e0d0c0b0a09080706050403020100;
        repeat(20) @(posedge clk);
        rst_n = 1;
    end


    simon_en_de_cryption #(
        .N(N),
        .M(M),
        .T(T),
        .j(j)
    )simon_en_de_cryption(
        .clk(clk),
        .rst_n(rst_n),
        .en_de_cry(0),//1 加密�?0 解密
        .din(din),
        .key(key),
        .dout(dout),
        .done(done)
    );

    initial begin
        clk = 1;
        forever begin
            #10 clk = ~clk;
        end
    end

endmodule
