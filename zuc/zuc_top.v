`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/22 12:01:32
// Design Name: 
// Module Name: zuc_top
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


module zuc_top(
        input clk,
        input rst_n,
        input [127:0] k,
        input [127:0] iv,
        input [7:0] L,
        output [7:0] L_out,
        output [31:0] Z,
        output done
    );

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
