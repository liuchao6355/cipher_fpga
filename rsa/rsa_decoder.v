`timescale 1ns / 1ps

module rsa_decoder (
        input clk,
        input rst_n,
        input start,
        input [n_bit-1:0] data_in,
        output [n_bit-1:0] data_out,
        output done
    );

    parameter n = 12'd3551;
    parameter n_bit = 12;
    parameter logr = 3;
    parameter p =  3'd1;
    parameter Rmodn = 12'd545;
    parameter R2modn = 12'd2292;
    parameter d = 12'd1373;

    // mod_exp
    mod_exp #(
                .n     (n),
                .n_bit (n_bit),
                .logr  (logr),
                .p     (p),
                .Rmodn (Rmodn),
                .R2modn(R2modn)
            ) inst_mod_exp (
                .a    (data_in),
                .e    (d),
                .clk  (clk),
                .rst_n(rst_n),
                .start(start),
                .z    (data_out),
                .done (done)
            );
endmodule
