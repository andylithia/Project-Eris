///***< LICENSE - HEAD >**********************************************************/
// MIT License
//
// Copyright (c) 2018 AndyLithia
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
///***< LICENSE - TAIL >**********************************************************/
`timescale  100ns / 1ns

// A fake ROM primitive for simulation
module ROM10b (
	input [9:0]			Address,
	input				OutClock,
	input				OutClockEn,
	input				Reset,
	output reg [9:0]	Q	
);

always @(posedge OutClock) begin
	if(OutClockEn) begin
		case(Address)
			10'h0000:	Q <= 10'h00DD;
			10'h0001:	Q <= 10'h02FF;
			10'h0002:	Q <= 10'h0224;
			10'h0003:	Q <= 10'h0017;
			10'h0004:	Q <= 10'h0144;
			10'h0005:	Q <= 10'h0244;
			10'h0006:	Q <= 10'h0084;
			10'h0007:	Q <= 10'h0110;
			10'h0008:	Q <= 10'h02D1;
			10'h0009:	Q <= 10'h03FB;
			10'h000A:	Q <= 10'h005F;
			10'h000B:	Q <= 10'h00C3;
			10'h000C:	Q <= 10'h01A8;
			10'h000D:	Q <= 10'h0367;
			10'h000E:	Q <= 10'h02EE;
			10'h000F:	Q <= 10'h03E2;
			10'h0010:	Q <= 10'h002E;
			10'h0011:	Q <= 10'h0090;
			10'h0012:	Q <= 10'h03EA;
			10'h0013:	Q <= 10'h03EA;
			10'h0014:	Q <= 10'h03EA;
			10'h0015:	Q <= 10'h006B;
			10'h0016:	Q <= 10'h0269;
			10'h0017:	Q <= 10'h00A8;
			10'h0018:	Q <= 10'h02A8;
			10'h0019:	Q <= 10'h00FF;
			10'h001A:	Q <= 10'h03EA;
			10'h001B:	Q <= 10'h03EA;
			10'h001C:	Q <= 10'h03EA;
			10'h001D:	Q <= 10'h0030;
			10'h001E:	Q <= 10'h00CC;
			10'h001F:	Q <= 10'h00AA;
			10'h0020:	Q <= 10'h01A8;
			10'h0021:	Q <= 10'h0043;
			10'h0022:	Q <= 10'h01D3;
			10'h0023:	Q <= 10'h00CC;
			10'h0024:	Q <= 10'h0030;
			10'h0025:	Q <= 10'h0000;
			10'h0026:	Q <= 10'h0083;
			10'h0027:	Q <= 10'h0144;
			10'h0028:	Q <= 10'h0044;
			10'h0029:	Q <= 10'h00BB;
			10'h002A:	Q <= 10'h0244;
			10'h002B:	Q <= 10'h009F;
			10'h002C:	Q <= 10'h0284;
			10'h002D:	Q <= 10'h030B;
			10'h002E:	Q <= 10'h002E;
			10'h002F:	Q <= 10'h0090;
			10'h0030:	Q <= 10'h0328;
			10'h0031:	Q <= 10'h036F;
			10'h0032:	Q <= 10'h03EA;
			10'h0033:	Q <= 10'h03EA;
			10'h0034:	Q <= 10'h03EA;
			10'h0035:	Q <= 10'h004B;
			10'h0036:	Q <= 10'h0267;
			10'h0037:	Q <= 10'h03A8;
			10'h0038:	Q <= 10'h0171;
			10'h0039:	Q <= 10'h0377;
			10'h003A:	Q <= 10'h03CB;
			10'h003B:	Q <= 10'h02CE;
			10'h003C:	Q <= 10'h00C4;
			10'h003D:	Q <= 10'h01DB;
			10'h003E:	Q <= 10'h0128;
			10'h003F:	Q <= 10'h0034;
			10'h0040:	Q <= 10'h02CE;
			10'h0041:	Q <= 10'h0375;
			10'h0042:	Q <= 10'h012E;
			10'h0043:	Q <= 10'h02FA;
			10'h0044:	Q <= 10'h0116;
			10'h0045:	Q <= 10'h036A;
			10'h0046:	Q <= 10'h0383;
			10'h0047:	Q <= 10'h01BA;
			10'h0048:	Q <= 10'h039B;
			10'h0049:	Q <= 10'h0336;
			10'h004A:	Q <= 10'h034C;
			10'h004B:	Q <= 10'h039B;
			10'h004C:	Q <= 10'h001C;
			10'h004D:	Q <= 10'h01EA;
			10'h004E:	Q <= 10'h0002;
			10'h004F:	Q <= 10'h0133;
			10'h0050:	Q <= 10'h02C4;
			10'h0051:	Q <= 10'h02D6;
			10'h0052:	Q <= 10'h03A6;
			10'h0053:	Q <= 10'h0114;
			10'h0054:	Q <= 10'h021F;
			10'h0055:	Q <= 10'h017D;
			10'h0056:	Q <= 10'h0377;
			10'h0057:	Q <= 10'h00D2;
			10'h0058:	Q <= 10'h0172;
			10'h0059:	Q <= 10'h00DA;
			10'h005A:	Q <= 10'h038A;
			10'h005B:	Q <= 10'h0177;
			10'h005C:	Q <= 10'h00CE;
			10'h005D:	Q <= 10'h0034;
			10'h005E:	Q <= 10'h018E;
			10'h005F:	Q <= 10'h030C;
			10'h0060:	Q <= 10'h012A;
			10'h0061:	Q <= 10'h018A;
			10'h0062:	Q <= 10'h01BA;
			10'h0063:	Q <= 10'h01A3;
			10'h0064:	Q <= 10'h00AA;
			10'h0065:	Q <= 10'h017A;
			10'h0066:	Q <= 10'h015F;
			10'h0067:	Q <= 10'h014C;
			10'h0068:	Q <= 10'h03AA;
			10'h0069:	Q <= 10'h0114;
			10'h006A:	Q <= 10'h010B;
			10'h006B:	Q <= 10'h032A;
			10'h006C:	Q <= 10'h002A;
			10'h006D:	Q <= 10'h03DD;
			10'h006E:	Q <= 10'h010A;
			10'h006F:	Q <= 10'h02CE;
			10'h0070:	Q <= 10'h032C;
			10'h0071:	Q <= 10'h0227;
			10'h0072:	Q <= 10'h03B2;
			10'h0073:	Q <= 10'h01EB;
			10'h0074:	Q <= 10'h02D1;
			10'h0075:	Q <= 10'h0090;
			10'h0076:	Q <= 10'h0114;
			10'h0077:	Q <= 10'h03DB;
			10'h0078:	Q <= 10'h03B2;
			10'h0079:	Q <= 10'h00FA;
			10'h007A:	Q <= 10'h018E;
			10'h007B:	Q <= 10'h01BA;
			10'h007C:	Q <= 10'h01FF;
			10'h007D:	Q <= 10'h00DA;
			10'h007E:	Q <= 10'h00AA;
			10'h007F:	Q <= 10'h034C;
			10'h0080:	Q <= 10'h0116;
			10'h0081:	Q <= 10'h016A;
			10'h0082:	Q <= 10'h027E;
			10'h0083:	Q <= 10'h013B;
			10'h0084:	Q <= 10'h0276;
			10'h0085:	Q <= 10'h0203;
			10'h0086:	Q <= 10'h00CA;
			10'h0087:	Q <= 10'h03DD;
			10'h0088:	Q <= 10'h02D6;
			10'h0089:	Q <= 10'h019E;
			10'h008A:	Q <= 10'h032C;
			10'h008B:	Q <= 10'h024F;
			10'h008C:	Q <= 10'h008E;
			10'h008D:	Q <= 10'h01EE;
			10'h008E:	Q <= 10'h004C;
			10'h008F:	Q <= 10'h0112;
			10'h0090:	Q <= 10'h003C;
			10'h0091:	Q <= 10'h01A2;
			10'h0092:	Q <= 10'h023F;
			10'h0093:	Q <= 10'h03AE;
			10'h0094:	Q <= 10'h00EC;
			10'h0095:	Q <= 10'h03E7;
			10'h0096:	Q <= 10'h00CA;
			10'h0097:	Q <= 10'h0184;
			10'h0098:	Q <= 10'h01EB;
			10'h0099:	Q <= 10'h00FE;
			10'h009A:	Q <= 10'h01A8;
			10'h009B:	Q <= 10'h002E;
			10'h009C:	Q <= 10'h03FA;
			10'h009D:	Q <= 10'h03FA;
			10'h009E:	Q <= 10'h01FA;
			10'h009F:	Q <= 10'h01FA;
			10'h00A0:	Q <= 10'h004A;
			10'h00A1:	Q <= 10'h028F;
			10'h00A2:	Q <= 10'h03AE;
			10'h00A3:	Q <= 10'h03A6;
			10'h00A4:	Q <= 10'h01A6;
			10'h00A5:	Q <= 10'h029F;
			10'h00A6:	Q <= 10'h03AE;
			10'h00A7:	Q <= 10'h0226;
			10'h00A8:	Q <= 10'h004A;
			10'h00A9:	Q <= 10'h02FB;
			10'h00AA:	Q <= 10'h028E;
			10'h00AB:	Q <= 10'h03EA;
			10'h00AC:	Q <= 10'h000E;
			10'h00AD:	Q <= 10'h02FB;
			10'h00AE:	Q <= 10'h02A3;
			10'h00AF:	Q <= 10'h02F6;
			10'h00B0:	Q <= 10'h00D4;
			10'h00B1:	Q <= 10'h02D3;
			10'h00B2:	Q <= 10'h037E;
			10'h00B3:	Q <= 10'h00FE;
			10'h00B4:	Q <= 10'h01D4;
			10'h00B5:	Q <= 10'h02DF;
			10'h00B6:	Q <= 10'h0128;
			10'h00B7:	Q <= 10'h01C4;
			10'h00B8:	Q <= 10'h00CE;
			10'h00B9:	Q <= 10'h016E;
			10'h00BA:	Q <= 10'h00BE;
			10'h00BB:	Q <= 10'h01FE;
			10'h00BC:	Q <= 10'h022E;
			10'h00BD:	Q <= 10'h0030;
			10'h00BE:	Q <= 10'h0090;
			10'h00BF:	Q <= 10'h0171;
			10'h00C0:	Q <= 10'h0144;
			10'h00C1:	Q <= 10'h0377;
			10'h00C2:	Q <= 10'h02CE;
			10'h00C3:	Q <= 10'h019E;
			10'h00C4:	Q <= 10'h0224;
			10'h00C5:	Q <= 10'h033F;
			10'h00C6:	Q <= 10'h01FA;
			10'h00C7:	Q <= 10'h0204;
			10'h00C8:	Q <= 10'h0154;
			10'h00C9:	Q <= 10'h0337;
			10'h00CA:	Q <= 10'h01EA;
			10'h00CB:	Q <= 10'h031B;
			10'h00CC:	Q <= 10'h0028;
			10'h00CD:	Q <= 10'h0014;
			10'h00CE:	Q <= 10'h031F;
			10'h00CF:	Q <= 10'h0024;
			10'h00D0:	Q <= 10'h001C;
			10'h00D1:	Q <= 10'h032C;
			10'h00D2:	Q <= 10'h0343;
			10'h00D3:	Q <= 10'h0228;
			10'h00D4:	Q <= 10'h0214;
			10'h00D5:	Q <= 10'h0333;
			10'h00D6:	Q <= 10'h010E;
			10'h00D7:	Q <= 10'h0164;
			10'h00D8:	Q <= 10'h00D0;
			10'h00D9:	Q <= 10'h0128;
			10'h00DA:	Q <= 10'h03AE;
			10'h00DB:	Q <= 10'h0175;
			10'h00DC:	Q <= 10'h01C4;
			10'h00DD:	Q <= 10'h03DD;
			10'h00DE:	Q <= 10'h02BD;
			10'h00DF:	Q <= 10'h022B;
			10'h00E0:	Q <= 10'h02D6;
			10'h00E1:	Q <= 10'h001C;
			10'h00E2:	Q <= 10'h00AC;
			10'h00E3:	Q <= 10'h0117;
			10'h00E4:	Q <= 10'h030C;
			10'h00E5:	Q <= 10'h02EE;
			10'h00E6:	Q <= 10'h02F6;
			10'h00E7:	Q <= 10'h03E2;
			10'h00E8:	Q <= 10'h03E2;
			10'h00E9:	Q <= 10'h008C;
			10'h00EA:	Q <= 10'h003C;
			10'h00EB:	Q <= 10'h0362;
			10'h00EC:	Q <= 10'h03BF;
			10'h00ED:	Q <= 10'h0002;
			10'h00EE:	Q <= 10'h03AB;
			10'h00EF:	Q <= 10'h03E2;
			10'h00F0:	Q <= 10'h032E;
			10'h00F1:	Q <= 10'h0030;
			10'h00F2:	Q <= 10'h0104;
			10'h00F3:	Q <= 10'h02D4;
			10'h00F4:	Q <= 10'h0073;
			10'h00F5:	Q <= 10'h01BF;
			10'h00F6:	Q <= 10'h00FE;
			10'h00F7:	Q <= 10'h02A4;
			10'h00F8:	Q <= 10'h030F;
			10'h00F9:	Q <= 10'h0194;
			10'h00FA:	Q <= 10'h03F3;
			10'h00FB:	Q <= 10'h001C;
			10'h00FC:	Q <= 10'h0292;
			10'h00FD:	Q <= 10'h01E9;
			10'h00FE:	Q <= 10'h02A8;
			10'h00FF:	Q <= 10'h036F;
			10'h0100:	Q <= 10'h03CF;
			10'h0101:	Q <= 10'h032E;
			10'h0102:	Q <= 10'h00A1;
			10'h0103:	Q <= 10'h01A8;
			10'h0104:	Q <= 10'h00A1;
			10'h0105:	Q <= 10'h01A8;
			10'h0106:	Q <= 10'h0254;
			10'h0107:	Q <= 10'h0027;
			10'h0108:	Q <= 10'h03AE;
			10'h0109:	Q <= 10'h0154;
			10'h010A:	Q <= 10'h004B;
			10'h010B:	Q <= 10'h00DE;
			10'h010C:	Q <= 10'h0299;
			10'h010D:	Q <= 10'h0128;
			10'h010E:	Q <= 10'h0295;
			10'h010F:	Q <= 10'h0261;
			10'h0110:	Q <= 10'h0095;
			10'h0111:	Q <= 10'h01A8;
			10'h0112:	Q <= 10'h0299;
			10'h0113:	Q <= 10'h0294;
			10'h0114:	Q <= 10'h036B;
			10'h0115:	Q <= 10'h02EE;
			10'h0116:	Q <= 10'h03E2;
			10'h0117:	Q <= 10'h0126;
			10'h0118:	Q <= 10'h03A6;
			10'h0119:	Q <= 10'h016A;
			10'h011A:	Q <= 10'h0292;
			10'h011B:	Q <= 10'h01BA;
			10'h011C:	Q <= 10'h0067;
			10'h011D:	Q <= 10'h02D2;
			10'h011E:	Q <= 10'h01EA;
			10'h011F:	Q <= 10'h0077;
			10'h0120:	Q <= 10'h02CE;
			10'h0121:	Q <= 10'h028E;
			10'h0122:	Q <= 10'h0128;
			10'h0123:	Q <= 10'h022E;
			10'h0124:	Q <= 10'h0107;
			10'h0125:	Q <= 10'h022E;
			10'h0126:	Q <= 10'h010C;
			10'h0127:	Q <= 10'h037B;
			10'h0128:	Q <= 10'h0128;
			10'h0129:	Q <= 10'h03AE;
			10'h012A:	Q <= 10'h01A2;
			10'h012B:	Q <= 10'h00B7;
			10'h012C:	Q <= 10'h00AE;
			10'h012D:	Q <= 10'h018E;
			10'h012E:	Q <= 10'h008A;
			10'h012F:	Q <= 10'h032F;
			10'h0130:	Q <= 10'h018E;
			10'h0131:	Q <= 10'h0054;
			10'h0132:	Q <= 10'h0097;
			10'h0133:	Q <= 10'h0294;
			10'h0134:	Q <= 10'h01B7;
			10'h0135:	Q <= 10'h0154;
			10'h0136:	Q <= 10'h0057;
			10'h0137:	Q <= 10'h00FE;
			10'h0138:	Q <= 10'h03BE;
			10'h0139:	Q <= 10'h0037;
			10'h013A:	Q <= 10'h0292;
			10'h013B:	Q <= 10'h037E;
			10'h013C:	Q <= 10'h00EB;
			10'h013D:	Q <= 10'h01FE;
			10'h013E:	Q <= 10'h0332;
			10'h013F:	Q <= 10'h01D2;
			10'h0140:	Q <= 10'h032E;
			10'h0141:	Q <= 10'h012E;
			10'h0142:	Q <= 10'h0352;
			10'h0143:	Q <= 10'h00EF;
			10'h0144:	Q <= 10'h01A8;
			10'h0145:	Q <= 10'h02CE;
			10'h0146:	Q <= 10'h03B2;
			10'h0147:	Q <= 10'h032E;
			10'h0148:	Q <= 10'h0112;
			10'h0149:	Q <= 10'h0128;
			10'h014A:	Q <= 10'h03FE;
			10'h014B:	Q <= 10'h03FE;
			10'h014C:	Q <= 10'h008F;
			10'h014D:	Q <= 10'h00CE;
			10'h014E:	Q <= 10'h002A;
			10'h014F:	Q <= 10'h02D6;
			10'h0150:	Q <= 10'h02C9;
			10'h0151:	Q <= 10'h0162;
			10'h0152:	Q <= 10'h01A8;
			10'h0153:	Q <= 10'h03AE;
			10'h0154:	Q <= 10'h010C;
			10'h0155:	Q <= 10'h0291;
			10'h0156:	Q <= 10'h018C;
			10'h0157:	Q <= 10'h026D;
			10'h0158:	Q <= 10'h020C;
			10'h0159:	Q <= 10'h026D;
			10'h015A:	Q <= 10'h008C;
			10'h015B:	Q <= 10'h0218;
			10'h015C:	Q <= 10'h028C;
			10'h015D:	Q <= 10'h026D;
			10'h015E:	Q <= 10'h0239;
			10'h015F:	Q <= 10'h026D;
			10'h0160:	Q <= 10'h0331;
			10'h0161:	Q <= 10'h010E;
			10'h0162:	Q <= 10'h026D;
			10'h0163:	Q <= 10'h008E;
			10'h0164:	Q <= 10'h032D;
			10'h0165:	Q <= 10'h0331;
			10'h0166:	Q <= 10'h02AE;
			10'h0167:	Q <= 10'h0299;
			10'h0168:	Q <= 10'h0254;
			10'h0169:	Q <= 10'h01B3;
			10'h016A:	Q <= 10'h00FE;
			10'h016B:	Q <= 10'h0261;
			10'h016C:	Q <= 10'h0064;
			10'h016D:	Q <= 10'h00CE;
			10'h016E:	Q <= 10'h0162;
			10'h016F:	Q <= 10'h01EA;
			10'h0170:	Q <= 10'h0054;
			10'h0171:	Q <= 10'h0297;
			10'h0172:	Q <= 10'h0299;
			10'h0173:	Q <= 10'h0331;
			10'h0174:	Q <= 10'h02AE;
			10'h0175:	Q <= 10'h0295;
			10'h0176:	Q <= 10'h0331;
			10'h0177:	Q <= 10'h02AE;
			10'h0178:	Q <= 10'h02AE;
			10'h0179:	Q <= 10'h0255;
			10'h017A:	Q <= 10'h02AE;
			10'h017B:	Q <= 10'h03AD;
			10'h017C:	Q <= 10'h0331;
			10'h017D:	Q <= 10'h028C;
			10'h017E:	Q <= 10'h0271;
			10'h017F:	Q <= 10'h0239;
			10'h0180:	Q <= 10'h020C;
			10'h0181:	Q <= 10'h0275;
			10'h0182:	Q <= 10'h008C;
			10'h0183:	Q <= 10'h0218;
			10'h0184:	Q <= 10'h018C;
			10'h0185:	Q <= 10'h0271;
			10'h0186:	Q <= 10'h010C;
			10'h0187:	Q <= 10'h0271;
			10'h0188:	Q <= 10'h0271;
			10'h0189:	Q <= 10'h032E;
			10'h018A:	Q <= 10'h024E;
			10'h018B:	Q <= 10'h034C;
			10'h018C:	Q <= 10'h0158;
			10'h018D:	Q <= 10'h03EF;
			10'h018E:	Q <= 10'h018C;
			10'h018F:	Q <= 10'h0218;
			10'h0190:	Q <= 10'h0198;
			10'h0191:	Q <= 10'h0158;
			10'h0192:	Q <= 10'h0098;
			10'h0193:	Q <= 10'h0118;
			10'h0194:	Q <= 10'h0258;
			10'h0195:	Q <= 10'h0054;
			10'h0196:	Q <= 10'h036B;
			10'h0197:	Q <= 10'h0030;
			10'h0198:	Q <= 10'h02EE;
			10'h0199:	Q <= 10'h03E2;
			10'h019A:	Q <= 10'h0010;
			10'h019B:	Q <= 10'h0110;
			10'h019C:	Q <= 10'h010E;
			10'h019D:	Q <= 10'h0296;
			10'h019E:	Q <= 10'h022E;
			10'h019F:	Q <= 10'h0287;
			10'h01A0:	Q <= 10'h01FE;
			10'h01A1:	Q <= 10'h030E;
			10'h01A2:	Q <= 10'h0283;
			10'h01A3:	Q <= 10'h038E;
			10'h01A4:	Q <= 10'h0110;
			10'h01A5:	Q <= 10'h0110;
			10'h01A6:	Q <= 10'h014A;
			10'h01A7:	Q <= 10'h0110;
			10'h01A8:	Q <= 10'h01E2;
			10'h01A9:	Q <= 10'h034E;
			10'h01AA:	Q <= 10'h02A3;
			10'h01AB:	Q <= 10'h03CE;
			10'h01AC:	Q <= 10'h010E;
			10'h01AD:	Q <= 10'h001C;
			10'h01AE:	Q <= 10'h0252;
			10'h01AF:	Q <= 10'h002C;
			10'h01B0:	Q <= 10'h02A7;
			10'h01B1:	Q <= 10'h00B7;
			10'h01B2:	Q <= 10'h01E2;
			10'h01B3:	Q <= 10'h0316;
			10'h01B4:	Q <= 10'h02CB;
			10'h01B5:	Q <= 10'h0396;
			10'h01B6:	Q <= 10'h0116;
			10'h01B7:	Q <= 10'h001C;
			10'h01B8:	Q <= 10'h002C;
			10'h01B9:	Q <= 10'h02CF;
			10'h01BA:	Q <= 10'h00B7;
			10'h01BB:	Q <= 10'h001C;
			10'h01BC:	Q <= 10'h0396;
			10'h01BD:	Q <= 10'h036F;
			10'h01BE:	Q <= 10'h0010;
			10'h01BF:	Q <= 10'h017A;
			10'h01C0:	Q <= 10'h017A;
			10'h01C1:	Q <= 10'h02EA;
			10'h01C2:	Q <= 10'h035E;
			10'h01C3:	Q <= 10'h027E;
			10'h01C4:	Q <= 10'h031B;
			10'h01C5:	Q <= 10'h0110;
			10'h01C6:	Q <= 10'h0206;
			10'h01C7:	Q <= 10'h032B;
			10'h01C8:	Q <= 10'h00FE;
			10'h01C9:	Q <= 10'h032E;
			10'h01CA:	Q <= 10'h030E;
			10'h01CB:	Q <= 10'h0110;
			10'h01CC:	Q <= 10'h00CE;
			10'h01CD:	Q <= 10'h02CC;
			10'h01CE:	Q <= 10'h01D8;
			10'h01CF:	Q <= 10'h0218;
			10'h01D0:	Q <= 10'h0158;
			10'h01D1:	Q <= 10'h00D8;
			10'h01D2:	Q <= 10'h0258;
			10'h01D3:	Q <= 10'h0218;
			10'h01D4:	Q <= 10'h0058;
			10'h01D5:	Q <= 10'h0198;
			10'h01D6:	Q <= 10'h00D8;
			10'h01D7:	Q <= 10'h0158;
			10'h01D8:	Q <= 10'h030C;
			10'h01D9:	Q <= 10'h0030;
			10'h01DA:	Q <= 10'h0010;
			10'h01DB:	Q <= 10'h038A;
			10'h01DC:	Q <= 10'h037B;
			10'h01DD:	Q <= 10'h0162;
			10'h01DE:	Q <= 10'h01FE;
			10'h01DF:	Q <= 10'h002C;
			10'h01E0:	Q <= 10'h02EF;
			10'h01E1:	Q <= 10'h03AA;
			10'h01E2:	Q <= 10'h02EA;
			10'h01E3:	Q <= 10'h0062;
			10'h01E4:	Q <= 10'h039B;
			10'h01E5:	Q <= 10'h02CE;
			10'h01E6:	Q <= 10'h024E;
			10'h01E7:	Q <= 10'h022A;
			10'h01E8:	Q <= 10'h00CA;
			10'h01E9:	Q <= 10'h030C;
			10'h01EA:	Q <= 10'h02BB;
			10'h01EB:	Q <= 10'h0110;
			10'h01EC:	Q <= 10'h0292;
			10'h01ED:	Q <= 10'h0292;
			10'h01EE:	Q <= 10'h017E;
			10'h01EF:	Q <= 10'h03B3;
			10'h01F0:	Q <= 10'h01D2;
			10'h01F1:	Q <= 10'h0312;
			10'h01F2:	Q <= 10'h0232;
			10'h01F3:	Q <= 10'h008E;
			10'h01F4:	Q <= 10'h037E;
			10'h01F5:	Q <= 10'h03BB;
			10'h01F6:	Q <= 10'h03B2;
			10'h01F7:	Q <= 10'h01A8;
			10'h01F8:	Q <= 10'h001E;
			10'h01F9:	Q <= 10'h0007;
			10'h01FA:	Q <= 10'h010E;
			10'h01FB:	Q <= 10'h03B2;
			10'h01FC:	Q <= 10'h0128;
			10'h01FD:	Q <= 10'h0292;
			10'h01FE:	Q <= 10'h017E;
			10'h01FF:	Q <= 10'h023E;
			10'h0200:	Q <= 10'h0010;
			10'h0201:	Q <= 10'h033E;
			10'h0202:	Q <= 10'h03FE;
			10'h0203:	Q <= 10'h0256;
			10'h0204:	Q <= 10'h0112;
			10'h0205:	Q <= 10'h004B;
			10'h0206:	Q <= 10'h01A8;
			10'h0207:	Q <= 10'h0299;
			10'h0208:	Q <= 10'h018E;
			10'h0209:	Q <= 10'h0214;
			10'h020A:	Q <= 10'h010B;
			10'h020B:	Q <= 10'h02EE;
			10'h020C:	Q <= 10'h0346;
			10'h020D:	Q <= 10'h0003;
			10'h020E:	Q <= 10'h02CE;
			10'h020F:	Q <= 10'h017E;
			10'h0210:	Q <= 10'h0003;
			10'h0211:	Q <= 10'h01FE;
			10'h0212:	Q <= 10'h012E;
			10'h0213:	Q <= 10'h0259;
			10'h0214:	Q <= 10'h0362;
			10'h0215:	Q <= 10'h0047;
			10'h0216:	Q <= 10'h0332;
			10'h0217:	Q <= 10'h039E;
			10'h0218:	Q <= 10'h0007;
			10'h0219:	Q <= 10'h01CC;
			10'h021A:	Q <= 10'h01B5;
			10'h021B:	Q <= 10'h020C;
			10'h021C:	Q <= 10'h0275;
			10'h021D:	Q <= 10'h024C;
			10'h021E:	Q <= 10'h0271;
			10'h021F:	Q <= 10'h03F9;
			10'h0220:	Q <= 10'h028C;
			10'h0221:	Q <= 10'h0271;
			10'h0222:	Q <= 10'h01F5;
			10'h0223:	Q <= 10'h02CC;
			10'h0224:	Q <= 10'h0271;
			10'h0225:	Q <= 10'h037D;
			10'h0226:	Q <= 10'h0271;
			10'h0227:	Q <= 10'h02E5;
			10'h0228:	Q <= 10'h0271;
			10'h0229:	Q <= 10'h03D9;
			10'h022A:	Q <= 10'h03AE;
			10'h022B:	Q <= 10'h014E;
			10'h022C:	Q <= 10'h001A;
			10'h022D:	Q <= 10'h00BF;
			10'h022E:	Q <= 10'h014E;
			10'h022F:	Q <= 10'h032E;
			10'h0230:	Q <= 10'h001C;
			10'h0231:	Q <= 10'h010E;
			10'h0232:	Q <= 10'h006C;
			10'h0233:	Q <= 10'h00C3;
			10'h0234:	Q <= 10'h03AE;
			10'h0235:	Q <= 10'h01BE;
			10'h0236:	Q <= 10'h00E3;
			10'h0237:	Q <= 10'h00E6;
			10'h0238:	Q <= 10'h01EA;
			10'h0239:	Q <= 10'h02CC;
			10'h023A:	Q <= 10'h0315;
			10'h023B:	Q <= 10'h0254;
			10'h023C:	Q <= 10'h001B;
			10'h023D:	Q <= 10'h0154;
			10'h023E:	Q <= 10'h0253;
			10'h023F:	Q <= 10'h03D9;
			10'h0240:	Q <= 10'h029D;
			10'h0241:	Q <= 10'h0253;
			10'h0242:	Q <= 10'h03D9;
			10'h0243:	Q <= 10'h03B1;
			10'h0244:	Q <= 10'h02E5;
			10'h0245:	Q <= 10'h02CC;
			10'h0246:	Q <= 10'h026D;
			10'h0247:	Q <= 10'h037D;
			10'h0248:	Q <= 10'h028C;
			10'h0249:	Q <= 10'h026D;
			10'h024A:	Q <= 10'h01F5;
			10'h024B:	Q <= 10'h024C;
			10'h024C:	Q <= 10'h026D;
			10'h024D:	Q <= 10'h03F9;
			10'h024E:	Q <= 10'h020C;
			10'h024F:	Q <= 10'h026D;
			10'h0250:	Q <= 10'h026D;
			10'h0251:	Q <= 10'h026D;
			10'h0252:	Q <= 10'h018C;
			10'h0253:	Q <= 10'h02F2;
			10'h0254:	Q <= 10'h034C;
			10'h0255:	Q <= 10'h022E;
			10'h0256:	Q <= 10'h03AE;
			10'h0257:	Q <= 10'h0198;
			10'h0258:	Q <= 10'h023B;
			10'h0259:	Q <= 10'h0094;
			10'h025A:	Q <= 10'h017B;
			10'h025B:	Q <= 10'h03EA;
			10'h025C:	Q <= 10'h027A;
			10'h025D:	Q <= 10'h030B;
			10'h025E:	Q <= 10'h0316;
			10'h025F:	Q <= 10'h0167;
			10'h0260:	Q <= 10'h0396;
			10'h0261:	Q <= 10'h010E;
			10'h0262:	Q <= 10'h016A;
			10'h0263:	Q <= 10'h0173;
			10'h0264:	Q <= 10'h02CE;
			10'h0265:	Q <= 10'h00D2;
			10'h0266:	Q <= 10'h03AA;
			10'h0267:	Q <= 10'h01BE;
			10'h0268:	Q <= 10'h01B3;
			10'h0269:	Q <= 10'h032E;
			10'h026A:	Q <= 10'h030E;
			10'h026B:	Q <= 10'h00EE;
			10'h026C:	Q <= 10'h02CE;
			10'h026D:	Q <= 10'h022E;
			10'h026E:	Q <= 10'h00CE;
			10'h026F:	Q <= 10'h0166;
			10'h0270:	Q <= 10'h0094;
			10'h0271:	Q <= 10'h01DB;
			10'h0272:	Q <= 10'h0118;
			10'h0273:	Q <= 10'h01E6;
			10'h0274:	Q <= 10'h01E7;
			10'h0275:	Q <= 10'h0198;
			10'h0276:	Q <= 10'h006C;
			10'h0277:	Q <= 10'h01D7;
			10'h0278:	Q <= 10'h024E;
			10'h0279:	Q <= 10'h024E;
			10'h027A:	Q <= 10'h0094;
			10'h027B:	Q <= 10'h0253;
			10'h027C:	Q <= 10'h0030;
			10'h027D:	Q <= 10'h01CC;
			10'h027E:	Q <= 10'h00D8;
			10'h027F:	Q <= 10'h00D8;
			10'h0280:	Q <= 10'h0018;
			10'h0281:	Q <= 10'h0218;
			10'h0282:	Q <= 10'h0158;
			10'h0283:	Q <= 10'h0018;
			10'h0284:	Q <= 10'h0258;
			10'h0285:	Q <= 10'h03AB;
			10'h0286:	Q <= 10'h0259;
			10'h0287:	Q <= 10'h03E2;
			10'h0288:	Q <= 10'h012E;
			10'h0289:	Q <= 10'h017E;
			10'h028A:	Q <= 10'h021B;
			10'h028B:	Q <= 10'h02D2;
			10'h028C:	Q <= 10'h03AE;
			10'h028D:	Q <= 10'h0116;
			10'h028E:	Q <= 10'h03AE;
			10'h028F:	Q <= 10'h037E;
			10'h0290:	Q <= 10'h0223;
			10'h0291:	Q <= 10'h032E;
			10'h0292:	Q <= 10'h03E2;
			10'h0293:	Q <= 10'h0331;
			10'h0294:	Q <= 10'h0090;
			10'h0295:	Q <= 10'h02D2;
			10'h0296:	Q <= 10'h037E;
			10'h0297:	Q <= 10'h0257;
			10'h0298:	Q <= 10'h02FE;
			10'h0299:	Q <= 10'h038E;
			10'h029A:	Q <= 10'h0030;
			10'h029B:	Q <= 10'h0090;
			10'h029C:	Q <= 10'h02CE;
			10'h029D:	Q <= 10'h022E;
			10'h029E:	Q <= 10'h0283;
			10'h029F:	Q <= 10'h038E;
			10'h02A0:	Q <= 10'h017E;
			10'h02A1:	Q <= 10'h027F;
			10'h02A2:	Q <= 10'h03AE;
			10'h02A3:	Q <= 10'h0116;
			10'h02A4:	Q <= 10'h03AE;
			10'h02A5:	Q <= 10'h01B7;
			10'h02A6:	Q <= 10'h00CC;
			10'h02A7:	Q <= 10'h01CA;
			10'h02A8:	Q <= 10'h015E;
			10'h02A9:	Q <= 10'h02AF;
			10'h02AA:	Q <= 10'h00BE;
			10'h02AB:	Q <= 10'h0326;
			10'h02AC:	Q <= 10'h02EE;
			10'h02AD:	Q <= 10'h032C;
			10'h02AE:	Q <= 10'h0317;
			10'h02AF:	Q <= 10'h0066;
			10'h02B0:	Q <= 10'h02DB;
			10'h02B1:	Q <= 10'h0054;
			10'h02B2:	Q <= 10'h0003;
			10'h02B3:	Q <= 10'h0092;
			10'h02B4:	Q <= 10'h0366;
			10'h02B5:	Q <= 10'h01FA;
			10'h02B6:	Q <= 10'h0232;
			10'h02B7:	Q <= 10'h03A6;
			10'h02B8:	Q <= 10'h0090;
			10'h02B9:	Q <= 10'h0224;
			10'h02BA:	Q <= 10'h0198;
			10'h02BB:	Q <= 10'h0258;
			10'h02BC:	Q <= 10'h00D8;
			10'h02BD:	Q <= 10'h0058;
			10'h02BE:	Q <= 10'h0118;
			10'h02BF:	Q <= 10'h01D8;
			10'h02C0:	Q <= 10'h0058;
			10'h02C1:	Q <= 10'h039B;
			10'h02C2:	Q <= 10'h03E6;
			10'h02C3:	Q <= 10'h0193;
			10'h02C4:	Q <= 10'h038E;
			10'h02C5:	Q <= 10'h0162;
			10'h02C6:	Q <= 10'h0313;
			10'h02C7:	Q <= 10'h02CE;
			10'h02C8:	Q <= 10'h003C;
			10'h02C9:	Q <= 10'h036C;
			10'h02CA:	Q <= 10'h0317;
			10'h02CB:	Q <= 10'h01EA;
			10'h02CC:	Q <= 10'h02FE;
			10'h02CD:	Q <= 10'h030C;
			10'h02CE:	Q <= 10'h002E;
			10'h02CF:	Q <= 10'h0262;
			10'h02D0:	Q <= 10'h035B;
			10'h02D1:	Q <= 10'h010E;
			10'h02D2:	Q <= 10'h016A;
			10'h02D3:	Q <= 10'h026E;
			10'h02D4:	Q <= 10'h033F;
			10'h02D5:	Q <= 10'h00CE;
			10'h02D6:	Q <= 10'h012A;
			10'h02D7:	Q <= 10'h038E;
			10'h02D8:	Q <= 10'h027E;
			10'h02D9:	Q <= 10'h031F;
			10'h02DA:	Q <= 10'h03A6;
			10'h02DB:	Q <= 10'h018E;
			10'h02DC:	Q <= 10'h002E;
			10'h02DD:	Q <= 10'h030C;
			10'h02DE:	Q <= 10'h01EB;
			10'h02DF:	Q <= 10'h024C;
			10'h02E0:	Q <= 10'h00D8;
			10'h02E1:	Q <= 10'h0058;
			10'h02E2:	Q <= 10'h0018;
			10'h02E3:	Q <= 10'h0058;
			10'h02E4:	Q <= 10'h01D8;
			10'h02E5:	Q <= 10'h0258;
			10'h02E6:	Q <= 10'h0218;
			10'h02E7:	Q <= 10'h0018;
			10'h02E8:	Q <= 10'h0158;
			10'h02E9:	Q <= 10'h0158;
			10'h02EA:	Q <= 10'h00D8;
			10'h02EB:	Q <= 10'h0377;
			10'h02EC:	Q <= 10'h03AE;
			10'h02ED:	Q <= 10'h012E;
			10'h02EE:	Q <= 10'h0186;
			10'h02EF:	Q <= 10'h02BA;
			10'h02F0:	Q <= 10'h017B;
			10'h02F1:	Q <= 10'h01FA;
			10'h02F2:	Q <= 10'h02CE;
			10'h02F3:	Q <= 10'h01EA;
			10'h02F4:	Q <= 10'h03CB;
			10'h02F5:	Q <= 10'h019F;
			10'h02F6:	Q <= 10'h00CE;
			10'h02F7:	Q <= 10'h030C;
			10'h02F8:	Q <= 10'h0098;
			10'h02F9:	Q <= 10'h00D8;
			10'h02FA:	Q <= 10'h0018;
			10'h02FB:	Q <= 10'h0098;
			10'h02FC:	Q <= 10'h0158;
			10'h02FD:	Q <= 10'h0207;
			10'h02FE:	Q <= 10'h014C;
			10'h02FF:	Q <= 10'h01FB;

			default:	Q <= 10'h0000;
		endcase
	end else begin
		Q <= 10'h0000;
	end
end

endmodule