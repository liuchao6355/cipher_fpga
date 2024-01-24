`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/24 10:19:18
// Design Name: 
// Module Name: tb_CF
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


module tb_CF();
    reg clk;
    reg rst_n;
    reg [255:0]V_in;
    reg [511:0] B;
    wire done;
    wire [255:0] V_out;

    initial begin
        clk = 1;
        forever begin
            #10 clk = ~clk;
        end
    end

    initial begin
        rst_n = 0;
        @(posedge clk);
        V_in = 256'h7380166f_4914b2b9_172442d7_da8a0600_a96f30bc_163138aa_e38dee4d_b0fb0e4e;
        // B = 512'h61626364_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000018;
        B = 512'h61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364_61626364;
        rst_n = 1;
    end

    CF CF(
        clk,
        rst_n,
        V_in,
        B,
        V_out,
        done
    );

endmodule
