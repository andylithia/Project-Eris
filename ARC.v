module ARC (
	//input			cph1,
	input			cph2,
	input			is,
	input			ws,
	input			sync,
	output wire		carry,
	output wire		start,
	output [4:0]	anode_data
);


///***< NOTE - HEAD >**********************************************************/
//	Description:	  This project is a cycle-exact replica of the HP classic
//					series calculator chip set. Namely A&R and C&T. This File is
//					the complete design of the A&R Chip. The design was actually
//					a clean-room re-implementation of the well received 
//					Systemyde 41CL project (whose heart is the NEWT processor).
//					  There are many similarities. I've learnt how a bit-serial
//					CPU works from his amazing code.					
//
//	Date 18.03.12:	Rough Coding Finished, Code Untested.
//			-TODO:	1.The result of COMPARE operations might be incorrect,
//					  requires further investigation.
//					2.Write a testbench for this module which contains a series
//					  of arithmetic type opcodes (*_10)
//					3.Not enough attention was spared to non-arithmetic type
//					  opcodes, double check.
//					4.Display Signal (anode signal) Generation
//					5.LDC n
//					6.C->DataAdr, C->Data, Data->C
//					7.RAM Interface
//
//	Goal UNTIMED:	1.Utilize CPH1 for better timing
//
///***< NOTE - TAIL >**********************************************************/


/***** OPCODE buffer and Sync *************************************************/
reg				pre_sync;
reg [4:0]		opcode_sr;		// The opcode being fetched this cycle
reg [4:0]		opcode_dly_r;	// The opcode being executed this cycle
reg [1:0]		optype_sr;		// The instruction being fetched this cycle
reg [1:0]		optype_dly_r;	// The instruction being executed this cycle

/***** Registers **************************************************************/
reg [55:0]		a_r;
reg [3:0]		adly_r;			// A BCD segment delayed for adjustment / SL
reg [55:0]		b_r;
reg [3:0]		b_buf_r;
reg [55:0]		c_r;
reg [3:0]		c_buf_r;
reg [55:0]		d_r;			// D stack register
reg [55:0]		e_r;			// E stack register
reg [55:0]		f_r;			// F stack register
reg [55:0]		m_r;			// M scratchpad register

// "ENable for change" Signals
reg				b_en;
reg				stk_en;
reg				m_en;

// Shift register input MUX
reg				a_nxt;
reg	[3:0]		a_nxt_buffer;
reg				b_nxt;
reg				c_nxt;
reg	[3:0]		c_nxt_buffer;
reg				d_nxt;
reg				e_nxt;
reg				f_nxt;
reg				m_nxt;

/***** ALU and DADJ ***********************************************************/
reg 			alu_out;
reg				alu_cry_out;
reg	[1:0]		alu_dly_r;

reg				dadj_add_mode_r;
reg [2:0]		dadj_out;
reg				dadj_cry_out;

reg				cry_en;
reg				cry_nxt;
reg				cry_init_r;
reg				cry_r;
wire			cry_0;
wire			cry_1;

/***** Timings ****************************************************************/
reg [5:0]		sys_cnt_r;		// System Counter (Binary)

wire			te_iarith;		// I[9:5] 5-bit Arith (or Display) OPCODE
wire			te_itype;		// I[1:0] 2-bit OPCODE Type, 00:Misc, 10:Arith
wire			te_is;			// IS Available, T45-T55, 10 cycle
wire			te_t55;			// Done Refreshing
wire			te_t0;			// Start Signal
wire			te_t4km1;		// The Last Clock Of A Digit Time

reg				re_a_arithtype;	// A register is exec'ing arith-type operation
reg				re_c_arithtype;	// C register is exec'ing arith-type operation

// Display Signals
reg				display_en_r;

/******************************************************************************
/*	System Counter & Timing
/*****************************************************************************/
// Attention: a binary counter was used at this point, 
//            potentially a better solution
// Time Enables
assign te_iarith	= (sys_cnt_r >= 6'd50) && (sys_cnt_r <= 6'd54);
assign te_itype		= (sys_cnt_r == 6'd45) || (sys_cnt_r == 6'd46);
assign te_is		= (sys_cnt_r >= 6'd45) && (sys_cnt_r <= 6'd54);
assign te_t55		= (sys_cnt_r == 6'd55);
assign te_t0		= (sys_cnt_r == 6'd0);
assign te_t4km1		= (sys_cnt_r[1:0] == 2'b11);
assign start		= te_t0;

always @ (posedge cph2) begin
	if(!sync && pre_sync)	pre_sync <= 0;
	else if(sync)			pre_sync <= 1;

	if(!sync && pre_sync)	sys_cnt_r <= 6'b0;
	else 					sys_cnt_r <= sys_cnt_r + 1;
end

/******************************************************************************
/*	OPCODE Buffer
/*****************************************************************************/
assign Itype_Arith	= (optype_dly_r == 2'b10);
assign Itype_Misc	= (optype_dly_r == 2'b00);
always @ (posedge cph2) begin
	if(te_iarith)	opcode_sr <= {is, opcode_sr[4:1]};
	if(te_itype)	optype_sr <= {is, optype_sr[1]};
	if(te_t55)		{opcode_dly_r,optype_dly_r} <= {opcode_sr, optype_sr};
end

/******************************************************************************
/*	ALU
/*****************************************************************************/
always @ (*) begin
	casex ({opcode_dly_r, optype_dly_r})
		// ?A>=C, C=A-C, C=A+C, A=A-C, A=A+C
		7'b11x10_10,
		7'b01110_10,
		7'b0x010_10:alu_out = a_r[0]^c_r[0]^cry_0;
		// ?C>=1
		7'b00011_10:alu_out = c_r[0]^cry_1;
		// C=0-C, ?C=0, C=C+1
		7'b01111_10,
		7'b0x101_10:alu_out = c_r[0]^cry_0;
		// C=0-C-1,  C=C-1
		7'b01011_10,
		7'b00111_10:alu_out = c_r[0]^cry_1;
		// ?A>=B, A=A-B, A=A+B
		7'b11100_10,
		7'b1x000_10:alu_out = a_r[0]^b_r[0]^cry_0;
		// ?A>=1
		7'b10011_10:alu_out = a_r[0]^cry_1;
		// C=C+C
		7'b10101_10:alu_out = cry_0;
		// A=A-1, A=A+1
		7'b11x11_10:alu_out = a_r[0]^cry_1;
		// ?B=0
		7'b00000_10:alu_out = b_r[0]^cry_0;
		default:	alu_out = 1'b0;
	endcase
end

always @ (*) begin
	casex({opcode_dly_r, optype_dly_r})
		// A=A+B
		7'b11100_10:alu_cry_out = (b_r[0]&&cry_0)||(a_r[0]&&(b_r[0]||cry_0));
		// A=A+C, C=A+C
		7'bx1110_10:alu_cry_out = (c_r[0]&&cry_0)||(a_r[0]&&(c_r[0]||cry_0));
		// A=A+1
		7'b11111_10:alu_cry_out = a_r[0]&&cry_1;
		// A=A-B, ?A>=B
		7'b1x000_10:alu_cry_out = (b_r[0]&&cry_0)||(!a_r[0]&&(b_r[0]||cry_0));
		// A=A-1,?A>=1
		7'b1x011_10:alu_cry_out = !a_r[0]&&cry_1;
		// A=A-C, C=A-C, ?A>=C
		7'bx1010_10,
		7'b00010_10:alu_cry_out = (c_r[0]&&cry_0)||(!a_r[0]&&(c_r[0]||cry_0));
		// C=C+C
		7'b10101_10:alu_cry_out = c_r[0];
		// C=C+1
		7'b01111_10:alu_cry_out = c_r[0]&&cry_1;
		// C=C-1, ?C>=1
		7'b0x011_10:alu_cry_out = !c_r[0]&&cry_1;
		// ?C=0, C=-C
		7'b0x101_10:alu_cry_out = c_r[0]||cry_0;
		// ?B=0
		7'b00000_10:alu_cry_out = b_r[0]||cry_0;
		// C=-C-1
		7'b00111_10:alu_cry_out = c_r[0]||cry_1;
		default:	alu_cry_out = 1'b0;
	endcase
end

always @ (posedge cph2) begin
	alu_dly_r <= {alu_out, alu_dly_r[1]};
end

/******************************************************************************
/*	Data ADJ
/*****************************************************************************/
// **** DONE...? ****
always @ (*) begin
	casex(opcode_dly_r) 
		5'b0111x,
		5'b1x101,
		5'b1111x:	dadj_add_mode_r = 1'b1;
		default:	dadj_add_mode_r = 1'b0;
	endcase

	if(dadj_add_mode_r) begin
		casex({alu_cry_out, alu_out, alu_dly_r})
			// if result > 1001, subtract 1010 from result (add 10110)
			4'bx101:	dadj_out = 3'b000;
			4'bx110:	dadj_out = 3'b001;
			4'bx111:	dadj_out = 3'b010;
			4'b1000:	dadj_out = 3'b011;
			4'b1001:	dadj_out = 3'b100;
			4'b1010:	dadj_out = 3'b101;
			4'b1011:	dadj_out = 3'b110;
			4'b1100:	dadj_out = 3'b111;
			default:	dadj_out = {alu_out, alu_dly_r};
		endcase
		casex({alu_cry_out, alu_out, alu_dly_r})
			4'b00xx,
			4'b0100:	dadj_cry_out = 1'b0;
			default:	dadj_cry_out = 1'b1;
		endcase 

	end else begin
		casex({alu_cry_out, alu_out, alu_dly_r})
			// if result < 0000 (>10000), add 01010 to result
			4'b1000:	dadj_out = 3'b101;
			4'b1001:	dadj_out = 3'b110;
			4'b1010:	dadj_out = 3'b111;
			4'b1011:	dadj_out = 3'b000;
			4'b1100:	dadj_out = 3'b001;
			4'b1101:	dadj_out = 3'b010;
			4'b1110:	dadj_out = 3'b011;
			4'b1111:	dadj_out = 3'b100;
			default:	dadj_out = {alu_out, alu_dly_r};
		endcase
		casex({alu_cry_out, alu_out, alu_dly_r})
			4'b0xxx:	dadj_cry_out = 1'b0;
			default:	dadj_cry_out = 1'b1;
		endcase

	end
end

/******************************************************************************
/*	Carry FF
/*****************************************************************************/
// **** DONE...? ****
always @ (*) begin
	if(optype_dly_r == 2'b10)	cry_en = 1;
	else						cry_en = 0;

	casex({opcode_dly_r, optype_dly_r})
		// ?B=0, ?C=0
		7'b00000_10,
		7'b01101_10:cry_nxt = alu_cry_out;
		// A=A+B, A=A+C, A=A-B, A=A-C, A=A+1, A=A-1
		// C=C+C, C=-C, C=-C-1, C=A+C, C=A-C, C=C+1, C=C-1
		// ?A>=C, ?C>=1, ?A>=B, A>=1, 
		// ---- ?A<B, ?A<C ----
		7'b001x1_10,
		7'b01x1x_10,
		7'b10101_10,
		7'b1x000_10,
		7'b1101x_10,
		7'b11100_10,
		7'b1111x_10,
		7'b0001x_10,
		7'b10011_10:cry_nxt = te_t4km1?dadj_cry_out:alu_cry_out;
		default:	cry_nxt = 1'b0;
	endcase
end

assign carry = cry_r;
assign cry_0 = cry_r && !cry_init_r;
assign cry_1 = cry_r || cry_init_r;

always @ (posedge cph2) begin
	cry_init_r <= te_t55 || (!ws && cry_init_r);
	if (ws||te_t55) cry_r <= cry_nxt;
end

/******************************************************************************
/*	Register A
/*****************************************************************************/
// **** DONE...? ****
always @ (*) begin
	casex({opcode_dly_r, optype_dly_r})
		// A=A-B, A=A-C, A=A-1, A=A+B, A=A+C, A=A+1
		7'b11x1x_10,
		7'b11x00_10:re_a_arithtype = 1'b1;
		default:	re_a_arithtype = 1'b0;
	endcase

	casex({opcode_dly_r, optype_dly_r})
		// A=0, CLREG 
		7'b10111_10,
		7'b11101_00:a_nxt = 1'b0;
		// POP A
		7'b01101_00:a_nxt = d_r[0];
		// A=C, AXC
		7'b11101_10,
		7'b01100_10:a_nxt = c_r[0];
		// SRA
		7'b10110_10:a_nxt = ws?a_r[4]:a_r[0];
		// A=A-B, A=A-C, A=A-1, A=A+B, A=A+C, A=A+1
		7'b11x1x_10,
		7'b11x00_10:a_nxt = alu_out;
		// AXB
		7'b11001_10:a_nxt = b_r[0];
		// SLA
		7'b01000_10:a_nxt = adly_r[0];
		default:	a_nxt = a_r[0];
	endcase

	if(re_a_arithtype) begin
		if(ws) begin
			if(te_t4km1)	a_nxt_buffer = {dadj_out, a_r[53]};
			else			a_nxt_buffer = {alu_out, a_r[55:53]};
		end else			a_nxt_buffer = {a_r[0], a_r[55:53]};
	end else begin
		if(ws)		a_nxt_buffer = {a_nxt, a_r[55:53]};
		else		a_nxt_buffer = {a_r[0], a_r[55:53]};
	end
end

always @ (posedge cph2) begin
	a_r <=  {a_nxt_buffer, a_r[52:1]};
	if(te_t55||ws) adly_r <= (te_t55)?4'b0000:{a_r[0],adly_r[3:1]};
end

/******************************************************************************
/*	Register B
/*****************************************************************************/
// **** DONE...? ****
always @ (*) begin
	casex({opcode_dly_r, optype_dly_r}) 
		// CLREG
		7'b11101_00,
		7'bxxxxx_10:b_en = 1;
		default:	b_en = 0;
	endcase

	casex({opcode_dly_r, optype_dly_r}) 
		// CLREG, B=0
		7'b11101_00,
		7'b00001_10:b_nxt = 1'b0;
		// B=A, AXB			
		7'bx1001_10:b_nxt = a_r[0];
		// BXC
		7'b10001_10:b_nxt = c_r[0];
		// SRB
		7'b10100_10:b_nxt = ws?b_r[4]:b_r[0];
		default:	b_nxt = b_r[0];	
	endcase
end

always @ (posedge cph2 or negedge ws) begin
	if(~ws)begin
		if({opcode_dly_r, optype_dly_r}==7'b10100_00) b_r[55:52] <= 4'b0;
	end else begin
		if(b_en) begin
			if(ws)	b_r <= {b_nxt, b_r[55:1]};
			else 	b_r <= {b_r[0], b_r[55:1]};
		end
	end
end


/******************************************************************************
/*	Register C
/*****************************************************************************/
// **** DONE...? ****
always @ (*) begin
	casex({opcode_dly_r, optype_dly_r})
		// ALU Operation
		// C=0-C, C=0-C-1, C=A-C, C=C-1, C=A+C, C=C+C
		7'b001x1_10,
		7'b0101x_10,
		7'b0111x_10,
		7'b10101_10:re_c_arithtype = 1'b1;
		default:	re_c_arithtype = 1'b0;
	endcase

	casex({opcode_dly_r, optype_dly_r})
		// CXM, C=M
		7'bx0101_00:c_nxt = m_r[0];
		// PUSH C
		// 7'b01001_00:c_nxt = c_r[0];
		// RDN
		7'b11001_00:c_nxt = d_r[0];
		// CLREG, C=0
		7'b00110_10,
		7'b11101_00:c_nxt = 1'b0;
		// C=B
		7'b00100_10:c_nxt = b_r[0];
		// ALU Operation
		// C=0-C, C=0-C-1, C=A-C, C=C-1, C=A+C, C=C+C
		7'b001x1_10,
		7'b0101x_10,
		7'b0111x_10,
		7'b10101_10:c_nxt = alu_out;
		// SRC
		7'b10010_10:c_nxt = ws?c_r[4]:c_r[0];
		// AXC
		7'b11101_10:c_nxt = a_r[0];
		default:	c_nxt = c_r[0];
	endcase

	if(re_c_arithtype) begin
		if(te_t4km1)c_nxt_buffer = {alu_out, c_r[55:53]};
		else		c_nxt_buffer = {dadj_out, c_r[53]};
	end else begin
		if(ws)		c_nxt_buffer = {c_nxt, c_r[55:53]};
		else 		c_nxt_buffer = {c_r[0], c_r[55:53]};
	end

end

always @ (posedge cph2) begin
	c_r <= {c_nxt_buffer, c_r[52:1]};
end

/******************************************************************************
/*	Stack Register D(L1), E(L2), F(L3)
/*****************************************************************************/
// **** DONE ****
always @ (*) begin
	casex({opcode_dly_r[4],opcode_dly_r[2]}) 
		// PUSH C
		2'b00:	{f_nxt, e_nxt, d_nxt} = {e_r[0], d_r[0], c_r[0]};
		// POP A
		2'b01:	{f_nxt, e_nxt, d_nxt} = {f_r[0], f_r[0], e_r[0]};
		// RDN
		2'b10:	{f_nxt, e_nxt, d_nxt} = {c_r[0], f_r[0], e_r[0]};
		// CLREG
		2'b11:	{f_nxt, e_nxt, d_nxt} = 3'b000;
		/*
		default:f_nxt = f_r[0];
				e_nxt = e_r[0];
				d_nxt = d_r[0];
				*/
	endcase

	casex({opcode_dly_r, optype_dly_r})
		7'bx1x01_00:	stk_en = 1;
		default:		stk_en = 0;
	endcase
end

always @ (posedge cph2) begin
	if(stk_en) begin
		f_r <= {f_nxt, f_r[55:1]};
		e_r <= {e_nxt, e_r[55:1]};
		d_r <= {d_nxt, d_r[55:1]};
	end
end

/******************************************************************************
/*	Register M
/*****************************************************************************/
// **** DONE ****
always @ (*) begin
	casex({opcode_dly_r, optype_dly_r})		
		7'bx0101_00:m_en = 1;	// CXM, C=M
		default:	m_en = 0;
	endcase

	if(opcode_dly_r[4]) m_nxt = m_r[0];	// CXM
	else m_nxt = c_r[0];				// C=M
end

always @(posedge cph2) begin
	if(m_en) m_r <= {m_nxt, m_r[55:1]};
end

/******************************************************************************
/*	Display Output
/*****************************************************************************/
// **** TBD ****

endmodule // ARC
