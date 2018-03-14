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