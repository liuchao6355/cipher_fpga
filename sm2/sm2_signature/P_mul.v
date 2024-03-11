`timescale 1ns / 1ps

module P_mul(
    input clk,
    input rst_n,
    input [255:0] k,
    input [255:0] Gx,
    input [255:0] Gy,
    output [255:0] x_out,
    output [255:0] y_out,
    output done
    );

    // parameter p = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_FFFFFFFF_00000000_FFFFFFFF_FFFFFFFF;
    // parameter a = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_FFFFFFFF_00000000_FFFFFFFF_FFFFFFFC;
    // parameter b = 256'h28E9FA9E_9D9F5E34_4D5A9E4B_CF6509A7_F39789F5_15AB8F92_DDBCBD41_4D940E93;
    // parameter n = 256'hFFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_7203DF6B_21C6052B_53BBF409_39D54123;
    // parameter Gx = 256'h32C4AE2C_1F198119_5F990446_6A39C994_8FE30BBF_F2660BE1_715A4589_334C74C7;
    // parameter Gy = 256'hBC3736A2_F4F6779C_59BDCEE3_6B692153_D0A9877C_C62A4740_02DF32E5_2139F0A0;

    parameter IDLE = 4'd0, INT=4'd1,S0=4'd2,S1 = 4'd3, S2 = 4'd4,INT2=4'd5,CVT=4'd6,FINISH=4'd7;
    reg [3:0] state, next_state;
    // reg [255:0] k;
    
    reg [8:0] count;

    reg [255:0] PA_x1,PA_x2,PA_z1,PA_z2,PD_x,PD_z;
    reg rst_PA,rst_PD;
    wire [255:0] PA_x_out,PA_z_out,PD_x_out,PD_z_out;
    wire done_PA, done_PD;
    reg rst_inv;
    reg [255:0] inv_a, inv_p;
    wire [255:0] inv_b;
    wire done_inv;
    reg rst_convert;
    reg [255:0] X1_cvt,Z1_cvt,X2_cvt,Z2_cvt;
    wire [255:0] x_out_cvt,y_out_cvt;
    wire done_convert;


    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            state <= IDLE;
        else        
            state <= next_state;
    end

    always @(*) begin
        case(state)
            IDLE:begin
                if(k[count]==1'b1)
                    next_state = INT;
                else 
                    next_state = IDLE;//找到第一个为1的bit位 
            end
            INT:begin
                //初始化R0,R1
                if(done_PD)
                    next_state = S0;
                else
                    next_state = INT;
            end
            S0: begin
                //while判断
                if(count==(9'd0-9'd1))
                    next_state = INT2;
                else 
                    next_state <= S1;
            end
            S1: begin
                next_state <= S2;
            end
            S2: begin
                if(done_PA&done_PD)
                    next_state <= S0;
                else
                    next_state <= S2;
            end
            INT2:next_state <= CVT;
            CVT:begin
                if(done_convert)
                    next_state <= FINISH;
                else
                    next_state <= CVT;
            end
            FINISH:;
        endcase
    end

    reg [255:0] R0_x,R0_z,R1_x,R1_z;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            count <= 9'd255;
            done_reg <= 0;
        end
        else begin
            case(state)
                IDLE:begin
                    //找到第一个为1的bit位 
                    if(k[count]==1'b1)begin
                        R0_x <= Gx;
                        R0_z <= 256'd1;
                        count <= count - 1'b1;
                        
                        //计算R1
                        rst_PD <= 1'b0;
                        PD_x <= Gx;
                        PD_z <= 256'd1;
                    end 
                    else  count <= count - 1'b1; 
                end
                INT:begin
                    // R0,R1
                    if(done_PD)begin
                        R1_x <= PD_x_out;
                        R1_z <= PD_z_out;
                    end
                    else rst_PD <= 1;
                end
                S0:begin
                    rst_PA <= 1'b0;
                    rst_PD <= 1'b0;
                    if(k[count]==1'b0) begin
                        PD_x <= R0_x;
                        PD_z <= R0_z;
                    end
                    else begin
                        PD_x <= R1_x;
                        PD_z <= R1_z;
                    end
                    PA_x1 <= R0_x;
                    PA_z1 <= R0_z;
                    PA_x2 <= R1_x;
                    PA_z2 <= R1_z;
                end
                S1:begin
                    rst_PA <= 1'b1;
                    rst_PD <= 1'b1;
                end
                S2:begin
                    if(done_PA&done_PD) begin
                        if(k[count]==1'b0) begin
                            R1_x <= PA_x_out;
                            R1_z <= PA_z_out;
                            R0_x <= PD_x_out;
                            R0_z <= PD_z_out;
                        end
                        else begin
                            R1_x <= PD_x_out;
                            R1_z <= PD_z_out;
                            R0_x <= PA_x_out;
                            R0_z <= PA_z_out;
                        end
                        count <= count - 1'b1;
                    end
                end
                INT2:begin
                    rst_convert <= 0;
                    X1_cvt <= R0_x;
                    Z1_cvt <= R0_z;
                    X2_cvt <= R1_x;
                    Z2_cvt <= R1_z;
                end
                CVT:begin
                    if(done_convert)begin
                        x_out_reg <= x_out_cvt;
                        y_out_reg <= y_out_cvt;
                    end
                    else
                        rst_convert <= 1;
                end
                FINISH: done_reg <= 1;
            endcase
        end
    end
    reg [255:0] x_out_reg,y_out_reg;
    reg done_reg;

    assign done = done_reg;
    assign x_out = x_out_reg;
    assign y_out = y_out_reg;

    PA PA(clk,rst_PA,PA_x1,PA_x2,PA_z1,PA_z2,Gx,PA_x_out,PA_z_out,done_PA);

    PD PD(clk,rst_PD,PD_x,PD_z,PD_x_out,PD_z_out,done_PD);

    convert_coordinate convert_coordinate(clk,rst_convert,X1_cvt,Z1_cvt,X2_cvt,Z2_cvt,Gx,Gy,x_out_cvt,y_out_cvt,done_convert);




endmodule
