module mod_exp (
        input [n_bit-1:0] a,
        input [n_bit-1:0] e,
        input clk,
        input rst_n,
        input start,
        output [n_bit-1:0] z,
        output done
    );

    // mod_exp(a,e){
    //     s = R % n;
    //     t = mont(a,R^2 % n);
    //     for ( i = k-1; i >= 0; i-- ){
    //         s = mont(s,s);
    //         if ( e[i] == 1 ){
    //             s = mont(s,t);
    //         }
    //     }
    //     z = mont(s,1);
    //     return z;
    // }

    parameter n = 7'd79;
    parameter n_bit = 7;
    parameter logr = 3;
    parameter p =  3'd1;
    parameter Rmodn = 7'd49;
    parameter R2modn = 7'd31;

    localparam count_stop_flag = n_bit-1;
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

    reg [1:0] control;
    localparam one = {{n_bit - 2{1'b0}}, 1'b1};
    wire [n_bit-1 : 0] operand1, operand2;
    assign operand1 = (control==2'b00)? a : s;
    assign operand2 = (control==2'b00)? R2modn :(control==2'b01)? s:(control==2'b10)? t: one;

    wire [n_bit-1 : 0] mont_result;
    reg mont_start;
    mont #(
             .n_bit(n_bit),
             .logr (logr),
             .p    (p),
             .n    (n)
         ) inst_mont (
             .x    (operand1),
             .y    (operand2),
             .clk  (clk),
             .rst_n(rst_n),
             .start(mont_start),
             .z    (mont_result),
             .done (mont_done)
         );

    reg [n_bit-1 : 0] reg_e;
    wire ei;
    assign ei = reg_e[n_bit-1];

    reg temp_mont_done;
    wire pedge_mont_done;
    always @(posedge clk) begin
        temp_mont_done <= mont_done;
    end
    assign pedge_mont_done = ~temp_mont_done & mont_done;

    reg [2:0] current_state, next_state;
    localparam IDLE = 3'd0, LOAD = 3'd1, GET_T = 3'd2, GET_S1 = 3'd3, GET_S2 = 3'd4, UPDATE = 3'd5, GET_Z = 3'd6, ENDING = 3'd7;

    wire done;
    assign done = current_state == ENDING;

    // FSM-1
    always @(posedge clk, negedge rst_n) begin : proc_current_state
        if (~rst_n) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end

    // FSM-2
    reg [count_bit-1 : 0] count_i;

    wire s1_to_s2;
    wire s1_to_s1;
    wire end_circle;
    assign end_circle = count_i == count_stop_flag;
    assign s1_to_s2 = pedge_mont_done & ei;
    assign s1_to_s1 = ~pedge_mont_done;
    always @(*) begin
        case (current_state)
            IDLE:
                next_state = start ? LOAD : IDLE;
            LOAD:
                next_state = GET_T;
            GET_T:
                next_state = pedge_mont_done ? GET_S1 : GET_T;
            GET_S1:
                next_state = s1_to_s1 ? GET_S1 : s1_to_s2 ? GET_S2 : UPDATE;
            GET_S2:
                next_state = pedge_mont_done ? UPDATE : GET_S2;
            UPDATE:
                next_state = end_circle ? GET_Z : GET_S1;
            GET_Z:
                next_state = pedge_mont_done ? ENDING : GET_Z;
            ENDING:
                next_state = start ? ENDING : IDLE;
            default:
                next_state = IDLE;
        endcase
    end

    // FSM-3
    reg [n_bit-1 :
         0] t, s, z;
    always @(posedge clk) begin
        case (current_state)
            IDLE: begin
                mont_start <= 1'b0;
            end

            LOAD: begin
                count_i <= 'b0;
                reg_e <= e;
                mont_start <= 1'b0;
                s <= Rmodn;
            end

            GET_T: begin
                control <= 2'b00;
                mont_start <= 1'b1;
                if (pedge_mont_done) begin
                    mont_start <= 1'b0;
                    t <= mont_result;
                end
            end

            GET_S1: begin
                control <= 2'b01;
                mont_start <= 1'b1;
                if (pedge_mont_done) begin
                    mont_start <= 1'b0;
                    s <= mont_result;
                end
            end

            GET_S2: begin
                control <= 2'b10;
                mont_start <= 1'b1;
                if (pedge_mont_done) begin
                    mont_start <= 1'b0;
                    s <= mont_result;
                end
            end

            UPDATE:begin
                mont_start <= 1'b0;
                count_i <= count_i + 1;
                reg_e <= (reg_e << 1);
            end

            GET_Z: begin
                control <= 2'b11;
                mont_start <= 1'b1;
                if (pedge_mont_done) begin
                    mont_start <= 1'b0;
                    z <= mont_result;
                end
            end

            default: begin
                mont_start <= 1'b0;
            end
        endcase
    end
endmodule

