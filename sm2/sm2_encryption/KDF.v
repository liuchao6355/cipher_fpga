`timescale 1ns / 1ps

module KDF #(
    parameter klen = 152,
    parameter klen_v=1 // klen/v v=256
)(
    input clk,
    input rst_n,
    input [511:0] Z,
    output [(klen_v-1)*256+klen-(256*(klen_v-1)):0] K,
    output done  
    );

    reg [31:0] ct;
    reg [klen-1:0] K_reg;
    reg done_reg;

    reg rst_sm3;
    reg [512+32-1:0] i_sm3;
    wire [255:0] o_sm3;
    wire done_sm3;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            ct <= 32'd1;
        else begin
            if(done_sm3)
                ct <= ct + 1'b1;
            else 
                ct <= ct;
        end
    end

    reg[255:0] final_Ha;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rst_sm3 <= 0;
            i_sm3 <= {Z,ct};
            done_reg <= 0;
            K_reg <= 0;
        end
        else begin
            if(done_sm3) begin
                if(ct==klen_v) begin
                    // K_reg[(klen-1-256*(ct-1)):0] <= o_sm3[255:255-klen+256*(klen_v-1)];
                    K_reg <= K_reg + o_sm3[255:255-klen+256*(klen_v-1)+1];
                    // K_reg[(klen-1-256*(ct-1)):0] <= o_sm3>>(255-klen+256*(klen_v-1));
                    done_reg <= 1;
                end
                else begin
                    K_reg[(klen-1-256*(ct-1))-:256] <= o_sm3;
                    ct <= ct + 1'b1;
                    rst_sm3 <= 0;
                end
            end
            else rst_sm3 <= 1;
        end
    end

    assign done = done_reg;
    assign K = done?K_reg:0;


    sm3 #(.len(512+32)
    ) sm3 (
        clk,rst_sm3,i_sm3,o_sm3,done_sm3
    );

endmodule
