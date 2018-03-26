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

	output wire		ia,
	output			ws,
	output wire		sync,
	output [7:0]	kr
);

/***** Gating Signals *********************************************************/
wire 			itype_brn;
wire			itype_jsb;
wire			itype_rtn;

wire			ia_out_en;
reg				ia_out_buf_r;

/***** Registers **************************************************************/
reg [7:0]		ssr_2_sr;		// ROM Address Buffer
reg [11:0]		ssr_1_sr;		// Status bits
reg [7:0]		ssr_0_sr;		// Return Address Buffer

reg				ssr_2_cen_r;
reg				ssr_1_cen_r;
reg				ssr_0_cen_r;	

reg				ssr_2_nxt;
reg				ssr_0_nxt;

reg				as_en_r;		// Adder enable
reg				as_out;			// Adder output
reg				as_cry_r;		// Adder Carry

reg [9:0]		is_buf_sr;		// The inst being executed this cycle
// reg [7:0]		ibody_dly_r;	// Equal to is_buf_sr[9:2];
// reg [1:0]		itype_dly_r;		
reg				is_has_imm_fr;

reg				carry_in_r;		// JNC Flag


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

wire			te_ia;			// IA output, T20-T27, 8 cycle, RADR first pass
wire			te_is;			// IS Available, T45-T55, 10 cycle
wire			te_t0_7;		// RTN first pass
wire			te_t8_19;		// STBT first pass
wire			te_t47;			// RADR second pass begin
wire			te_t55;			// Done Refreshing
wire			te_t0;			// Start Signal
wire			te_t4km1;		// The Last Clock Of A Digit Time

reg				te_p;			// 000 pointer
reg				te_wp;			// 001 word thru ptr

wire			stat_bits_pos;	// the stat bit beging operated on, first pass

/******************************************************************************
/*	System Counter & Timing
/*****************************************************************************/
// Attention: a binary counter was used at this point, 
//            potentially a better solution
assign sync 		= te_is;
// assign te_ibody		= (sys_cnt_r>=6'd47)&&(sys_cnt_r<=6'd54);
// assign te_itype		= (sys_cnt_r>=6'd45)&&(sys_cnt_r<=6'd46);
// assign te_is		= (sys_cnt_r>=6'd45)&&(sys_cnt_r<=6'd54);
assign te_is		= sys_cnt_r[5]&&(
					(&{sys_cnt_r[4],|{~sys_cnt_r[2:0]}})	||
					(&{sys_cnt_r[3:2],|{sys_cnt_r[1:0]}}));

assign te_ia		= sys_cnt_r[4]&&(
					(&{~sys_cnt_r[5], ~sys_cnt_r[3],
						|{&sys_cnt_r[1:0], sys_cnt_r[2]}})	||
					(&{~sys_cnt_r[2], sys_cnt_r[4:3], ~|sys_cnt_r[1:0]}));

assign te_t0_7		= sys_cnt_r <= 6'd07;
assign te_t8_19		= (sys_cnt_r <= 6'd19)&&~te_t0_7;

assign te_t55		= (sys_cnt_r == 6'd55);
assign te_t47		= (sys_cnt_r <= 6'd47)&&te_is;
assign te_t48		= (sys_cnt_r <= 6'd48)&&te_is;
assign te_t0		= (sys_cnt_r == 6'd0);

assign te_t4km1		= (sys_cnt_r[1:0] == 2'b11);
assign te_t4k		= (sys_cnt_r[1:0] == 2'b00);

always @ (posedge cph2) begin
	if (sys_cnt_r == 6'd55)	sys_cnt_r <= 0;
	else					sys_cnt_r <= sys_cnt_r + 1;
end

/******************************************************************************
/*	OPCODE Buffer and Address Buffer (GTO or JSB)
/*****************************************************************************/
// Necessary?
// ATTENTION: a problem is that the itype should be determined
//  as soon as the first 2 bits entered the sr

assign itype_jsb = (is_buf_sr[1:0] == 2'b01);
assign itype_brn = (is_buf_sr[1:0] == 2'b11);
assign itype_rtn = (is_buf_sr == 10'b0xxx_1100_00);
assign itype_sst = (is_buf_sr == 10'bxxxx_0001_00);
assign itype_cst = (is_buf_sr == 10'bxxxx_1001_00);
assign itype_tst = (is_buf_sr == 10'bxxxx_0000_00);

assign stat_bits_pos = {~sys_cnt_r[3],sys_cnt_r[2:0]}; // -8

assign ia = (ia_out_en)?ia_out_buf_r:1'b0;

always @ (posedge cph2) begin

	if(te_is) 
		// Load new IS
		is_buf_sr <= {is, is_buf_sr[9:1]};
	else if(is_has_imm_fr) 
		// Circulate the ibody if it is imm address
		is_buf_sr <= {is_buf_sr[2], is_buf_sr[9:3], is_buf_sr[1:0]};
	else
		is_buf_sr <= is_buf_sr;

	// Determine whether the ibody is imm address
	if(te_t47)	
		is_has_imm_fr <= is_buf_sr[8];
end

// Maybe I should write this part in the style that I've written the ARC in.


/*
always @ (posedge cph2) begin
	
	if(itype_brn) begin

	end else begin
		if(itype_rtn) begin
			if(te_t0_7) begin
				ssr_2_sr <= {ssr_0_sr[0],ssr_2_sr[7:1]};
				ssr_1_sr <= ssr_1_sr;
				ssr_0_sr <= {ssr_0_sr[0],ssr_0_sr[7:1]};
				ia_out_buf_r <= 1'bx;
			end else if (te_ia) begin
				{ssr_2_sr, ssr_1_sr} <= {ssr_2_sr, ssr_1_sr};
				ssr_0_sr <= {ssr_0_sr[0],ssr_0_sr[7:1]};
				ia_out_buf_r <= ssr_0_sr[0];
		end else if(itype_jsb&&te_ibody) begin
			// @T47: [STBT][RTN][RADR]
			// IS->[STBT]->[RTN]-X-->[RADR]-|
			//                     |--(+1)<--
			{ssr_2_sr, ssr_1_sr, ssr_0_sr}
			<= {is, ssr_2_sr, ssr_1_sr[11:1], as_out, ssr_0_sr[7:1]};
			ia_out_buf_r <= 1'bx;
		end else begin
			// Normal loop
			{ssr_2_sr, ssr_1_sr, ssr_0_sr}
				<= {ssr_0_sr[0], ssr_2_sr, ssr_1_sr, ssr_0_sr[7:1]};
			ia_out_buf_r <= 1'bx;
		end
	end
end
*/

// NORM:   ssr2   ssr1   ssr0   ia
// Begin: [RADR] [STBT] [RTN]  [    ]
//  8clk: [RTN]  [RADR] [STBT] [    ]
// 12clk: [STBT] [RTN]  [RADR] [    ]
//  8clk: [RADR] [STBT] [RTN]  [RADR]
//  8clk: [RTN]  [RADR] [STBT] [RADR]
// 12clk: [STBT] [RTN]  [RADR] [RADR]
//  8clk: [RADR] [STBT] [RTN]  []

// RTN:    ssr2    ssr1   ssr0  ia
// Begin: [RADR]  [STBT] [RTN] [   ]
//  8clk: [RTN]   [STBT] [RTN] [   ]
// 12clk: [RTN]   [STBT] [RTN] [   ]
//  8clk: [RTN+1] [STBT] [RTN] [RTN]

// JSB:    ssr2     ssr1     ssr0     ia
//   T47: [STBT]   [RTN]    [RADR]   [  ]
// Begin: [IS]     [STBT]   [RADR+1] [  ]
//  8clk: [RADR+1] [IS]     [STBT]   [  ]
// 12clk: [STBT]   [RADR+1] [IS]     [  ]
//  8clk: [IS+1]   [STBT]   [RADR+1] [IS]

// BRH:    ssr2   ssr1   ssr0   ia
//         abuf
//   T47: [STBT] [RTN]  [RADR] [    ]
//        [    ]
// Begin: [RADR] [STBT] [RTN]  [    ]
//        [IS]
//  8clk: [RTN]  [RADR] [STBT] [    ]
//        [IS]
// 12clk: [STBT] [RTN]  [RADR] [    ]
//        [ISL-H]
// -If no carry-
//  8clk: [IS+1] [STBT] [RTN]  [IS+1]
//        [ISL-H]


always @ (*) begin
	// ssr_2_sr entry
	if(te_is&&itype_jsb) 	ssr_2_nxt = is;		// JSB
	else					ssr_2_nxt = as_out;	// RTN: RADR, NORM: RADR+1
												// BRH: ABUF+1 (when no carry)
												// STATUS Related OPs
	// ssr_0_sr entry
	if(te_ia&&itype_rtn)	ssr_0_nxt = ssr_0_sr[0];	// RTN
	else 					ssr_0_nxt = ssr_1_sr[0];
end

always @ (posedge cph2) begin
	if(ssr_2_cen_r)	ssr_2_sr <= {ssr_2_nxt, ssr_2_sr[7:1]};
	else 			ssr_2_sr <= ssr_2_sr;
	if(ssr_1_cen_r) ssr_1_sr <= {ssr_2_sr[0], ssr_1_sr[11:1]};
	else 			ssr_1_sr <= ssr_1_sr;
	if(ssr_0_cen_r)	ssr_0_sr <= {ssr_0_nxt, ssr_0_sr[7:1]};
	else			ssr_0_sr <= ssr_0_sr;
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
	end else			ws = 0;
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
		ssr_1_sr[0] <= 1'b1;
		kcode_buf_r <= sys_cnt_r;
	end
end

// The sequence of bank switching
// 

endmodule // CTC