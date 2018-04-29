module vga_sync (
	input	wire		clk,
	input	wire		nrst,
	output	wire		hsync,
	output	wire		vsync,
	output	wire		video_on,
	output	wire		p_tick,
	output	wire [9:0]	pixel_x,
	output	wire [9:0]	pixel_y);

parameter V_PX = 480;	// Vertical Display Area
parameter V_FP = 10;	// Vertical Front Porch
parameter V_BP = 33;	// Vertical Back Porch
parameter V_RT = 2;		// Vertical Retrace Virtual Lenghth

parameter H_PX = 640;	// Horizontal Display Area
parameter H_FP = 16;	// Horizontal Front Porch
parameter H_BP = 48;	// Horizontal Back Porch
parameter H_RT = 96;	// Horizontal Retrace Virtual Length

reg 		cdiv_r;
reg 		p_tick_r;

reg			v_cnt_nxt;
reg			h_cnt_nxt;
reg [9:0]	v_cnt_r;
reg [9:0]	h_cnt_r;

reg 		v_sync_r;
reg 		h_sync_r;

reg			v_done_r;
reg			h_done_r;

assign	video_on = (h_cnt_r<H_PX && v_cnt_r<V_PX)?1'b1:1'b0;
assign	p_tick = p_tick_r;
assign	hsync = h_sync_r;
assign	vsync = v_sync_r;
assign	pixel_x = h_cnt_r;
assign	pixel_y = v_cnt_r;

always @ (posedge clk or negedge nrst) begin
	if(~nrst) begin
		// Sync'd Negedge Reset
		cdiv_r <= 1'b0;
		v_cnt_r <= 10'b0;
		h_cnt_r <= 10'b0;
		v_sync_r <= 1'b0;
		h_sync_r <= 1'b0;
	end else begin
		// Timing Signals
		cdiv_r <= ~cdiv_r;
		p_tick_r <= cdiv_r?1'b1:1'b0;

		v_cnt_r <= v_cnt_nxt;
		h_cnt_r <= h_cnt_nxt;
		v_sync_r <= (h_cnt_r>=(V_PX+V_FP) && v_cnt_r<=(V_PX+V_FP+V_RT-1))?
					1'b1:1'b0;
		h_sync_r <= (h_cnt_r>=(H_PX+H_FP) && h_cnt_r<=(H_PX+H_FP+H_RT-1))?
					1'b1:1'b0;
	end
end

always @ (*) begin
	 if(p_tick_r) begin
	 	if(h_done_r) 	h_cnt_nxt = 10'b0;
	 	else			h_cnt_nxt = h_cnt_r + 1;
	 end else			h_cnt_nxt = h_cnt_r;

	 if(p_tick_r && h_done_r) begin
	 	if(v_done_r) 	v_cnt_nxt = 10'b0;
	 	else			v_cnt_nxt = v_cnt_r + 1;
	 end else			v_cnt_nxt = v_cnt_r;
end

endmodule // vga_sync
