`timescale 1ns/1ps

module AES_MIX_COLUMN(
    mode,
    S_0,
    S_1,
    S_2,
    S_3,
    S_0_next,
    S_1_next,
    S_2_next,
    S_3_next
);

    parameter WIDTH=32;
    input mode;
    input[WIDTH-1:0] S_0;
    input[WIDTH-1:0] S_1;
    input[WIDTH-1:0] S_2;
    input[WIDTH-1:0] S_3;
    output[WIDTH-1:0] S_0_next;
    output[WIDTH-1:0] S_1_next;
    output[WIDTH-1:0] S_2_next;
    output[WIDTH-1:0] S_3_next;
    
    AES_MIX_COLUMN_ONE mix1(mode, S_0,S_0_next);
    AES_MIX_COLUMN_ONE mix2(mode,S_1,S_1_next);
    AES_MIX_COLUMN_ONE mix3(mode,S_2,S_2_next);
    AES_MIX_COLUMN_ONE mix4(mode,S_3,S_3_next);
endmodule

module AES_MIX_COLUMN_ONE(
    input mode,
    input[WIDTH-1:0] in,
    output [WIDTH-1:0] out 
);
    reg[WIDTH-1:0] out_temp;
    parameter WIDTH = 32;
    always @(*) begin
        if(!mode)begin
            out_temp[31:24] = (in[31]?({in[30:24],1'b0}^8'b00011011):{in[30:24],1'b0}) ^ ((in[23]?({in[22:16],1'b0}^8'b00011011):{in[22:16],1'b0})^in[23:16]) ^ (in[15:8]) ^ (in[7:0]);
            out_temp[23:16] = (in[31:24]) ^ (in[23]?({in[22:16],1'b0}^8'b00011011):{in[22:16],1'b0}) ^ ((in[15]?({in[14:8],1'b0}^8'b00011011):{in[14:8],1'b0})^in[15:8]) ^ (in[7:0]);
            out_temp[15:8] =  (in[31:24]) ^ (in[23:16]) ^ (in[15]?({in[14:8],1'b0}^8'b00011011):{in[14:8],1'b0}) ^ ((in[7]?({in[6:0],1'b0}^8'b00011011):{in[6:0],1'b0})^in[7:0]);
            out_temp[7:0] =   ((in[31]?({in[30:24],1'b0}^8'b00011011):{in[30:24],1'b0})^in[31:24]) ^ (in[23:16]) ^ (in[15:8]) ^ (in[7]?({in[6:0],1'b0}^8'b00011011):{in[6:0],1'b0});
        end
        else begin
            //Ω‚√‹
            out_temp[31:24] = (16'h0e * in[31:24])^(16'h0b * in[23:16])^(16'h0d * in[15:8])^(16'h09 * in[7:0]);
            out_temp[23:16] = (16'h09 * in[31:24])^(16'h0e * in[23:16])^(16'h0b * in[15:8])^(16'h0d * in[7:0]);
            out_temp[15:8] = (16'h0d * in[31:24])^(16'h09 * in[23:16])^(16'h0e * in[15:8])^(16'h0b * in[7:0]);
            out_temp[7:0] = (16'h0b * in[31:24])^(16'h0d * in[23:16])^(16'h09 * in[15:8])^(16'h0e * in[7:0]);
        end
    end
    assign out = out_temp;
endmodule

//`timescale 1ns/1ps

//module AES_MIX_COLUMN(
//    S_0,
//    S_1,
//    S_2,
//    S_3,
//    S_0_next,
//    S_1_next,
//    S_2_next,
//    S_3_next
//);

//    parameter WIDTH=32;
//    input[WIDTH-1:0] S_0;
//    input[WIDTH-1:0] S_1;
//    input[WIDTH-1:0] S_2;
//    input[WIDTH-1:0] S_3;
//    output[WIDTH-1:0] S_0_next;
//    output[WIDTH-1:0] S_1_next;
//    output[WIDTH-1:0] S_2_next;
//    output[WIDTH-1:0] S_3_next;
    
//    AES_MIX_COLUMN_ONE mix1(S_0,S_0_next);
//    AES_MIX_COLUMN_ONE mix2(S_1,S_1_next);
//    AES_MIX_COLUMN_ONE mix3(S_2,S_2_next);
//    AES_MIX_COLUMN_ONE mix4(S_3,S_3_next);
//endmodule

//module AES_MIX_COLUMN_ONE(
//    input[WIDTH-1:0] in,
//    output[WIDTH-1:0] out 
//);
//    parameter WIDTH = 32;

//    assign out[31:24] = (in[31]?({in[30:24],1'b0}^8'b00011011):{in[30:24],1'b0}) ^ ((in[23]?({in[22:16],1'b0}^8'b00011011):{in[22:16],1'b0})^in[23:16]) ^ (in[15:8]) ^ (in[7:0]);
//    assign out[23:16] = (in[31:24]) ^ (in[23]?({in[22:16],1'b0}^8'b00011011):{in[22:16],1'b0}) ^ ((in[15]?({in[14:8],1'b0}^8'b00011011):{in[14:8],1'b0})^in[15:8]) ^ (in[7:0]);
//    assign out[15:8] =  (in[31:24]) ^ (in[23:16]) ^ (in[15]?({in[14:8],1'b0}^8'b00011011):{in[14:8],1'b0}) ^ ((in[7]?({in[6:0],1'b0}^8'b00011011):{in[6:0],1'b0})^in[7:0]);
//    assign out[7:0] =   ((in[31]?({in[30:24],1'b0}^8'b00011011):{in[30:24],1'b0})^in[31:24]) ^ (in[23:16]) ^ (in[15:8]) ^ (in[7]?({in[6:0],1'b0}^8'b00011011):{in[6:0],1'b0});
//endmodule