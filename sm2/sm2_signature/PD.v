`timescale 1ns / 1ps

module PD(
    input clk,
    input rst_n,
    input [255:0] X1,
    input [255:0] Z1,
    output [255:0] X_out,
    output [255:0] Z_out,
    output done
);

    parameter p = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_FFFFFFFF_00000000_FFFFFFFF_FFFFFFFF;
    parameter a = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_FFFFFFFF_00000000_FFFFFFFF_FFFFFFFC;
    parameter b = 256'h28E9FA9E_9D9F5E34_4D5A9E4B_CF6509A7_F39789F5_15AB8F92_DDBCBD41_4D940E93;
    // parameter b2 = 2*b;
    // parameter b4 = 4*b;
    reg [255:0] b2,b4;
    // parameter n = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_7203DF6B_21C6052B_53BBF409_39D54123;
    // parameter Gx = 256'h32C4AE2C_1F198119_5F990446_6A39C994_8FE30BBF_F2660BE1_715A4589_334C74C7;
    // parameter Gy = 256'hBC3736A2_F4F6779C_59BDCEE3_6B692153_D0A9877C_C62A4740_02DF32E5_2139F0A0;

    // parameter p = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_FFFFFFFF_00000000_FFFFFFFF_FFFFFFFF;
    // parameter a = 256'd9;
    // parameter b = 256'd3;
    // // parameter b2 = 2*b;
    // reg [255:0] b2,b4;
    // // parameter n = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_7203DF6B_21C6052B_53BBF409_39D54123;
    // parameter Gx = 256'd7;
    // // parameter Gy = 256'hBC3736A2_F4F6779C_59BDCEE3_6B692153_D0A9877C_C62A4740_02DF32E5_2139F0A0;

    reg [4:0] count;
    reg [255:0] T1,T2,T3,T4,T5,T6,mul_a,mul_b;
    wire [255:0] abmodp;
    wire done_mul_mod_p;
    reg rst_mul_mod_p;
    reg [255:0] add_a,add_b,sub_a,sub_b;
    wire [255:0] add_ab,sub_ab;
    //延迟一个时钟的done
    reg [255:0] abmodp_one_cycle;
    reg done_one_cycle;
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            count <= 5'd0;
            rst_mul_mod_p <= 0;
            done_reg<= 0;
        end
        else begin
            if(done_mul_mod_p) begin
                rst_mul_mod_p <= 0;
                count <= count + 1'b1;
            end
            else begin
                rst_mul_mod_p <= 1;
                count <= count;
            end
            done_one_cycle <= done_mul_mod_p;
            abmodp_one_cycle <= abmodp;
        end
    end


    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rst_mul_mod_p <= 0;
        end 
        else begin
            if(count == 0) begin
                mul_a <= Z1;
                mul_b <= Z1;
                add_a <= b;
                add_b <= b;
            end
            else if(done_one_cycle) begin
                case(count)
                    // 5'd0:begin
                        // mul_a <= X1;
                        // mul_b <= Z2;
                    // end
                    5'd1:begin
                        T1 <= abmodp_one_cycle;
                        mul_a <= X1;
                        mul_b <= X1;
                        b2 <= add_ab;
                        add_a <= add_ab;
                        add_b <= add_ab;
                    end
                    5'd2:begin
                        T2 <= abmodp_one_cycle;
                        mul_a <= a;
                        mul_b <= T1;
                        T4 <= add_ab;
                    end
                    5'd3:begin
                        T3 <= abmodp_one_cycle;
                        mul_a <= T4;
                        mul_b <= T1;
                        add_a <= T2;
                        add_b <= abmodp_one_cycle;
                        sub_a <= T2;
                        sub_b <= abmodp_one_cycle;
                    end
                    5'd4:begin
                        T4 <= abmodp_one_cycle;
                        T2 <= sub_ab;
                        T3 <= add_ab;
                        mul_a <= X1;
                        mul_b <= Z1;
                    end
                    5'd5:begin
                        T5 <= abmodp_one_cycle;
                        mul_a <= T1;
                        mul_b <= T4;
                        add_a <= T3;
                        add_b <= T3;
                    end
                    5'd6:begin
                        T1 <= abmodp_one_cycle;
                        mul_a <= T5;
                        mul_b <= T4;
                        T3 <= add_ab;
                        add_a <= add_ab;
                        add_b <= add_ab;
                    end
                    5'd7:begin
                        T4 <= abmodp_one_cycle;
                        mul_a <= T2;
                        mul_b <= T2;
                        T3 <= add_ab;
                        add_a <= abmodp_one_cycle;
                        add_b <= abmodp_one_cycle;
                    end
                    5'd8:begin
                        T2 <= abmodp_one_cycle;
                        mul_a <= T5;
                        mul_b <= T3;
                        T4 <= add_ab;
                        sub_a <= abmodp_one_cycle;
                        sub_b <= add_ab;
                    end
                    5'd9:begin
                        T3 <= abmodp_one_cycle;
                        T2 <= sub_ab;
                        add_a <= T1;
                        add_b <= abmodp_one_cycle;
                    end
                    5'd10:begin
                        Z_out_reg <= add_ab;
                        X_out_reg <= T2;
                        done_reg <= 1;
                    end
                endcase
            end
        end
    end

    reg [255:0] Z_out_reg,X_out_reg;
    reg done_reg;

    assign X_out = X_out_reg;
    assign Z_out = Z_out_reg;
    assign done = done_reg;

    mul_mod_p mul_mod_p(clk,rst_mul_mod_p,mul_a,mul_b,abmodp,done_mul_mod_p);

    add_mod add_mod(add_a,add_b,p,add_ab);
    sub_mod sub_mod(sub_a,sub_b,p,sub_ab);

endmodule