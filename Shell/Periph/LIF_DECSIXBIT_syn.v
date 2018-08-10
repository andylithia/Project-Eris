// megafunction wizard: %ROM: 1-PORT%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altsyncram 

// ============================================================
// File Name: LIF_DECSIXBIT.v
// Megafunction Name(s):
// 			altsyncram
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 17.1.0 Build 590 10/25/2017 SJ Lite Edition
// ************************************************************


//Copyright (C) 2017  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details.


//altsyncram ADDRESS_ACLR_A="NONE" CLOCK_ENABLE_INPUT_A="BYPASS" CLOCK_ENABLE_OUTPUT_A="BYPASS" DEVICE_FAMILY="Cyclone IV E" ENABLE_RUNTIME_MOD="YES" INIT_FILE="LIF_DEC_SIXBIT.mif" INSTANCE_NAME="114" NUMWORDS_A=320 OPERATION_MODE="ROM" OUTDATA_ACLR_A="NONE" OUTDATA_REG_A="UNREGISTERED" WIDTH_A=7 WIDTH_BYTEENA_A=1 WIDTHAD_A=9 address_a clock0 q_a
//VERSION_BEGIN 17.1 cbx_altera_syncram_nd_impl 2017:10:25:18:06:52:SJ cbx_altsyncram 2017:10:25:18:06:53:SJ cbx_cycloneii 2017:10:25:18:06:53:SJ cbx_lpm_add_sub 2017:10:25:18:06:53:SJ cbx_lpm_compare 2017:10:25:18:06:53:SJ cbx_lpm_decode 2017:10:25:18:06:53:SJ cbx_lpm_mux 2017:10:25:18:06:53:SJ cbx_mgl 2017:10:25:18:08:29:SJ cbx_nadder 2017:10:25:18:06:53:SJ cbx_stratix 2017:10:25:18:06:53:SJ cbx_stratixii 2017:10:25:18:06:53:SJ cbx_stratixiii 2017:10:25:18:06:53:SJ cbx_stratixv 2017:10:25:18:06:53:SJ cbx_util_mgl 2017:10:25:18:06:53:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



//altsyncram ADDRESS_ACLR_A="NONE" ADDRESS_ACLR_B="NONE" ADDRESS_REG_B="CLOCK1" CLOCK_ENABLE_INPUT_A="BYPASS" CLOCK_ENABLE_OUTPUT_A="BYPASS" DEVICE_FAMILY="Cyclone IV E" ENABLE_RUNTIME_MOD="NO" INDATA_ACLR_B="NONE" INDATA_REG_B="CLOCK1" INIT_FILE="LIF_DEC_SIXBIT.mif" NUMWORDS_A=320 NUMWORDS_B=320 OPERATION_MODE="BIDIR_DUAL_PORT" OUTDATA_ACLR_A="NONE" OUTDATA_ACLR_B="NONE" OUTDATA_REG_A="UNREGISTERED" OUTDATA_REG_B="UNREGISTERED" RDCONTROL_REG_B="CLOCK1" read_during_write_mode_port_a="NEW_DATA_NO_NBE_READ" WIDTH_A=7 WIDTH_B=7 WIDTH_BYTEENA_A=1 WIDTHAD_A=9 WIDTHAD_B=9 WRCONTROL_ACLR_A="NONE" WRCONTROL_ACLR_B="NONE" WRCONTROL_WRADDRESS_REG_B="CLOCK1" address_a address_b clock0 clock1 data_b q_a q_b wren_b
//VERSION_BEGIN 17.1 cbx_altera_syncram_nd_impl 2017:10:25:18:06:52:SJ cbx_altsyncram 2017:10:25:18:06:53:SJ cbx_cycloneii 2017:10:25:18:06:53:SJ cbx_lpm_add_sub 2017:10:25:18:06:53:SJ cbx_lpm_compare 2017:10:25:18:06:53:SJ cbx_lpm_decode 2017:10:25:18:06:53:SJ cbx_lpm_mux 2017:10:25:18:06:53:SJ cbx_mgl 2017:10:25:18:08:29:SJ cbx_nadder 2017:10:25:18:06:53:SJ cbx_stratix 2017:10:25:18:06:53:SJ cbx_stratixii 2017:10:25:18:06:53:SJ cbx_stratixiii 2017:10:25:18:06:53:SJ cbx_stratixv 2017:10:25:18:06:53:SJ cbx_util_mgl 2017:10:25:18:06:53:SJ  VERSION_END

//synthesis_resources = M9K 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
(* ALTERA_ATTRIBUTE = {"OPTIMIZE_POWER_DURING_SYNTHESIS=NORMAL_COMPILATION"} *)
module  LIF_DECSIXBIT_altsyncram1
	( 
	address_a,
	address_b,
	clock0,
	clock1,
	data_b,
	q_a,
	q_b,
	wren_b) /* synthesis synthesis_clearbox=1 */;
	input   [8:0]  address_a;
	input   [8:0]  address_b;
	input   clock0;
	input   clock1;
	input   [6:0]  data_b;
	output   [6:0]  q_a;
	output   [6:0]  q_b;
	input   wren_b;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1   [8:0]  address_b;
	tri1   clock0;
	tri1   clock1;
	tri1   [6:0]  data_b;
	tri0   wren_b;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [0:0]   wire_ram_block3a_0portadataout;
	wire  [0:0]   wire_ram_block3a_1portadataout;
	wire  [0:0]   wire_ram_block3a_2portadataout;
	wire  [0:0]   wire_ram_block3a_3portadataout;
	wire  [0:0]   wire_ram_block3a_4portadataout;
	wire  [0:0]   wire_ram_block3a_5portadataout;
	wire  [0:0]   wire_ram_block3a_6portadataout;
	wire  [0:0]   wire_ram_block3a_0portbdataout;
	wire  [0:0]   wire_ram_block3a_1portbdataout;
	wire  [0:0]   wire_ram_block3a_2portbdataout;
	wire  [0:0]   wire_ram_block3a_3portbdataout;
	wire  [0:0]   wire_ram_block3a_4portbdataout;
	wire  [0:0]   wire_ram_block3a_5portbdataout;
	wire  [0:0]   wire_ram_block3a_6portbdataout;
	wire  [8:0]  address_a_wire;
	wire  [8:0]  address_b_wire;
	wire [6:0]  data_a;
	wire wren_a;

	cycloneive_ram_block   ram_block3a_0
	( 
	.clk0(clock0),
	.clk1(clock1),
	.portaaddr({address_a_wire[8:0]}),
	.portadatain({data_a[0]}),
	.portadataout(wire_ram_block3a_0portadataout[0:0]),
	.portare(1'b1),
	.portawe(wren_a),
	.portbaddr({address_b_wire[8:0]}),
	.portbdatain({data_b[0]}),
	.portbdataout(wire_ram_block3a_0portbdataout[0:0]),
	.portbre(1'b1),
	.portbwe(wren_b)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clr0(1'b0),
	.clr1(1'b0),
	.ena0(1'b1),
	.ena1(1'b1),
	.ena2(1'b1),
	.ena3(1'b1),
	.portaaddrstall(1'b0),
	.portabyteenamasks({1{1'b1}}),
	.portbaddrstall(1'b0),
	.portbbyteenamasks({1{1'b1}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1)
	// synopsys translate_on
	);
	defparam
		ram_block3a_0.clk0_core_clock_enable = "none",
		ram_block3a_0.clk0_input_clock_enable = "none",
		ram_block3a_0.clk1_core_clock_enable = "none",
		ram_block3a_0.clk1_input_clock_enable = "none",
		ram_block3a_0.connectivity_checking = "OFF",
		ram_block3a_0.init_file = "LIF_DEC_SIXBIT.mif",
		ram_block3a_0.init_file_layout = "port_a",
		ram_block3a_0.logical_ram_name = "ALTSYNCRAM",
		ram_block3a_0.mem_init0 = 320'h000C2600000000000000000000000000000000000000000000000000000040000000480000400000,
		ram_block3a_0.mixed_port_feed_through_mode = "dont_care",
		ram_block3a_0.operation_mode = "bidir_dual_port",
		ram_block3a_0.port_a_address_width = 9,
		ram_block3a_0.port_a_data_out_clear = "none",
		ram_block3a_0.port_a_data_width = 1,
		ram_block3a_0.port_a_first_address = 0,
		ram_block3a_0.port_a_first_bit_number = 0,
		ram_block3a_0.port_a_last_address = 319,
		ram_block3a_0.port_a_logical_ram_depth = 320,
		ram_block3a_0.port_a_logical_ram_width = 7,
		ram_block3a_0.port_a_read_during_write_mode = "new_data_no_nbe_read",
		ram_block3a_0.port_b_address_clock = "clock1",
		ram_block3a_0.port_b_address_width = 9,
		ram_block3a_0.port_b_data_in_clock = "clock1",
		ram_block3a_0.port_b_data_out_clear = "none",
		ram_block3a_0.port_b_data_width = 1,
		ram_block3a_0.port_b_first_address = 0,
		ram_block3a_0.port_b_first_bit_number = 0,
		ram_block3a_0.port_b_last_address = 319,
		ram_block3a_0.port_b_logical_ram_depth = 320,
		ram_block3a_0.port_b_logical_ram_width = 7,
		ram_block3a_0.port_b_read_during_write_mode = "new_data_no_nbe_read",
		ram_block3a_0.port_b_read_enable_clock = "clock1",
		ram_block3a_0.port_b_write_enable_clock = "clock1",
		ram_block3a_0.ram_block_type = "AUTO",
		ram_block3a_0.lpm_type = "cycloneive_ram_block";
	cycloneive_ram_block   ram_block3a_1
	( 
	.clk0(clock0),
	.clk1(clock1),
	.portaaddr({address_a_wire[8:0]}),
	.portadatain({data_a[1]}),
	.portadataout(wire_ram_block3a_1portadataout[0:0]),
	.portare(1'b1),
	.portawe(wren_a),
	.portbaddr({address_b_wire[8:0]}),
	.portbdatain({data_b[1]}),
	.portbdataout(wire_ram_block3a_1portbdataout[0:0]),
	.portbre(1'b1),
	.portbwe(wren_b)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clr0(1'b0),
	.clr1(1'b0),
	.ena0(1'b1),
	.ena1(1'b1),
	.ena2(1'b1),
	.ena3(1'b1),
	.portaaddrstall(1'b0),
	.portabyteenamasks({1{1'b1}}),
	.portbaddrstall(1'b0),
	.portbbyteenamasks({1{1'b1}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1)
	// synopsys translate_on
	);
	defparam
		ram_block3a_1.clk0_core_clock_enable = "none",
		ram_block3a_1.clk0_input_clock_enable = "none",
		ram_block3a_1.clk1_core_clock_enable = "none",
		ram_block3a_1.clk1_input_clock_enable = "none",
		ram_block3a_1.connectivity_checking = "OFF",
		ram_block3a_1.init_file = "LIF_DEC_SIXBIT.mif",
		ram_block3a_1.init_file_layout = "port_a",
		ram_block3a_1.logical_ram_name = "ALTSYNCRAM",
		ram_block3a_1.mem_init0 = 320'h0108227E318C63FFFDFF7C621CB9D1FFFEF7BDCEF0808003FFFFBFCFFD8F400002548427A7E52880,
		ram_block3a_1.mixed_port_feed_through_mode = "dont_care",
		ram_block3a_1.operation_mode = "bidir_dual_port",
		ram_block3a_1.port_a_address_width = 9,
		ram_block3a_1.port_a_data_out_clear = "none",
		ram_block3a_1.port_a_data_width = 1,
		ram_block3a_1.port_a_first_address = 0,
		ram_block3a_1.port_a_first_bit_number = 1,
		ram_block3a_1.port_a_last_address = 319,
		ram_block3a_1.port_a_logical_ram_depth = 320,
		ram_block3a_1.port_a_logical_ram_width = 7,
		ram_block3a_1.port_a_read_during_write_mode = "new_data_no_nbe_read",
		ram_block3a_1.port_b_address_clock = "clock1",
		ram_block3a_1.port_b_address_width = 9,
		ram_block3a_1.port_b_data_in_clock = "clock1",
		ram_block3a_1.port_b_data_out_clear = "none",
		ram_block3a_1.port_b_data_width = 1,
		ram_block3a_1.port_b_first_address = 0,
		ram_block3a_1.port_b_first_bit_number = 1,
		ram_block3a_1.port_b_last_address = 319,
		ram_block3a_1.port_b_logical_ram_depth = 320,
		ram_block3a_1.port_b_logical_ram_width = 7,
		ram_block3a_1.port_b_read_during_write_mode = "new_data_no_nbe_read",
		ram_block3a_1.port_b_read_enable_clock = "clock1",
		ram_block3a_1.port_b_write_enable_clock = "clock1",
		ram_block3a_1.ram_block_type = "AUTO",
		ram_block3a_1.lpm_type = "cycloneive_ram_block";
	cycloneive_ram_block   ram_block3a_2
	( 
	.clk0(clock0),
	.clk1(clock1),
	.portaaddr({address_a_wire[8:0]}),
	.portadatain({data_a[2]}),
	.portadataout(wire_ram_block3a_2portadataout[0:0]),
	.portare(1'b1),
	.portawe(wren_a),
	.portbaddr({address_b_wire[8:0]}),
	.portbdatain({data_b[2]}),
	.portbdataout(wire_ram_block3a_2portbdataout[0:0]),
	.portbre(1'b1),
	.portbwe(wren_b)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clr0(1'b0),
	.clr1(1'b0),
	.ena0(1'b1),
	.ena1(1'b1),
	.ena2(1'b1),
	.ena3(1'b1),
	.portaaddrstall(1'b0),
	.portabyteenamasks({1{1'b1}}),
	.portbaddrstall(1'b0),
	.portbbyteenamasks({1{1'b1}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1)
	// synopsys translate_on
	);
	defparam
		ram_block3a_2.clk0_core_clock_enable = "none",
		ram_block3a_2.clk0_input_clock_enable = "none",
		ram_block3a_2.clk1_core_clock_enable = "none",
		ram_block3a_2.clk1_input_clock_enable = "none",
		ram_block3a_2.connectivity_checking = "OFF",
		ram_block3a_2.init_file = "LIF_DEC_SIXBIT.mif",
		ram_block3a_2.init_file_layout = "port_a",
		ram_block3a_2.logical_ram_name = "ALTSYNCRAM",
		ram_block3a_2.mem_init0 = 320'h028842222A8C6240C6318C6212A091884318C631813E421231884328C5512000023884279A5FA880,
		ram_block3a_2.mixed_port_feed_through_mode = "dont_care",
		ram_block3a_2.operation_mode = "bidir_dual_port",
		ram_block3a_2.port_a_address_width = 9,
		ram_block3a_2.port_a_data_out_clear = "none",
		ram_block3a_2.port_a_data_width = 1,
		ram_block3a_2.port_a_first_address = 0,
		ram_block3a_2.port_a_first_bit_number = 2,
		ram_block3a_2.port_a_last_address = 319,
		ram_block3a_2.port_a_logical_ram_depth = 320,
		ram_block3a_2.port_a_logical_ram_width = 7,
		ram_block3a_2.port_a_read_during_write_mode = "new_data_no_nbe_read",
		ram_block3a_2.port_b_address_clock = "clock1",
		ram_block3a_2.port_b_address_width = 9,
		ram_block3a_2.port_b_data_in_clock = "clock1",
		ram_block3a_2.port_b_data_out_clear = "none",
		ram_block3a_2.port_b_data_width = 1,
		ram_block3a_2.port_b_first_address = 0,
		ram_block3a_2.port_b_first_bit_number = 2,
		ram_block3a_2.port_b_last_address = 319,
		ram_block3a_2.port_b_logical_ram_depth = 320,
		ram_block3a_2.port_b_logical_ram_width = 7,
		ram_block3a_2.port_b_read_during_write_mode = "new_data_no_nbe_read",
		ram_block3a_2.port_b_read_enable_clock = "clock1",
		ram_block3a_2.port_b_write_enable_clock = "clock1",
		ram_block3a_2.ram_block_type = "AUTO",
		ram_block3a_2.lpm_type = "cycloneive_ram_block";
	cycloneive_ram_block   ram_block3a_3
	( 
	.clk0(clock0),
	.clk1(clock1),
	.portaaddr({address_a_wire[8:0]}),
	.portadatain({data_a[3]}),
	.portadataout(wire_ram_block3a_3portadataout[0:0]),
	.portare(1'b1),
	.portawe(wren_a),
	.portbaddr({address_b_wire[8:0]}),
	.portbdatain({data_b[3]}),
	.portbdataout(wire_ram_block3a_3portbdataout[0:0]),
	.portbre(1'b1),
	.portbwe(wren_b)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clr0(1'b0),
	.clr1(1'b0),
	.ena0(1'b1),
	.ena1(1'b1),
	.ena2(1'b1),
	.ena3(1'b1),
	.portaaddrstall(1'b0),
	.portabyteenamasks({1{1'b1}}),
	.portbaddrstall(1'b0),
	.portbbyteenamasks({1{1'b1}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1)
	// synopsys translate_on
	);
	defparam
		ram_block3a_3.clk0_core_clock_enable = "none",
		ram_block3a_3.clk0_input_clock_enable = "none",
		ram_block3a_3.clk1_core_clock_enable = "none",
		ram_block3a_3.clk1_input_clock_enable = "none",
		ram_block3a_3.connectivity_checking = "OFF",
		ram_block3a_3.init_file = "LIF_DEC_SIXBIT.mif",
		ram_block3a_3.init_file_layout = "port_a",
		ram_block3a_3.logical_ram_name = "ALTSYNCRAM",
		ram_block3a_3.mem_init0 = 320'h00084213E48C6247FE3F8CF611A09F0BDF10FFF5C2002003EE47FF166115201C0FFC8401CFF50080,
		ram_block3a_3.mixed_port_feed_through_mode = "dont_care",
		ram_block3a_3.operation_mode = "bidir_dual_port",
		ram_block3a_3.port_a_address_width = 9,
		ram_block3a_3.port_a_data_out_clear = "none",
		ram_block3a_3.port_a_data_width = 1,
		ram_block3a_3.port_a_first_address = 0,
		ram_block3a_3.port_a_first_bit_number = 3,
		ram_block3a_3.port_a_last_address = 319,
		ram_block3a_3.port_a_logical_ram_depth = 320,
		ram_block3a_3.port_a_logical_ram_width = 7,
		ram_block3a_3.port_a_read_during_write_mode = "new_data_no_nbe_read",
		ram_block3a_3.port_b_address_clock = "clock1",
		ram_block3a_3.port_b_address_width = 9,
		ram_block3a_3.port_b_data_in_clock = "clock1",
		ram_block3a_3.port_b_data_out_clear = "none",
		ram_block3a_3.port_b_data_width = 1,
		ram_block3a_3.port_b_first_address = 0,
		ram_block3a_3.port_b_first_bit_number = 3,
		ram_block3a_3.port_b_last_address = 319,
		ram_block3a_3.port_b_logical_ram_depth = 320,
		ram_block3a_3.port_b_logical_ram_width = 7,
		ram_block3a_3.port_b_read_during_write_mode = "new_data_no_nbe_read",
		ram_block3a_3.port_b_read_enable_clock = "clock1",
		ram_block3a_3.port_b_write_enable_clock = "clock1",
		ram_block3a_3.ram_block_type = "AUTO",
		ram_block3a_3.lpm_type = "cycloneive_ram_block";
	cycloneive_ram_block   ram_block3a_4
	( 
	.clk0(clock0),
	.clk1(clock1),
	.portaaddr({address_a_wire[8:0]}),
	.portadatain({data_a[4]}),
	.portadataout(wire_ram_block3a_4portadataout[0:0]),
	.portare(1'b1),
	.portawe(wren_a),
	.portbaddr({address_b_wire[8:0]}),
	.portbdatain({data_b[4]}),
	.portbdataout(wire_ram_block3a_4portbdataout[0:0]),
	.portbre(1'b1),
	.portbwe(wren_b)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clr0(1'b0),
	.clr1(1'b0),
	.ena0(1'b1),
	.ena1(1'b1),
	.ena2(1'b1),
	.ena3(1'b1),
	.portaaddrstall(1'b0),
	.portabyteenamasks({1{1'b1}}),
	.portbaddrstall(1'b0),
	.portbbyteenamasks({1{1'b1}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1)
	// synopsys translate_on
	);
	defparam
		ram_block3a_4.clk0_core_clock_enable = "none",
		ram_block3a_4.clk0_input_clock_enable = "none",
		ram_block3a_4.clk1_core_clock_enable = "none",
		ram_block3a_4.clk1_input_clock_enable = "none",
		ram_block3a_4.connectivity_checking = "OFF",
		ram_block3a_4.init_file = "LIF_DEC_SIXBIT.mif",
		ram_block3a_4.init_file_layout = "port_a",
		ram_block3a_4.logical_ram_name = "ALTSYNCRAM",
		ram_block3a_4.mem_init0 = 320'h0008421204AC624816A18D6A11A091C84310C63D223E2002114461F81915200002388406794F8080,
		ram_block3a_4.mixed_port_feed_through_mode = "dont_care",
		ram_block3a_4.operation_mode = "bidir_dual_port",
		ram_block3a_4.port_a_address_width = 9,
		ram_block3a_4.port_a_data_out_clear = "none",
		ram_block3a_4.port_a_data_width = 1,
		ram_block3a_4.port_a_first_address = 0,
		ram_block3a_4.port_a_first_bit_number = 4,
		ram_block3a_4.port_a_last_address = 319,
		ram_block3a_4.port_a_logical_ram_depth = 320,
		ram_block3a_4.port_a_logical_ram_width = 7,
		ram_block3a_4.port_a_read_during_write_mode = "new_data_no_nbe_read",
		ram_block3a_4.port_b_address_clock = "clock1",
		ram_block3a_4.port_b_address_width = 9,
		ram_block3a_4.port_b_data_in_clock = "clock1",
		ram_block3a_4.port_b_data_out_clear = "none",
		ram_block3a_4.port_b_data_width = 1,
		ram_block3a_4.port_b_first_address = 0,
		ram_block3a_4.port_b_first_bit_number = 4,
		ram_block3a_4.port_b_last_address = 319,
		ram_block3a_4.port_b_logical_ram_depth = 320,
		ram_block3a_4.port_b_logical_ram_width = 7,
		ram_block3a_4.port_b_read_during_write_mode = "new_data_no_nbe_read",
		ram_block3a_4.port_b_read_enable_clock = "clock1",
		ram_block3a_4.port_b_write_enable_clock = "clock1",
		ram_block3a_4.ram_block_type = "AUTO",
		ram_block3a_4.lpm_type = "cycloneive_ram_block";
	cycloneive_ram_block   ram_block3a_5
	( 
	.clk0(clock0),
	.clk1(clock1),
	.portaaddr({address_a_wire[8:0]}),
	.portadatain({data_a[5]}),
	.portadataout(wire_ram_block3a_5portadataout[0:0]),
	.portare(1'b1),
	.portawe(wren_a),
	.portbaddr({address_b_wire[8:0]}),
	.portbdatain({data_b[5]}),
	.portbdataout(wire_ram_block3a_5portbdataout[0:0]),
	.portbre(1'b1),
	.portbwe(wren_b)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clr0(1'b0),
	.clr1(1'b0),
	.ena0(1'b1),
	.ena1(1'b1),
	.ena2(1'b1),
	.ena3(1'b1),
	.portaaddrstall(1'b0),
	.portabyteenamasks({1{1'b1}}),
	.portbaddrstall(1'b0),
	.portbbyteenamasks({1{1'b1}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1)
	// synopsys translate_on
	);
	defparam
		ram_block3a_5.clk0_core_clock_enable = "none",
		ram_block3a_5.clk0_input_clock_enable = "none",
		ram_block3a_5.clk1_core_clock_enable = "none",
		ram_block3a_5.clk1_input_clock_enable = "none",
		ram_block3a_5.connectivity_checking = "OFF",
		ram_block3a_5.init_file = "LIF_DEC_SIXBIT.mif",
		ram_block3a_5.init_file_layout = "port_a",
		ram_block3a_5.logical_ram_name = "ALTSYNCRAM",
		ram_block3a_5.mem_init0 = 320'h0008820A0ADCA24827218E6212A891884318C6210100421231246308C5111100425484026CF50000,
		ram_block3a_5.mixed_port_feed_through_mode = "dont_care",
		ram_block3a_5.operation_mode = "bidir_dual_port",
		ram_block3a_5.port_a_address_width = 9,
		ram_block3a_5.port_a_data_out_clear = "none",
		ram_block3a_5.port_a_data_width = 1,
		ram_block3a_5.port_a_first_address = 0,
		ram_block3a_5.port_a_first_bit_number = 5,
		ram_block3a_5.port_a_last_address = 319,
		ram_block3a_5.port_a_logical_ram_depth = 320,
		ram_block3a_5.port_a_logical_ram_width = 7,
		ram_block3a_5.port_a_read_during_write_mode = "new_data_no_nbe_read",
		ram_block3a_5.port_b_address_clock = "clock1",
		ram_block3a_5.port_b_address_width = 9,
		ram_block3a_5.port_b_data_in_clock = "clock1",
		ram_block3a_5.port_b_data_out_clear = "none",
		ram_block3a_5.port_b_data_width = 1,
		ram_block3a_5.port_b_first_address = 0,
		ram_block3a_5.port_b_first_bit_number = 5,
		ram_block3a_5.port_b_last_address = 319,
		ram_block3a_5.port_b_logical_ram_depth = 320,
		ram_block3a_5.port_b_logical_ram_width = 7,
		ram_block3a_5.port_b_read_during_write_mode = "new_data_no_nbe_read",
		ram_block3a_5.port_b_read_enable_clock = "clock1",
		ram_block3a_5.port_b_write_enable_clock = "clock1",
		ram_block3a_5.ram_block_type = "AUTO",
		ram_block3a_5.lpm_type = "cycloneive_ram_block";
	cycloneive_ram_block   ram_block3a_6
	( 
	.clk0(clock0),
	.clk1(clock1),
	.portaaddr({address_a_wire[8:0]}),
	.portadatain({data_a[6]}),
	.portadataout(wire_ram_block3a_6portadataout[0:0]),
	.portare(1'b1),
	.portawe(wren_a),
	.portbaddr({address_b_wire[8:0]}),
	.portbdatain({data_b[6]}),
	.portbdataout(wire_ram_block3a_6portbdataout[0:0]),
	.portbre(1'b1),
	.portbwe(wren_b)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clr0(1'b0),
	.clr1(1'b0),
	.ena0(1'b1),
	.ena1(1'b1),
	.ena2(1'b1),
	.ena3(1'b1),
	.portaaddrstall(1'b0),
	.portabyteenamasks({1{1'b1}}),
	.portbaddrstall(1'b0),
	.portbbyteenamasks({1{1'b1}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	// synopsys translate_off
	,
	.devclrn(1'b1),
	.devpor(1'b1)
	// synopsys translate_on
	);
	defparam
		ram_block3a_6.clk0_core_clock_enable = "none",
		ram_block3a_6.clk0_input_clock_enable = "none",
		ram_block3a_6.clk1_core_clock_enable = "none",
		ram_block3a_6.clk1_input_clock_enable = "none",
		ram_block3a_6.connectivity_checking = "OFF",
		ram_block3a_6.init_file = "LIF_DEC_SIXBIT.mif",
		ram_block3a_6.init_file_layout = "port_a",
		ram_block3a_6.logical_ram_name = "ALTSYNCRAM",
		ram_block3a_6.mem_init0 = 320'h700C867FF18F3C4FC7E1F463FC91D1F87FFFFE3E20808201FF27DF0FFD1E100040004805F2400080,
		ram_block3a_6.mixed_port_feed_through_mode = "dont_care",
		ram_block3a_6.operation_mode = "bidir_dual_port",
		ram_block3a_6.port_a_address_width = 9,
		ram_block3a_6.port_a_data_out_clear = "none",
		ram_block3a_6.port_a_data_width = 1,
		ram_block3a_6.port_a_first_address = 0,
		ram_block3a_6.port_a_first_bit_number = 6,
		ram_block3a_6.port_a_last_address = 319,
		ram_block3a_6.port_a_logical_ram_depth = 320,
		ram_block3a_6.port_a_logical_ram_width = 7,
		ram_block3a_6.port_a_read_during_write_mode = "new_data_no_nbe_read",
		ram_block3a_6.port_b_address_clock = "clock1",
		ram_block3a_6.port_b_address_width = 9,
		ram_block3a_6.port_b_data_in_clock = "clock1",
		ram_block3a_6.port_b_data_out_clear = "none",
		ram_block3a_6.port_b_data_width = 1,
		ram_block3a_6.port_b_first_address = 0,
		ram_block3a_6.port_b_first_bit_number = 6,
		ram_block3a_6.port_b_last_address = 319,
		ram_block3a_6.port_b_logical_ram_depth = 320,
		ram_block3a_6.port_b_logical_ram_width = 7,
		ram_block3a_6.port_b_read_during_write_mode = "new_data_no_nbe_read",
		ram_block3a_6.port_b_read_enable_clock = "clock1",
		ram_block3a_6.port_b_write_enable_clock = "clock1",
		ram_block3a_6.ram_block_type = "AUTO",
		ram_block3a_6.lpm_type = "cycloneive_ram_block";
	assign
		address_a_wire = address_a,
		address_b_wire = address_b,
		data_a = {7{1'b1}},
		q_a = {wire_ram_block3a_6portadataout[0], wire_ram_block3a_5portadataout[0], wire_ram_block3a_4portadataout[0], wire_ram_block3a_3portadataout[0], wire_ram_block3a_2portadataout[0], wire_ram_block3a_1portadataout[0], wire_ram_block3a_0portadataout[0]},
		q_b = {wire_ram_block3a_6portbdataout[0], wire_ram_block3a_5portbdataout[0], wire_ram_block3a_4portbdataout[0], wire_ram_block3a_3portbdataout[0], wire_ram_block3a_2portbdataout[0], wire_ram_block3a_1portbdataout[0], wire_ram_block3a_0portbdataout[0]},
		wren_a = 1'b0;
endmodule //LIF_DECSIXBIT_altsyncram1

//synthesis_resources = M9K 1 sld_mod_ram_rom 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  LIF_DECSIXBIT_altsyncram
	( 
	address_a,
	clock0,
	q_a) /* synthesis synthesis_clearbox=1 */;
	input   [8:0]  address_a;
	input   clock0;
	output   [6:0]  q_a;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1   clock0;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [6:0]   wire_altsyncram1_q_a;
	wire  [6:0]   wire_altsyncram1_q_b;
	wire  [8:0]   wire_mgl_prim2_address;
	wire  [6:0]   wire_mgl_prim2_data_write;
	wire  wire_mgl_prim2_enable_write;
	wire  wire_mgl_prim2_tck_usr;

	LIF_DECSIXBIT_altsyncram1   altsyncram1
	( 
	.address_a(address_a),
	.address_b(wire_mgl_prim2_address),
	.clock0(clock0),
	.clock1(wire_mgl_prim2_tck_usr),
	.data_b(wire_mgl_prim2_data_write),
	.q_a(wire_altsyncram1_q_a),
	.q_b(wire_altsyncram1_q_b),
	.wren_b(wire_mgl_prim2_enable_write));
	sld_mod_ram_rom   mgl_prim2
	( 
	.address(wire_mgl_prim2_address),
	.data_read(wire_altsyncram1_q_b),
	.data_write(wire_mgl_prim2_data_write),
	.enable_write(wire_mgl_prim2_enable_write),
	.tck_usr(wire_mgl_prim2_tck_usr));
	defparam
		mgl_prim2.cvalue = 7'b0000000,
		mgl_prim2.is_data_in_ram = 1,
		mgl_prim2.is_readable = 1,
		mgl_prim2.node_name = 825308160,
		mgl_prim2.numwords = 320,
		mgl_prim2.shift_count_bits = 3,
		mgl_prim2.width_word = 7,
		mgl_prim2.widthad = 9;
	assign
		q_a = wire_altsyncram1_q_a;
endmodule //LIF_DECSIXBIT_altsyncram
//VALID FILE


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module LIF_DECSIXBIT (
	address,
	clock,
	q)/* synthesis synthesis_clearbox = 1 */;

	input	[8:0]  address;
	input	  clock;
	output	[6:0]  q;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1	  clock;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire [6:0] sub_wire0;
	wire [6:0] q = sub_wire0[6:0];

	LIF_DECSIXBIT_altsyncram	LIF_DECSIXBIT_altsyncram_component (
				.address_a (address),
				.clock0 (clock),
				.q_a (sub_wire0));

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ADDRESSSTALL_A NUMERIC "0"
// Retrieval info: PRIVATE: AclrAddr NUMERIC "0"
// Retrieval info: PRIVATE: AclrByte NUMERIC "0"
// Retrieval info: PRIVATE: AclrOutput NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_ENABLE NUMERIC "0"
// Retrieval info: PRIVATE: BYTE_SIZE NUMERIC "8"
// Retrieval info: PRIVATE: BlankMemory NUMERIC "0"
// Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_A NUMERIC "0"
// Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_A NUMERIC "0"
// Retrieval info: PRIVATE: Clken NUMERIC "0"
// Retrieval info: PRIVATE: IMPLEMENT_IN_LES NUMERIC "0"
// Retrieval info: PRIVATE: INIT_FILE_LAYOUT STRING "PORT_A"
// Retrieval info: PRIVATE: INIT_TO_SIM_X NUMERIC "0"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: PRIVATE: JTAG_ENABLED NUMERIC "1"
// Retrieval info: PRIVATE: JTAG_ID STRING "114"
// Retrieval info: PRIVATE: MAXIMUM_DEPTH NUMERIC "0"
// Retrieval info: PRIVATE: MIFfilename STRING "LIF_DEC_SIXBIT.mif"
// Retrieval info: PRIVATE: NUMWORDS_A NUMERIC "320"
// Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "0"
// Retrieval info: PRIVATE: RegAddr NUMERIC "1"
// Retrieval info: PRIVATE: RegOutput NUMERIC "0"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "1"
// Retrieval info: PRIVATE: SingleClock NUMERIC "1"
// Retrieval info: PRIVATE: UseDQRAM NUMERIC "0"
// Retrieval info: PRIVATE: WidthAddr NUMERIC "9"
// Retrieval info: PRIVATE: WidthData NUMERIC "7"
// Retrieval info: PRIVATE: rden NUMERIC "0"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: ADDRESS_ACLR_A STRING "NONE"
// Retrieval info: CONSTANT: CLOCK_ENABLE_INPUT_A STRING "BYPASS"
// Retrieval info: CONSTANT: CLOCK_ENABLE_OUTPUT_A STRING "BYPASS"
// Retrieval info: CONSTANT: INIT_FILE STRING "LIF_DEC_SIXBIT.mif"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: CONSTANT: LPM_HINT STRING "ENABLE_RUNTIME_MOD=YES,INSTANCE_NAME=114"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altsyncram"
// Retrieval info: CONSTANT: NUMWORDS_A NUMERIC "320"
// Retrieval info: CONSTANT: OPERATION_MODE STRING "ROM"
// Retrieval info: CONSTANT: OUTDATA_ACLR_A STRING "NONE"
// Retrieval info: CONSTANT: OUTDATA_REG_A STRING "UNREGISTERED"
// Retrieval info: CONSTANT: WIDTHAD_A NUMERIC "9"
// Retrieval info: CONSTANT: WIDTH_A NUMERIC "7"
// Retrieval info: CONSTANT: WIDTH_BYTEENA_A NUMERIC "1"
// Retrieval info: USED_PORT: address 0 0 9 0 INPUT NODEFVAL "address[8..0]"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT VCC "clock"
// Retrieval info: USED_PORT: q 0 0 7 0 OUTPUT NODEFVAL "q[6..0]"
// Retrieval info: CONNECT: @address_a 0 0 9 0 address 0 0 9 0
// Retrieval info: CONNECT: @clock0 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: q 0 0 7 0 @q_a 0 0 7 0
// Retrieval info: GEN_FILE: TYPE_NORMAL LIF_DECSIXBIT.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL LIF_DECSIXBIT.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL LIF_DECSIXBIT.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL LIF_DECSIXBIT.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL LIF_DECSIXBIT_inst.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL LIF_DECSIXBIT_bb.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL LIF_DECSIXBIT_syn.v TRUE
// Retrieval info: LIB_FILE: altera_mf