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


module DISP5584 (
	// input		cfst,
	input		cph1,
	input		cph2,
	input		pon,
	input		sync,
	input		start,
	input [4:0]	anode_data,	
	input		set,

	output		scd_sdclk,
	output		scd_load_n,
	output		scd_rst_n,
	output		scd_data
);

reg	[19:0]		input_decode_r;
reg [24:0]		send_buf_r;
reg [3:0]		pos_r;
	
endmodule