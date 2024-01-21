`timescale 1ns / 1ps

module simon_top(
    input clk,
    input rst_n,
    input key_in,
    output reg led
);
    //            N/M  T  j
    // 32/64      16/4 32 0
    // 48/72      24/3 36 0
    // 48/96      24/4 36 1
    // 64/96      32/3 42 2
    // 64/128     32/4 44 3
    // 96/96      48/2 52 2
    // 96/144     48/3 54 3
    // 128/128    64/2 68 2
    // 128/192    64/3 69 3
    // 128/256    64 4 72 4
    parameter N=16,M=4,T=32,j=0;
    wire[2*N-1:0] din; 
    wire[M*N-1:0] key;
    wire[2*N-1:0] dout,dout_true;
    wire done;

    assign key = 64'h1918111009080100;
    assign din = 32'h65656877;
    // assign dout_true = 32'hc69be9bb;
    assign dout_true = 32'hc69be9b1;


    // din = 32'h65656877;
    // din = 128'h8d2b5579afc8a3a03bf72a87efe7b868;
    // din = 128'h74206e69206d6f6f6d69732061207369;
    // key = 256'h1f1e1d1c1b1a191817161514131211100f0e0d0c0b0a09080706050403020100;


    wire right;
    assign right = (dout_true==dout);

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)                           
            led<=1'b1;                       
        else if(key_down)   
            if(done&right)                 
                led<=~led;
            else
                led <= led;                                                      
        else                           
            led<=led;                                                         
    end 

    key_debounce key_debounce(
       .clk        (clk   ), 
       .rst_n      (rst_n ),
       .key_in     (key_in),
       .key_down   (key_down),  
       .key_up     (key_up  )  
    );

    simon_en_de_cryption #(
        .N(N),
        .M(M),
        .T(T),
        .j(j)
    )simon_en_de_cryption(
        .clk(clk),
        .rst_n(rst_n),
        .en_de_cry(1),//1 加密 ?0 解密
        .din(din),
        .key(key),
        .dout(dout),
        .done(done)
    );

    


endmodule
