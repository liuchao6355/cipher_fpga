`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/21 11:45:52
// Design Name: 
// Module Name: zuc
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


module zuc(
    input clk,
    input rst_n,
    input [127:0] k,
    input [127:0] iv,
    input [7:0] L,
    output [7:0] L_out, // which Z
    output done, // 输出一个z，发出一个done=1，然后置0
    output [31:0] Z
    );

    reg [30:0] s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15;
    wire[30:0] s16;
    reg lfsr_mode;
    reg [31:0] X0,X1,X2,X3;
    wire [31:0] X0_reg,X1_reg,X2_reg, X3_reg;
    reg [31:0] R1,R2;
    wire [31:0] R1_reg,R2_reg;
    reg [31:0] W;
    wire [31:0] W_reg;
    reg [31:0] Z_reg; 
    reg done_reg;

    parameter IDLE=4'd0,INIT_BITRE=4'd1,INIT_F=4'd2,INIT_LFSR=4'd3,
              WORK_A_BITRE=4'd4,WORK_A_F=4'd5,WORK_A_LFSR=4'd6,
              WORK_B_BITRE=4'd7,WORK_B_F=4'd8,WORK_B_LFSR=4'd9,
              FINISH=4'd10;
    reg[3:0] state, next_state;

    
    reg[7:0] cnt;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            cnt <= 8'd0;
        else begin
            if(state==INIT_LFSR|state==WORK_B_LFSR)
                cnt <= cnt + 1'b1;
            else if(state==IDLE|state==WORK_A_LFSR)
                cnt <= 8'd0;
            else
                cnt <= cnt;
        end
    end

    //FSM-1
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            state <= IDLE;
        else
            state <= next_state;
    end
    //FSM-2
    always @(*) begin
        if(!rst_n)
            next_state <= IDLE;
        else begin
            case(state)
                IDLE:
                    next_state <= INIT_BITRE;
                INIT_BITRE:
                    next_state <=INIT_F;
                INIT_F:begin
                    // if(add1clk)
                    //     next_state <= INIT_F;
                    // else
                        next_state <= INIT_LFSR;
                end
                INIT_LFSR: begin
                    if(cnt==31)
                        next_state <= WORK_A_BITRE;
                    else
                        next_state <= INIT_BITRE;
                end
                WORK_A_BITRE:
                    next_state <= WORK_A_F;
                WORK_A_F:
                    next_state <= WORK_A_LFSR;
                WORK_A_LFSR:
                    next_state <= WORK_B_BITRE;
                WORK_B_BITRE:
                    next_state <= WORK_B_F;
                WORK_B_F:
                    next_state <= WORK_B_LFSR;
                WORK_B_LFSR: begin
                    if(cnt==L-1)
                        next_state <= FINISH;
                    else
                        next_state <= WORK_B_BITRE;
                end
                FINISH:;
            endcase
        end
    end
    reg add1clk;
    // FSM-3
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            s0<=0;s1<=0;s2<=0;s3<=0;s4<=0;s5<=0;s6<=0;s7<=0;s8<=0;s9<=0;s10<=0;s11<=0;s12<=0;s13<=0;s14<=0;s15<=0; 
            R1<=0;R2<=0;
        end
        else begin
            case(state)
                IDLE:begin
                    s0<={k[127:120],15'b100010011010111,iv[127:120]};
                    s1<={k[119:112],15'b010011010111100,iv[119:112]};
                    s2<={k[111:104],15'b110001001101011,iv[111:104]};
                    s3<={k[103:96],15'b001001101011110,iv[103:96]};
                    s4<={k[95:88],15'b101011110001001,iv[95:88]};
                    s5<={k[87:80],15'b011010111100010,iv[87:80]};
                    s6<={k[79:72],15'b111000100110101,iv[79:72]};
                    s7<={k[71:64],15'b000100110101111,iv[71:64]};
                    s8<={k[63:56],15'b100110101111000,iv[63:56]};
                    s9<={k[55:48],15'b010111100010011,iv[55:48]};
                    s10<={k[47:40],15'b110101111000100,iv[47:40]};
                    s11<={k[39:32],15'b001101011110001,iv[39:32]};
                    s12<={k[31:24],15'b101111000100110,iv[31:24]};
                    s13<={k[23:16],15'b011110001001101,iv[23:16]};
                    s14<={k[15:8],15'b111100010011010,iv[15:8]};
                    s15<={k[7:0],15'b100011110101100,iv[7:0]};
                    R1 <= 0;
                    R2 <= 0;
                end
                INIT_BITRE: begin
                    X0 <= X0_reg;
                    X1 <= X1_reg;
                    X2 <= X2_reg;
                    X3 <= X3_reg;
                    // add1clk <= 1;
                end
                INIT_F:begin
                    // if(add1clk) add1clk <= 0;
                    W <= W_reg;
                    R1 <= R1_reg;
                    R2 <= R2_reg;
                    lfsr_mode <= 1'b1;// initial mode
                end
                INIT_LFSR: begin
                    {s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15} <= {s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16};
                end
                WORK_A_BITRE: begin
                    X0 <= X0_reg;
                    X1 <= X1_reg;
                    X2 <= X2_reg;
                    X3 <= X3_reg;
                end
                WORK_A_F: begin
                    R1 <= R1_reg;
                    R2 <= R2_reg;
                    lfsr_mode <= 1'b0;// work mode
                end
                WORK_A_LFSR:begin
                    {s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15} <= {s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16};      
                end
                WORK_B_BITRE: begin
                    X0 <= X0_reg;
                    X1 <= X1_reg;
                    X2 <= X2_reg;
                    X3 <= X3_reg;
                    done_reg <= 0;
                end
                WORK_B_F:begin
                    Z_reg <= W_reg^X3;
                    done_reg <= 1;
                    R1 <= R1_reg;
                    R2 <= R2_reg;
                    lfsr_mode <= 1'b0;// work mode
                end
                WORK_B_LFSR: begin
                    done_reg <= 0;
                    {s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15} <= {s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16};
                end
                FINISH:;
            endcase
        end
    end
    assign Z = done?Z_reg:0;
    assign done = done_reg;
    assign L_out = cnt;
    BitReconstruction BitReconstruction(
        .s15(s15),.s14(s14),.s11(s11),.s9(s9),.s7(s7),.s5(s5),.s2(s2),.s0(s0),
        .X0(X0_reg),.X1(X1_reg),.X2(X2_reg),.X3(X3_reg)
    );

    F_func F_func(
        .X0(X0),.X1(X1),.X2(X2),.R1(R1),.R2(R2),
        .W(W_reg),.R1out(R1_reg),.R2out(R2_reg)
    );

    LFSR LFSR(
        .lfsr_mode(lfsr_mode),.s15(s15),.s13(s13),.s10(s10),.s4(s4),.s0(s0),.u(W[31:1]),
        .s16(s16)
    );
endmodule
