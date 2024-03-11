// `timescale 1ns / 1ps

// // 模约减
// // P256 = 260'h0_fffffffe_ffffffff_ffffffff_ffffffff_ffffffff_00000000_ffffffff_ffffffff;

// module mod_re(
//     input [511:0] C,
//     output [255:0] R
//     );

//     parameter P256 = 260'h0_fffffffe_ffffffff_ffffffff_ffffffff_ffffffff_00000000_ffffffff_ffffffff;
//     // parameter P256 = 260'h0_FFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_7203DF6B_21C6052B_53BBF409_39D54123;
//     parameter P256_2 = 2*P256;
//     parameter P256_3 = 3*P256;
//     parameter P256_4 = 4*P256;
//     parameter P256_5 = 5*P256;
//     parameter P256_6 = 6*P256;
//     parameter P256_7 = 7*P256;
//     parameter P256_8 = 8*P256;
//     parameter P256_9 = 9*P256;
//     parameter P256_10 = 10*P256;
//     parameter P256_11 = 11*P256;
//     parameter P256_12 = 12*P256;
//     parameter P256_13 = 13*P256;
//     parameter P256_14 = 14*P256;
//     reg carry1;wire carry2;
//     reg [259:0] result1;wire [259:0] result2;
//     wire [255:0] s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14;
//     wire[31:0] c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15;
//     wire [259:0] r;
//     assign {c15,c14,c13,c12,c11,c10,c9,c8,c7,c6,c5,c4,c3,c2,c1,c0} = C;
//     assign s1 = {c7,c6,c5,c4,c3,c2,c1,c0};
//     assign s2 = {c15,c14,c13,c12,c11,32'h0,c9,c8};
//     assign s3 = {c14,32'h0,c15,c14,c13,32'h0,c14,c13};
//     assign s4 = {c13,32'h0,32'h0,32'h0,32'h0,32'h0,c15,c14};
//     assign s5 = {c12,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,c15};
//     assign s6 = {c11,c11,c10,c15,c14,32'h0,c13,c12};
//     assign s7 = {c10,c15,c14,c13,c12,32'h0,c11,c10};
//     assign s8 = {c9,32'h0,32'h0,c9,c8,32'h0,c10,c9};
//     assign s9 = {c8,32'h0,32'h0,32'h0,c15,32'h0,c12,c11};
//     assign s10 = {c15,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0};
//     assign s11 = {32'h0,32'h0,32'h0,32'h0,32'h0,c14,32'h0,32'h0};
//     assign s12 = {32'h0,32'h0,32'h0,32'h0,32'h0,c13,32'h0,32'h0};
//     assign s13 = {32'h0,32'h0,32'h0,32'h0,32'h0,c9,32'h0,32'h0};
//     assign s14 = {32'h0,32'h0,32'h0,32'h0,32'h0,c8,32'h0,32'h0};
//     assign r = s1+s2+s3+s3+s4+s4+s5+s5+s6+s7+s8+s9+s10+s10-s11-s12-s13-s14;   
//     always @(*) begin
//         case(r[259:256])
//                     3'd0:{carry1,result1} = r;
//                     3'd1:{carry1,result1} = r-P256;
//                     3'd2:{carry1,result1} = r-P256_2;
//                     3'd3:{carry1,result1} = r-P256_3;
//                     3'd4:{carry1,result1} = r-P256_4;
//                     3'd5:{carry1,result1} = r-P256_5;
//                     3'd6:{carry1,result1} = r-P256_6;
//                     3'd7:{carry1,result1} = r-P256_7;
//                     3'd8:{carry1,result1} = r-P256_8;
//                     3'd9:{carry1,result1} = r-P256_9;
//                     3'd10:{carry1,result1} = r-P256_10;
//                     3'd11:{carry1,result1} = r-P256_11;
//                     3'd12:{carry1,result1} = r-P256_12;
//                     3'd13:{carry1,result1} = r-P256_13;
//                     3'd14:{carry1,result1} = r-P256_14;
//                 endcase
//     end
//     assign {carry2,result2} = result1-P256;
//     assign R = carry1?result2[255:0]:result1[255:0];
//     assign done = 1;

// endmodule




// // `timescale 1ns / 1ps

// // // 模约减
// // //论文：基于国密算法加密技术的SoC设计与优化
// // // (c+x) mod p256

// // module mod_re(
// //     input clk,
// //     input rst_n,
// //     input [511:0] C,
// //     input [255:0] X,
// //     output [255:0] R,
// //     output done
// //     );

// //     reg[255:0] P256 = 256'hfffffffe_ffffffff_ffffffff_ffffffff_ffffffff_00000000_ffffffff_ffffffff;

// //     wire [255:0] s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14;
// //     reg [255:0] s15,s16,s17;
// //     wire[31:0] c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15;
// //     reg [287:0] r;
// //     wire [31:0] r0,r1,r2,r3,r4,r5,r6,r7,r8;
// //     reg done_reg;
// //     assign {c15,c14,c13,c12,c11,c10,c9,c8,c7,c6,c5,c4,c3,c2,c1,c0} = C;

// //     assign s1 = {c7,c6,c5,c4,c3,c2,c1,c0};
// //     assign s2 = {c15,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0};
// //     assign s3 = {c12,32'h0,c15,c14,32'h0,32'h0,32'h0,c13};
// //     assign s4 = {c13,32'h0,32'h0,32'h0,32'h0,32'h0,c14,c15};
// //     assign s5 = {c14,32'h0,32'h0,32'h0,c13,32'h0,c15,c14};
// //     assign s6 = {c8,c11,c13,c15,c14,32'h0,c9,c10};
// //     assign s7 = {c9,c14,c10,c13,c8,32'h0,c11,c12};
// //     assign s8 = {c11,32'h0,32'h0,c9,c12,0,c10,c9};
// //     assign s9 = {c10,c15,c14,c12,c11,32'h0,c13,c8};
// //     assign s10 = {32'h0,32'h0,32'h0,32'h0,c15,32'h0,c12,c11};
// //     assign s11 = {32'h0,32'h0,32'h0,32'h0,32'h0,c8,32'h0,32'h0};
// //     assign s12 = {32'h0,32'h0,32'h0,32'h0,32'h0,c9,32'h0,32'h0};
// //     assign s13 = {32'h0,32'h0,32'h0,32'h0,32'h0,c13,32'h0,32'h0};
// //     assign s14 = {32'h0,32'h0,32'h0,32'h0,32'h0,c14,32'h0,32'h0};
    
    
// //     // assign s1 = {c7,c6,c5,c4,c3,c2,c1,c0};
// //     // assign s2 = {c15,c14,c13,c12,c11,32'h0,c9,c8};
// //     // assign s3 = {c14,32'h0,c15,c14,c13,32'h0,c14,c13};
// //     // assign s4 = {c13,32'h0,32'h0,32'h0,32'h0,32'h0,c15,c14};
// //     // assign s5 = {c12,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,c15};
// //     // assign s6 = {c11,c11,c10,c15,c14,32'h0,c13,c12};
// //     // assign s7 = {c10,c15,c14,c13,c12,32'h0,c11,c10};
// //     // assign s8 = {c9,32'h0,32'h0,c9,c8,32'h0,c10,c9};
// //     // assign s9 = {c8,32'h0,32'h0,32'h0,c15,32'h0,c12,c11};
// //     // assign s10 = {c15,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0};
// //     // assign s11 = {32'h0,32'h0,32'h0,32'h0,32'h0,c14,32'h0,32'h0};
// //     // assign s12 = {32'h0,32'h0,32'h0,32'h0,32'h0,c13,32'h0,32'h0};
// //     // assign s13 = {32'h0,32'h0,32'h0,32'h0,32'h0,c9,32'h0,32'h0};
// //     // assign s14 = {32'h0,32'h0,32'h0,32'h0,32'h0,c8,32'h0,32'h0};
// //     assign {r8,r7,r6,r5,r4,r3,r2,r1,r0} = r;
// //     always @(posedge clk or negedge rst_n) begin
// //         if(!rst_n) begin
// //             done_reg <= 0;
// //             // R_tmp <= s1+s2+2*(s3+s4+s5+s10)+s6+s7+s8+s9-s11-s12-s13-s14;
// //             r <= s1+s2+s2+s2+s3+s3+s4+s4+s5+s5+s6+s7+s8+s9+s10-s11-s12-s13-s14-X+P256;
// //         end
// //         else begin
// //             s15 <= {r7,r6,r5,r4,r3,r2,r1,r0};
// //             s16 <= {r8,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0};
// //             s17 <= {32'h0,32'h0,32'h0,32'h0,32'h0,r8,32'h0,32'h0};
// //             // R_reg <= R_tmp>=P256?(R_tmp-P256):R_tmp[255:0];
// //             done_reg <= 1;
// //         end
// //     end
// //     wire [256:0] R2;
// //     assign R2 = s15+s16-s17;
// //     assign done = done_reg;
// //     assign R = done?((R2>=P256)?(R2-P256):(R2)):0;
// //     // assign R = R_reg;

// // endmodule





// // `timescale 1ns / 1ps

// // // 模约减
// // //论文：基于国密算法加密技术的SoC设计与优化
// // // (c+x) mod p256

// // module mod_re(
// //     input clk,
// //     input rst_n,
// //     input [511:0] C,
// //     output [255:0] R,
// //     output done
// //     );

// //     parameter P256 = 288'h00000000_fffffffe_ffffffff_ffffffff_ffffffff_ffffffff_00000000_ffffffff_ffffffff;

// //     wire [255:0] s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14;
// //     wire[31:0] c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15;
// //     reg [287:0] r;
// //     reg done_reg;
// //     assign {c15,c14,c13,c12,c11,c10,c9,c8,c7,c6,c5,c4,c3,c2,c1,c0} = C;

    
// //     assign s1 = {c7,c6,c5,c4,c3,c2,c1,c0};
// //     assign s2 = {c15,c14,c13,c12,c11,32'h0,c9,c8};
// //     assign s3 = {c14,32'h0,c15,c14,c13,32'h0,c14,c13};
// //     assign s4 = {c13,32'h0,32'h0,32'h0,32'h0,32'h0,c15,c14};
// //     assign s5 = {c12,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,c15};
// //     assign s6 = {c11,c11,c10,c15,c14,32'h0,c13,c12};
// //     assign s7 = {c10,c15,c14,c13,c12,32'h0,c11,c10};
// //     assign s8 = {c9,32'h0,32'h0,c9,c8,32'h0,c10,c9};
// //     assign s9 = {c8,32'h0,32'h0,32'h0,c15,32'h0,c12,c11};
// //     assign s10 = {c15,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0};
// //     assign s11 = {32'h0,32'h0,32'h0,32'h0,32'h0,c14,32'h0,32'h0};
// //     assign s12 = {32'h0,32'h0,32'h0,32'h0,32'h0,c13,32'h0,32'h0};
// //     assign s13 = {32'h0,32'h0,32'h0,32'h0,32'h0,c9,32'h0,32'h0};
// //     assign s14 = {32'h0,32'h0,32'h0,32'h0,32'h0,c8,32'h0,32'h0};

// //     reg first;
// //     reg [255:0] R_reg;
// //     assign {r8,r7,r6,r5,r4,r3,r2,r1,r0} = r;
// //     always @(posedge clk or negedge rst_n) begin
// //         if(!rst_n) begin
// //             done_reg <= 0;
// //             first <= 0;
// //             // R_tmp <= s1+s2+2*(s3+s4+s5+s10)+s6+s7+s8+s9-s11-s12-s13-s14;
// //             // r <= s1+s2+s3+s3+s4+s4+s5+s5+s6+s7+s8+s9+s10+s10-s11-s12-s13-s14;
// //         end
// //         else begin
// //             if(first==0) begin
// //                 r <= s1+s2+s3+s3+s4+s4+s5+s5+s6+s7+s8+s9+s10+s10-s11-s12-s13-s14;
// //                 // R_reg <= R_tmp>=P256?(R_tmp-P256):R_tmp[255:0];
// //                 first = 1;
// //             end
// //             else begin
// //                 done_reg <= 1;
// //                 // if(r>=P256_13) R_reg <= r-P256_13;
// //                 // else if(r>=P256_12) R_reg <= r-P256_12;
// //                 // else if(r>=P256_11) R_reg <= r-P256_11;
// //                 // else if(r>=P256_10) R_reg <= r-P256_10;
// //                 // else if(r>=P256_9) R_reg <= r-P256_9;
// //                 // else if(r>=P256_8) R_reg <= r-P256_8;
// //                 // else if(r>=P256_7) R_reg <= r-P256_7;
// //                 // else if(r>=P256_6) R_reg <= r-P256_6;
// //                 // else if(r>=P256_5) R_reg <= r-P256_5;
// //                 // else if(r>=P256_4) R_reg <= r-P256_4;
// //                 // else if(r>=P256_3) R_reg <= r-P256_3;
// //                 // else if(r>=P256_2) R_reg <= r-P256_2;
// //                 // else if(r>=P256) R_reg <= r-P256;
// //                 // else R_reg <= r;
// //             end
// //         end
// //     end
// //     assign done = done_reg;
// //     // assign R = done?((r[255:0]>=P256)?(r[255:0]-P256):r[255:0]):0;
// //     assign R = done?(r%P256):0;
// //     // assign R = R_reg;

// // endmodule




// // `timescale 1ns / 1ps

// // // 模约减
// // //论文：基于国密算法加密技术的SoC设计与优化
// // // (c+x) mod p256

// // module mod_re(
// //     input clk,
// //     input rst_n,
// //     input [511:0] C,
// //     output [255:0] R,
// //     output done
// //     );

// //     parameter P256 = 260'h0_fffffffe_ffffffff_ffffffff_ffffffff_ffffffff_00000000_ffffffff_ffffffff;
// //     parameter P256_2 = 2*P256;
// //     parameter P256_3 = 3*P256;
// //     parameter P256_4 = 4*P256;
// //     parameter P256_5 = 5*P256;
// //     parameter P256_6 = 6*P256;
// //     parameter P256_7 = 7*P256;
// //     parameter P256_8 = 8*P256;
// //     parameter P256_9 = 9*P256;
// //     parameter P256_10 = 10*P256;
// //     parameter P256_11 = 11*P256;
// //     parameter P256_12 = 12*P256;
// //     parameter P256_13 = 13*P256;
// //     parameter P256_14 = 14*P256;

// //     wire [255:0] s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14;
// //     wire[31:0] c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15;
// //     reg [259:0] r;
// //     reg done_reg;
// //     assign {c15,c14,c13,c12,c11,c10,c9,c8,c7,c6,c5,c4,c3,c2,c1,c0} = C;

    
// //     assign s1 = {c7,c6,c5,c4,c3,c2,c1,c0};
// //     assign s2 = {c15,c14,c13,c12,c11,32'h0,c9,c8};
// //     assign s3 = {c14,32'h0,c15,c14,c13,32'h0,c14,c13};
// //     assign s4 = {c13,32'h0,32'h0,32'h0,32'h0,32'h0,c15,c14};
// //     assign s5 = {c12,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,c15};
// //     assign s6 = {c11,c11,c10,c15,c14,32'h0,c13,c12};
// //     assign s7 = {c10,c15,c14,c13,c12,32'h0,c11,c10};
// //     assign s8 = {c9,32'h0,32'h0,c9,c8,32'h0,c10,c9};
// //     assign s9 = {c8,32'h0,32'h0,32'h0,c15,32'h0,c12,c11};
// //     assign s10 = {c15,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0};
// //     assign s11 = {32'h0,32'h0,32'h0,32'h0,32'h0,c14,32'h0,32'h0};
// //     assign s12 = {32'h0,32'h0,32'h0,32'h0,32'h0,c13,32'h0,32'h0};
// //     assign s13 = {32'h0,32'h0,32'h0,32'h0,32'h0,c9,32'h0,32'h0};
// //     assign s14 = {32'h0,32'h0,32'h0,32'h0,32'h0,c8,32'h0,32'h0};

// //     reg [2:0] first;
// //     reg carry1,carry2;
// //     reg [255:0] R_reg;
// //     reg [259:0] result1,result2;
// //     always @(posedge clk or negedge rst_n) begin
// //         if(!rst_n) begin
// //             done_reg <= 0;
// //             first <= 3'd0;
// //             // R_tmp <= s1+s2+2*(s3+s4+s5+s10)+s6+s7+s8+s9-s11-s12-s13-s14;
// //             // r <= s1+s2+s3+s3+s4+s4+s5+s5+s6+s7+s8+s9+s10+s10-s11-s12-s13-s14;
// //         end
// //         else begin
// //             if(first==3'd0) begin
// //                 r <= s1+s2+s3+s3+s4+s4+s5+s5+s6+s7+s8+s9+s10+s10-s11-s12-s13-s14;
// //                 // R_reg <= R_tmp>=P256?(R_tmp-P256):R_tmp[255:0];
// //                 first <= 3'd1;
// //             end
// //             else if(first==3'd1)begin
// //                 first <= 3'd2;
// //                 case(r[259:256])
// //                     3'd0:{carry1,result1} <= r;
// //                     3'd1:{carry1,result1} <= r-P256;
// //                     3'd2:{carry1,result1} <= r-P256_2;
// //                     3'd3:{carry1,result1} <= r-P256_3;
// //                     3'd4:{carry1,result1} <= r-P256_4;
// //                     3'd5:{carry1,result1} <= r-P256_5;
// //                     3'd6:{carry1,result1} <= r-P256_6;
// //                     3'd7:{carry1,result1} <= r-P256_7;
// //                     3'd8:{carry1,result1} <= r-P256_8;
// //                     3'd9:{carry1,result1} <= r-P256_9;
// //                     3'd10:{carry1,result1} <= r-P256_10;
// //                     3'd11:{carry1,result1} <= r-P256_11;
// //                     3'd12:{carry1,result1} <= r-P256_12;
// //                     3'd13:{carry1,result1} <= r-P256_13;
// //                     3'd14:{carry1,result1} <= r-P256_14;
// //                 endcase
// //             end
// //             else if(first==3'd2) begin
// //                 first <= 3'd3;
// //                 {carry2,result2} <= result1-P256;
// //             end
// //             else if(first==3'd3) begin
// //                 R_reg <= carry1?result2[255:0]:result1[255:0];
// //                 done_reg <= 1;
// //             end
// //         end
// //     end
// //     assign done = done_reg;
// //     // assign R = done?((r[255:0]>=P256)?(r[255:0]-P256):r[255:0]):0;
// //     // assign R = done?(r%P256):0;
// //     assign R = done?R_reg:0;

// // endmodule


`timescale 1ns / 1ps

// 模约减
// P256 = 260'h0_fffffffe_ffffffff_ffffffff_ffffffff_ffffffff_00000000_ffffffff_ffffffff;

module mod_re(
    input [511:0] C,
    output [255:0] R
    );

    parameter P256 = 260'h0_fffffffe_ffffffff_ffffffff_ffffffff_ffffffff_00000000_ffffffff_ffffffff;
    // parameter P256 = 260'h0_FFFFFFFE_FFFFFFFF_FFFFFFFF_FFFFFFFF_7203DF6B_21C6052B_53BBF409_39D54123;
    parameter P256_2 = 2*P256;
    parameter P256_3 = 3*P256;
    parameter P256_4 = 4*P256;
    parameter P256_5 = 5*P256;
    parameter P256_6 = 6*P256;
    parameter P256_7 = 7*P256;
    parameter P256_8 = 8*P256;
    parameter P256_9 = 9*P256;
    parameter P256_10 = 10*P256;
    parameter P256_11 = 11*P256;
    parameter P256_12 = 12*P256;
    parameter P256_13 = 13*P256;
    parameter P256_14 = 14*P256;
    parameter P256_15 = 15*P256;
    reg carry1;wire carry2;
    reg [259:0] result1;wire [259:0] result2;
    wire [259:0] s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14;
    wire[31:0] c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15;
    wire [259:0] r;
    assign {c15,c14,c13,c12,c11,c10,c9,c8,c7,c6,c5,c4,c3,c2,c1,c0} = C;
    // assign s1 = {c7,c6,c5,c4,c3,c2,c1,c0};
    // assign s2 = {c15,c14,c13,c12,c11,32'h0,c9,c8};
    // assign s3 = {c14,32'h0,c15,c14,c13,32'h0,c14,c13};
    // assign s4 = {c13,32'h0,32'h0,32'h0,32'h0,32'h0,c15,c14};
    // assign s5 = {c12,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,c15};
    // assign s6 = {c11,c11,c10,c15,c14,32'h0,c13,c12};
    // assign s7 = {c10,c15,c14,c13,c12,32'h0,c11,c10};
    // assign s8 = {c9,32'h0,32'h0,c9,c8,32'h0,c10,c9};
    // assign s9 = {c8,32'h0,32'h0,32'h0,c15,32'h0,c12,c11};
    // assign s10 = {c15,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0};
    // assign s11 = {32'h0,32'h0,32'h0,32'h0,32'h0,c14,32'h0,32'h0};
    // assign s12 = {32'h0,32'h0,32'h0,32'h0,32'h0,c13,32'h0,32'h0};
    // assign s13 = {32'h0,32'h0,32'h0,32'h0,32'h0,c9,32'h0,32'h0};
    // assign s14 = {32'h0,32'h0,32'h0,32'h0,32'h0,c8,32'h0,32'h0};
    assign s0 = {32'h0,c15,32'h0,c15,c14,c13,32'h0,c15,c14};
    assign s1 = {32'h0,c14,32'h0,32'h0,32'h0,32'h0,32'h0,c14,c13};
    assign s2 = {32'h0,c13,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,c15};
    assign s3 = {32'h0,c12,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0};
    assign s4 = {32'h0,c15,c15,c14,c13,c12,32'h0,c11,c10};
    assign s5 = {32'h0,c11,c14,c13,c12,c11,0,c10,c9};
    assign s6 = {32'h0,c10,c11,c10,c9,c8,32'h0,c13,c12};
    assign s7 = {32'h0,c9,32'h0,32'h0,c15,c14,32'h0,c9,c8};
    assign s8 = {32'h0,c8,32'h0,32'h0,32'h0,c15,32'h0,c12,c11};
    assign s9 = {32'h0,c7,c6,c5,c4,c3,c2,c1,c0};
    assign s10 = {32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,c8,32'h0,32'h0};
    assign s11 = {32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,c9,32'h0,32'h0};
    assign s12 = {32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,c13,32'h0,32'h0};
    assign s13 = {32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,c14,32'h0,32'h0};
    // assign r = s1+s2+s3+s3+s4+s4+s5+s5+s6+s7+s8+s9+s10+s10-s11-s12-s13-s14;  
    assign r = s0+s0+s1+s1+s2+s2+s3+s3+s4+s5+s6+s7+s8+s9-s10-s11-s12-s13;   
    always @(*) begin
        case(r[259:256])
        //4 bit！！
                    4'd0:{carry1,result1} = r;
                    4'd1:{carry1,result1} = r-P256;
                    4'd2:{carry1,result1} = r-P256_2;
                    4'd3:{carry1,result1} = r-P256_3;
                    4'd4:{carry1,result1} = r-P256_4;
                    4'd5:{carry1,result1} = r-P256_5;
                    4'd6:{carry1,result1} = r-P256_6;
                    4'd7:{carry1,result1} = r-P256_7;
                    4'd8:{carry1,result1} = r-P256_8;
                    4'd9:{carry1,result1} = r-P256_9;
                    4'd10:{carry1,result1} = r-P256_10;
                    4'd11:{carry1,result1} = r-P256_11;
                    4'd12:{carry1,result1} = r-P256_12;
                    4'd13:{carry1,result1} = r-P256_13;
                    4'd14:{carry1,result1} = r-P256_14;
                    4'd15:{carry1,result1} = r-P256_15;
                endcase
    end
    // assign R = r%P256;
    assign {carry2,result2} = result1-P256;
    assign R = carry1?result2[255:0]:result1[255:0];
    assign done = 1;

endmodule




// `timescale 1ns / 1ps

// // 模约减
// //论文：基于国密算法加密技术的SoC设计与优化
// // (c+x) mod p256

// module mod_re(
//     input clk,
//     input rst_n,
//     input [511:0] C,
//     input [255:0] X,
//     output [255:0] R,
//     output done
//     );

//     reg[255:0] P256 = 256'hfffffffe_ffffffff_ffffffff_ffffffff_ffffffff_00000000_ffffffff_ffffffff;

//     wire [255:0] s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14;
//     reg [255:0] s15,s16,s17;
//     wire[31:0] c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15;
//     reg [287:0] r;
//     wire [31:0] r0,r1,r2,r3,r4,r5,r6,r7,r8;
//     reg done_reg;
//     assign {c15,c14,c13,c12,c11,c10,c9,c8,c7,c6,c5,c4,c3,c2,c1,c0} = C;

//     assign s1 = {c7,c6,c5,c4,c3,c2,c1,c0};
//     assign s2 = {c15,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0};
//     assign s3 = {c12,32'h0,c15,c14,32'h0,32'h0,32'h0,c13};
//     assign s4 = {c13,32'h0,32'h0,32'h0,32'h0,32'h0,c14,c15};
//     assign s5 = {c14,32'h0,32'h0,32'h0,c13,32'h0,c15,c14};
//     assign s6 = {c8,c11,c13,c15,c14,32'h0,c9,c10};
//     assign s7 = {c9,c14,c10,c13,c8,32'h0,c11,c12};
//     assign s8 = {c11,32'h0,32'h0,c9,c12,0,c10,c9};
//     assign s9 = {c10,c15,c14,c12,c11,32'h0,c13,c8};
//     assign s10 = {32'h0,32'h0,32'h0,32'h0,c15,32'h0,c12,c11};
//     assign s11 = {32'h0,32'h0,32'h0,32'h0,32'h0,c8,32'h0,32'h0};
//     assign s12 = {32'h0,32'h0,32'h0,32'h0,32'h0,c9,32'h0,32'h0};
//     assign s13 = {32'h0,32'h0,32'h0,32'h0,32'h0,c13,32'h0,32'h0};
//     assign s14 = {32'h0,32'h0,32'h0,32'h0,32'h0,c14,32'h0,32'h0};
    
    
//     // assign s1 = {c7,c6,c5,c4,c3,c2,c1,c0};
//     // assign s2 = {c15,c14,c13,c12,c11,32'h0,c9,c8};
//     // assign s3 = {c14,32'h0,c15,c14,c13,32'h0,c14,c13};
//     // assign s4 = {c13,32'h0,32'h0,32'h0,32'h0,32'h0,c15,c14};
//     // assign s5 = {c12,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,c15};
//     // assign s6 = {c11,c11,c10,c15,c14,32'h0,c13,c12};
//     // assign s7 = {c10,c15,c14,c13,c12,32'h0,c11,c10};
//     // assign s8 = {c9,32'h0,32'h0,c9,c8,32'h0,c10,c9};
//     // assign s9 = {c8,32'h0,32'h0,32'h0,c15,32'h0,c12,c11};
//     // assign s10 = {c15,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0};
//     // assign s11 = {32'h0,32'h0,32'h0,32'h0,32'h0,c14,32'h0,32'h0};
//     // assign s12 = {32'h0,32'h0,32'h0,32'h0,32'h0,c13,32'h0,32'h0};
//     // assign s13 = {32'h0,32'h0,32'h0,32'h0,32'h0,c9,32'h0,32'h0};
//     // assign s14 = {32'h0,32'h0,32'h0,32'h0,32'h0,c8,32'h0,32'h0};
//     assign {r8,r7,r6,r5,r4,r3,r2,r1,r0} = r;
//     always @(posedge clk or negedge rst_n) begin
//         if(!rst_n) begin
//             done_reg <= 0;
//             // R_tmp <= s1+s2+2*(s3+s4+s5+s10)+s6+s7+s8+s9-s11-s12-s13-s14;
//             r <= s1+s2+s2+s2+s3+s3+s4+s4+s5+s5+s6+s7+s8+s9+s10-s11-s12-s13-s14-X+P256;
//         end
//         else begin
//             s15 <= {r7,r6,r5,r4,r3,r2,r1,r0};
//             s16 <= {r8,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0};
//             s17 <= {32'h0,32'h0,32'h0,32'h0,32'h0,r8,32'h0,32'h0};
//             // R_reg <= R_tmp>=P256?(R_tmp-P256):R_tmp[255:0];
//             done_reg <= 1;
//         end
//     end
//     wire [256:0] R2;
//     assign R2 = s15+s16-s17;
//     assign done = done_reg;
//     assign R = done?((R2>=P256)?(R2-P256):(R2)):0;
//     // assign R = R_reg;

// endmodule






// `timescale 1ns / 1ps

// // 模约减
// //论文：基于国密算法加密技术的SoC设计与优化
// // (c+x) mod p256

// module mod_re(
//     input clk,
//     input rst_n,
//     input [511:0] C,
//     output [255:0] R,
//     output done
//     );

//     parameter P256 = 260'h0_fffffffe_ffffffff_ffffffff_ffffffff_ffffffff_00000000_ffffffff_ffffffff;
//     parameter P256_2 = 2*P256;
//     parameter P256_3 = 3*P256;
//     parameter P256_4 = 4*P256;
//     parameter P256_5 = 5*P256;
//     parameter P256_6 = 6*P256;
//     parameter P256_7 = 7*P256;
//     parameter P256_8 = 8*P256;
//     parameter P256_9 = 9*P256;
//     parameter P256_10 = 10*P256;
//     parameter P256_11 = 11*P256;
//     parameter P256_12 = 12*P256;
//     parameter P256_13 = 13*P256;
//     parameter P256_14 = 14*P256;
//     parameter P256_15 = 15*P256;

//     wire [255:0] s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13;
//     wire[31:0] c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15;
//     reg [259:0] r;
//     reg done_reg;
//     assign {c15,c14,c13,c12,c11,c10,c9,c8,c7,c6,c5,c4,c3,c2,c1,c0} = C;

    
//     assign s0 = {c15,32'h0,c15,c14,c13,32'h0,c15,c14};
//     assign s1 = {c14,32'h0,32'h0,32'h0,32'h0,32'h0,c14,c13};
//     assign s2 = {c13,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,c15};
//     assign s3 = {c12,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0,32'h0};
//     assign s4 = {c15,c15,c14,c13,c12,32'h0,c11,c10};
//     assign s5 = {c11,c14,c13,c12,c11,0,c10,c9};
//     assign s6 = {c10,c11,c10,c9,c8,32'h0,c13,c12};
//     assign s7 = {c9,32'h0,32'h0,c15,c14,32'h0,c9,c8};
//     assign s8 = {c8,32'h0,32'h0,32'h0,c15,32'h0,c12,c11};
//     assign s9 = {c7,c6,c5,c4,c3,c2,c1,c0};
//     assign s10 = {32'h0,32'h0,32'h0,32'h0,32'h0,c8,32'h0,32'h0};
//     assign s11 = {32'h0,32'h0,32'h0,32'h0,32'h0,c9,32'h0,32'h0};
//     assign s12 = {32'h0,32'h0,32'h0,32'h0,32'h0,c13,32'h0,32'h0};
//     assign s13 = {32'h0,32'h0,32'h0,32'h0,32'h0,c14,32'h0,32'h0};

//     reg [2:0] first;
//     reg carry1,carry2;
//     reg [255:0] R_reg;
//     reg [259:0] result1,result2;
//     always @(posedge clk or negedge rst_n) begin
//         if(!rst_n) begin
//             done_reg <= 0;
//             first <= 3'd0;
//             // R_tmp <= s1+s2+2*(s3+s4+s5+s10)+s6+s7+s8+s9-s11-s12-s13-s14;
//             // r <= s1+s2+s3+s3+s4+s4+s5+s5+s6+s7+s8+s9+s10+s10-s11-s12-s13-s14;
//         end
//         else begin
//             if(first==3'd0) begin
//                 r <= (s0+s1+s2+s3)*2+s4+s5+s6+s7+s8+s9-s10-s11-s12-s13;
//                 // R_reg <= R_tmp>=P256?(R_tmp-P256):R_tmp[255:0];
//                 first <= 3'd1;
//             end
//             else if(first==3'd1)begin
//                 first <= 3'd2;
//                 case(r[259:256])
//                     3'd0:{carry1,result1} <= r;
//                     3'd1:{carry1,result1} <= r-P256;
//                     3'd2:{carry1,result1} <= r-P256_2;
//                     3'd3:{carry1,result1} <= r-P256_3;
//                     3'd4:{carry1,result1} <= r-P256_4;
//                     3'd5:{carry1,result1} <= r-P256_5;
//                     3'd6:{carry1,result1} <= r-P256_6;
//                     3'd7:{carry1,result1} <= r-P256_7;
//                     3'd8:{carry1,result1} <= r-P256_8;
//                     3'd9:{carry1,result1} <= r-P256_9;
//                     3'd10:{carry1,result1} <= r-P256_10;
//                     3'd11:{carry1,result1} <= r-P256_11;
//                     3'd12:{carry1,result1} <= r-P256_12;
//                     3'd13:{carry1,result1} <= r-P256_13;
//                     3'd14:{carry1,result1} <= r-P256_14;
//                     3'd15:{carry1,result1} <= r-P256_15;
//                 endcase
//             end
//             else if(first==3'd2) begin
//                 first <= 3'd3;
//                 {carry2,result2} <= result1-P256;
//             end
//             else if(first==3'd3) begin
//                 R_reg <= carry1?result2[255:0]:result1[255:0];
//                 done_reg <= 1;
//             end
//         end
//     end
//     assign done = done_reg;
//     // assign R = done?((r[255:0]>=P256)?(r[255:0]-P256):r[255:0]):0;
//     // assign R = done?(r%P256):0;
//     assign R = done?R_reg:0;

// endmodule
