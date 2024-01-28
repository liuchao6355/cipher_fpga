`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/27 11:04:52
// Design Name: 
// Module Name: sm2_signature
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


// F_p-256
module sm2_signature #(
    parameter M_len = 112
    )(
    input clk,
    input rst_n,
    input [255:0] p, // 素数
    input [255:0] a, // 系数
    input [255:0] b,
    input [255:0] G_x, //基点坐标
    input [255:0] G_y,
    input [255:0] n, //基点阶
    input [255:0] dA, //私钥
    input [255:0] PA_x, //公钥
    input [255:0] PA_y,
    input [127:0] ID_a,
    input [31:0] ENTL_a,
    input [M_len-1:0] M, // 加密消息
    output [255:0] r,
    output [255:0] s,
    output done
    );

    wire [255:0] k;
    assign k = 256'h6CB28D99_385C175C_94F94E93_4817663F_C176D925_DD72B727_260DBAAE_1FB2F96F；//确定随机数方便测试

    parameter IDLE = 3'd0, CAL_M = 3'd1, CAL_e = 3'd2, CAL_xy = 3'd3, CAL_r = 3'd4, CAL_s = 3'd5, FINISH = 3'd6;
    reg [2:0] state, next_state;
    reg [255:0] x1,y1;
    reg [255:0] Z_A,e;
    wire [255:0] Z_A_tmp,e_tmp;
    reg rst_n_sm3_1,rst_n_sm3_2;
    wire done_sm3_1,done_sm3_2;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            state <= IDLE;
        else
            state <= next_state;
    end
    always @(*) begin
        case(state):
            IDLE:next_state = CAL_M;
            CAL_M: next_state <= done_sm3?CAL_e:CAL_M;
            CAL_e:next_state <= done_sm3?CAL_xy:CAL_e;
            CAL_xy: next_state <= done_kG?CAL_r:CAL_xy;
            CAL_r: begin

            end
            CAL_s: begin

            end
            FINISH:;
        endcase
    end

    sm3 sm3_1#(parameter len = (32+128+512+512+512))(clk,rst_n_sm3_1,{ENTL_a,ID_a,b,G_x,G_y,PA_x,PA_y},Z_A_tmp,done_sm3_1);
    sm3 sm3_2#(parameter len = (256+M_len))(clk,rst_n_sm3_2,{Z_A,M},e_tmp,done_sm3_2)

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rst_n_sm3_1 <= 0;
            rst_n_sm3_2 <= 0;
        end
        else begin
            case(state)
                IDLE: begin
                    rst_n_sm3_1 <= 1; // 计算第一个hash值
                end
                CAL_M: begin
                    if(done_sm3_1) begin
                        Z_A <= Z_A_tmp;
                        rst_n_sm3_2 <= 1;
                    end
                end
                CAL_e: begin
                    if(done_sm3_2)
                        e <= e_tmp;
                end
                CAL_xy: begin
                    x1 <= k*G_x;//使用IP核
                    y1 <= k*G_y;
                end
                CAL_r: begin
                    r <= (e+x1)%n;
                end
                CAL_s: begin
                
                end
                FINISH: begin

                end

            endcase
        end
    end



endmodule
