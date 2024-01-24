`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/24 15:15:40
// Design Name: 
// Module Name: tb_sm3
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


module tb_sm3();
    parameter len = 48;
    reg clk,rst_n;
    reg [len-1:0] m;
    wire [255:0] m_out;
    wire done;

    initial begin
        clk = 1;
        forever begin
            #10 clk = ~clk;
        end
    end
    initial begin
        rst_n = 0;
        // m = 512'h61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364;
        m = 48'h123ef3212acc;
        repeat(20) @(posedge clk);
        rst_n = 1;
    end

    sm3 #(
        .len(len)
    )sm3(
        .clk(clk),
        .rst_n(rst_n),
        .m(m),
        .m_out(m_out),
        .done(done)
    );
endmodule
