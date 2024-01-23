`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/21 17:49:32
// Design Name: 
// Module Name: sbox
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


module sbox_0(
        input[7:0] x,
        output[7:0] dout
    );
    reg [7:0] d;
    assign dout = d;
    always @(*) begin
        case(x)
            8'd0: d  <= 8'h3e;
            8'd1: d  <= 8'h72;
            8'd2: d  <= 8'h5b;
            8'd3: d  <= 8'h47;
            8'd4: d  <= 8'hca;
            8'd5: d  <= 8'he0;
            8'd6: d  <= 8'h00;
            8'd7: d  <= 8'h33;
            8'd8: d  <= 8'h04;
            8'd9: d  <= 8'hd1;
            8'd10: d  <= 8'h54;
            8'd11: d  <= 8'h98;
            8'd12: d  <= 8'h09;
            8'd13: d  <= 8'hb9;
            8'd14: d  <= 8'h6d;
            8'd15: d  <= 8'hcb;
            8'd16: d  <= 8'h7b;
            8'd17: d  <= 8'h1b;
            8'd18: d  <= 8'hf9;
            8'd19: d  <= 8'h32;
            8'd20: d  <= 8'haf;
            8'd21: d  <= 8'h9d;
            8'd22: d  <= 8'h6a;
            8'd23: d  <= 8'ha5;
            8'd24: d  <= 8'hb8;
            8'd25: d  <= 8'h2d;
            8'd26: d  <= 8'hfc;
            8'd27: d  <= 8'h1d;
            8'd28: d  <= 8'h08;
            8'd29: d  <= 8'h53;
            8'd30: d  <= 8'h03;
            8'd31: d  <= 8'h90;
            8'd32: d  <= 8'h4d;
            8'd33: d  <= 8'h4e;
            8'd34: d  <= 8'h84;
            8'd35: d  <= 8'h99;
            8'd36: d  <= 8'he4;
            8'd37: d  <= 8'hce;
            8'd38: d  <= 8'hd9;
            8'd39: d  <= 8'h91;
            8'd40: d  <= 8'hdd;
            8'd41: d  <= 8'hb6;
            8'd42: d  <= 8'h85;
            8'd43: d  <= 8'h48;
            8'd44: d  <= 8'h8b;
            8'd45: d  <= 8'h29;
            8'd46: d  <= 8'h6e;
            8'd47: d  <= 8'hac;
            8'd48: d  <= 8'hcd;
            8'd49: d  <= 8'hc1;
            8'd50: d  <= 8'hf8;
            8'd51: d  <= 8'h1e;
            8'd52: d  <= 8'h73;
            8'd53: d  <= 8'h43;
            8'd54: d  <= 8'h69;
            8'd55: d  <= 8'hc6;
            8'd56: d  <= 8'hb5;
            8'd57: d  <= 8'hbd;
            8'd58: d  <= 8'hfd;
            8'd59: d  <= 8'h39;
            8'd60: d  <= 8'h63;
            8'd61: d  <= 8'h20;
            8'd62: d  <= 8'hd4;
            8'd63: d  <= 8'h38;
            8'd64: d  <= 8'h76;
            8'd65: d  <= 8'h7d;
            8'd66: d  <= 8'hb2;
            8'd67: d  <= 8'ha7;
            8'd68: d  <= 8'hcf;
            8'd69: d  <= 8'hed;
            8'd70: d  <= 8'h57;
            8'd71: d  <= 8'hc5;
            8'd72: d  <= 8'hf3;
            8'd73: d  <= 8'h2c;
            8'd74: d  <= 8'hbb;
            8'd75: d  <= 8'h14;
            8'd76: d  <= 8'h21;
            8'd77: d  <= 8'h06;
            8'd78: d  <= 8'h55;
            8'd79: d  <= 8'h9b;
            8'd80: d  <= 8'he3;
            8'd81: d  <= 8'hef;
            8'd82: d  <= 8'h5e;
            8'd83: d  <= 8'h31;
            8'd84: d  <= 8'h4f;
            8'd85: d  <= 8'h7f;
            8'd86: d  <= 8'h5a;
            8'd87: d  <= 8'ha4;
            8'd88: d  <= 8'h0d;
            8'd89: d  <= 8'h82;
            8'd90: d  <= 8'h51;
            8'd91: d  <= 8'h49;
            8'd92: d  <= 8'h5f;
            8'd93: d  <= 8'hba;
            8'd94: d  <= 8'h58;
            8'd95: d  <= 8'h1c;
            8'd96: d  <= 8'h4a;
            8'd97: d  <= 8'h16;
            8'd98: d  <= 8'hd5;
            8'd99: d  <= 8'h17;
            8'd100: d  <= 8'ha8;
            8'd101: d  <= 8'h92;
            8'd102: d  <= 8'h24;
            8'd103: d  <= 8'h1f;
            8'd104: d  <= 8'h8c;
            8'd105: d  <= 8'hff;
            8'd106: d  <= 8'hd8;
            8'd107: d  <= 8'hae;
            8'd108: d  <= 8'h2e;
            8'd109: d  <= 8'h01;
            8'd110: d  <= 8'hd3;
            8'd111: d  <= 8'had;
            8'd112: d  <= 8'h3b;
            8'd113: d  <= 8'h4b;
            8'd114: d  <= 8'hda;
            8'd115: d  <= 8'h46;
            8'd116: d  <= 8'heb;
            8'd117: d  <= 8'hc9;
            8'd118: d  <= 8'hde;
            8'd119: d  <= 8'h9a;
            8'd120: d  <= 8'h8f;
            8'd121: d  <= 8'h87;
            8'd122: d  <= 8'hd7;
            8'd123: d  <= 8'h3a;
            8'd124: d  <= 8'h80;
            8'd125: d  <= 8'h6f;
            8'd126: d  <= 8'h2f;
            8'd127: d  <= 8'hc8;
            8'd128: d  <= 8'hb1;
            8'd129: d  <= 8'hb4;
            8'd130: d  <= 8'h37;
            8'd131: d  <= 8'hf7;
            8'd132: d  <= 8'h0a;
            8'd133: d  <= 8'h22;
            8'd134: d  <= 8'h13;
            8'd135: d  <= 8'h28;
            8'd136: d  <= 8'h7c;
            8'd137: d  <= 8'hcc;
            8'd138: d  <= 8'h3c;
            8'd139: d  <= 8'h89;
            8'd140: d  <= 8'hc7;
            8'd141: d  <= 8'hc3;
            8'd142: d  <= 8'h96;
            8'd143: d  <= 8'h56;
            8'd144: d  <= 8'h07;
            8'd145: d  <= 8'hbf;
            8'd146: d  <= 8'h7e;
            8'd147: d  <= 8'hf0;
            8'd148: d  <= 8'h0b;
            8'd149: d  <= 8'h2b;
            8'd150: d  <= 8'h97;
            8'd151: d  <= 8'h52;
            8'd152: d  <= 8'h35;
            8'd153: d  <= 8'h41;
            8'd154: d  <= 8'h79;
            8'd155: d  <= 8'h61;
            8'd156: d  <= 8'ha6;
            8'd157: d  <= 8'h4c;
            8'd158: d  <= 8'h10;
            8'd159: d  <= 8'hfe;
            8'd160: d  <= 8'hbc;
            8'd161: d  <= 8'h26;
            8'd162: d  <= 8'h95;
            8'd163: d  <= 8'h88;
            8'd164: d  <= 8'h8a;
            8'd165: d  <= 8'hb0;
            8'd166: d  <= 8'ha3;
            8'd167: d  <= 8'hfb;
            8'd168: d  <= 8'hc0;
            8'd169: d  <= 8'h18;
            8'd170: d  <= 8'h94;
            8'd171: d  <= 8'hf2;
            8'd172: d  <= 8'he1;
            8'd173: d  <= 8'he5;
            8'd174: d  <= 8'he9;
            8'd175: d  <= 8'h5d;
            8'd176: d  <= 8'hd0;
            8'd177: d  <= 8'hdc;
            8'd178: d  <= 8'h11;
            8'd179: d  <= 8'h66;
            8'd180: d  <= 8'h64;
            8'd181: d  <= 8'h5c;
            8'd182: d  <= 8'hec;
            8'd183: d  <= 8'h59;
            8'd184: d  <= 8'h42;
            8'd185: d  <= 8'h75;
            8'd186: d  <= 8'h12;
            8'd187: d  <= 8'hf5;
            8'd188: d  <= 8'h74;
            8'd189: d  <= 8'h9c;
            8'd190: d  <= 8'haa;
            8'd191: d  <= 8'h23;
            8'd192: d  <= 8'h0e;
            8'd193: d  <= 8'h86;
            8'd194: d  <= 8'hab;
            8'd195: d  <= 8'hbe;
            8'd196: d  <= 8'h2a;
            8'd197: d  <= 8'h02;
            8'd198: d  <= 8'he7;
            8'd199: d  <= 8'h67;
            8'd200: d  <= 8'he6;
            8'd201: d  <= 8'h44;
            8'd202: d  <= 8'ha2;
            8'd203: d  <= 8'h6c;
            8'd204: d  <= 8'hc2;
            8'd205: d  <= 8'h93;
            8'd206: d  <= 8'h9f;
            8'd207: d  <= 8'hf1;
            8'd208: d  <= 8'hf6;
            8'd209: d  <= 8'hfa;
            8'd210: d  <= 8'h36;
            8'd211: d  <= 8'hd2;
            8'd212: d  <= 8'h50;
            8'd213: d  <= 8'h68;
            8'd214: d  <= 8'h9e;
            8'd215: d  <= 8'h62;
            8'd216: d  <= 8'h71;
            8'd217: d  <= 8'h15;
            8'd218: d  <= 8'h3d;
            8'd219: d  <= 8'hd6;
            8'd220: d  <= 8'h40;
            8'd221: d  <= 8'hc4;
            8'd222: d  <= 8'he2;
            8'd223: d  <= 8'h0f;
            8'd224: d  <= 8'h8e;
            8'd225: d  <= 8'h83;
            8'd226: d  <= 8'h77;
            8'd227: d  <= 8'h6b;
            8'd228: d  <= 8'h25;
            8'd229: d  <= 8'h05;
            8'd230: d  <= 8'h3f;
            8'd231: d  <= 8'h0c;
            8'd232: d  <= 8'h30;
            8'd233: d  <= 8'hea;
            8'd234: d  <= 8'h70;
            8'd235: d  <= 8'hb7;
            8'd236: d  <= 8'ha1;
            8'd237: d  <= 8'he8;
            8'd238: d  <= 8'ha9;
            8'd239: d  <= 8'h65;
            8'd240: d  <= 8'h8d;
            8'd241: d  <= 8'h27;
            8'd242: d  <= 8'h1a;
            8'd243: d  <= 8'hdb;
            8'd244: d  <= 8'h81;
            8'd245: d  <= 8'hb3;
            8'd246: d  <= 8'ha0;
            8'd247: d  <= 8'hf4;
            8'd248: d  <= 8'h45;
            8'd249: d  <= 8'h7a;
            8'd250: d  <= 8'h19;
            8'd251: d  <= 8'hdf;
            8'd252: d  <= 8'hee;
            8'd253: d  <= 8'h78;
            8'd254: d  <= 8'h34;
            8'd255: d  <= 8'h60;
        endcase
    end

endmodule

module sbox_1(
        input[7:0] x,
        output[7:0] dout
    );
    reg [7:0] d;
    assign dout = d;
    always @(*) begin
        case(x)
            8'd0: d  <= 8'h55;
            8'd1: d  <= 8'hc2;
            8'd2: d  <= 8'h63;
            8'd3: d  <= 8'h71;
            8'd4: d  <= 8'h3b;
            8'd5: d  <= 8'hc8;
            8'd6: d  <= 8'h47;
            8'd7: d  <= 8'h86;
            8'd8: d  <= 8'h9f;
            8'd9: d  <= 8'h3c;
            8'd10: d  <= 8'hda;
            8'd11: d  <= 8'h5b;
            8'd12: d  <= 8'h29;
            8'd13: d  <= 8'haa;
            8'd14: d  <= 8'hfd;
            8'd15: d  <= 8'h77;
            8'd16: d  <= 8'h8c;
            8'd17: d  <= 8'hc5;
            8'd18: d  <= 8'h94;
            8'd19: d  <= 8'h0c;
            8'd20: d  <= 8'ha6;
            8'd21: d  <= 8'h1a;
            8'd22: d  <= 8'h13;
            8'd23: d  <= 8'h00;
            8'd24: d  <= 8'he3;
            8'd25: d  <= 8'ha8;
            8'd26: d  <= 8'h16;
            8'd27: d  <= 8'h72;
            8'd28: d  <= 8'h40;
            8'd29: d  <= 8'hf9;
            8'd30: d  <= 8'hf8;
            8'd31: d  <= 8'h42;
            8'd32: d  <= 8'h44;
            8'd33: d  <= 8'h26;
            8'd34: d  <= 8'h68;
            8'd35: d  <= 8'h96;
            8'd36: d  <= 8'h81;
            8'd37: d  <= 8'hd9;
            8'd38: d  <= 8'h45;
            8'd39: d  <= 8'h3e;
            8'd40: d  <= 8'h10;
            8'd41: d  <= 8'h76;
            8'd42: d  <= 8'hc6;
            8'd43: d  <= 8'ha7;
            8'd44: d  <= 8'h8b;
            8'd45: d  <= 8'h39;
            8'd46: d  <= 8'h43;
            8'd47: d  <= 8'he1;
            8'd48: d  <= 8'h3a;
            8'd49: d  <= 8'hb5;
            8'd50: d  <= 8'h56;
            8'd51: d  <= 8'h2a;
            8'd52: d  <= 8'hc0;
            8'd53: d  <= 8'h6d;
            8'd54: d  <= 8'hb3;
            8'd55: d  <= 8'h05;
            8'd56: d  <= 8'h22;
            8'd57: d  <= 8'h66;
            8'd58: d  <= 8'hbf;
            8'd59: d  <= 8'hdc;
            8'd60: d  <= 8'h0b;
            8'd61: d  <= 8'hfa;
            8'd62: d  <= 8'h62;
            8'd63: d  <= 8'h48;
            8'd64: d  <= 8'hdd;
            8'd65: d  <= 8'h20;
            8'd66: d  <= 8'h11;
            8'd67: d  <= 8'h06;
            8'd68: d  <= 8'h36;
            8'd69: d  <= 8'hc9;
            8'd70: d  <= 8'hc1;
            8'd71: d  <= 8'hcf;
            8'd72: d  <= 8'hf6;
            8'd73: d  <= 8'h27;
            8'd74: d  <= 8'h52;
            8'd75: d  <= 8'hbb;
            8'd76: d  <= 8'h69;
            8'd77: d  <= 8'hf5;
            8'd78: d  <= 8'hd4;
            8'd79: d  <= 8'h87;
            8'd80: d  <= 8'h7f;
            8'd81: d  <= 8'h84;
            8'd82: d  <= 8'h4c;
            8'd83: d  <= 8'hd2;
            8'd84: d  <= 8'h9c;
            8'd85: d  <= 8'h57;
            8'd86: d  <= 8'ha4;
            8'd87: d  <= 8'hbc;
            8'd88: d  <= 8'h4f;
            8'd89: d  <= 8'h9a;
            8'd90: d  <= 8'hdf;
            8'd91: d  <= 8'hfe;
            8'd92: d  <= 8'hd6;
            8'd93: d  <= 8'h8d;
            8'd94: d  <= 8'h7a;
            8'd95: d  <= 8'heb;
            8'd96: d  <= 8'h2b;
            8'd97: d  <= 8'h53;
            8'd98: d  <= 8'hd8;
            8'd99: d  <= 8'h5c;
            8'd100: d  <= 8'ha1;
            8'd101: d  <= 8'h14;
            8'd102: d  <= 8'h17;
            8'd103: d  <= 8'hfb;
            8'd104: d  <= 8'h23;
            8'd105: d  <= 8'hd5;
            8'd106: d  <= 8'h7d;
            8'd107: d  <= 8'h30;
            8'd108: d  <= 8'h67;
            8'd109: d  <= 8'h73;
            8'd110: d  <= 8'h08;
            8'd111: d  <= 8'h09;
            8'd112: d  <= 8'hee;
            8'd113: d  <= 8'hb7;
            8'd114: d  <= 8'h70;
            8'd115: d  <= 8'h3f;
            8'd116: d  <= 8'h61;
            8'd117: d  <= 8'hb2;
            8'd118: d  <= 8'h19;
            8'd119: d  <= 8'h8e;
            8'd120: d  <= 8'h4e;
            8'd121: d  <= 8'he5;
            8'd122: d  <= 8'h4b;
            8'd123: d  <= 8'h93;
            8'd124: d  <= 8'h8f;
            8'd125: d  <= 8'h5d;
            8'd126: d  <= 8'hdb;
            8'd127: d  <= 8'ha9;
            8'd128: d  <= 8'had;
            8'd129: d  <= 8'hf1;
            8'd130: d  <= 8'hae;
            8'd131: d  <= 8'h2e;
            8'd132: d  <= 8'hcb;
            8'd133: d  <= 8'h0d;
            8'd134: d  <= 8'hfc;
            8'd135: d  <= 8'hf4;
            8'd136: d  <= 8'h2d;
            8'd137: d  <= 8'h46;
            8'd138: d  <= 8'h6e;
            8'd139: d  <= 8'h1d;
            8'd140: d  <= 8'h97;
            8'd141: d  <= 8'he8;
            8'd142: d  <= 8'hd1;
            8'd143: d  <= 8'he9;
            8'd144: d  <= 8'h4d;
            8'd145: d  <= 8'h37;
            8'd146: d  <= 8'ha5;
            8'd147: d  <= 8'h75;
            8'd148: d  <= 8'h5e;
            8'd149: d  <= 8'h83;
            8'd150: d  <= 8'h9e;
            8'd151: d  <= 8'hab;
            8'd152: d  <= 8'h82;
            8'd153: d  <= 8'h9d;
            8'd154: d  <= 8'hb9;
            8'd155: d  <= 8'h1c;
            8'd156: d  <= 8'he0;
            8'd157: d  <= 8'hcd;
            8'd158: d  <= 8'h49;
            8'd159: d  <= 8'h89;
            8'd160: d  <= 8'h01;
            8'd161: d  <= 8'hb6;
            8'd162: d  <= 8'hbd;
            8'd163: d  <= 8'h58;
            8'd164: d  <= 8'h24;
            8'd165: d  <= 8'ha2;
            8'd166: d  <= 8'h5f;
            8'd167: d  <= 8'h38;
            8'd168: d  <= 8'h78;
            8'd169: d  <= 8'h99;
            8'd170: d  <= 8'h15;
            8'd171: d  <= 8'h90;
            8'd172: d  <= 8'h50;
            8'd173: d  <= 8'hb8;
            8'd174: d  <= 8'h95;
            8'd175: d  <= 8'he4;
            8'd176: d  <= 8'hd0;
            8'd177: d  <= 8'h91;
            8'd178: d  <= 8'hc7;
            8'd179: d  <= 8'hce;
            8'd180: d  <= 8'hed;
            8'd181: d  <= 8'h0f;
            8'd182: d  <= 8'hb4;
            8'd183: d  <= 8'h6f;
            8'd184: d  <= 8'ha0;
            8'd185: d  <= 8'hcc;
            8'd186: d  <= 8'hf0;
            8'd187: d  <= 8'h02;
            8'd188: d  <= 8'h4a;
            8'd189: d  <= 8'h79;
            8'd190: d  <= 8'hc3;
            8'd191: d  <= 8'hde;
            8'd192: d  <= 8'ha3;
            8'd193: d  <= 8'hef;
            8'd194: d  <= 8'hea;
            8'd195: d  <= 8'h51;
            8'd196: d  <= 8'he6;
            8'd197: d  <= 8'h6b;
            8'd198: d  <= 8'h18;
            8'd199: d  <= 8'hec;
            8'd200: d  <= 8'h1b;
            8'd201: d  <= 8'h2c;
            8'd202: d  <= 8'h80;
            8'd203: d  <= 8'hf7;
            8'd204: d  <= 8'h74;
            8'd205: d  <= 8'he7;
            8'd206: d  <= 8'hff;
            8'd207: d  <= 8'h21;
            8'd208: d  <= 8'h5a;
            8'd209: d  <= 8'h6a;
            8'd210: d  <= 8'h54;
            8'd211: d  <= 8'h1e;
            8'd212: d  <= 8'h41;
            8'd213: d  <= 8'h31;
            8'd214: d  <= 8'h92;
            8'd215: d  <= 8'h35;
            8'd216: d  <= 8'hc4;
            8'd217: d  <= 8'h33;
            8'd218: d  <= 8'h07;
            8'd219: d  <= 8'h0a;
            8'd220: d  <= 8'hba;
            8'd221: d  <= 8'h7e;
            8'd222: d  <= 8'h0e;
            8'd223: d  <= 8'h34;
            8'd224: d  <= 8'h88;
            8'd225: d  <= 8'hb1;
            8'd226: d  <= 8'h98;
            8'd227: d  <= 8'h7c;
            8'd228: d  <= 8'hf3;
            8'd229: d  <= 8'h3d;
            8'd230: d  <= 8'h60;
            8'd231: d  <= 8'h6c;
            8'd232: d  <= 8'h7b;
            8'd233: d  <= 8'hca;
            8'd234: d  <= 8'hd3;
            8'd235: d  <= 8'h1f;
            8'd236: d  <= 8'h32;
            8'd237: d  <= 8'h65;
            8'd238: d  <= 8'h04;
            8'd239: d  <= 8'h28;
            8'd240: d  <= 8'h64;
            8'd241: d  <= 8'hbe;
            8'd242: d  <= 8'h85;
            8'd243: d  <= 8'h9b;
            8'd244: d  <= 8'h2f;
            8'd245: d  <= 8'h59;
            8'd246: d  <= 8'h8a;
            8'd247: d  <= 8'hd7;
            8'd248: d  <= 8'hb0;
            8'd249: d  <= 8'h25;
            8'd250: d  <= 8'hac;
            8'd251: d  <= 8'haf;
            8'd252: d  <= 8'h12;
            8'd253: d  <= 8'h03;
            8'd254: d  <= 8'he2;
            8'd255: d  <= 8'hf2;
        endcase
    end
endmodule
