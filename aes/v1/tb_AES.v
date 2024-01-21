`timescale 1ns / 1ps

module tb_AES;
    reg clk,reset,mode;
    reg[127:0] data_in, key_in;
    wire[127:0] data_out;
    wire aes_done;

    always #5 clk = ~clk;

    AES aes(
        clk,
        reset,
        mode,
        data_in,
        key_in,
        data_out,
        aes_done
    );
    
    initial begin
        clk = 1'b0;
        
//        reset = 1;
//        mode = 0;
//        data_in = 128'h3243f6a8885a308d313198a2e0370734;
//        key_in = 128'h2b7e151628aed2a6abf7158809cf4f3c;
//        #100
//        reset = 0;
        
//        #100000

        reset = 1;
        mode = 1;
        data_in = 128'h3925841D02DC09FBDC118597196A0B32;
        key_in = 128'h2b7e151628aed2a6abf7158809cf4f3c;
        #100
        reset = 0;
    end
endmodule
