`timescale 1ns / 1ps

module Multigame128k(input [21:1] addr,
							input [7:0] data,
							output [24:17] rom_addr,
							output n_rom_ce,
							output n_ram_ce,
							input n_wr,
							input n_oe,
							input n_ce,
							input n_reset,
							input n_time
							);

localparam BANK_REG_SIZE = 8;

wire n_mapper_write = n_time | ~n_oe;

assign n_ram_ce = n_wr | n_ce | ~n_oe | addr[21] != 1'b1;
assign n_rom_ce = n_ce | ~n_ram_ce;


wire [21:17] ored_addresses;
assign rom_addr[21:17] = ored_addresses | addr[21:17];

RegRst #(.SIZE(BANK_REG_SIZE),.INITVAL(0)) r (.clk(~n_mapper_write), .n_reset(n_reset), .d({data[7] , addr[7:1]}),
			.o({rom_addr[24:22], ored_addresses}));


endmodule
