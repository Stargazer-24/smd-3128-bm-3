`timescale 1ns / 1ps

module Multigame512k(input [21:1] addr,
							input [7:0] data,
							output [26:17] rom_addr,
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


wire [21:19] ored_addresses;
assign rom_addr[21:19] = ored_addresses | addr[21:19];
assign rom_addr[18:17] = addr[18:17];

reg [BANK_REG_SIZE-1:0] bank;

assign {rom_addr[26:22], ored_addresses[21:19]} = bank;

always @(negedge n_reset or posedge n_mapper_write) begin
	if (~n_reset)
		bank <= 0;
	else
		bank <= (bank << 1 | addr[7]);
end


endmodule
