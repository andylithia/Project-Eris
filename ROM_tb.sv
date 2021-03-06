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
module ROM_tb;

reg			cph1, cph2;
reg			rstn;

reg [5:0]	sys_cnt_ph2_r;
reg [5:0]	sys_cnt_ph1_r;
reg			sync;
wire		is;
reg			ia;
wire		ws;
wire [1:0]	d_page;
reg [9:0]	adr_r		= 10'b0;

QUAD_ROM uut(
	.cph1  (cph1),
	.cph2  (cph2),
	.pon   (rstn),
	.sync  (sync),
	.is    (is),
	.ia    (ia),
	.ws    (ws),
	.d_page(d_page),
	.lpmode(1'b0)
  );

initial begin
	cph1 = 0;
	cph2 = 0;
	rstn = 0;
	#35 rstn = 1;
end

// CLK generation
always begin
	#6	cph1 = 0;
	#6	cph1 = 1;
	#30	cph2 = 0;
	#6	cph2 = 1;
end

assign	sync = (sys_cnt_ph2_r >= 6'd45)
				&&(sys_cnt_ph2_r <= 6'd54);

always_ff @ (posedge cph2 or negedge rstn) begin
	if(~rstn) begin
		sys_cnt_ph2_r <= 0;
		adr_r <= 0;
	end else if(sys_cnt_ph2_r == 6'd55) begin
		adr_r <= adr_r + 1;
 		sys_cnt_ph2_r <= 0;
 	end else sys_cnt_ph2_r <= sys_cnt_ph2_r + 1;
end

always_comb begin
	case(sys_cnt_ph2_r)
		6'd19:	ia = adr_r[0];
		6'd20:	ia = adr_r[1];
		6'd21:	ia = adr_r[2];
		6'd22:	ia = adr_r[3];
		6'd23:	ia = adr_r[4];
		6'd24:	ia = adr_r[5];
		6'd25:	ia = adr_r[6];
		6'd26:	ia = adr_r[7];
		default:ia = 0;
	endcase // sys_cnt_ph2_r
end

/*
always_ff @ (posedge cph1 or negedge rstn) begin
	if(~rstn)
			sys_cnt_ph1_r <= 0;
	else if(sys_cnt_ph1_r == 6'd55)
 			sys_cnt_ph1_r <= 0;
 	else	sys_cnt_ph1_r <= sys_cnt_ph1_r + 1;
end
*/

endmodule // ROM_tb
