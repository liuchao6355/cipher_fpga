// `timescale 1ns / 1ps
// //////////////////////////////////////////////////////////////////////////////////
// // Company: 
// // Engineer: 
// // 
// // Create Date: 2024/03/01 00:03:11
// // Design Name: 
// // Module Name: mul_128
// // Project Name: 
// // Target Devices: 
// // Tool Versions: 
// // Description: 
// // 
// // Dependencies: 
// // 
// // Revision:
// // Revision 0.01 - File Created
// // Additional Comments:
// // 
// //////////////////////////////////////////////////////////////////////////////////


// module mul_128(
//     input clk,
//     input [127:0] a,
//     input [127:0] b,
//     output [255:0] c
//     );

//     wire [63:0] a0,b0,a1,b1;

//     wire [127:0] P0,P1,P2,P3;

//     assign {a1,a0} = a;
//     assign {b1,b0} = b;

//     mul_64 mul_64_1(clk,a0,b0,P0);
//     mul_64 mul_64_2(clk,a1,b1,P1);

//     mul_64 mul_64_3(clk,a1,b0,P2);
//     mul_64 mul_64_4(clk,a0,b1,P3);


//     assign c = {P1,128'd0} + {P2+P3,64'd0} + {128'd0,P0};

// endmodule











`timescale 1ns / 1ps


module mul_128(
    input clk,
    input rst_n,
    input [127:0] a,
    input [127:0] b,
    output [255:0] c,
    output done
    );

    wire [63:0] a0,b0,a1,b1;
    reg [127:0] P0,P1,P2,P3;
    wire [127:0] P_out;
    wire [255:0] c_reg;
    reg done_reg;

    reg [63:0] aa,bb;

    assign {a1,a0} = a;
    assign {b1,b0} = b;

    parameter IDLE=3'd0,ROUND1=3'd1,ROUND2=3'd2,ROUND3=3'd3,ROUND4=3'd5,FINISH=3'd6;
    reg[2:0] state,next_state;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            state <= IDLE;
        else 
            state <= next_state;
    end
    always @(*) begin
        case(state)
            IDLE:next_state = ROUND1;
            ROUND1:next_state = ROUND2;
            ROUND2:next_state = ROUND3;
            ROUND3:next_state = ROUND4;
            ROUND4:;
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            aa <= a0;
            bb <= b0;
            done_reg <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    aa <= a1;
                    bb <= b1; 
                    done_reg <= 0;
                end
                 ROUND1: begin
                    P0 <= P_out;
                    aa <= a1;
                    bb <= b0; 
                    done_reg <= 0;
                 end
                 ROUND2: begin
                    P1 <= P_out;
                    aa <= a0;
                    bb <= b1; 
                    done_reg <= 0;
                 end
                 ROUND3: begin
                    P2 <= P_out;
                 end
                 ROUND4: begin
                    P3 <= P_out;
                    done_reg <= 1;
                 end
            endcase
        end     
    end

    mul_64 mul_64(clk,aa,bb,P_out);
    //忘记改了
    wire [128:0] P2P3;
    assign P2P3 = P2+P3;
    assign done = done_reg;
    assign c = done?({P1,128'd0} + {P2P3,64'd0} + {128'd0,P0}):0;

endmodule