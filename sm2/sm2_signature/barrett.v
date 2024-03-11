`timescale 1ns / 1ps


module barrett(
    input clk,
    input rst_n,
    input [255:0] a,
    input [255:0] b,
    output [255:0] c,
    output done
    );

    parameter P256 = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_7203DF6B_21C6052B_53BBF409_39D54123;
    parameter u = 257'h1_00000001_00000001_00000001_00000001_8DFC2096_FA323C01_12AC6361_F15149A0;

    parameter S1=3'd0,S2=3'd1,S3=3'd2,S4=3'd3,S5=3'd4,S6=3'd5,S7=3'd6,S8=3'd7;
    reg [2:0] state,next_state;
    reg [255:0] mul_a,mul_b;
    reg rst_mul;
    wire [511:0] mul_ab;
    wire done_mul_256;

    reg [511:0] d,e1,e2,d_;
    wire [512:0] e1e2;
    // reg [255:0] e_;
    reg [256:0] c_tmp;
    reg [255:0] c_reg;
    reg done_reg;


    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            state <= S1;
        else
            state <= next_state;
    end
    always @(*) begin
        case(state)
            S1:begin
                if(done_mul_256)
                    next_state = S2;
                else next_state = S1;
            end
            S2:begin
                if(done_mul_256) next_state = S3;
                else next_state = S2;
            end
            S3: next_state = S4;
            S4: begin
                if(done_mul_256) next_state = S5;
                else next_state = S4;
            end
            S5: next_state = S6;
            S6:;
        endcase
    end
    assign e1e2 = e1+e2;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            mul_a <= a;
            mul_b <= b;
            rst_mul <= 0;
            done_reg <= 0;
        end
        else begin
            case(state)
                S1:begin
                    if(done_mul_256) begin
                        d <= mul_ab;
                        mul_a <= u[255:0];
                        mul_b <= mul_ab[511:256];
                        rst_mul <= 0;
                    end
                    else rst_mul <= 1;
                end
                S2:begin
                    if(done_mul_256) begin
                        e1 <= mul_ab;
                        e2 <= {d[511:256],256'd0};
                        rst_mul <= 0;
                    end
                    else rst_mul <= 1;
                end
                S3:begin
                    // e_ = e1e2>>256;
                    mul_a <= P256;
                    mul_b <= e1e2>>256;
                end
                S4:begin
                    if(done_mul_256) d_ <= mul_ab;
                    else rst_mul <= 1;
                end
                S5:begin
                    c_tmp = d-d_;
                end
                S6:begin
                    if(c_tmp>P256)
                        c_reg <= c_tmp- P256;
                    else
                        c_reg <= c_tmp;
                    done_reg <= 1;
                end
            endcase
        end
    end

    assign done = done_reg;
    assign c = c_reg;

    mul_256 mul_256(clk,rst_mul,mul_a,mul_b,mul_ab,done_mul_256);

endmodule
