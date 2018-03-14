`timescale  100ns / 1ns
module ARC_tb;

reg cph1, cph2;
reg cfst;
reg rstb;

reg [5:0]	em_sys_cnt_r;
reg [7:0]	em_adr_r;
reg	[9:0]	em_is_r;
reg			em_is;
wire 		em_sync;

reg			em_ws;

wire		out_carry;
wire		out_start;
wire [4:0]	out_anode_data;

initial begin
	cfst = 0;
	cph1 = 0;
	cph2 = 0;
	rstb = 0;

	em_ws = 1;

	#35 rstb = 1;
end

// CLK generation
always begin
	#6	cph1 = 0;
	#6	cph1 = 1;
	#30	cph2 = 0;
	#6	cph2 = 1;
end

ARC uut(
	.cph2      (cph2),
	.is        (em_is),
	.ws        (em_ws),
	.sync      (em_sync),
	.carry     (out_carry),
	.start     (out_start),
	.anode_data(out_anode_data)
	);

assign	em_sync = (em_sys_cnt_r >= 6'd45)
					&&(em_sys_cnt_r <= 6'd54);

always_ff @ (posedge cph2 or negedge rstb) begin
	if(~rstb) begin
		em_sys_cnt_r <= 0;
		em_adr_r <= 0;
	end else if(em_sys_cnt_r == 6'd55) begin
		em_adr_r <= em_adr_r + 1;
 		em_sys_cnt_r <= 0;
 	end else em_sys_cnt_r <= em_sys_cnt_r + 1;
end

always_comb begin
	case(em_adr_r) 
		8'h00:	em_is_r = 10'b11101_010_00;	// CLREG
		8'h01:	em_is_r = 10'b11101_010_00;	// CLREG
		8'h02:	em_is_r = 10'b11111_000_10; // A=A+1
		8'h03:	em_is_r = 10'b11111_000_10; // A=A+1
		8'h04:	em_is_r = 10'b11111_000_10; // A=A+1
		8'h05:	em_is_r = 10'b11111_000_10; // A=A+1
		8'h06:	em_is_r = 10'b11111_000_10; // A=A+1
		8'h07:	em_is_r = 10'b11111_000_10; // A=A+1
		8'h08:	em_is_r = 10'b11111_000_10; // A=A+1
		8'h09:	em_is_r = 10'b11111_000_10; // A=A+1
		8'h0A:	em_is_r = 10'b11111_000_10; // A=A+1
		8'h0B:	em_is_r = 10'b11111_000_10; // A=A+1
		8'h0C:	em_is_r = 10'b11111_000_10; // A=A+1
		8'h0D:	em_is_r = 10'b11111_000_10; // A=A+1 // 12 in total
		8'h0E:	em_is_r = 10'b11011_000_10; // A=A-1

		default:em_is_r = 0;
	endcase // em_adr_r

	case(em_sys_cnt_r)
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
	endcase // em_sys_cnt_r

end

endmodule // ARC_tb
