`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/18 11:38:31
// Design Name: 
// Module Name: simon
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


module simon #(
    parameter N = 16,
    parameter M = 4 
)(
    input clk,
    input rst_n,
    input en_de_cry,//1 is encry, 0 is decry
    input [2*N-1:0] din,
    input [M*N-1:0] key,
    output [2*N-1:0] dout,
    output done
    );

    reg[61:0] z[0:4]; 
    parameter IDLE = 2'b00, CIPHER1=2'b01, CIPHER2=2'b10,FINISH=2'b11;

    reg [2:0] state, next_state;

    reg [6:0] T; // T <= 72
    reg [2:0] j; // j <= 4;

    reg [N-1:0] x, y;
    reg [N*M-1:0] k;
    wire [N-1:0] k_expansion;
    wire [N-1:0] tmp1,tmp2,tmp3;
    
    reg [6:0] cnt_t; // count from 0-T,when cnt_t==m,begin k expansion
    wire cnt_en; // cnt_t?
    

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            z[0] <= 62'b11111010001001010110000111001101111101000100101011000011100110;
            z[1] <= 62'b10001110111110010011000010110101000111011111001001100001011010;
            z[2] <= 62'b10101111011100000011010010011000101000010001111110010110110011;
            z[3] <= 62'b11011011101011000110010111100000010010001010011100110100001111;
            z[4] <= 62'b11010001111001101011011000100000010111000011001010010011101111;
        end
        else begin 
            z[0] <= z[0];
            z[1] <= z[1];
            z[2] <= z[2];
            z[3] <= z[3];
            z[4] <= z[4];
        end
    end

    // FSM-1
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            state <= IDLE;
        else 
            state <= next_state; 
    end
    //FSM-2
    always @(*) begin
        case(state) 
            IDLE:begin
                next_state = CIPHER1;
            end
            CIPHER1:begin
                if(cnt_t==M-1)
                    next_state = CIPHER2;
                else
                    next_state = CIPHER1;
            end
            CIPHER2:begin
                if(cnt_t==T-1)
                    next_state = FINISH;
                else
                    next_state = CIPHER2;
            end
            FINISH:next_state = FINISH;
        endcase
    end

     //cnt_n
    assign cnt_en = (state==CIPHER1)|(state==CIPHER2);
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            cnt_t <= 7'd0;
        else if(cnt_en) 
            cnt_t <= cnt_t + 1'b1;
        else
            cnt_t <= 7'd0;
    end

    // FSM-3
    // key expansion
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            if(N==16) begin
                T <= 32;j <= 0; 
            end
            else if(N==24) begin
                if(M==3) begin
                    T <= 36; j <= 0;
                end
                else begin
                    T<=36;j<=1;
                end
            end
            else if(N==32) begin
                if(M==3) begin
                    T<=42;j<=2;
                end
                else begin
                    T<=44;j<=3;
                end
            end
            else if(N==48) begin
                if(M==2) begin
                    T<=52;j<=2;
                end
                else begin
                    T<=54;j<=3;
                end
            end
            else begin
                if(M==2) begin
                    T<=68;j<=2;
                end
                else if(M==3) begin
                    T<=69;j<=3;
                end
                else begin
                    T<=72;j<=4;
                end
            end
        end
        else begin
            T <= T;
            j <= j;
        end
    end
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            k <= 0;
        end
        else begin
            case(state)
                IDLE: begin
                    k <= key;
                end
                CIPHER1:begin
                    k <= k;
                end
                CIPHER2: begin
                    k <= {k_expansion,k[(N*M)-1:N]};
                end
                FINISH:;
            endcase
        end
    end
    assign tmp1 = {k[(M-1)*N+2:(M-1)*N],k[M*N-1:(M-1)*N+3]}; // S^-3
    assign tmp2 = (M==4)?(tmp1^k[(M-2)*N-1:(M-3)*N]):tmp1; // if(m=4) tmp<-tmp^k[i-3]
    assign tmp3 = tmp2^{tmp2[0],tmp2[N-1:1]};
    assign k_expansion = (cnt_t<=(M-1))?(k[(N*(cnt_t+1)-1)-:N]):((~k[N-1:0])^tmp3^z[j][61-(cnt_t-M)%62]^3);
    // x,y expansion
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            x <= 0;
            y <= 0;
        end
        else begin
            case(state)
                IDLE: begin
                    {x,y} <= din;
                end
                CIPHER1,CIPHER2: begin
                    if(en_de_cry) begin
                        y <= x;
                        x <= y^({x[N-2:0],x[N-1]}&{x[N-9:0],x[N-1:N-8]})^{x[N-3:0],x[N-1:N-2]}^k_expansion;
                    end
                    else begin
                        x <= y;
                        y <= x^({y[N-2:0],y[N-1]}&{y[N-9:0],y[N-1:N-8]})^{y[N-3:0],y[N-1:N-2]}^k_expansion;
                    end
                end
                FINISH:;
            endcase
        end
    end
    assign done = state==FINISH;
    assign dout = {x,y};
endmodule
