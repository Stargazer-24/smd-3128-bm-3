`timescale 1ns / 1ps

module PierSolar(
	input [21:1] addr,
	input [7:0] data,
	output [22:15] rom_addr,
	output n_rom_ce,
	input n_wr,
	input n_oe,
	input n_ce,
	input n_reset,
	input n_time,
	output wire eeprom_n_cs,
	output wire eeprom_n_hold,
	output wire eeprom_clk,
	output wire eeprom_din,
	output wire eeprom_read
	);

localparam BANK_REG_SIZE = 4;
localparam NUM_BANKS = 3;

reg protection_release;
reg [1:0] protection_counter;

wire protection_active = protection_counter == 2'b0 ? 1'b0 : 1'b1;
assign rom_addr[16:15] = protection_release ? addr[16:15] : 2'b0;
assign rom_addr[18:17] = addr[18:17];

wire n_mapper_write = n_wr | n_time | ~n_oe | (|addr[7:4]); //0xA1300x

assign eeprom_read = n_wr & ~n_time & ~n_oe & ({addr[7:1],1'b1} == 8'h0B); //Only address 0xA1300B is readable


always @(negedge n_ce or negedge n_reset) begin
	if (~n_reset)
		protection_counter <= 2'b11;
	else
		if (protection_active && addr[16:15] == 2'b11) //0xx8xxx: 0x181C8, 0x18104, 0x181C9
			protection_counter <= protection_counter - 1'b1;
end

always @(negedge n_ce or negedge n_reset) begin
	if (~n_reset)
		protection_release <= 1'b0;
	else
		if (~protection_active)
			protection_release <= 1'b1;
end

assign n_rom_ce = n_ce;

reg [3:0] clk_sel;

always @(*) begin
	if (n_mapper_write)
		clk_sel = 4'b0;
	else
		case (addr[3:1])
			//0: 0xA13001 w/o mapper enable ? can be ignored
			1: clk_sel = 4'b1; //0xA13003 w/o page select (0-15) for bank1 (0x280000 - 0x2FFFFF).
			2: clk_sel = 4'b10; //0xA13005 w/o page select (0-15) for bank2 (0x300000 - 0x37FFFF).
			3: clk_sel = 4'b100; //0xA13007 w/o page select (0-15) for bank3 (0x380000 - 0x3FFFFF).
			4: clk_sel = 4'b1000; //0xA13009 w/o EEPROM control register
			//5: 0xA1300B r/o EEPROM data
			default:
				clk_sel = 4'b0;
		endcase
end

wire [BANK_REG_SIZE-1:0] page_address [0:NUM_BANKS-1];
reg [BANK_REG_SIZE-1:0] hi_rom_addr;

always @(*) begin
	case (addr[21:19])
		5: hi_rom_addr = page_address[0];
		6: hi_rom_addr = page_address[1];
		7: hi_rom_addr = page_address[2];
		default:
			hi_rom_addr = {1'b0, addr[21:19]};
	endcase
end

assign rom_addr[22:19] = hi_rom_addr;


RegRst #(.SIZE(4),.INITVAL(4'b1111)) control_reg (.clk(clk_sel[3]), .n_reset(n_reset), .d(data[3:0]),
			.o({eeprom_n_cs, eeprom_n_hold, eeprom_clk, eeprom_din}));

genvar ireg;
generate
	for (ireg = 0; ireg < NUM_BANKS; ireg = ireg + 1) begin : RegFile
		RegRst #(.SIZE(BANK_REG_SIZE),.INITVAL(ireg)) r (	.clk(clk_sel[ireg]), 
																			.n_reset(n_reset),
																			.d(data[BANK_REG_SIZE-1:0]),
																			.o(page_address[ireg])
																		);
	end
endgenerate

endmodule
