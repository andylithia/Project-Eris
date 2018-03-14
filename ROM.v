module QUAD_ROM(
	input		cph1,
	input		cph2,
	input		pon,
	input		sync,

	input		ia,
	inout		is,
	output		ws
);

reg [7:0]		adr_buf_r;
reg [2:0]		ws_buf_r;
reg [9:0]		inst_buf_r;

reg [1:0]		rom_page_id;


endmodule // QUAD_ROM
