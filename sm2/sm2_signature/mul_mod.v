`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/01 14:38:42
// Design Name: 
// Module Name: mul_mod
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


module mul_mod_p(
    input clk,
    input rst_n,
    input [255:0] a,
    input [255:0] b,
    output [255:0] abmodp,
    output done
    );

    // wire [255:0] a,b,abmodp;
    // assign a = 256'h421DEBD61B62EAB6746434EBC3CC315E32220B3BADD50BDC4C4E6C147FEDD43D;
    // assign b = 256'h0680512BCBB42C07D47349D2153B70C4E5D7FDFCBFA36EA1A85841B9E46E09A2;

    reg rst_mul256;
    wire rst_re;
    wire done_mul256,done_re;
    wire [511:0] c;


    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rst_mul256 <= 0;
        end
        else 
            rst_mul256 <= 1;
    end

    mul_256 mul_256(clk,rst_mul256,a,b,c,done);
    // assign rst_re = done_mul256;
    mod_re mod_re(c,abmodp);
    // assign abmodp = c%256'hfffffffe_ffffffff_ffffffff_ffffffff_ffffffff_00000000_ffffffff_ffffffff;

endmodule

