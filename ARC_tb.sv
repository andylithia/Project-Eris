`timescale  100ns / 1ns
module ARC_tb;

reg cph1, cph2;
reg cfst;
reg rstn;

reg [5:0]	sys_cnt_ph2_r;
reg [7:0]	em_adr_r;
reg	[9:0]	em_is_r;
reg			em_is;
wire 		em_sync;

wire		out_carry;
wire		out_start;
wire [4:0]	out_anode_data;

wire		te_p;
wire		te_m;
wire		te_x;
wire		te_wp;
wire		te_ms;
wire		te_xs;
wire		te_s;

reg [2:0]	te_type;
reg [2:0]	te_type_dly_r;
reg			te_en_dly_r;
reg			em_ws;
reg	[3:0]	ptr_r;

initial begin
	cfst = 0;
	cph1 = 0;
	cph2 = 0;
	rstn = 0;

	#35 rstn = 1;
end

// CLK generation
always begin
	#6	cph1 = 0;
	#6	cph1 = 1;
	#30	cph2 = 0;
	#6	cph2 = 1;
end

ARC uut(
	.cph1		(cph1),
	.cph2		(cph2),
	.is			(em_is),
	.ws			(em_ws),
	.sync		(em_sync),
	.carry		(out_carry),
	.start		(out_start),
	.disp_data	(out_anode_data)
	);

assign	em_sync = (sys_cnt_ph2_r >= 6'd45)
					&&(sys_cnt_ph2_r <= 6'd54);

always_ff @ (posedge cph2 or negedge rstn) begin
	if(~rstn) begin
		sys_cnt_ph2_r <= 0;
		em_adr_r <= 0;
	end else if(sys_cnt_ph2_r == 6'd55) begin
		em_adr_r <= em_adr_r + 1;
 		sys_cnt_ph2_r <= 0;
 	end else sys_cnt_ph2_r <= sys_cnt_ph2_r + 1;
end

// ***** Time Enables *****
assign te_d0 = (sys_cnt_ph2_r[5:2]==0);
assign te_d13 = (sys_cnt_ph2_r[5:2]==4'd13);

assign te_p = (sys_cnt_ph2_r[5:2]==ptr_r);
assign te_m = (sys_cnt_ph2_r[5:2]>=4'd3)&&(sys_cnt_ph2_r[5:2]<=4'd12);
assign te_x = (sys_cnt_ph2_r[5:2]<=4'd2);
assign te_w = 1'b1;
assign te_wp = (sys_cnt_ph2_r[5:2]<=ptr_r);
assign te_ms = (sys_cnt_ph2_r[5:2]>=4'd3)&&(sys_cnt_ph2_r[5:2]<=4'd13);
assign te_xs = (sys_cnt_ph2_r[5:2]==4'd2);
assign te_s = te_d13;

always_comb begin
	ptr_r = 3;
	//if(te_en_dly_r)
		case(te_type_dly_r)
			3'b000:	em_ws = te_p;
			3'b001:	em_ws = te_m;
			3'b010:	em_ws = te_x;
			3'b011:	em_ws = te_w;
			3'b100:	em_ws = te_wp;
			3'b101:	em_ws = te_ms;
			3'b110:	em_ws = te_xs;
			3'b111:	em_ws = te_s;
		endcase
	//else			em_ws = 1'b0;
	
	te_type = em_is_r[4:2];
end

always @ (posedge te_d0) begin
	te_type_dly_r <= te_type;
	te_en_dly_r <= em_is_r[1:0]==2'b10;
end

// ***** Test Data Generation *****
always_comb begin
	case(em_adr_r) 
		8'h00:	em_is_r = 10'b11101_010_00;	// CLREG
		8'h01:	em_is_r = 10'b11101_010_00;	// CLREG
		/*
		8'h02:	em_is_r = 10'b11111_000_10; // A=A+1[p]
		8'h03:	em_is_r = 10'b11111_001_10; // A=A+1[m]
		8'h04:	em_is_r = 10'b11111_010_10; // A=A+1[x]
		8'h05:	em_is_r = 10'b11111_011_10; // A=A+1[w]
		8'h06:	em_is_r = 10'b11111_100_10; // A=A+1[wp]
		8'h07:	em_is_r = 10'b11111_101_10; // A=A+1[ms]
		8'h08:	em_is_r = 10'b11111_110_10; // A=A+1[xs]
		8'h09:	em_is_r = 10'b11111_111_10; // A=A+1[s]
		8'h0A:	em_is_r = 10'b11111_000_10; // A=A+1[p]
		8'h0B:	em_is_r = 10'b11111_000_10; // A=A+1[p]
		8'h0C:	em_is_r = 10'b11111_000_10; // A=A+1[p]
		8'h0D:	em_is_r = 10'b11111_000_10; // A=A+1[p] // 12 in total
		8'h0E:	em_is_r = 10'b11011_000_10; // A=A-1
		*/
		default:em_is_r = 10'b00000_000_00;	// NOP
	endcase // em_adr_r	

	case(sys_cnt_ph2_r)
		6'd45:	em_is = em_is_r[0];
		6'd46:	em_is = em_is_r[1];
		6'd47:	em_is = em_is_r[2];
		6'd48:	em_is = em_is_r[3];
		6'd49:	em_is = em_is_r[4];
		6'd50:	em_is = em_is_r[5];
		6'd51:	em_is = em_is_r[6];
		6'd52:	em_is = em_is_r[7];
		6'd53:	em_is = em_is_r[8];
		6'd54:	em_is = em_is_r[9];
		default:em_is = 0;
	endcase // sys_cnt_ph2_r
end

endmodule // ARC_tb
