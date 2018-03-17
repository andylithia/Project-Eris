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

module SYS_tb;

reg			cfst;
wire		cph1, cph2;
wire		ws_rom;
wire		ws_ctc;
wire		ws_combined = ws_rom || ws_ctc;

// Dual Phase CLK Generation
// Since the bandwidth of FPGA interconnect is very high,
// The original HP design can generate severe spikes in an FPGA.
// We use a single-hot counter to eliminate this issue.
reg [7:0]	clk_div;
assign cph1 = clk_div[0]&&!clk_div[1]&&!clk_div[7];
assign cph2 = clk_div[3]&&!clk_div[2]&&!clk_div[4];
always @ (posedge cfst or negedge rstb) begin
	if(!rstb)	clk_div <= 8'b00000001;
	else		clk_div <= {clk_div[6:0],clk_div[7]};
end

// Instances
ARC ARC_inst(
	.cph1		(cph1),
	.cph2		(cph2),
	.is			(is),
	.ws			(ws_combined),
	.sync		(sync),

	.carry		(carry),
	.start		(start),
	.disp_data	(disp_data)
);

QUAD_ROM ROM_inst(
	.cph1		(cph1),
	.cph2		(cph2),
	.pon		(rstn),
	.sync		(sync),
	.ia			(ia),

	.is			(is),
	.ws			(ws_rom),
	.d_page		(d_page),
	.lpmode		(1'b0)
);

CTC CTC_inst(
	.cph1		(cph1),
	.cph2		(cph2),
	.pon		(rstn),
	.is			(is),
	.carry		(carry),

	.ia			(ia),
	.ws			(ws_ctc)
	.sync		(sync)
);


endmodule // SYS_tb
