module CTC (
	//input			cph1,
	input			cph2,
	//input			pon,
	input			nrst,
	input			is,
	input			carry
	output			ws,
	output wire		sync,

	output [7:0]	kr,
	input [4:0]		kc
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

reg [5:0]		kc_buf_r;		// keycode Buffer

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

always @ (posedge cph2) begin
	if (sys_cnt_r == 6'd55)	sys_cnt_r <= 0;
	else					sys_cnt_r <= sys_cnt_r + 1;
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



endmodule // CTC