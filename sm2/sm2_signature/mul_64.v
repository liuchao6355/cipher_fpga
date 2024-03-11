`timescale 1ns / 1ps

module mul_64(
    input clk,
    input [63:0] a,
    input [63:0] b,
    output [127:0] c
    );

    mul_64_ip mul_64_ip(clk,a,b,c);

endmodule
