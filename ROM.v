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


module QUAD_ROM(
	input				cph1,
	input				cph2,
	input				pon,
	input				sync,

	input				ia,
	output wire			is,
	output wire			ws,
	output wire [1:0]	d_page,
	input				lpmode
);

///***< NOTE - HEAD >**********************************************************/
//	Description:	  This project is a cycle-exact replica of the HP classic
//					series calculator chip set. Namely A&R and C&T. This File is
//					the complete design of the bit-serial ROM Chip.
//
//	Information:	The Original Timing is:
//	  0_//_|19:ROM ADR IN|27:ROM ACCESS|44:TO INST|45:IS OUT|55:SET NXT ws_u|0_//_
//	        8             17            1          10        1
//
//	Date 18.03.16:	Rough Coding Finished and tested. Seemes working fine.
//					One issue is that the PON is treated as a normal async rst,
//					This can be made better, just like the sync signal.
///***< NOTE - TAIL >**********************************************************/


reg [5:0]		sys_cnt_r;

reg [7:0]		ia_buf_sr;

reg [7:0]		adr_buf_r;
reg [9:0]		inst_buf_r;
reg [4:0]		inst_dly_slot_sr;
reg [2:0]		ws_buf_r;
reg				ws_u;

reg [1:0]		rom_page_id;
wire [9:0]		rom_read_adr;
wire [9:0]		rom_read_data;

reg				pre_sync;
reg				pre_pon;

wire			te_t11;
wire			te_t28;
wire			te_t29;
wire			te_t55;
wire			te_is;

wire			te_m;
wire			te_x;
wire			te_ms;
wire			te_xs;
wire			te_s;

// Debug information
assign d_page = rom_page_id;

/******************************************************************************
/*	System Counter and Timing Signals
/*****************************************************************************/
assign te_t11	= sys_cnt_r == 6'd11;
assign te_t28 	= sys_cnt_r == 6'd28;					// Latch Address(?)
assign te_t29	= sys_cnt_r == 6'd29;					// Latch Data
assign te_t55	= sys_cnt_r == 6'd55;

// Note: These gate-level implementations may make no difference in LUTs
/*assign te_is	= sys_cnt_r[5]&&(
					(&{sys_cnt_r[4],|{~sys_cnt_r[2:0]}})	||
					(&{sys_cnt_r[3:2],|{sys_cnt_r[1:0]}}));
assign te_ia	= sys_cnt_r[4]&&(
					(&{~sys_cnt_r[5], ~sys_cnt_r[3],
						|{&sys_cnt_r[1:0], sys_cnt_r[2]}})	||
					(&{~sys_cnt_r[2], sys_cnt_r[4:3], ~|sys_cnt_r[1:0]}));
*/
assign te_is	= (sys_cnt_r>=6'd45)&&(sys_cnt_r<=6'd54);
assign te_ia	= (sys_cnt_r>=6'd19)&&(sys_cnt_r<=6'd26);
assign te_m		= (sys_cnt_r[5:2]>=4'd3)&&(sys_cnt_r[5:2]<=4'd12);
assign te_x		= (sys_cnt_r[5:2]<=4'd2);
assign te_ms	= (sys_cnt_r[5:2]>=4'd3)&&(sys_cnt_r[5:2]<=4'd13);
assign te_xs	= (sys_cnt_r[5:2]==4'd2);
assign te_s		= (sys_cnt_r[5:2]==4'd13);

always @ (posedge cph2) begin
	if(!sync && pre_sync)		pre_sync <= 0;
	else if (sync)				pre_sync <= 1;

	if(!sync && pre_sync)		sys_cnt_r <= 6'b0;
	else 						sys_cnt_r <= sys_cnt_r + 1;
end

/******************************************************************************
/*	Registers
/*****************************************************************************/
assign is = te_t11 || (inst_buf_r[0]&&te_is);

// CPH2: SET & CONTROL CLOCK
always @ (posedge cph2 or negedge pon) begin
	if(~pon)	
		// Power On Seq
		rom_page_id <= 0;
	else begin 
		if(te_t29) begin
			// ROM Sel Handling
			if(inst_buf_r[6:0]==7'b0_0100_00)
				rom_page_id <= inst_buf_r[9:7];
		end
		if(te_is)	{inst_buf_r,inst_dly_slot_sr}
					 <= {inst_dly_slot_sr[0]
					 	, inst_buf_r[9:0]
					 	, inst_dly_slot_sr[4:1]};
	end
end

// CPH1: SAMPLE CLOCK
always @ (posedge cph1 or negedge pon) begin
	if(~pon)	adr_buf_r <= 0;	// Notice: in the original design, this was done in
							// shift reg fashion.
	else begin
		if(te_ia)	adr_buf_r <= {ia,adr_buf_r[7:1]};
	end
end

/******************************************************************************
/*	Word Select Decoding
/*****************************************************************************/
always @ (*) begin
	casex(ws_buf_r) 
		3'b001: ws_u = te_m;
		3'b010:	ws_u = te_x;
		3'b011:	ws_u = 1'b1;
		3'bx00:	ws_u = 1'b0;
		3'b101:	ws_u = te_ms;
		3'b110: ws_u = te_xs;
		3'b111: ws_u = te_s;
	endcase
end

// Simulating the original design, not necessary
// assign ws = ws_u&&cph2;
assign ws = ws_u;

always @ (posedge te_t55) begin
	if(inst_buf_r[6:5]==2'b10)
		ws_buf_r <= inst_buf_r[9:7];
	else
		ws_buf_r <= 3'b000;
end

/******************************************************************************
/*	Lattice EBR ROM primitive (init'd by HP35ROM.mem)
/*****************************************************************************/
// When lpmode is high, the RAM block is in its lowest power mode
ROM10b ROMinst(
	.Address(rom_read_adr),
	.OutClock(te_t28&&(~lpmode)),
	.OutClockEn(~lpmode),
	.Reset(1'b0),
	.Q(rom_read_data)
);

assign rom_read_adr = {rom_page_id, adr_buf_r};

always @ (posedge te_t29) begin
	inst_buf_r <= rom_read_data;
end

endmodule // QUAD_ROM
