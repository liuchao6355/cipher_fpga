module mont (
        input [n_bit-1 : 0] x,
        input [n_bit-1 : 0] y,
        input clk,
        input rst_n,
        input start,
        output [n_bit-1 : 0] z,
        output done
    );

    // x * y * R' mod n;
    // mont(x,y){
    //     p = r - n[0]';
    //     s = 0;
    //     for ( i = 0; i < m; i++ ){
    //         q1 = ( ( s[0] + x[i] * y[0] ) * p );
    //         q2 = q1 mod r;
    //         s1 = s + x[i] * y + q2 * n;
    //         s2 = s1 / r;
    //         if ( s2 - n >= 0 ){
    //             next_s = s2 - n;
    //         } else{
    //             next_s = s2;
    //         }
    //         s = next_s;
    //     }
    //     return s;
    // }

    parameter n = 7'd79;
    parameter n_bit = 7;
    parameter logr = 3;
    parameter p = 3'd1;

    localparam update_num = n_bit / logr + (n_bit % logr != 0);
    localparam count_stop_flag = update_num - 2;
    localparam count_bit = count_stop_flag < 2 ? 1 :
               count_stop_flag < 4 ? 2 :
               count_stop_flag < 8 ? 3 :
               count_stop_flag < 16 ? 4 :
               count_stop_flag < 32 ? 5 :
               count_stop_flag < 64 ? 6 :
               count_stop_flag < 128 ? 7 :
               count_stop_flag < 256 ? 8 :
               count_stop_flag < 512 ? 9 :
               count_stop_flag < 1024 ? 10 :
               count_stop_flag < 2048 ? 11 : 12 ;

    reg [count_bit-1 : 0] count_i;
    reg [n_bit-1 : 0] reg_x;
    wire [logr-1 : 0] xi;
    assign xi = reg_x[logr-1 : 0];

    reg [n_bit-1 : 0] s;
    wire [logr-1 : 0] s_zero, y_zero;
    assign s_zero = s[logr-1 : 0];
    assign y_zero = y[logr-1 : 0];

    wire [3*logr : 0] q1;
    wire [logr-1 : 0] q2;
    assign q1 = (s_zero + xi * y_zero) * p;
    assign q2 = q1[logr-1 : 0];

    wire [n_bit+logr : 0] s1;
    wire [n_bit : 0] s2;
    assign s1 = s + xi * y + q2 * n;
    assign s2 = s1 >> logr;

    wire [n_bit : 0] s2_minus_n;
    wire [n_bit-1 : 0] next_s;
    assign s2_minus_n = s2 - n;
    assign next_s = s2_minus_n[n_bit] ? s2[n_bit-1 : 0] : s2_minus_n[n_bit-1 : 0];
    assign z = next_s;

    localparam IDLE = 3'd0, LOAD = 3'd1, UPDATE = 3'd2, ENDING = 3'd3;
    reg [2:0] current_state, next_state;

    wire done;
    assign done = current_state == ENDING;

    // FSM-1
    always @(posedge clk, negedge rst_n) begin
        if (~rst_n) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end

    // FSM-2
    always @(*) begin
        case (current_state)
            IDLE: begin
                next_state = start ? LOAD : IDLE;
            end
            LOAD: begin
                next_state = UPDATE;
            end
            UPDATE: begin
                next_state = count_i == count_stop_flag ? ENDING : UPDATE;
            end
            ENDING: begin
                next_state = start ? ENDING : IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // FSM-3
    always @(posedge clk) begin
        case (current_state)
            LOAD: begin
                count_i <= 'b0;
                reg_x <= x;
                s <= 'b0;
            end

            UPDATE: begin
                count_i <= count_i + 1;
                reg_x <= (reg_x >> logr);
                s <= next_s;
            end
        endcase
    end

endmodule


