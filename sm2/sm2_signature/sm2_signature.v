`timescale 1ns / 1ps

module sm2_signature #(
    parameter len_M = 28*4
)(
    input clk,
    input rst_n,
    input [len_M-1:0] M,
    input [255:0] da,
    input [255:0] Px,
    input [255:0] Py,
    input [255:0] k,
    output [255:0] o_r,
    output [255:0] o_s,
    output done
    );
    parameter ID_a = 128'h31323334_35363738_31323334_35363738;
    parameter ENTL_a = 32'h0080;
    parameter S0=4'd0,S1=4'd1,S2=4'd2,S3=4'd3,S4=4'd4,S5=4'd5,S6=4'd6,S7=4'd7;
    parameter p = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_FFFFFFFF_00000000_FFFFFFFF_FFFFFFFF;
    parameter a = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_FFFFFFFF_00000000_FFFFFFFF_FFFFFFFC;
    parameter b = 256'h28E9FA9E_9D9F5E34_4D5A9E4B_CF6509A7_F39789F5_15AB8F92_DDBCBD41_4D940E93;
    parameter n = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_7203DF6B_21C6052B_53BBF409_39D54123;
    parameter Gx = 256'h32C4AE2C_1F198119_5F990446_6A39C994_8FE30BBF_F2660BE1_715A4589_334C74C7;
    parameter Gy = 256'hBC3736A2_F4F6779C_59BDCEE3_6B692153_D0A9877C_C62A4740_02DF32E5_2139F0A0;
    reg[3:0] state, next_state;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        case(state)
            S0:begin //Z_A
                if(done_sm3_1) next_state = S1;
                else next_state = S0;
            end
            S1:begin //e
                if(done_sm3_2) next_state = S2;
                else next_state = S1;
            end
            S2:begin //x1,y1
                // if(done_P_mul)
                if(done_PM)  next_state = S3;
                else next_state = S2;
            end
            S3:begin //r,(1+da)^-1
                if(done_inv_mod) next_state = S4;
                else next_state = S3;
            end
            S4:begin//(r*da)mod n
                if(done_mul_mod) next_state = S5;
                else next_state = S4;
            end
            S5:begin //(k-r*da)mod n
                next_state = S6;
                // else next_state = S5;
            end
            S6:begin //s
                if(done_mul_mod) next_state = S7;
                else next_state = S6;
            end
            S7:;
        endcase
    end

    reg rst_sm3_1,rst_sm3_2,rst_mul_mod,rst_inv_mod,rst_PM;
    wire done_PM;
    wire done_abmod_n,done_inv_mod,done_sm3_1,done_sm3_2;
    reg [(32+4+64+64+64+64+64+64)*4-1:0] i_sm3_1;
    reg [(256+len_M)-1:0] i_sm3_2;

    wire [255:0] o_sm3_1,o_sm3_2;
    reg [255:0] e,x1,y1,da_1_;
    reg [255:0] s_reg,i_inv_mod_a,i_add_a,i_add_b,i_sub_a,i_sub_b,r,i_mul_mod_a,i_mul_mod_b;
    reg [255:0] k_PM,Gx_PM,Gy_PM;
    wire [255:0] x_out_PM,y_out_PM;
    reg done_reg;
    wire done_mul_mod;
    reg rst_P_mul;
    wire [255:0] o_add,o_sub,o_inv_mod,o_abmodn;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rst_sm3_1 <= 0;
            i_sm3_1 <= {ENTL_a,ID_a,a,b,Gx,Gy,Px,Py};
            done_reg <= 0;
        end
        else begin
            case(state)
                S0:begin
                    if(done_sm3_1) begin
                        i_sm3_2 <= {o_sm3_1,M};
                        rst_sm3_2 <= 0; 
                    end
                    else rst_sm3_1 <= 1;
                end
                S1:begin
                    if(done_sm3_2) begin
                        e <= o_sm3_2;
                        //点乘初始化
                        //未完成

                        // 赋G，k，rst 0
                        // P
                        k_PM <= k;
                        Gx_PM <= Gx;
                        Gy_PM <= Gy;
                        rst_PM <= 0;
                    end
                    else rst_sm3_2 <= 1;
                end
                S2:begin
                    // if(done_P_mul) begin
                    if(done_PM) begin
                        x1 <= x_out_PM;
                        y1 <= y_out_PM;

                        rst_inv_mod <= 0;
                        i_inv_mod_a <= da+1'b1;
                        i_add_a <= e;
                        i_add_b <= x_out_PM;
                        // i_add_b <= 256'h04EBFC71_8E8D1798_62043226_8E77FEB6_415E2EDE_0E073C0F_4F640ECD_2E149A73;
                    end
                    else  rst_PM <= 1;//rst 1
                end
                S3:begin
                    if(done_inv_mod) begin
                        r <= o_add;
                        da_1_ <= o_inv_mod;//(1+da)^-1

                        i_mul_mod_a <= o_add;
                        i_mul_mod_b <= da;
                        rst_mul_mod <= 0;
                    end
                    else rst_inv_mod <= 1;
                end
                S4:begin
                    if(done_mul_mod) begin
                        i_sub_b <= o_abmodn;
                        i_sub_a <= k;
                    end
                    else rst_mul_mod <= 1;
                end
                S5:begin
                    i_mul_mod_b <= o_sub;
                    i_mul_mod_a <= da_1_;
                    rst_mul_mod <= 0;
                end
                S6:begin
                    if(done_mul_mod) s_reg <= o_abmodn;
                    else rst_mul_mod <= 1;
                end
                S7:begin
                    done_reg <= 1;
                end
            endcase
        end
    end

    assign done = done_reg;
    assign o_r = done?r:0;
    assign o_s = done?s_reg:0;

    // 模乘，针对模n（阶）
    barrett abmodn(clk,rst_mul_mod,i_mul_mod_a,i_mul_mod_b,o_abmodn,done_mul_mod);

    // 模n
    inv_mod inv_mod(clk,rst_inv_mod,i_inv_mod_a,n,o_inv_mod,done_inv_mod);
    add_mod add_mod(i_add_a,i_add_b,n,o_add);
    sub_mod sub_mod(i_sub_a,i_sub_b,n,o_sub);

    P_mul P_mul(clk,rst_PM,k_PM,Gx_PM,Gy_PM,x_out_PM,y_out_PM,done_PM);

    // Z_A=H(ENTLa|IDa|a|b|Gx|Gy|xa|ya)
    sm3 #(
        .len((32+4+64+64+64+64+64+64)*4))
    sm31(
        clk,rst_sm3_1,i_sm3_1,o_sm3_1,done_sm3_1
    );
    // e = H(M)
    sm3 #(
        .len(256+len_M))
    sm32 (
        clk,rst_sm3_2,i_sm3_2,o_sm3_2,done_sm3_2
    );
endmodule
