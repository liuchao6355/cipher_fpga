`timescale 1ns / 1ps
module inv_mod(
    input clk,
    input rst_n,
    input [255:0] a,
    input [255:0] p,
    output [255:0] b,
    output done
    );
    
    //tmp用于判断
    parameter IDLE=4'd0,S1=4'd1,S2=4'd2,S3=4'd3,S4=4'd4,S5=4'd5,S6=4'd6,S7=4'd7,S8=4'd8,S2_tmp=4'd9,S3_tmp=4'd10,S5_tmp=4'd11,S6_tmp=4'd12;
    reg[3:0] state, next_state;

    wire u_even,v_even,u_zero,u_ge_v;
    assign u_even = u[0]==0?1:0;
    assign v_even = v[0]==0?1:0;
    assign u_zero = u==0?1:0;
    assign u_ge_v = u>=v?1:0;
    //相加可能溢出，所以采用257位
    reg [256:0] u,v,x,y,b_reg;
    reg done_reg;
    always @(posedge clk or negedge rst_n) begin
          if(!rst_n)
            state <= IDLE;
        else
            state <= next_state;
    end
    always @(*) begin
        case(state)
            IDLE:next_state = S1;
            S1: begin
                if(u_zero==1) next_state = S7;
                else if(u_zero==0&u_even==1) next_state = S2;
                else if(u_zero==0&u_even==0&v_even==1) next_state = S3;
                else next_state = S4;
            end
            S2: begin
                next_state = S2_tmp;
            end
            // 用于判断
            S2_tmp: begin
                if(u_even==1) next_state = S2;
                else if(u_even==0&v_even==1) next_state = S3;
                else next_state = S4;
            end
            S3:next_state = S3_tmp;
            S3_tmp: begin
                if(v_even==1) next_state = S3;
                else if(v_even==0) next_state = S4;
            end
            S4:begin
                if(u_ge_v==1) next_state = S5;
                else next_state = S6;
            end
            S5:next_state = S5_tmp;
            S5_tmp: begin
                if(u_zero==1) next_state = S7;
                else if(u_zero==0&u_even==1) next_state = S2;
                else if(u_zero==0&u_even==0&v_even==1) next_state = S3;
                else next_state = S4;
            end
            S6: next_state = S6_tmp;
            S6_tmp: begin
                if(u_zero==1) next_state = S7;
                else if(u_zero==0&u_even==1) next_state = S2;
                else if(u_zero==0&u_even==0&v_even==1) next_state = S3;
                else next_state = S4;
            end
            S7: next_state = S8;
            S8: ;
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            done_reg <= 0;
        end
        else begin
            case(state)
                IDLE:begin
                    done_reg<=0;
                    u <= a;
                    v <= p;
                    x <= 1;
                    y <= 0;
                end
                S1: begin
                    u <= a;
                    v <= p;
                    x <= 1;
                    y <= 0;
                end
                S2: begin
                    u <= u>>1;
                    if(x[0]==0) x <= x>>1;
                    else x <= (x+p)>>1;
                end
                S3: begin
                    v <= v>>1;
                    if(y[0]==0) y <= y>>1;
                    else y <= (y+p)>>1;
                end
                S4:;
                S5: begin
                    u <= u-v;
                    if(x>y) x <= x-y;
                    else x <= x+p-y;
                end
                S6: begin
                    v = v-u;
                    if(y>x) y <= y-x;
                    else y <= y+p-x;
                end
                S7: b_reg <= (y[256]==1)?(y-p):y;
                S8:done_reg <= 1;
                S2_tmp,S3_tmp,S5_tmp,S6:;
            endcase
        end
    end
    assign done = done_reg;
    assign b = done?b_reg:0;

endmodule
