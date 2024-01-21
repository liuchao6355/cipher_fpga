`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/21 17:13:26
// Design Name: 
// Module Name: BitReconstruction
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


module BitReconstruction(
        input [30:0] s15,
        input [30:0] s14,
        input [30:0] s11,
        input [30:0] s9,
        input [30:0] s7,
        input [30:0] s5,
        input [30:0] s2,
        input [30:0] s0,
        output [31:0] X0,
        output [31:0] X1,
        output [31:0] X2,
        output [31:0] X3
    );

    assign X0 ={s15[30:15],s14[15:0]};
    assign X1 ={s11[15:0],s9[30:15]};
    assign X2 ={s7[15:0],s5[30:15]};
    assign X3 ={s2[15:0],s0[30:15]};

endmodule
