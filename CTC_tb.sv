`timescale  100ns / 1ns
module CTC_tb;

reg cph1, cph2;
reg cfst;
reg rstn;

reg [5:0]	sys_cnt_ph2_r;
reg [7:0]	adr_r;
reg	[9:0]	is_r;
reg			is;


wire 		sync;
wire		ia;
wire		ws;
wire [7:0]	kr;

reg			carry;
reg	[5:0]	keycode;
reg	[4:0]	kc;


reg [2:0]	te_type;
reg [2:0]	te_type_dly_r;
reg			te_en_dly_r;
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

CTC uut(
	.cph1	(cph1),
	.cph2	(cph2),
	.pon	(rstn),
	.is		(is),
	.carry	(carry),
	.kc		(kc),

	.kr		(kr),
	.ia		(ia),
	.ws		(ws),
	.sync 	(sync)
	);


always_ff @ (posedge cph2 or negedge rstn) begin
	if(~rstn)						sys_cnt_ph2_r <= 0;
	else if(sys_cnt_ph2_r == 6'd55)	sys_cnt_ph2_r <= 0;
 	else 							sys_cnt_ph2_r <= sys_cnt_ph2_r + 1;
end

// ***** Test Data Generation *****
always_comb begin
	case(adr_r) 
		8'h00:	is_r = 10'b11101_010_00;	// CLREG
		8'h01:	is_r = 10'b11101_010_00;	// CLREG
		/*
		8'h02:	is_r = 10'b11111_000_10; // A=A+1[p]
		8'h03:	is_r = 10'b11111_001_10; // A=A+1[m]
		8'h04:	is_r = 10'b11111_010_10; // A=A+1[x]
		8'h05:	is_r = 10'b11111_011_10; // A=A+1[w]
		8'h06:	is_r = 10'b11111_100_10; // A=A+1[wp]
		8'h07:	is_r = 10'b11111_101_10; // A=A+1[ms]
		8'h08:	is_r = 10'b11111_110_10; // A=A+1[xs]
		8'h09:	is_r = 10'b11111_111_10; // A=A+1[s]
		8'h0A:	is_r = 10'b11111_000_10; // A=A+1[p]
		8'h0B:	is_r = 10'b11111_000_10; // A=A+1[p]
		8'h0C:	is_r = 10'b11111_000_10; // A=A+1[p]
		8'h0D:	is_r = 10'b11111_000_10; // A=A+1[p] // 12 in total
		8'h0E:	is_r = 10'b11011_000_10; // A=A-1
		*/
		default:is_r = 10'b00000_000_00;	// NOP
	endcase // adr_r	

	case(sys_cnt_ph2_r)
		6'd45:	is = is_r[0];
		6'd46:	is = is_r[1];
		6'd47:	is = is_r[2];
		6'd48:	is = is_r[3];
		6'd49:	is = is_r[4];
		6'd50:	is = is_r[5];
		6'd51:	is = is_r[6];
		6'd52:	is = is_r[7];
		6'd53:	is = is_r[8];
		6'd54:	is = is_r[9];
		default:is = 0;
	endcase // sys_cnt_ph2_r
end

endmodule // ARC_tb
