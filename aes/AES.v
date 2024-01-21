`timescale 1ns/1ps
// AES-128 密钥 4字，分组4字，加密10轮
// 使用串口调用，输入128bit数据，128bit密钥，输出128bit加密数据
module AES(
    clk,
    reset,
    mode,
    data_in,
    key_in,
    data_out,
    aes_done
);

    parameter WIDTH = 128;
    input clk;
    input reset;
    input mode;
    input [WIDTH-1:0] data_in;
    input[WIDTH-1:0] key_in;
    output[WIDTH-1:0] data_out;
    output aes_done;
    
    
    reg aes_done_reg;
    // 三段式状态机
    parameter IDLE=3'b000,BYTE_SUB=3'b001,ROW_SHIFT=3'b010,MIX_COLUMN=3'b011,AddRoundKey=3'b100,FINISH=3'b101,FIRST=3'b110;
    reg[2:0] state,next_state; 
    // key 一列一列存放
    reg[31:0] W_0,W_1,W_2,W_3;
    wire[31:0] W_0_next,W_1_next,W_2_next,W_3_next;
    reg[127:0] k[10:0];
    // data
    reg[31:0] S_0,S_1,S_2,S_3;
    wire[31:0] S_0_next,S_1_next,S_2_next,S_3_next;
    wire[31:0] S_0mix_next,S_1mix_next,S_2mix_next,S_3mix_next;
    //使用一个计数器，加密多少轮，状态机表示每轮中的字节代换、行移位、列混合、轮密钥加
    reg[3:0] rount_cnt;
    reg[3:0] key_expansion_cnt;
    reg key_expansion_done;
    reg flag;

    // 密钥扩展阶段
    // 密钥扩展计数器
    always @(posedge clk) begin
        if(reset)
            key_expansion_cnt <= 1;
        else if(key_expansion_cnt != 4'd11)
            key_expansion_cnt <= key_expansion_cnt + 1;
        else 
            key_expansion_cnt <= key_expansion_cnt;
    end
    always @(posedge clk) begin
        if(reset)
            key_expansion_done <= 0;
        else if(key_expansion_cnt != 4'd11)
            key_expansion_done <= 0;
        else 
            key_expansion_done <= 1;
    end
    // 密钥扩展存储
    always @(posedge clk) begin
        if(reset) begin
            k[0] <= key_in;
            {W_0,W_1,W_2,W_3} <= key_in;
        end
        else begin
                k[key_expansion_cnt] <= {W_0_next,W_1_next,W_2_next,W_3_next};
                W_0 <= W_0_next;
                W_1 <= W_1_next;
                W_2 <= W_2_next;
                W_3 <= W_3_next;
        end
    end
    // 密钥扩展
    AES_KET_EXPANSION key_expansion(W_0,W_1,W_2,W_3,key_expansion_cnt,W_0_next,W_1_next,W_2_next,W_3_next);



    // 加密轮数计数器
    always @(posedge clk) begin
        if(reset)
            rount_cnt <= 1;
        else if(key_expansion_cnt == 4'd11 && state == AddRoundKey&&rount_cnt!=4'd10)//每进行一次字节代换，并且计数未到最后一轮
            rount_cnt <= rount_cnt + 1'b1;
        else    
            rount_cnt <= rount_cnt;
    end
    //当前阶段的值存放在next中，在下一周期赋给S or W
    always @(posedge clk) begin
        if(reset)
            state <= IDLE;
        else begin
            if(key_expansion_done && state == IDLE)
                state <= FIRST;
            else if(key_expansion_done && state != IDLE) begin
//                $display(state);
                state <= next_state;
            end
            else
                state <=IDLE;
        end
    end
    
    always @(*) begin    
        if(reset) begin
            next_state = IDLE;
        end
        else begin
            case(state)
                FIRST: next_state = BYTE_SUB;
                BYTE_SUB:begin
                    next_state = ROW_SHIFT;
                end
                ROW_SHIFT: begin
                    if(rount_cnt == 4'd10)
                        next_state = AddRoundKey;
                    else
                        next_state = MIX_COLUMN;
                end
                MIX_COLUMN:begin
                    next_state = AddRoundKey;
                end
                AddRoundKey: begin
                    if(flag)
                        next_state = FINISH;
                    else if(rount_cnt == 4'd10) begin
                        flag = 1'b1;
                        next_state = FINISH;
                    end
                    else
                        next_state = BYTE_SUB;
                end
                default:;
            endcase
        end
    end
    
    //字节代换，以列传入，32bit
    AES_BYTE_SUB byte_sub(mode,S_0,S_1,S_2,S_3,S_0_next,S_1_next,S_2_next,S_3_next);
    // 列混合 ,S_1_next由byte和mix共同驱动，导致x状态
    AES_MIX_COLUMN mix_column(mode,S_0,S_1,S_2,S_3,S_0mix_next,S_1mix_next,S_2mix_next,S_3mix_next);

    // 逆列混合
    wire[31:0] k_inv_mixcolumn_1,k_inv_mixcolumn_2,k_inv_mixcolumn_3,k_inv_mixcolumn_4;
    AES_MIX_COLUMN mix_column_key(mode,k[10-rount_cnt][127:96],k[10-rount_cnt][95:64],k[10-rount_cnt][63:32],k[10-rount_cnt][31:0],k_inv_mixcolumn_1,k_inv_mixcolumn_2,k_inv_mixcolumn_3,k_inv_mixcolumn_4);


    always @(posedge clk) begin
        if(reset) begin
            //进行一次轮密钥加
            flag <= 1'b0;//未进入第10轮
            aes_done_reg <= 1'b0;
        end
        else begin
            case(state)
                FIRST:{S_0,S_1,S_2,S_3} <= data_in ^ (mode?k[10]:k[0]);
                BYTE_SUB:begin
                    S_0 <= S_0_next;
                    S_1 <= S_1_next;
                    S_2 <= S_2_next;
                    S_3 <= S_3_next;
                end
                ROW_SHIFT: begin
                    if(!mode) begin
                        // mode=0,加密
                        S_0 <= {S_0[31:24],S_1[23:16],S_2[15:8],S_3[7:0]}; 
                        S_1 <= {S_1[31:24],S_2[23:16],S_3[15:8],S_0[7:0]};
                        S_2 <= {S_2[31:24],S_3[23:16],S_0[15:8],S_1[7:0]};
                        S_3 <= {S_3[31:24],S_0[23:16],S_1[15:8],S_2[7:0]};
                    end
                    else begin
                        S_0 <= {S_0[31:24],S_3[23:16],S_2[15:8],S_1[7:0]}; 
                        S_1 <= {S_1[31:24],S_0[23:16],S_3[15:8],S_2[7:0]};
                        S_2 <= {S_2[31:24],S_1[23:16],S_0[15:8],S_3[7:0]};
                        S_3 <= {S_3[31:24],S_2[23:16],S_1[15:8],S_0[7:0]};
                    end
                end
                MIX_COLUMN:begin
                    S_0 <= S_0mix_next;
                    S_1 <= S_1mix_next;
                    S_2 <= S_2mix_next;
                    S_3 <= S_3mix_next;
                end
                AddRoundKey: begin
                    if(!mode) begin
                        S_0 <= S_0 ^ k[rount_cnt][127:96];
                        S_1 <= S_1 ^ k[rount_cnt][95:64];
                        S_2 <= S_2 ^ k[rount_cnt][63:32];
                        S_3 <= S_3 ^ k[rount_cnt][31:0];
                    end
                    else begin
                        S_0 <= S_0 ^ ((rount_cnt==10)?k[0][127:96]:k_inv_mixcolumn_1);
                        S_1 <= S_1 ^ ((rount_cnt==10)?k[0][95:64]:k_inv_mixcolumn_2);
                        S_2 <= S_2 ^ ((rount_cnt==10)?k[0][63:32]:k_inv_mixcolumn_3);
                        S_3 <= S_3 ^ ((rount_cnt==10)?k[0][31:0]:k_inv_mixcolumn_4);
                    end
                end
                FINISH: begin
                    aes_done_reg = 1'b1;
                end
                default:;
            endcase
        end
    end
    assign aes_done = aes_done_reg;
    assign data_out = aes_done?{S_0,S_1,S_2,S_3}:32'd0;

endmodule



//`timescale 1ns/1ps
//// AES-128 密钥 4字，分组4字，加密10轮
//// 使用串口调用，输入128bit数据，128bit密钥，输出128bit加密数据
//module AES(
//    clk,
//    reset,
//    mode,
//    data_in,
//    key_in,
//    data_out,
//    aes_done
//);

//    parameter WIDTH = 128;
//    input clk;
//    input reset;
//    input mode;
//    input [WIDTH-1:0] data_in;
//    input[WIDTH-1:0] key_in;
//    output[WIDTH-1:0] data_out;
//    output aes_done;
    
    
//    reg aes_done_reg;
//    // 三段式状态机
//    parameter IDLE=3'b000,BYTE_SUB=3'b001,ROW_SHIFT=3'b010,MIX_COLUMN=3'b011,AddRoundKey=3'b100,FINISH=3'b101,FIRST=3'b110;
//    reg[2:0] state,next_state; 
//    // key 一列一列存放
//    reg[31:0] W_0,W_1,W_2,W_3;
//    wire[31:0] W_0_next,W_1_next,W_2_next,W_3_next;
//    reg[127:0] k[10:0];
//    // data
//    reg[31:0] S_0,S_1,S_2,S_3;
//    wire[31:0] S_0_next,S_1_next,S_2_next,S_3_next;
//    wire[31:0] S_0mix_next,S_1mix_next,S_2mix_next,S_3mix_next;
//    //使用一个计数器，加密多少轮，状态机表示每轮中的字节代换、行移位、列混合、轮密钥加
//    reg[3:0] rount_cnt;
//    reg[3:0] key_expansion_cnt;
//    reg key_expansion_done;
//    reg flag;

//    // 密钥扩展阶段
//    // 密钥扩展计数器
//    always @(posedge clk) begin
//        if(reset)
//            key_expansion_cnt <= 1;
//        else if(key_expansion_cnt != 4'd11)
//            key_expansion_cnt <= key_expansion_cnt + 1;
//        else 
//            key_expansion_cnt <= key_expansion_cnt;
//    end
//    always @(posedge clk) begin
//        if(reset)
//            key_expansion_done <= 0;
//        else if(key_expansion_cnt != 4'd11)
//            key_expansion_done <= 0;
//        else 
//            key_expansion_done <= 1;
//    end
//    // 密钥扩展存储
//    always @(posedge clk) begin
//        if(reset) begin
//            k[0] <= key_in;
//            {W_0,W_1,W_2,W_3} <= key_in;
//        end
//        else begin
//                k[key_expansion_cnt] <= {W_0_next,W_1_next,W_2_next,W_3_next};
//                W_0 <= W_0_next;
//                W_1 <= W_1_next;
//                W_2 <= W_2_next;
//                W_3 <= W_3_next;
//        end
//    end
//    // 密钥扩展
//    AES_KET_EXPANSION key_expansion(W_0,W_1,W_2,W_3,key_expansion_cnt,W_0_next,W_1_next,W_2_next,W_3_next);



//    // 加密轮数计数器
//    always @(posedge clk) begin
//        if(reset)
//            rount_cnt <= 1;
//        else if(key_expansion_cnt == 4'd11 && state == AddRoundKey&&rount_cnt!=4'd10)//每进行一次字节代换，并且计数未到最后一轮
//            rount_cnt <= rount_cnt + 1'b1;
//        else    
//            rount_cnt <= rount_cnt;
//    end
//    //当前阶段的值存放在next中，在下一周期赋给S or W
//    always @(posedge clk) begin
//        if(reset)
//            state <= IDLE;
//        else 
//            if(key_expansion_done && state == IDLE)
//                state <= FIRST;
//            else if(key_expansion_done && state != IDLE)
//                state <= next_state;
//            else
//                state <=IDLE;
//    end
    
//    always @(*) begin    
//        if(reset) begin
//            next_state = IDLE;
//        end
//        else begin
//            case(state)
//                FIRST: next_state = BYTE_SUB;
//                BYTE_SUB:begin
//                    next_state = ROW_SHIFT;
//                end
//                ROW_SHIFT: begin
//                    if(rount_cnt == 4'd10)
//                        next_state = AddRoundKey;
//                    else
//                        next_state = MIX_COLUMN;
//                end
//                MIX_COLUMN:begin
//                    next_state = AddRoundKey;
//                end
//                AddRoundKey: begin
//                    if(flag)
//                        next_state = FINISH;
//                    else if(rount_cnt == 4'd10) begin
//                        flag = 1'b1;
//                        next_state = FINISH;
//                    end
//                    else
//                        next_state = BYTE_SUB;
//                end
//                default:;
//            endcase
//        end
//    end
    
//    //字节代换，以列传入，32bit
//    AES_BYTE_SUB byte_sub(S_0,S_1,S_2,S_3,S_0_next,S_1_next,S_2_next,S_3_next);
//    // 列混合 ,S_1_next由byte和mix共同驱动，导致x状态
//    AES_MIX_COLUMN mix_column(S_0,S_1,S_2,S_3,S_0mix_next,S_1mix_next,S_2mix_next,S_3mix_next);

//    always @(posedge clk) begin
//        if(reset) begin
//            //进行一次轮密钥加
//            flag <= 1'b0;//未进入第10轮
//            aes_done_reg <= 1'b0;
//        end
//        else begin
//            case(state)
//                FIRST:{S_0,S_1,S_2,S_3} <= data_in ^ k[0];
//                BYTE_SUB:begin
//                    S_0 <= S_0_next;
//                    S_1 <= S_1_next;
//                    S_2 <= S_2_next;
//                    S_3 <= S_3_next;
//                end
//                ROW_SHIFT: begin
//                    S_0 <= {S_0[31:24],S_1[23:16],S_2[15:8],S_3[7:0]}; 
//                    S_1 <= {S_1[31:24],S_2[23:16],S_3[15:8],S_0[7:0]};
//                    S_2 <= {S_2[31:24],S_3[23:16],S_0[15:8],S_1[7:0]};
//                    S_3 <= {S_3[31:24],S_0[23:16],S_1[15:8],S_2[7:0]};
//                end
//                MIX_COLUMN:begin
//                    S_0 <= S_0mix_next;
//                    S_1 <= S_1mix_next;
//                    S_2 <= S_2mix_next;
//                    S_3 <= S_3mix_next;
//                end
//                AddRoundKey: begin
//                    S_0 <= S_0 ^ k[rount_cnt][127:96];
//                    S_1 <= S_1 ^ k[rount_cnt][95:64];
//                    S_2 <= S_2 ^ k[rount_cnt][63:32];
//                    S_3 <= S_3 ^ k[rount_cnt][31:0];
//                end
//                FINISH: begin
//                    aes_done_reg = 1'b1;
//                end
//                default:;
//            endcase
//        end
//    end
//    assign aes_done = aes_done_reg;
//    assign data_out = aes_done?{S_0,S_1,S_2,S_3}:32'd0;

//endmodule