`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/11 18:16:00
// Design Name: 
// Module Name: sm2_encryption
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


module sm2_encryption#(
    parameter len_M = 4*38
)(
    input clk,
    input rst_n,
    input [len_M-1:0] M,
    input [255:0] k,
    input [255:0] xPb,
    input [255:0] yPb,
    output [len_M+512+256-1:0] M_out,
    output done
    );
    parameter p = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_FFFFFFFF_00000000_FFFFFFFF_FFFFFFFF;
    parameter a = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_FFFFFFFF_00000000_FFFFFFFF_FFFFFFFC;
    parameter b = 256'h28E9FA9E_9D9F5E34_4D5A9E4B_CF6509A7_F39789F5_15AB8F92_DDBCBD41_4D940E93;
    parameter n = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_7203DF6B_21C6052B_53BBF409_39D54123;
    parameter Gx = 256'h32C4AE2C_1F198119_5F990446_6A39C994_8FE30BBF_F2660BE1_715A4589_334C74C7;
    parameter Gy = 256'hBC3736A2_F4F6779C_59BDCEE3_6B692153_D0A9877C_C62A4740_02DF32E5_2139F0A0;
    
    reg [len_M+512+256-1:0] M_reg;
    reg [255:0] x2,y2;
    reg [len_M-1:0] t;
    reg done_reg;

    reg rst_PM,rst_KDF,rst_sm3;
    reg [255:0] k_PM,Gx_PM,Gy_PM;
    reg [511:0] Z_KDF;
    reg [512+len_M-1:0] m_sm3;
    wire [255:0] x_out_PM,y_out_PM,m_out_sm3;
    wire [len_M-1:0] K_KDF;
    wire done_PM,done_KDF,done_sm3;

    parameter S0=3'd0,S1=3'd1,S2=3'd2,S3=3'd3,S4=3'd4,S5=3'd5,S6=3'd6;
    reg [2:0] state,next_state;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            state <= S0;
        else 
            state <= next_state;
    end
    always @(*) begin
        case(state)
            S0:begin
                if(done_PM) next_state = S1;
                else next_state = S0;
            end
            S1: begin
                if(done_PM) next_state = S2;
                else next_state = S1;
            end
            S2:begin
                if(done_KDF) next_state = S3;
                else next_state = S2;
            end
            S3:next_state = S4;
            S4:begin
                if(done_sm3) next_state = S5;
                else next_state = S4;
            end
            S5:;
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            done_reg <= 0;
            rst_PM <= 0;
            k_PM <= k;
            Gx_PM <= Gx;
            Gy_PM <= Gy;
        end
        else begin
            case(state)
                S0:begin
                    if(done_PM) begin
                        M_reg[len_M+512+256-1:len_M+256] = {x_out_PM,y_out_PM};
                        
                        rst_PM <= 0;
                        k_PM <= k;
                        Gx_PM <= xPb;
                        Gy_PM <= yPb;
                    end
                    else rst_PM <= 1;
                end
                S1:begin
                    if(done_PM) begin
                        x2 <= x_out_PM;
                        y2 <= y_out_PM;

                        rst_KDF <= 0;
                        Z_KDF <= {x_out_PM,y_out_PM};
                    end
                    else rst_PM <= 1;
                end
                S2:begin
                    if(done_KDF) begin
                        t <= K_KDF;
                    end
                    else rst_KDF <= 1;
                end
                S3: begin 
                    M_reg[len_M-1:0] <= t^M;

                    rst_sm3 <= 0;
                    m_sm3 <= {x2,M,y2};
                end
                S4:begin
                    if(done_sm3) M_reg[len_M+255:len_M] <= m_out_sm3;
                    else rst_sm3 <= 1;
                end
                S5: done_reg <= 1;
            endcase
        end
    end

    assign done = done_reg;
    assign M_out = done?M_reg:0;

    P_mul P_mul(clk,rst_PM,k_PM,Gx_PM,Gy_PM,x_out_PM,y_out_PM,done_PM);

    KDF #(
        .klen(len_M),
        .klen_v(len_M/256+1) // klen/v v=256
    )KDF(
        clk,rst_KDF,Z_KDF,K_KDF,done_KDF  
    );

    sm3 #(
        .len(512+len_M)
    )sm3(
        clk,rst_sm3,m_sm3,m_out_sm3,done_sm3
    );

endmodule

















