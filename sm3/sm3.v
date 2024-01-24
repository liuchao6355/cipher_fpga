`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/23 15:50:56
// Design Name: 
// Module Name: sm3
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


module sm3 #(
    parameter len = 24
    )(
    input clk,
    input rst_n,
    input [len-1:0] m,
    output [255:0] m_out,
    output done
    );

    parameter n = (len+1+64)/512+1;
    parameter pad_len = n*512;
    reg[pad_len-1:0] pad_m;

    reg rst_n_CF;
    reg[7:0] cnt;
    reg[255:0] V_in;
    reg[511:0] B;
    reg[255:0]m_out_reg;
    reg done_reg;
    wire [255:0] V_out;
    wire done_CF;

    parameter IDLE=2'b00, CF_ROUND_INIT=2'b01,CF_ROUND_CAL = 2'b10,FINISH=2'b11;
    reg [1:0] state, next_state;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            state <= IDLE;
        else
            state <= next_state;
    end
    always @(*) begin
        case(state)
            IDLE:next_state <= CF_ROUND_INIT;
            CF_ROUND_INIT: begin
                if(cnt==n)
                    next_state <= FINISH;
                else
                    next_state <= CF_ROUND_CAL;
            end
            CF_ROUND_CAL: begin
                if(done_CF)
                    next_state <= CF_ROUND_INIT;
                else
                    next_state <= CF_ROUND_CAL;
            end
            FINISH:;
        endcase
    end
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            pad_m <= 0;
        end
        else begin
            case(state)
                IDLE: begin
                    pad_m[(pad_len-1)-:len+1] <= {m,1'b1};
                    pad_m[pad_len-len-2:64] <= 0;
                    pad_m[63:0] <= len;
                    rst_n_CF <= 0;
                    cnt <= 0;
                end
                CF_ROUND_INIT: begin
                    if(cnt==0) begin
                        // V_in <= 256'h7380166f_4914b2b9_172442d7_da8a0600_a96f30be_163138aa_e38dee4d_b0fb0e4e;
                        V_in <= 256'h7380166f_4914b2b9_172442d7_da8a0600_a96f30bc_163138aa_e38dee4d_b0fb0e4e;
                    end
                    else begin
                        V_in <= m_out_reg;
                    end
                    rst_n_CF <= 1;
                    B <= pad_m[((n-cnt)*512-1)-:512];
                    cnt <= cnt + 1;
                end
                CF_ROUND_CAL: begin
                    if(done_CF) begin
                        m_out_reg <= V_out;
                        rst_n_CF <= 0;
                    end
                    else
                        rst_n_CF <= 1;
                end
                FINISH: begin
                    done_reg <= 1;
                end
            endcase
        end
    end

    assign done = done_reg;
    assign m_out = done?m_out_reg:0;

    CF CF(
        clk,
        rst_n_CF,
        V_in,
        B,
        V_out,
        done_CF
    );
endmodule
