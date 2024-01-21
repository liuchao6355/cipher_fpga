`timescale 1ns/1ps

`define FK_0 32'ha3b1bac6
`define FK_1 32'h56aa3350
`define FK_2 32'h677d9197
`define FK_3 32'hb27022dc

module SM4(
    input clk,
    input reset,
    input mode, // 1 is excrypt, and 0 is decrypt
    input[WIDTH-1:0] MK, // secret key
    input[WIDTH-1:0] X, //4 plain text
    output[WIDTH-1:0] Y, // cipher text
    output finish
);
    parameter WIDTH=128; // excryption length
    parameter[1:0] INTERTION_RK = 2'b00, ITERATION_X = 2'b01, FINISH = 2'b10; // 32 iteration  没有流水线，节约资源
    reg[1:0] state;

    reg[WIDTH-1:0] Y_reg;
    reg[31:0] X_0,X_1,X_2,X_3; 
    wire[31:0] X_4;
    reg[31:0] K[35:0];
    wire[31:0] K_temp;
    reg finish_reg;
    reg[5:0] counter;
    
    reg EncryptDecrypt;
    
    
    SM4_F sm4_F(X_0, X_1, X_2, X_3, K[mode?counter+4:35-counter], X_4);
    SM4_RoundKey sm4_RoundKey(K[counter], K[counter+1], K[counter+2], K[counter+3], counter, K_temp);
    // state
    always @(posedge clk) begin
        if(reset)
            state <= INTERTION_RK;        
        else begin
            case(state)
                INTERTION_RK:begin
                    if(counter == 6'd31) state <= ITERATION_X;
                    else state <= INTERTION_RK;
                end
                ITERATION_X:begin
                    if(counter == 6'd30) state <= FINISH;
                    else state <= ITERATION_X;
                end 
                FINISH:;
            endcase
        end
    end
    // counter
    always @(posedge clk) begin
        if(reset)
            counter <= 0;
        else begin
            case(state)
                INTERTION_RK:begin
                    if(counter == 6'd31) counter <= 0;
                    else counter <= counter + 1;
                end
                ITERATION_X:begin
                    if(counter == 6'd31) counter <= 0;
                    else counter <= counter + 1;
                end 
                FINISH:;
            endcase
        end
    end
    // key
    always @(posedge clk) begin
        if(reset) begin
            K[3] <= MK[31:0]^`FK_3; K[2] <= MK[63:32]^`FK_2; K[1] <= MK[95:64]^`FK_1; K[0] <= MK[127:96]^`FK_0;
        end
        else begin
            case(state)
                INTERTION_RK:begin
                    K[counter+4] <= K_temp;
                end
                FINISH:;
            endcase
        end
    end
    // Encryption iteration
    always @(posedge clk) begin
        if(reset) begin
            X_3 <= X[31:0];X_2 <= X[63:32]; X_1 <= X[95:64];X_0 <= X[127:96];
        end
        else begin
            case(state)
                ITERATION_X:begin
                    X_0 <= X_1;
                    X_1 <= X_2;
                    X_2 <= X_3;
                    X_3 <= X_4;
                end
                FINISH:begin
                    Y_reg <= {X_4,X_3,X_2,X_1};
                    finish_reg <= 1'b1;
                end
            endcase
        end
    end
    assign Y = Y_reg;
    assign finish = finish_reg;
endmodule
