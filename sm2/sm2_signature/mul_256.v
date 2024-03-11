// `timescale 1ns / 1ps

// module mul_256(
//     input clk,
//     input rst_n,
//     input [255:0] a,
//     input [255:0] b,
//     output [511:0] c,
//     output done
//     );

//     wire [127:0] a0,a1,b1,b0;
//     wire [255:0] P0,P1,P2,P3;

//     assign {a1,a0} = a;
//     assign {b1,b0} = b;

//     reg rst_1,rst_2,rst_3,rst_4;
//     wire done_1,done_2,done_3,done_4;

//     always @(posedge clk or negedge rst_n) begin
//         if(!rst_n) begin
//             rst_1 <= 0;
//             rst_2 <= 0;
//             rst_3 <= 0;
//             rst_4 <= 0;
//         end
//         else begin
//             rst_1 <= 1;
//             rst_2 <= 1;
//             rst_3 <= 1;
//             rst_4 <= 1;
//         end
//     end

//     mul_128 mul_128_1(clk,rst_1,a0,b0,P0,done_1);
//     mul_128 mul_128_2(clk,rst_2,a1,b1,P1,done_2);
//     mul_128 mul_128_3(clk,rst_3,a1,b0,P2,done_3);
//     mul_128 mul_128_4(clk,rst_4,a0,b1,P3,done_4);
//     assign done = done_1==1&done_2==1&done_3==1&done_4==1;
//     assign c = done?({P1,256'd0} + {P2+P3,128'd0} + {256'd0,P0}):0;

// endmodule



module mul_256(
    input clk,
    input rst_n,
    input [255:0] a,
    input [255:0] b,
    output [511:0] c,
    output done
    );

    wire [127:0] a0,b0,a1,b1;
    reg [255:0] P0,P1,P2,P3;
    wire [255:0] P_out;
    wire [511:0] c_reg;
    reg done_reg;

    reg rst_128;
    wire done_128;

    reg [127:0] aa,bb;

    assign {a1,a0} = a;
    assign {b1,b0} = b;

    parameter IDLE=3'd0,ROUND1=3'd1,ROUND2=3'd2,ROUND3=3'd3,ROUND4=3'd5,FINISH=3'd6;
    reg[2:0] state,next_state;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            state <= IDLE;
        else 
            state <= next_state;
    end
    always @(*) begin
        case(state)
            IDLE: begin 
                if(done_128) next_state = ROUND1;
                else next_state = IDLE;
            end
            ROUND1:begin 
                if(done_128) next_state = ROUND2;
                else next_state = ROUND1;
            end
            ROUND2:begin 
                if(done_128) next_state = ROUND3;
                else next_state = ROUND2;
            end
            ROUND3:begin 
                if(done_128) next_state = ROUND4;
                else next_state = ROUND3;
            end
            ROUND4:;
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            aa <= a0;
            bb <= b0;
            rst_128 <=0;
            done_reg <= 0;
        end
        else begin
            case (state)
                IDLE: begin
                    if(done_128) begin
                        P0 <= P_out;
                        aa <= a1;
                        bb <= b1; 
                        rst_128 <= 0;
                    end 
                    else 
                        rst_128 <= 1;
                    done_reg <= 0;
                end
                 ROUND1: begin
                    if(done_128) begin
                        P1 <= P_out;
                        aa <= a1;
                        bb <= b0;
                        rst_128 <= 0; 
                    end
                    else
                        rst_128 <= 1;
                    done_reg <= 0;
                 end
                 ROUND2: begin
                    if(done_128) begin
                        P2 <= P_out;
                        aa <= a0;
                        bb <= b1; 
                        rst_128 <= 0;
                    end
                    else
                        rst_128 <= 1;
                    done_reg <= 0;
                 end
                 ROUND3: begin
                    if(done_128) begin
                        P3 <= P_out;
                        done_reg <= 1;
                    end
                    else
                        rst_128 <= 1;
                 end
                 ROUND4: begin
                    // done_reg <= 1;
                 end
            endcase
        end     
    end
    // wire [255:0] P0_ref,P1_ref,P2_ref,P3_ref;
    // assign P0_ref = a0*b0;
    // assign P1_ref = a1*b1;
    // assign P2_ref = a1*b0;
    // assign P3_ref = a0*b1;


    mul_128 mul_128(clk,rst_128,aa,bb,P_out,done_128);
    
    wire [256:0] P2P3 = P2+P3; 
    assign done = done_reg;
    assign c = done?({P1,256'd0} + {127'd0,P2P3,128'd0} + {256'd0,P0}):0;

endmodule