`timescale 1ns / 1ps

module SSF2 #(parameter REGSIZE=8)(
    input [21:1] addr,
    input [REGSIZE-1:0] data,
    output [19+REGSIZE-1:19] rom_addr,
    output reg n_rom_ce,
    output reg n_ram_ce,
    input n_wr,
    input n_oe,
    input n_ce,
    input n_reset,
    input n_time
    );
	 
wire sram_enable;
wire sram_wp;

always @(*)	begin
	if (addr[21:19] == 3'h4 && sram_enable == 1) begin
		n_rom_ce = 1'b1;
		n_ram_ce = (n_wr | ~n_oe) ? n_ce : (sram_wp ? 1'b1 : n_ce);
	end
	else begin
		n_rom_ce = n_ce;
		n_ram_ce = 1'b1;
	end
end

wire n_mapper_write = n_wr | n_time | ~n_oe | ~(&addr[7:4]);

reg [7:0] clk_sel;

always @(*) begin
	if (n_mapper_write)
		clk_sel = 8'b0;
	else
		case (addr[3:1])
			0: clk_sel = 8'b1;
			1: clk_sel = 8'b10;
			2: clk_sel = 8'b100;
			3: clk_sel = 8'b1000;
			4: clk_sel = 8'b10000;
			5: clk_sel = 8'b100000;
			6: clk_sel = 8'b1000000;
			7: clk_sel = 8'b10000000;
		endcase
end

wire [REGSIZE-1:0] page_address [1:7];
wire [2:0] bank_number = addr[21:19];
assign rom_addr = bank_number == 0 ? {REGSIZE{1'b0}} : page_address[bank_number];

RegRst #(.SIZE(2),.INITVAL(2'b10)) r0 (.clk(clk_sel[0]), .n_reset(n_reset), .d(data[1:0]), .o({sram_wp, sram_enable}));

genvar ireg;
generate
	for (ireg = 1; ireg <= 7; ireg = ireg + 1) begin : RegFile
		RegRst #(.SIZE(REGSIZE),.INITVAL(ireg)) r (.clk(clk_sel[ireg]), .n_reset(n_reset), .d(data[REGSIZE-1:0]), .o(page_address[ireg]));
	end
endgenerate

endmodule
