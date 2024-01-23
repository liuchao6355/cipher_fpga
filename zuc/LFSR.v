`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/22 11:09:44
// Design Name: 
// Module Name: LFSR
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


module LFSR(
        input lfsr_mode,
        input [30:0] s15,
        input [30:0] s13,
        input [30:0] s10,
        input [30:0] s4,
        input [30:0] s0,
        input [30:0] u,
        output [30:0] s16
    );

    wire [30:0] s0_tmp, s4_tmp, s10_tmp, s13_tmp;
    wire [30:0] v,u_now;

    // assign s0_tmp = (s0 + {s0[22:0],s0[30:23]})&(31'h7fffffff) + ((s0 + {s0[22:0],s0[30:23]})>>31);
    // assign s4_tmp = (s0_tmp[30:0] + {s4[10:0],s4[30:11]})&(31'h7fffffff) + ((s0_tmp[30:0] + {s4[10:0],s4[30:11]})>>31);
    // assign s10_tmp = (s4_tmp[30:0] + {s10[9:0],s10[30:10]})&(31'h7fffffff) + ( (s4_tmp[30:0] + {s10[9:0],s10[30:10]})>>31);
    // assign s13_tmp = (s10_tmp[30:0] + {s13[13:0],s13[30:14]})&(31'h7fffffff) + ((s10_tmp[30:0] + {s13[13:0],s13[30:14]})>>31);
    // assign v = (s13_tmp[30:0] + {s15[15:0],s15[30:16]})&(31'h7fffffff) + ((s13_tmp[30:0] + {s15[15:0],s15[30:16]})>>31);
    assign s0_tmp =Add(s0,{s0[22:0],s0[30:23]});
    assign s4_tmp = Add(s0_tmp,{s4[10:0],s4[30:11]});
    assign s10_tmp = Add(s4_tmp,{s10[9:0],s10[30:10]});
    assign s13_tmp = Add(s10_tmp,{s13[13:0],s13[30:14]});
    assign v = Add(s13_tmp,{s15[15:0],s15[30:16]});

    assign u_now = lfsr_mode?u:0;

    assign s16 = Add(v,u_now)?Add(v,u_now):31'h7fffffff;


    function [31:0] Add;
        input    [31:0] a,b;
        begin
            Add = ((a + b) & 32'h7FFF_FFFF) + ((a + b) >> 31);
        end
    endfunction
endmodule
