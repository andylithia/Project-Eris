module TextROM(
	input			clk,
	input			rst,
	input [5:0]	char,
	input [2:0]	y,
	input [2:0]	x,
	output reg		pixel_on
);

wire [6:0]	q;

LIF_DECSIXBIT text_rom_inst(
	.address((char*5)+x),
	.clock(clk),
	.q(q));

// assign pixel_on = (y==3'b111)?1'b0:((x>=3'd5)?1'b0:q[y]);
	
always @ (clk) begin
	pixel_on <= (y==3'b111)?1'b0:((x>=3'd5)?1'b0:q[y]);
end


endmodule
