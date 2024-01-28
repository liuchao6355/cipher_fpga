`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/23 16:36:42
// Design Name: 
// Module Name: CF
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


module CF(
    input clk,
    input rst_n,
    input [255:0] V_in,
    input [511:0] B,
    output [255:0] V_out,
    output done
    );


    reg [6:0] cnt;
    reg[31:0] W[0:15];
    wire [31:0] W16;
    reg [31:0] W_,W_i;
    reg [255:0] V_in_tmp;
    // reg [511:0] B_tmp;
    wire [255:0] V_tmp;
    reg done_reg;

    parameter IDLE=2'b00,ROUND=2'b10,FINISH=2'b11;
    reg [1:0] state, next_state;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            cnt <= 7'd0;
        else begin
            if(state==ROUND)
                    cnt <= cnt + 1'b1;
            else
                cnt <= 7'd0;
        end
    end
    // FSM-1
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            state <= IDLE;
        else
            state <= next_state;
    end
    // FSM-2
    always @(*) begin
        case(state)
            IDLE:next_state <=  ROUND;
            ROUND:begin
                if(cnt==63)
                    next_state <= FINISH;
                else
                    next_state <= ROUND;
            end
            FINISH:;
        endcase
    end
    // FSM-3
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin 
            {W[0],W[1],W[2],W[3],W[4],W[5],W[6],W[7],W[8],W[9],W[10],W[11],W[12],W[13],W[14],W[15]} <= 0;
            done_reg <= 0;
        end
        else begin
            case(state)
                IDLE:begin
                    {W[0],W[1],W[2],W[3],W[4],W[5],W[6],W[7],W[8],W[9],W[10],W[11],W[12],W[13],W[14],W[15]} <= B;
                    // B_tmp <= B;
                    done_reg <= 0;
                end
                ROUND: begin
                    if(cnt==0)begin V_in_tmp <= V_in;end
                    else begin V_in_tmp <= V_tmp;end
                    if(cnt>=11) begin
                        {W[0],W[1],W[2],W[3],W[4],W[5],W[6],W[7],W[8],W[9],W[10],W[11],W[12],W[13],W[14],W[15]} <= {W[1],W[2],W[3],W[4],W[5],W[6],W[7],W[8],W[9],W[10],W[11],W[12],W[13],W[14],W[15],W16};
                        W_ <= W[11]^W[15];
                        W_i <= W[11];
                    end
                    else begin
                        W_ <= W[cnt]^W[cnt+4];
                        W_i <= W[cnt];
                    end
                end
                FINISH: begin
                    done_reg <= 1;
                end
            endcase
        end
    end
    assign done = done_reg;
    assign V_out = done?V_tmp^V_in:0;

    // W[16]
    assign W16 = P1(W[0]^W[7]^{W[13][16:0],W[13][31:17]})^{W[3][24:0],W[3][31:25]}^W[10];

    // compress
    compress compress(
        .V_in(V_in_tmp),.W_i(W_i),.W_(W_),.cnt(cnt-1),
        .V_out(V_tmp)
    );

    function [31:0] P1;
        input [31:0] X;
        begin
            P1 = X^{X[16:0],X[31:17]}^{X[8:0],X[31:9]};
        end
    endfunction

endmodule
