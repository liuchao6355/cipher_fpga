`timescale 1ns / 1ps
module tb_zuc_top();
    reg clk, rst_n;
    reg [127:0] k;
    reg[127:0] iv;
    reg[7:0] L;
    wire[31:0] Z;
    wire [7:0] L_out;
    wire done;

    initial begin
        clk = 1;
        forever begin
            #10 clk = ~clk;
        end
    end

    initial begin
        rst_n = 0;
        k = 128'h3d4c4be96a82fdaeb58f641db17b455b;
        iv = 128'h84319aa8de6915ca1f6bda6bfbd8c766;
        L = 2;
        repeat(20) @(posedge clk);
        rst_n = 1;
    end


    // zuc_top zuc_top(
    //         .clk(clk),
    //         .rst_n(rst_n),
    //         .k(k),
    //         .iv(iv),
    //         .L(L),
    //         .Z(Z),
    //         .done(done)
    //     );
       zuc zuc(
        .clk(clk),
        .rst_n(rst_n),
        .k(k),
        .iv(iv),
        .L(L),
        .L_out(L_out), // which Z
        .done(done), // 输出一个z，发出一个done=1，然后置0
        .Z(Z)
    );
endmodule
