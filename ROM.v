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
	// input				cph2,
	input				pon,
	input				sync,

	input				ia,
	output wire			is,
	output				ws,
	output wire [1:0]	d_page
);

reg [5:0]		sys_cnt_r;

reg [7:0]		ia_buf_sr;

reg [7:0]		adr_buf_r;
reg [2:0]		ws_buf_r;
reg [9:0]		inst_buf_r;

reg [1:0]		rom_page_id;
wire [9:0]		rom_read_adr;
wire [9:0]		rom_read_data;

wire			te_t11;
wire			te_t28;
wire			te_t29;
wire			te_t55;
wire			te_is;


assign te_t11 = sys_cnt_r == 6'd11;
assign te_t28 = sys_cnt_r == 6'd28;					// Latch Address(?)
assign te_t29 = sys_cnt_r == 6'd29;					// Latch Data
assign te_t55 = sys_cnt_r == 6'd55;
assign te_is = (sys_cnt_r>=6'd45)&&(sys_cnt_r<=6'd54);

assign is = te_t11 || (inst_buf_r[0]&&te_is);

always @ (posedge cph1 or negedge sync) begin
	if(~sync)					sys_cnt_r <= 0;
	else if(sys_cnt_r == 6'd55)	sys_cnt_r <= 0;
	else						sys_cnt_r <= sys_cnt_r + 1;
end

assign d_page = rom_page_id;
assign rom_read_adr = {rom_page_id, adr_buf_r};

always @ (posedge cph1 or posedge pon) begin
	if(pon)	rom_page_id <= 0; // Power On Seq
	else begin 
		if(te_t55&&(inst_buf_r[6:0]==7'b0_0100_00)
			rom_page_id <= inst_buf_r[9:7];

		if(te_is)	inst_buf_r <= {inst_buf_r[0], inst_buf_r[9:1]};
	end
end

// Lattice EBR ROM primitive (init'd by HP35ROM.mem)
ROM10b ROMinst(
	.Address(rom_read_adr),
	.OutClock(te_t28),
	.OutClockEn(1'b1),
	.Reset(1'b0),
	.Q(rom_read_data)
);

always @ (posedge te_t29) begin
	inst_buf_r <= rom_read_data;
end

endmodule // QUAD_ROM
