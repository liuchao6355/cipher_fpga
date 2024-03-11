`timescale 1ns / 1ps

module convert_coordinate(
    input clk,
    input rst_n,
    input [255:0] X1,
    input [255:0] Z1,
    input [255:0] X2,
    input [255:0] Z2,
    input [255:0] Gx,
    input [255:0] Gy,
    output [255:0] x_out,
    output [255:0] y_out,
    output done
    );
    parameter p = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_FFFFFFFF_00000000_FFFFFFFF_FFFFFFFF;
    parameter a = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_FFFFFFFF_00000000_FFFFFFFF_FFFFFFFC;
    parameter b = 256'h28E9FA9E_9D9F5E34_4D5A9E4B_CF6509A7_F39789F5_15AB8F92_DDBCBD41_4D940E93;
    // parameter b2 = 2*b;
    // reg [255:0] b2;
    // reg [255:0] Gy2;
    // parameter n = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_7203DF6B_21C6052B_53BBF409_39D54123;
    // parameter Gx = 256'h32C4AE2C_1F198119_5F990446_6A39C994_8FE30BBF_F2660BE1_715A4589_334C74C7;
    // parameter Gy = 256'hBC3736A2_F4F6779C_59BDCEE3_6B692153_D0A9877C_C62A4740_02DF32E5_2139F0A0;

    // parameter p = 256'd10;
    // parameter a = 256'd9;
    // parameter b = 256'd3;
    // // parameter b2 = 2*b;
    // parameter b2 = 2*b;
    // // parameter n = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_7203DF6B_21C6052B_53BBF409_39D54123;
    // parameter Gx = 256'd7;
    // // parameter Gy = 256'hBC3736A2_F4F6779C_59BDCEE3_6B692153_D0A9877C_C62A4740_02DF32E5_2139F0A0;

    reg [255:0] T1,T2,T3,T4,T5,mul_a,mul_b,inv_a,x1,x2,y1;
    wire [255:0] abmodp,out_inv_mod;
    wire done_mul_mod_p,done_inv_mod;
    reg rst_mul_mod_p,rst_n_inv_mod;
    reg [255:0] add_a,add_b,sub_a,sub_b;
    wire [255:0] add_ab,sub_ab;
    //延迟一个时钟的done
    reg [255:0] abmodp_one_cycle;
    reg done_one_cycle;

    parameter S1=5'd0,S2=5'd1,S2_tmp=5'd15,S3=5'd2,S3_tmp=5'd16,S4=5'd3,S4_tmp=5'd17,S5=5'd4,S6=5'd5,S7=5'd6,S8=5'd7,S9=5'd8,S10=5'd10;//s1-s5求2b+(a+xgx1)(xg+x1)-x2(xg-x1)^2,s6inv(z1),s7inv(z2),mulx1z1,s8inv(2gy),mulx2z2,s9y1,s10;
    reg [4:0] state,next_state;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            state <= S1;
        else
            state <= next_state;
    end

    always @(*) begin
        case(state)
            S1:begin  
                if(done_inv_mod) next_state <= S2; 
                else next_state <= S1; 
            end //z1^-1
            S2:begin if(done_mul_mod_p) next_state <= S2_tmp; else next_state <= S2; end//x1/z1
            S2_tmp:begin if(done_inv_mod) next_state <= S3; else next_state <= S2_tmp; end//z2^-1
            S3:begin if(done_mul_mod_p) next_state <= S3_tmp; else next_state <= S3; end//x2/z2
            S3_tmp:begin if(done_inv_mod) next_state <= S4; else next_state <= S3_tmp; end//2Gy^-1
            S4:begin if(done_mul_mod_p) next_state <= S5; else next_state <= S4; end//x1*xG,xG-x1
            S5:begin if(done_mul_mod_p) next_state <= S6; else next_state <= S5; end //(xG-x1)^2,x1*xG+a
            S6:begin if(done_mul_mod_p) next_state <= S7; else next_state <= S6; end//x2(xG-x1)^2,x1+xG
            S7:begin if(done_mul_mod_p) next_state <= S8; else next_state <= S7; end//(x1+xG)(a+xa*xG),2b-x2(xG-x1)^2
            S8:begin next_state <= S9; end //y1分子
            S9:begin if(done_mul_mod_p) next_state <= S10;else next_state <= S9;end
            S10:;
        endcase
    end
    reg done_reg;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rst_n_inv_mod <= 0;
            inv_a <= Z1;
            add_a <= b;
            add_b <= b;
            done_reg <= 0;
        end
        else begin
            case(state)
                S1:begin
                    if(done_inv_mod) begin 
                        T1 <= out_inv_mod;//Z1^-1
                        T3 <= add_ab;//2b
                        add_a <= Gy;
                        add_b <= Gy;
                        mul_a <= X1;
                        mul_b <= out_inv_mod;
                        rst_mul_mod_p <= 0; //x1*z1
                    end
                    else
                        rst_n_inv_mod <= 1;
                end
                S2:begin
                    if(done_mul_mod_p==1'b1) begin
                        x1 <= abmodp;//x1/z1
                        T4 <= add_ab;//2Gy
                        inv_a <= Z2;
                        rst_n_inv_mod <= 0;
                    end
                    else rst_mul_mod_p <= 1;
                end
                S2_tmp:begin
                    if(done_inv_mod) begin
                        T2 <= out_inv_mod;//Z2^-1
                        mul_a <= X2;
                        mul_b <= out_inv_mod;
                        rst_mul_mod_p <= 0;
                    end
                    else rst_n_inv_mod <= 1;
                end
                S3:begin
                    if(done_mul_mod_p) begin
                        x2 <= abmodp;//X2/Z2
                        inv_a <= T4;
                        rst_n_inv_mod <= 0;
                    end
                    else rst_mul_mod_p <= 1;
                end
                S3_tmp:begin
                    if(done_inv_mod) begin
                        T4 <= out_inv_mod;//2Gy^-1
                        mul_a <= x1;
                        mul_b <= Gx;
                        sub_a <= Gx;
                        sub_b <= x1;
                        rst_mul_mod_p <= 0;
                    end
                    else rst_n_inv_mod <= 1;
                end
                S4:begin
                    if(done_mul_mod_p) begin
                        T1 <= abmodp;//x1Gx
                        T2 <= sub_ab;//Gx-x1
                        mul_a <= sub_ab;
                        mul_b <= sub_ab;
                        add_a <= abmodp;
                        add_b <= a;
                        rst_mul_mod_p <= 0;
                    end
                    else rst_mul_mod_p <= 1;
                end
                S5:begin
                    if(done_mul_mod_p) begin
                        T2 <= abmodp;//(Gx-x1)^2
                        T1 <= add_ab;//x1Gx+a
                        mul_a <= x2;
                        mul_b <= abmodp;
                        add_a <= x1;
                        add_b <= Gx;
                        rst_mul_mod_p <= 0;
                    end
                    else rst_mul_mod_p <= 1;
                end
                S6:begin
                    if(done_mul_mod_p) begin
                        T2 <= abmodp;//x2(Gx-x1)^2
                        T5 <= add_ab;//x1+Gx
                        mul_a <= add_ab;
                        mul_b <= T1;
                        sub_a <= T3;
                        sub_b <= abmodp;
                        rst_mul_mod_p <= 0;
                    end
                    else rst_mul_mod_p <= 1;
                end
                S7:begin
                    if(done_mul_mod_p) begin
                        T1 <= abmodp;//(x1+Gx)(a+x1Gx)
                        T2 <= sub_ab;//2b-x2(Gx-x1)^2
                        add_a <= abmodp;
                        add_b <= sub_ab;
                        rst_mul_mod_p <= 0;
                    end
                    else rst_mul_mod_p <= 1;
                end
                S8:begin
                    // if(done_mul_mod_p) begin
                        mul_a <= add_ab;//2b-x2(Gx-x1)^2+(x1+Gx)(a+x1Gx)
                        mul_b <= T4;//2Gy^-1
                        // rst_mul_mod_p <= 0;
                    // end
                    rst_mul_mod_p <= 1;
                end
                S9:begin
                    if(done_mul_mod_p) begin
                        y1 <= abmodp;
                        rst_mul_mod_p <= 0;
                    end
                    else rst_mul_mod_p <= 1;
                end
                S10:begin
                    done_reg <= 1;
                end
            endcase
        end
    end
    assign done = done_reg;
    assign x_out = done?x1:0;
    assign y_out = done?y1:0;

    mul_mod_p mul_mod_p(clk,rst_mul_mod_p,mul_a,mul_b,abmodp,done_mul_mod_p);

    add_mod add_mod(add_a,add_b,p,add_ab);
    sub_mod sub_mod(sub_a,sub_b,p,sub_ab);

    inv_mod inv_mod(clk,rst_n_inv_mod,inv_a,p,out_inv_mod,done_inv_mod);

endmodule
