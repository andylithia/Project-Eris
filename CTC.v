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

module CTC (
	input			cph1,
	input			cph2,
	input			pon,
	// input			nrst,
	input			is,
	input			carry,
	input [4:0]		kc,

	output			ia,
	output			ws,
	output wire		sync,
	output [7:0]	kr
);

/***** Gating Signals *********************************************************/
reg 			c_jsb_en_r;
reg				c_brh_en_r;

/***** Shift Registers ********************************************************/
reg [7:0]		adr_r;			// ROM Address Buffer
reg [11:0]		stat_bits_r;	// Status bits
reg [7:0]		rtn_adr_r;		// Return Address Buffer

reg [9:0]		is_buf_sr;		// The inst being fetched this cycle
reg [9:0]		is_buf_dly_r;	// The inst being executed this cycle

reg [5:0]		kcode_buf_r;	// keycode Buffer
reg				kdown;
// reg [2:0]		kc_mask;

/***** Pointer ****************************************************************/
reg [3:0]		ptr_r;			// Pointer Register
reg				ws_type_r;		// handles 000(p) and 001(wp)
reg				ws_drive_en_r;
reg				ws_wp_done_r;	// Reached the Pointer in wp mode;

/***** Timings ****************************************************************/
reg [5:0]		sys_cnt_r;		// System Counter (Binary)

wire			te_is;			// IS Available, T45-T55, 10 cycle
wire			te_t55;			// Done Refreshing
wire			te_t0;			// Start Signal
wire			te_t4km1;		// The Last Clock Of A Digit Time

reg				te_p;			// 000 pointer
reg				te_wp;			// 001 word thru ptr

/******************************************************************************
/*	System Counter & Timing
/*****************************************************************************/
// Attention: a binary counter was used at this point, 
//            potentially a better solution
assign sync 		= te_is;
assign te_is		= (sys_cnt_r>=6'd45)&&(sys_cnt_r<=6'd54);
assign te_t55		= (sys_cnt_r == 6'd55);
assign te_t0		= (sys_cnt_r == 6'd0);
assign te_t4km1		= (sys_cnt_r[1:0] == 2'b11);
assign te_t4k		= (sys_cnt_r[1:0] == 2'b00);

always @ (posedge cph2) begin
	if (sys_cnt_r == 6'd55)	sys_cnt_r <= 0;
	else					sys_cnt_r <= sys_cnt_r + 1;
end

/******************************************************************************
/*	OPCODE Buffer
/*****************************************************************************/
always @ (posedge cph2) begin
	if(te_is)		is_buf_sr <= {is, is_buf_sr[9:1]};
	if(te_t55)		is_buf_dly_r <= is_buf_sr;
end
/******************************************************************************
/*	Pointer WS Signal
/*****************************************************************************/
// **** DONE...? ****
always @ (*) begin
	te_p = sys_cnt_r[5:2] == ptr_r;

	if(ws_drive_en_r) begin
		if(ws_type_r)	ws =  ~ws_wp_done_r||te_p;
		else			ws = te_p;
	end else		ws = 0;
end

always @ (posedge cph2) begin
	if(te_t55 && (is_buf_sr[1:0]==2'b10)) begin
		ws_type_r <= is_buf_sr[2];
		ws_drive_en_r <= (~|{is_buf_sr[4],is_buf_sr[3]});
	end
	if(te_t55)	ws_wp_done_r <= 0;
end

always @ (posedge te_p) begin
	if(~ws_wp_done_r)	ws_wp_done_r <= 1;
end

/******************************************************************************
/*	Key Scanner
/*****************************************************************************/
always @ (*) begin
	// Kr
	case(sys_cnt_r[2:0]) 
		3'b000:	kr = 8'b0000_0001;
		3'b001: kr = 8'b0000_0100;
		3'b010: kr = 8'b0010_0000;
		3'b011: kr = 8'b0100_0000;
		3'b100: kr = 8'b1000_0000;
		3'b101: kr = 8'b0000_0010;
		3'b110: kr = 8'b0001_0000;
		3'b111: kr = 8'b0000_1000;
	endcase // sys_cnt_r[2:0]

	case(sys_cnt_r[5:3])
		3'b000: kdown = kc[0]; 
		3'b010: kdown = kc[1];
		3'b011: kdown = kc[2];
		3'b101: kdown = kc[3];
		3'b110: kdown = kc[4];
		default:kdown = 1'b0;
	endcase
end

always @ (posedge cph1) begin
	if(kdown) begin
		stat_bits_r[0] <= 1'b1;
		kcode_buf_r <= sys_cnt_r;
	end
end

// The sequence of bank switching
// 

endmodule // CTC