`timescale 1ns/1ps
module AES_sbox(
    input mode,
    input[7:0]	in,
    output reg[7:0]	out
);
    //reg[7:0] out;
    //assign cout = out;
    always @(in)begin
        if(!mode) begin
            case(in)		
            8'h00: out=8'h63;
            8'h01: out=8'h7c;
            8'h02: out=8'h77;
            8'h03: out=8'h7b;
            8'h04: out=8'hf2;
            8'h05: out=8'h6b;
            8'h06: out=8'h6f;
            8'h07: out=8'hc5;
            8'h08: out=8'h30;
            8'h09: out=8'h01;
            8'h0a: out=8'h67;
            8'h0b: out=8'h2b;
            8'h0c: out=8'hfe;
            8'h0d: out=8'hd7;
            8'h0e: out=8'hab;
            8'h0f: out=8'h76;
            8'h10: out=8'hca;
            8'h11: out=8'h82;
            8'h12: out=8'hc9;
            8'h13: out=8'h7d;
            8'h14: out=8'hfa;
            8'h15: out=8'h59;
            8'h16: out=8'h47;
            8'h17: out=8'hf0;
            8'h18: out=8'had;
            8'h19: out=8'hd4;
            8'h1a: out=8'ha2;
            8'h1b: out=8'haf;
            8'h1c: out=8'h9c;
            8'h1d: out=8'ha4;
            8'h1e: out=8'h72;
            8'h1f: out=8'hc0;
            8'h20: out=8'hb7;
            8'h21: out=8'hfd;
            8'h22: out=8'h93;
            8'h23: out=8'h26;
            8'h24: out=8'h36;
            8'h25: out=8'h3f;
            8'h26: out=8'hf7;
            8'h27: out=8'hcc;
            8'h28: out=8'h34;
            8'h29: out=8'ha5;
            8'h2a: out=8'he5;
            8'h2b: out=8'hf1;
            8'h2c: out=8'h71;
            8'h2d: out=8'hd8;
            8'h2e: out=8'h31;
            8'h2f: out=8'h15;
            8'h30: out=8'h04;
            8'h31: out=8'hc7;
            8'h32: out=8'h23;
            8'h33: out=8'hc3;
            8'h34: out=8'h18;
            8'h35: out=8'h96;
            8'h36: out=8'h05;
            8'h37: out=8'h9a;
            8'h38: out=8'h07;
            8'h39: out=8'h12;
            8'h3a: out=8'h80;
            8'h3b: out=8'he2;
            8'h3c: out=8'heb;
            8'h3d: out=8'h27;
            8'h3e: out=8'hb2;
            8'h3f: out=8'h75;
            8'h40: out=8'h09;
            8'h41: out=8'h83;
            8'h42: out=8'h2c;
            8'h43: out=8'h1a;
            8'h44: out=8'h1b;
            8'h45: out=8'h6e;
            8'h46: out=8'h5a;
            8'h47: out=8'ha0;
            8'h48: out=8'h52;
            8'h49: out=8'h3b;
            8'h4a: out=8'hd6;
            8'h4b: out=8'hb3;
            8'h4c: out=8'h29;
            8'h4d: out=8'he3;
            8'h4e: out=8'h2f;
            8'h4f: out=8'h84;
            8'h50: out=8'h53;
            8'h51: out=8'hd1;
            8'h52: out=8'h00;
            8'h53: out=8'hed;
            8'h54: out=8'h20;
            8'h55: out=8'hfc;
            8'h56: out=8'hb1;
            8'h57: out=8'h5b;
            8'h58: out=8'h6a;
            8'h59: out=8'hcb;
            8'h5a: out=8'hbe;
            8'h5b: out=8'h39;
            8'h5c: out=8'h4a;
            8'h5d: out=8'h4c;
            8'h5e: out=8'h58;
            8'h5f: out=8'hcf;
            8'h60: out=8'hd0;
            8'h61: out=8'hef;
            8'h62: out=8'haa;
            8'h63: out=8'hfb;
            8'h64: out=8'h43;
            8'h65: out=8'h4d;
            8'h66: out=8'h33;
            8'h67: out=8'h85;
            8'h68: out=8'h45;
            8'h69: out=8'hf9;
            8'h6a: out=8'h02;
            8'h6b: out=8'h7f;
            8'h6c: out=8'h50;
            8'h6d: out=8'h3c;
            8'h6e: out=8'h9f;
            8'h6f: out=8'ha8;
            8'h70: out=8'h51;
            8'h71: out=8'ha3;
            8'h72: out=8'h40;
            8'h73: out=8'h8f;
            8'h74: out=8'h92;
            8'h75: out=8'h9d;
            8'h76: out=8'h38;
            8'h77: out=8'hf5;
            8'h78: out=8'hbc;
            8'h79: out=8'hb6;
            8'h7a: out=8'hda;
            8'h7b: out=8'h21;
            8'h7c: out=8'h10;
            8'h7d: out=8'hff;
            8'h7e: out=8'hf3;
            8'h7f: out=8'hd2;
            8'h80: out=8'hcd;
            8'h81: out=8'h0c;
            8'h82: out=8'h13;
            8'h83: out=8'hec;
            8'h84: out=8'h5f;
            8'h85: out=8'h97;
            8'h86: out=8'h44;
            8'h87: out=8'h17;
            8'h88: out=8'hc4;
            8'h89: out=8'ha7;
            8'h8a: out=8'h7e;
            8'h8b: out=8'h3d;
            8'h8c: out=8'h64;
            8'h8d: out=8'h5d;
            8'h8e: out=8'h19;
            8'h8f: out=8'h73;
            8'h90: out=8'h60;
            8'h91: out=8'h81;
            8'h92: out=8'h4f;
            8'h93: out=8'hdc;
            8'h94: out=8'h22;
            8'h95: out=8'h2a;
            8'h96: out=8'h90;
            8'h97: out=8'h88;
            8'h98: out=8'h46;
            8'h99: out=8'hee;
            8'h9a: out=8'hb8;
            8'h9b: out=8'h14;
            8'h9c: out=8'hde;
            8'h9d: out=8'h5e;
            8'h9e: out=8'h0b;
            8'h9f: out=8'hdb;
            8'ha0: out=8'he0;
            8'ha1: out=8'h32;
            8'ha2: out=8'h3a;
            8'ha3: out=8'h0a;
            8'ha4: out=8'h49;
            8'ha5: out=8'h06;
            8'ha6: out=8'h24;
            8'ha7: out=8'h5c;
            8'ha8: out=8'hc2;
            8'ha9: out=8'hd3;
            8'haa: out=8'hac;
            8'hab: out=8'h62;
            8'hac: out=8'h91;
            8'had: out=8'h95;
            8'hae: out=8'he4;
            8'haf: out=8'h79;
            8'hb0: out=8'he7;
            8'hb1: out=8'hc8;
            8'hb2: out=8'h37;
            8'hb3: out=8'h6d;
            8'hb4: out=8'h8d;
            8'hb5: out=8'hd5;
            8'hb6: out=8'h4e;
            8'hb7: out=8'ha9;
            8'hb8: out=8'h6c;
            8'hb9: out=8'h56;
            8'hba: out=8'hf4;
            8'hbb: out=8'hea;
            8'hbc: out=8'h65;
            8'hbd: out=8'h7a;
            8'hbe: out=8'hae;
            8'hbf: out=8'h08;
            8'hc0: out=8'hba;
            8'hc1: out=8'h78;
            8'hc2: out=8'h25;
            8'hc3: out=8'h2e;
            8'hc4: out=8'h1c;
            8'hc5: out=8'ha6;
            8'hc6: out=8'hb4;
            8'hc7: out=8'hc6;
            8'hc8: out=8'he8;
            8'hc9: out=8'hdd;
            8'hca: out=8'h74;
            8'hcb: out=8'h1f;
            8'hcc: out=8'h4b;
            8'hcd: out=8'hbd;
            8'hce: out=8'h8b;
            8'hcf: out=8'h8a;
            8'hd0: out=8'h70;
            8'hd1: out=8'h3e;
            8'hd2: out=8'hb5;
            8'hd3: out=8'h66;
            8'hd4: out=8'h48;
            8'hd5: out=8'h03;
            8'hd6: out=8'hf6;
            8'hd7: out=8'h0e;
            8'hd8: out=8'h61;
            8'hd9: out=8'h35;
            8'hda: out=8'h57;
            8'hdb: out=8'hb9;
            8'hdc: out=8'h86;
            8'hdd: out=8'hc1;
            8'hde: out=8'h1d;
            8'hdf: out=8'h9e;
            8'he0: out=8'he1;
            8'he1: out=8'hf8;
            8'he2: out=8'h98;
            8'he3: out=8'h11;
            8'he4: out=8'h69;
            8'he5: out=8'hd9;
            8'he6: out=8'h8e;
            8'he7: out=8'h94;
            8'he8: out=8'h9b;
            8'he9: out=8'h1e;
            8'hea: out=8'h87;
            8'heb: out=8'he9;
            8'hec: out=8'hce;
            8'hed: out=8'h55;
            8'hee: out=8'h28;
            8'hef: out=8'hdf;
            8'hf0: out=8'h8c;
            8'hf1: out=8'ha1;
            8'hf2: out=8'h89;
            8'hf3: out=8'h0d;
            8'hf4: out=8'hbf;
            8'hf5: out=8'he6;
            8'hf6: out=8'h42;
            8'hf7: out=8'h68;
            8'hf8: out=8'h41;
            8'hf9: out=8'h99;
            8'hfa: out=8'h2d;
            8'hfb: out=8'h0f;
            8'hfc: out=8'hb0;
            8'hfd: out=8'h54;
            8'hfe: out=8'hbb;
            8'hff: out=8'h16;
            default:out=8'h00;
            endcase
        end
        else begin
            // ����
            case(in)	
                0:out= 82;   1:out=  9;   2:out=106;   3:out=213;   4:out= 48;   5:out= 54;   6:out=165;   7:out= 56;
                8:out=191;   9:out= 64;  10:out=163;  11:out=158;  12:out=129;  13:out=243;  14:out=215;  15:out=251;
                16:out=124;  17:out=227;  18:out= 57;  19:out=130;  20:out=155;  21:out= 47;  22:out=255;  23:out=135;
                24:out= 52;  25:out=142;  26:out= 67;  27:out= 68;  28:out=196;  29:out=222;  30:out=233;  31:out=203;
                32:out= 84;  33:out=123;  34:out=148;  35:out= 50;  36:out=166;  37:out=194;  38:out= 35;  39:out= 61;
                40:out=238;  41:out= 76;  42:out=149;  43:out= 11;  44:out= 66;  45:out=250;  46:out=195;  47:out= 78;
                48:out=  8;  49:out= 46;  50:out=161;  51:out=102;  52:out= 40;  53:out=217;  54:out= 36;  55:out=178;
                56:out=118;  57:out= 91;  58:out=162;  59:out= 73;  60:out=109;  61:out=139;  62:out=209;  63:out= 37;
                64:out=114;  65:out=248;  66:out=246;  67:out=100;  68:out=134;  69:out=104;  70:out=152;  71:out= 22;
                72:out=212;  73:out=164;  74:out= 92;  75:out=204;  76:out= 93;  77:out=101;  78:out=182;  79:out=146;
                80:out=108;  81:out=112;  82:out= 72;  83:out= 80;  84:out=253;  85:out=237;  86:out=185;  87:out=218;
                88:out= 94;  89:out= 21;  90:out= 70;  91:out= 87;  92:out=167;  93:out=141;  94:out=157;  95:out=132;
                96:out=144;  97:out=216;  98:out=171;  99:out=  0; 100:out=140; 101:out=188; 102:out=211; 103:out= 10;
                104:out=247; 105:out=228; 106:out= 88; 107:out=  5; 108:out=184; 109:out=179; 110:out= 69; 111:out=  6;
                112:out=208; 113:out= 44; 114:out= 30; 115:out=143; 116:out=202; 117:out= 63; 118:out= 15; 119:out=  2;
                120:out=193; 121:out=175; 122:out=189; 123:out=  3; 124:out=  1; 125:out= 19; 126:out=138; 127:out=107;
                128:out= 58; 129:out=145; 130:out= 17; 131:out= 65; 132:out= 79; 133:out=103; 134:out=220; 135:out=234;
                136:out=151; 137:out=242; 138:out=207; 139:out=206; 140:out=240; 141:out=180; 142:out=230; 143:out=115;
                144:out=150; 145:out=172; 146:out=116; 147:out= 34; 148:out=231; 149:out=173; 150:out= 53; 151:out=133;
                152:out=226; 153:out=249; 154:out= 55; 155:out=232; 156:out= 28; 157:out=117; 158:out=223; 159:out=110;
                160:out= 71; 161:out=241; 162:out= 26; 163:out=113; 164:out= 29; 165:out= 41; 166:out=197; 167:out=137;
                168:out=111; 169:out=183; 170:out= 98; 171:out= 14; 172:out=170; 173:out= 24; 174:out=190; 175:out= 27;
                176:out=252; 177:out= 86; 178:out= 62; 179:out= 75; 180:out=198; 181:out=210; 182:out=121; 183:out= 32;
                184:out=154; 185:out=219; 186:out=192; 187:out=254; 188:out=120; 189:out=205; 190:out= 90; 191:out=244;
                192:out= 31; 193:out=221; 194:out=168; 195:out= 51; 196:out=136; 197:out=  7; 198:out=199; 199:out= 49;
                200:out=177; 201:out= 18; 202:out= 16; 203:out= 89; 204:out= 39; 205:out=128; 206:out=236; 207:out= 95;
                208:out= 96; 209:out= 81; 210:out=127; 211:out=169; 212:out= 25; 213:out=181; 214:out= 74; 215:out= 13;
                216:out= 45; 217:out=229; 218:out=122; 219:out=159; 220:out=147; 221:out=201; 222:out=156; 223:out=239;
                224:out=160; 225:out=224; 226:out= 59; 227:out= 77; 228:out=174; 229:out= 42; 230:out=245; 231:out=176;
                232:out=200; 233:out=235; 234:out=187; 235:out= 60; 236:out=131; 237:out= 83; 238:out=153; 239:out= 97;
                240:out= 23; 241:out= 43; 242:out=  4; 243:out=126; 244:out=186; 245:out=119; 246:out=214; 247:out= 38;
                248:out=225; 249:out=105; 250:out= 20; 251:out= 99; 252:out= 85; 253:out= 33; 254:out= 12; 255:out=125; 
                default:out=8'h00;
            endcase
        end
    end
 
endmodule
 
 
 module AES_Rcon(
    input[3:0] in,
    output[31:0] out
);
   reg[31:0] rcon[31:0];

    initial begin
        rcon[1]=32'h01000000;
        rcon[2]=32'h02000000;
        rcon[3]=32'h04000000;
        rcon[4]=32'h08000000;
        rcon[5]=32'h10000000;
        rcon[6]=32'h20000000;
        rcon[7]=32'h40000000;
        rcon[8]=32'h80000000;
        rcon[9]=32'h1b000000;
        rcon[10]=32'h36000000;
    end
    
    assign out = rcon[in];

endmodule

//`timescale 1ns/1ps
//module AES_sbox(
//    input[7:0]	in,
//    output reg[7:0]	out
//);
//    //reg[7:0] out;
//    //assign cout = out;
//    always @(in)begin
//        case(in)		
//        8'h00: out=8'h63;
//        8'h01: out=8'h7c;
//        8'h02: out=8'h77;
//        8'h03: out=8'h7b;
//        8'h04: out=8'hf2;
//        8'h05: out=8'h6b;
//        8'h06: out=8'h6f;
//        8'h07: out=8'hc5;
//        8'h08: out=8'h30;
//        8'h09: out=8'h01;
//        8'h0a: out=8'h67;
//        8'h0b: out=8'h2b;
//        8'h0c: out=8'hfe;
//        8'h0d: out=8'hd7;
//        8'h0e: out=8'hab;
//        8'h0f: out=8'h76;
//        8'h10: out=8'hca;
//        8'h11: out=8'h82;
//        8'h12: out=8'hc9;
//        8'h13: out=8'h7d;
//        8'h14: out=8'hfa;
//        8'h15: out=8'h59;
//        8'h16: out=8'h47;
//        8'h17: out=8'hf0;
//        8'h18: out=8'had;
//        8'h19: out=8'hd4;
//        8'h1a: out=8'ha2;
//        8'h1b: out=8'haf;
//        8'h1c: out=8'h9c;
//        8'h1d: out=8'ha4;
//        8'h1e: out=8'h72;
//        8'h1f: out=8'hc0;
//        8'h20: out=8'hb7;
//        8'h21: out=8'hfd;
//        8'h22: out=8'h93;
//        8'h23: out=8'h26;
//        8'h24: out=8'h36;
//        8'h25: out=8'h3f;
//        8'h26: out=8'hf7;
//        8'h27: out=8'hcc;
//        8'h28: out=8'h34;
//        8'h29: out=8'ha5;
//        8'h2a: out=8'he5;
//        8'h2b: out=8'hf1;
//        8'h2c: out=8'h71;
//        8'h2d: out=8'hd8;
//        8'h2e: out=8'h31;
//        8'h2f: out=8'h15;
//        8'h30: out=8'h04;
//        8'h31: out=8'hc7;
//        8'h32: out=8'h23;
//        8'h33: out=8'hc3;
//        8'h34: out=8'h18;
//        8'h35: out=8'h96;
//        8'h36: out=8'h05;
//        8'h37: out=8'h9a;
//        8'h38: out=8'h07;
//        8'h39: out=8'h12;
//        8'h3a: out=8'h80;
//        8'h3b: out=8'he2;
//        8'h3c: out=8'heb;
//        8'h3d: out=8'h27;
//        8'h3e: out=8'hb2;
//        8'h3f: out=8'h75;
//        8'h40: out=8'h09;
//        8'h41: out=8'h83;
//        8'h42: out=8'h2c;
//        8'h43: out=8'h1a;
//        8'h44: out=8'h1b;
//        8'h45: out=8'h6e;
//        8'h46: out=8'h5a;
//        8'h47: out=8'ha0;
//        8'h48: out=8'h52;
//        8'h49: out=8'h3b;
//        8'h4a: out=8'hd6;
//        8'h4b: out=8'hb3;
//        8'h4c: out=8'h29;
//        8'h4d: out=8'he3;
//        8'h4e: out=8'h2f;
//        8'h4f: out=8'h84;
//        8'h50: out=8'h53;
//        8'h51: out=8'hd1;
//        8'h52: out=8'h00;
//        8'h53: out=8'hed;
//        8'h54: out=8'h20;
//        8'h55: out=8'hfc;
//        8'h56: out=8'hb1;
//        8'h57: out=8'h5b;
//        8'h58: out=8'h6a;
//        8'h59: out=8'hcb;
//        8'h5a: out=8'hbe;
//        8'h5b: out=8'h39;
//        8'h5c: out=8'h4a;
//        8'h5d: out=8'h4c;
//        8'h5e: out=8'h58;
//        8'h5f: out=8'hcf;
//        8'h60: out=8'hd0;
//        8'h61: out=8'hef;
//        8'h62: out=8'haa;
//        8'h63: out=8'hfb;
//        8'h64: out=8'h43;
//        8'h65: out=8'h4d;
//        8'h66: out=8'h33;
//        8'h67: out=8'h85;
//        8'h68: out=8'h45;
//        8'h69: out=8'hf9;
//        8'h6a: out=8'h02;
//        8'h6b: out=8'h7f;
//        8'h6c: out=8'h50;
//        8'h6d: out=8'h3c;
//        8'h6e: out=8'h9f;
//        8'h6f: out=8'ha8;
//        8'h70: out=8'h51;
//        8'h71: out=8'ha3;
//        8'h72: out=8'h40;
//        8'h73: out=8'h8f;
//        8'h74: out=8'h92;
//        8'h75: out=8'h9d;
//        8'h76: out=8'h38;
//        8'h77: out=8'hf5;
//        8'h78: out=8'hbc;
//        8'h79: out=8'hb6;
//        8'h7a: out=8'hda;
//        8'h7b: out=8'h21;
//        8'h7c: out=8'h10;
//        8'h7d: out=8'hff;
//        8'h7e: out=8'hf3;
//        8'h7f: out=8'hd2;
//        8'h80: out=8'hcd;
//        8'h81: out=8'h0c;
//        8'h82: out=8'h13;
//        8'h83: out=8'hec;
//        8'h84: out=8'h5f;
//        8'h85: out=8'h97;
//        8'h86: out=8'h44;
//        8'h87: out=8'h17;
//        8'h88: out=8'hc4;
//        8'h89: out=8'ha7;
//        8'h8a: out=8'h7e;
//        8'h8b: out=8'h3d;
//        8'h8c: out=8'h64;
//        8'h8d: out=8'h5d;
//        8'h8e: out=8'h19;
//        8'h8f: out=8'h73;
//        8'h90: out=8'h60;
//        8'h91: out=8'h81;
//        8'h92: out=8'h4f;
//        8'h93: out=8'hdc;
//        8'h94: out=8'h22;
//        8'h95: out=8'h2a;
//        8'h96: out=8'h90;
//        8'h97: out=8'h88;
//        8'h98: out=8'h46;
//        8'h99: out=8'hee;
//        8'h9a: out=8'hb8;
//        8'h9b: out=8'h14;
//        8'h9c: out=8'hde;
//        8'h9d: out=8'h5e;
//        8'h9e: out=8'h0b;
//        8'h9f: out=8'hdb;
//        8'ha0: out=8'he0;
//        8'ha1: out=8'h32;
//        8'ha2: out=8'h3a;
//        8'ha3: out=8'h0a;
//        8'ha4: out=8'h49;
//        8'ha5: out=8'h06;
//        8'ha6: out=8'h24;
//        8'ha7: out=8'h5c;
//        8'ha8: out=8'hc2;
//        8'ha9: out=8'hd3;
//        8'haa: out=8'hac;
//        8'hab: out=8'h62;
//        8'hac: out=8'h91;
//        8'had: out=8'h95;
//        8'hae: out=8'he4;
//        8'haf: out=8'h79;
//        8'hb0: out=8'he7;
//        8'hb1: out=8'hc8;
//        8'hb2: out=8'h37;
//        8'hb3: out=8'h6d;
//        8'hb4: out=8'h8d;
//        8'hb5: out=8'hd5;
//        8'hb6: out=8'h4e;
//        8'hb7: out=8'ha9;
//        8'hb8: out=8'h6c;
//        8'hb9: out=8'h56;
//        8'hba: out=8'hf4;
//        8'hbb: out=8'hea;
//        8'hbc: out=8'h65;
//        8'hbd: out=8'h7a;
//        8'hbe: out=8'hae;
//        8'hbf: out=8'h08;
//        8'hc0: out=8'hba;
//        8'hc1: out=8'h78;
//        8'hc2: out=8'h25;
//        8'hc3: out=8'h2e;
//        8'hc4: out=8'h1c;
//        8'hc5: out=8'ha6;
//        8'hc6: out=8'hb4;
//        8'hc7: out=8'hc6;
//        8'hc8: out=8'he8;
//        8'hc9: out=8'hdd;
//        8'hca: out=8'h74;
//        8'hcb: out=8'h1f;
//        8'hcc: out=8'h4b;
//        8'hcd: out=8'hbd;
//        8'hce: out=8'h8b;
//        8'hcf: out=8'h8a;
//        8'hd0: out=8'h70;
//        8'hd1: out=8'h3e;
//        8'hd2: out=8'hb5;
//        8'hd3: out=8'h66;
//        8'hd4: out=8'h48;
//        8'hd5: out=8'h03;
//        8'hd6: out=8'hf6;
//        8'hd7: out=8'h0e;
//        8'hd8: out=8'h61;
//        8'hd9: out=8'h35;
//        8'hda: out=8'h57;
//        8'hdb: out=8'hb9;
//        8'hdc: out=8'h86;
//        8'hdd: out=8'hc1;
//        8'hde: out=8'h1d;
//        8'hdf: out=8'h9e;
//        8'he0: out=8'he1;
//        8'he1: out=8'hf8;
//        8'he2: out=8'h98;
//        8'he3: out=8'h11;
//        8'he4: out=8'h69;
//        8'he5: out=8'hd9;
//        8'he6: out=8'h8e;
//        8'he7: out=8'h94;
//        8'he8: out=8'h9b;
//        8'he9: out=8'h1e;
//        8'hea: out=8'h87;
//        8'heb: out=8'he9;
//        8'hec: out=8'hce;
//        8'hed: out=8'h55;
//        8'hee: out=8'h28;
//        8'hef: out=8'hdf;
//        8'hf0: out=8'h8c;
//        8'hf1: out=8'ha1;
//        8'hf2: out=8'h89;
//        8'hf3: out=8'h0d;
//        8'hf4: out=8'hbf;
//        8'hf5: out=8'he6;
//        8'hf6: out=8'h42;
//        8'hf7: out=8'h68;
//        8'hf8: out=8'h41;
//        8'hf9: out=8'h99;
//        8'hfa: out=8'h2d;
//        8'hfb: out=8'h0f;
//        8'hfc: out=8'hb0;
//        8'hfd: out=8'h54;
//        8'hfe: out=8'hbb;
//        8'hff: out=8'h16;
//        default:out=8'h00;
//        endcase
//    end
 
//endmodule
 
 
// module AES_Rcon(
//    input[3:0] in,
//    output[31:0] out
//);
//   reg[31:0] rcon[31:0];

//    initial begin
//        rcon[1]=32'h01000000;
//        rcon[2]=32'h02000000;
//        rcon[3]=32'h04000000;
//        rcon[4]=32'h08000000;
//        rcon[5]=32'h10000000;
//        rcon[6]=32'h20000000;
//        rcon[7]=32'h40000000;
//        rcon[8]=32'h80000000;
//        rcon[9]=32'h1b000000;
//        rcon[10]=32'h36000000;
//    end
    
//    assign out = rcon[in];

//endmodule