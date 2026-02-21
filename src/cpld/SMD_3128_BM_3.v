// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

/* Pier Solar and The Great Architects */
//`define MAPPER_PIER_SOLAR

/*	1. Super Street Fighter 2
	2. Earthion
	3. Sonic Delta (hack)
	4. Demons of Asteborg
	5. Astebros 
	6. Daemon Claw - Origins of Nnar
	7. Doom Resurrection (32X)(hack) */
`define MAPPER_SSF2

/*	1. Mortal Kombat Ultimate (hack)
	2. FX-Unit Yuki: Henshin Engine */
//`define MAPPER_FLAT64

/* Mortal Kombat Trilogy (hack) */
//`define MAPPER_FLAT80

/* Radica - like pirate multigame carts, 128k page size*/
//`define MAPPER_MULTIGAME_128k

/* Radica - like pirate multigame carts, 512k page size */
//`define MAPPER_MULTIGAME_512k

/* NBA Jam (JUE); (X24C02) */
//`define MAPPER_I2C_ACCLAIM

/* 1. NBA Jam Tournament Edition (JUE); (24C04)
		Note: Rev 00 of the game has buggy eeprom support (incorrect data written), game backup only work with Rev01 version
		(released apparently in 2002, eight years later !)
	2. NFL Quarterback Club (JUE); (24C02)
	3. NFL Quarterback Club 96 (UE); (24C16)
	4. College Slam (U); (24C65)
	5. Frank Thomas Big Hurt Baseball (UE); (24C65) */
//`define MAPPER_I2C_ACCLAIM_LZ95A53 Currently unsupported, requires both /LWR and /UWR signals

/* 1. NHLPA Hockey 93 (UE); (X24C01)
	2. Rings of Power (UE); (X24C01)
	3. John Madden Football 93; (X24C01)
	4. John Madden Football 93; (X24C01)
	5. Bill Walsh College Football; (X24C01) */
//`define MAPPER_I2C_EA

/* 1. Evander 'Real Deal' Holyfield's Boxing (X24C01)
	2. Greatest Heavyweights of the Ring (JUE) (X24C01)
	3  Wonder Boy in Monster World (UE)/Wonder Boy V - Monster World III (J); (X24C01)
	4. Sports Talk Baseball (X24C01)
	5. Honoo no Toukyuuji Dodge Danpei (X24C01)
	6. Ninja Burai Densetsu (X24C01)
	7. Game Toshokan (X24C01)
	8. Megaman - The Wily Wars (E)/Rockman Mega World (J)[alt]; (X24C01)
		NOTE: the original version of Rockman Mega World (J) uses traditional SRAM, header gives $200000-$203FFF range
		the alternate version uses a 128bytes serial EEPROM */
//`define MAPPER_I2C_SEGA

/* 1. Micro Machines 2 - Turbo Tournament (E) (J-Cart); (24C16)
		Note: this game needs the EEPROM to be initially fullfilled with the string
		"PETETEST01234567" otherwise it won't initialize memory with correct data.
	2. Micro Machines Military (E) (J-Cart); (24C08)
	3. Micro Machines Turbo Tournament 96 (E) (J-Cart); (24C16)
	4. Brian Lara Cricket (24C08)
	5. Brian Lara Cricket 96 / Shane Warne Cricket (24C65) */
//`define MAPPER_I2C_CODEMASTERS


module SMD_3128_BM_3
(
// {ALTERA_ARGS_BEGIN} DO NOT REMOVE THIS LINE!

	FA15,
	VA22,
	VA4,
	VA3,
	VA16,
	VA2,
	VA5,
	VA6,
	VA7,
	VA18,
	VA19,
	VA20,
	VA21,
	nRCE,
	nMOE,
	nFCE,
	nRWE,
	FA17,
	FA26,
	FA25,
	FA24,
	FA23,
	FA16,
	FA20,
	FA21,
	nFWE,
	FA22,
	FA19,
	FA18,
	SE_DIN_SDA,
	SE_CLK_SCL,
	SE_DOUT,
	SE_nCE,
	DELAY_OUT,
	DELAY_IN,
	nLWR,
	nVRES,
	nTIME,
	VD3,
	VD4,
	VD2,
	VD5,
	VD1,
	VD6,
	VD0,
	VD7,
	nDTACK,
	AS,
	VA1,
	nCE_0,
	nCAS0,
	VA17,
	VA15,
	VA23
// {ALTERA_ARGS_END} DO NOT REMOVE THIS LINE!

);

// {ALTERA_IO_BEGIN} DO NOT REMOVE THIS LINE!
output			FA15;
input			VA22;
input			VA4;
input			VA3;
input			VA16;
input			VA2;
input			VA5;
input			VA6;
input			VA7;
input			VA18;
input			VA19;
input			VA20;
input			VA21;
output			nRCE;
output			nMOE;
output			nFCE;
output			nRWE;
output			FA17;
output			FA26;
output			FA25;
output			FA24;
output			FA23;
output			FA16;
output			FA20;
output			FA21;
output			nFWE;
output			FA22;
output			FA19;
output			FA18;
inout			SE_DIN_SDA;
output			SE_CLK_SCL;
input			SE_DOUT;
output			SE_nCE;
output			DELAY_OUT;
input			DELAY_IN;
input			nLWR;
input			nVRES;
input			nTIME;
input			VD3;
input			VD4;
input			VD2;
input			VD5;
inout			VD1;
input			VD6;
inout			VD0;
inout			VD7;
inout			nDTACK;
input			AS;
input			VA1;
input			nCE_0;
input			nCAS0;
input			VA17;
input			VA15;
input			VA23;

// {ALTERA_IO_END} DO NOT REMOVE THIS LINE!
// {ALTERA_MODULE_BEGIN} DO NOT REMOVE THIS LINE!

//For I2C serial EEPROM
`ifdef MAPPER_I2C_ACCLAIM
	localparam ADDR_SDA_IN	= 22'h200001; // Write to cart
	localparam ADDR_SDA_OUT	= 22'h200001; // Read from cart
	localparam ADDR_SCL	= 22'h200001; // Write to cart
	`define D_OUT_PIN		VD1
	`define D_IN_PIN		VD0
	`define SCL_IN_PIN	VD1
	`define DISABLE_UNUSED_OUTPUTS assign {VD7, VD0} = 2'bZ;
	`define MAPPER_SERIAL_I2C
`elsif MAPPER_I2C_ACCLAIM_LZ95A53
	localparam ADDR_SDA_IN	= 22'h200001; // Write to cart
	localparam ADDR_SDA_OUT	= 22'h200001; // Read from cart
	localparam ADDR_SCL	= 22'h200000; // Write to cart
	`define D_OUT_PIN		VD0
	`define D_IN_PIN		VD0
	`define SCL_IN_PIN	VD0
	// *Unsupported* `define MAPPER_SERIAL_I2C
`elsif MAPPER_I2C_EA
	localparam ADDR_SDA_IN	= 22'h200001; // Write to cart
	localparam ADDR_SDA_OUT	= 22'h200001; // Read from cart
	localparam ADDR_SCL	= 22'h200001; // Write to cart 
	`define D_OUT_PIN		VD7
	`define D_IN_PIN		VD7
	`define SCL_IN_PIN	VD6
	`define DISABLE_UNUSED_OUTPUTS assign {VD1, VD0} = 2'bZ;
	`define MAPPER_SERIAL_I2C
`elsif MAPPER_I2C_SEGA
	localparam ADDR_SDA_IN	= 22'h200001; // Write to cart
	localparam ADDR_SDA_OUT	= 22'h200001; // Read from cart
	localparam ADDR_SCL	= 22'h200001; // Write to cart
	`define D_OUT_PIN		VD0
	`define D_IN_PIN		VD0
	`define SCL_IN_PIN	VD1
	`define DISABLE_UNUSED_OUTPUTS assign {VD7, VD1} = 2'bZ;
	`define MAPPER_SERIAL_I2C
`elsif MAPPER_I2C_CODEMASTERS
	localparam ADDR_SDA_IN	= 22'h300000; // Write to cart
	localparam ADDR_SDA_OUT	= 22'h380001; // Read from cart
	localparam ADDR_SCL	= 22'h300000; // Write to cart
	`define DISABLE_UNUSED_OUTPUTS assign {VD1, VD0} = 2'bZ;
	`define D_OUT_PIN		VD7
	`define D_IN_PIN		VD0
	`define SCL_IN_PIN	VD1
	`define MAPPER_SERIAL_I2C
`endif

//------------------------------------------------------------------------------
`ifdef MAPPER_PIER_SOLAR

	assign SE_DIN_SDA = 1'bZ; // Used only as input for M95320
	assign nDTACK = 1'bZ; // Unused, but must be kept HiZ
	assign nMOE = nCAS0;
	assign nFWE = nLWR; // Keep flash rewriteable
	assign nRCE = 1'b1; // SRAM is unused
	assign nRWE = 1'b1; // SRAM is unused
	assign DELAY_OUT = 1'b0; // Unused
	assign {FA26, FA25, FA24, FA23} = 4'b0; // Unused, max ROM size is 8MB
	assign {VD7, VD1} = 2'bZ; // Used only as inputs
	
	// VD0 is used as EEPROM data out
	wire eeprom_read;
	assign VD0 = eeprom_read ? SE_DOUT : 1'bZ;
	wire D0 = eeprom_read ? 1'b0 : VD0;

	PierSolar mapper(
					.addr({VA21, VA20, VA19, VA18, VA17, VA16, VA15, 7'b0000000, VA7, VA6, VA5, VA4, VA3, VA2, VA1}),
					.data({VD7, VD6, VD5, VD4, VD3, VD2, VD1, D0}), 
					.rom_addr({FA22, FA21, FA20, FA19, FA18, FA17, FA16, FA15}),
					.n_rom_ce(nFCE),
					.n_wr(nLWR),
					.n_oe(nCAS0),
					.n_ce(nCE_0),
					.n_reset(nVRES),
					.n_time(nTIME),
					.eeprom_n_cs(SE_nCE),
					.eeprom_n_hold(),
					.eeprom_clk(SE_CLK_SCL),
					.eeprom_din(SE_DIN_SDA),
					.eeprom_read(eeprom_read)
					);
//------------------------------------------------------------------------------
`elsif MAPPER_SSF2

	assign SE_DIN_SDA = 1'b0; // Unused
	assign nDTACK = 1'bZ; // Unused, but must be kept HiZ
	assign nMOE = nCAS0;
	assign nFWE = nLWR; // Keep flash rewriteable
	assign nRWE = nLWR;
	assign SE_CLK_SCL = 1'b0; // Unused
	assign SE_nCE = 1'b1; // Unused
	assign DELAY_OUT = 1'b0; // Unused
	assign {FA18, FA17, FA16, FA15} = {VA18, VA17, VA16, VA15};
	assign {VD7, VD1, VD0} = 3'bZ; // Used only as inputs
	
	SSF2 mapper(
				.addr({VA21, VA20, VA19, VA18, VA17, VA16, VA15, 7'b0000000, VA7, VA6, VA5, VA4, VA3, VA2, VA1}),
				.data({VD7, VD6, VD5, VD4, VD3, VD2, VD1, VD0}),
				.rom_addr({FA26, FA25, FA24, FA23, FA22, FA21, FA20, FA19}),
				.n_rom_ce(nFCE),
				.n_ram_ce(nRCE),
				.n_wr(nLWR),
				.n_oe(nCAS0),
				.n_ce(nCE_0),
				.n_reset(nVRES),
				.n_time(nTIME)
			);
//------------------------------------------------------------------------------
`elsif MAPPER_FLAT64

	assign SE_DIN_SDA = 1'b0; // Unused
	assign nDTACK = 1'bZ; // Unused, but must be kept HiZ
	assign nMOE = nCAS0;
	assign nFWE = nLWR; // Keep flash rewriteable
	assign nRCE = 1'b1; // SRAM is unused
	assign nRWE = 1'b1; // SRAM is unused
	assign SE_CLK_SCL = 1'b0; // Unused
	assign SE_nCE = 1'b1; // Unused
	assign DELAY_OUT = 1'b0; // Unused
	assign {FA22, FA21, FA20, FA19, FA18, FA17, FA16, FA15} = {VA22, VA21, VA20, VA19, VA18, VA17, VA16, VA15};
	assign {FA26, FA25, FA24, FA23} = 4'b0; // Unused, max ROM size is 8MB 
	assign {VD7, VD1, VD0} = 3'bZ; // Unused

	// Actual mapper 
	assign nFCE = VA23 | (nCE_0 & (~VA22));
//------------------------------------------------------------------------------
`elsif MAPPER_FLAT80

	assign SE_DIN_SDA = 1'b0; // Unused
	assign nMOE = nCAS0;
	assign nFWE = nLWR; // Keep flash rewriteable
	assign nRCE = 1'b1; // SRAM is unused
	assign nRWE = 1'b1; // SRAM is unused
	assign SE_CLK_SCL = 1'b0; // Unused
	assign SE_nCE = 1'b1; // Unused
	assign DELAY_OUT = 1'b0; // Unused
	assign {FA23, FA22, FA21, FA20, FA19, FA18, FA17, FA16, FA15} = {VA23, VA22, VA21, VA20, VA19, VA18, VA17, VA16, VA15};
	assign {FA26, FA25, FA24} = 3'b0; // Unused, max ROM size is 10MB 
	assign {VD7, VD1, VD0} = 3'bZ; // Unused

	// Actual mapper 
	assign nFCE = nCE_0 & (~(VA23 ^ (VA22 | VA21)));
	assign nDTACK = (VA23 & (VA23 ^ nFCE)) ? 1'b0 : 1'bZ;
//------------------------------------------------------------------------------
`elsif MAPPER_MULTIGAME_128k

	assign SE_DIN_SDA = 1'b0; // Unused
	assign nDTACK = 1'bZ; // Unused, but must be kept HiZ
	assign nMOE = nCAS0;
	assign nFWE = nLWR; // Keep flash rewriteable
	assign nRWE = nLWR;
	assign SE_CLK_SCL = 1'b0; // Unused
	assign SE_nCE = 1'b1; // Unused
	assign DELAY_OUT = 1'b0; // Unused
	assign {FA16, FA15} = {VA16, VA15};
	assign {VD7, VD1, VD0} = 3'bZ; // Used only as inputs
	assign {FA26, FA25} = 2'b0; // Unused, max ROM size is only 32MB :(
	
	Multigame128k mapper(
				.addr({VA21, VA20, VA19, VA18, VA17, VA16, VA15, 7'b0000000, VA7, VA6, VA5, VA4, VA3, VA2, VA1}),
				.data({VD7, VD6, VD5, VD4, VD3, VD2, VD1, VD0}),
				.rom_addr({FA24, FA23, FA22, FA21, FA20, FA19, FA18, FA17}),
				.n_rom_ce(nFCE),
				.n_ram_ce(nRCE),
				.n_wr(nLWR),
				.n_oe(nCAS0),
				.n_ce(nCE_0),
				.n_reset(nVRES),
				.n_time(nTIME)
			);
//------------------------------------------------------------------------------
`elsif MAPPER_MULTIGAME_512k

	assign SE_DIN_SDA = 1'b0; // Unused
	assign nDTACK = 1'bZ; // Unused, but must be kept HiZ
	assign nMOE = nCAS0;
	assign nFWE = nLWR; // Keep flash rewriteable
	assign nRWE = nLWR;
	assign SE_CLK_SCL = 1'b0; // Unused
	assign SE_nCE = 1'b1; // Unused
	assign DELAY_OUT = 1'b0; // Unused
	assign {FA16, FA15} = {VA16, VA15};
	assign {VD7, VD1, VD0} = 3'bZ; // Used only as inputs
	
	Multigame512k mapper(
				.addr({VA21, VA20, VA19, VA18, VA17, VA16, VA15, 7'b0000000, VA7, VA6, VA5, VA4, VA3, VA2, VA1}),
				.data({VD7, VD6, VD5, VD4, VD3, VD2, VD1, VD0}),
				.rom_addr({FA26, FA25, FA24, FA23, FA22, FA21, FA20, FA19, FA18, FA17}),
				.n_rom_ce(nFCE),
				.n_ram_ce(nRCE),
				.n_wr(nLWR),
				.n_oe(nCAS0),
				.n_ce(nCE_0),
				.n_reset(nVRES),
				.n_time(nTIME)
			);
//------------------------------------------------------------------------------
`elsif MAPPER_SERIAL_I2C

	assign nDTACK = 1'bZ; // Unused, but must be kept HiZ
	assign nMOE = nCAS0;
	assign nFWE = nLWR; // Keep flash rewriteable
	assign nRCE = 1'b1; // SRAM is unused
	assign nRWE = 1'b1; // SRAM is unused
	assign SE_nCE = 1'b1; // Unused
	assign DELAY_OUT = 1'b0; // Unused
	assign {FA21, FA20, FA19, FA18, FA17, FA16, FA15} = {VA21, VA20, VA19, VA18, VA17, VA16, VA15};
	assign {FA26, FA25, FA24, FA23, FA22} = 5'b0; // Unused, max ROM size is 4MB 

	`DISABLE_UNUSED_OUTPUTS
	
	reg sda;
	reg scl;

	wire [21:1] addr = {VA21, VA20, VA19, VA18, VA17, VA16, VA15, 7'b0000000, VA7, VA6, VA5, VA4, VA3, VA2, VA1};
	wire read = ~nCE_0 & ~nCAS0;
	wire write = nCAS0;
	
	wire eeprom_read = read & (addr[21:16] == ADDR_SDA_OUT[21:16]);
	wire eeprom_write_scl = write & (addr[21:16] == ADDR_SCL[21:16]);
	wire eeprom_write_sda = write & (addr[21:16] == ADDR_SDA_IN[21:16]);

	assign `D_OUT_PIN = eeprom_read ? SE_DIN_SDA : 1'bZ;

	assign SE_DIN_SDA = sda ? 1'bZ : 1'b0; //Pulled-up
	assign SE_CLK_SCL = scl;

	assign nFCE = nCE_0 | eeprom_read;

	// Posedge on /CE_0 is required here, negedge sometimes trigger on reads...
	always @(negedge nVRES or posedge nCE_0) begin
		if (~nVRES)
			scl <= 1'b1;
		else if (eeprom_write_scl)
			scl <= `SCL_IN_PIN;
	end

	always @(negedge nVRES or posedge nCE_0) begin
		if (~nVRES)
			sda <= 1'b1;
		else if (eeprom_write_sda)
			sda <= `D_IN_PIN;
	end
//------------------------------------------------------------------------------
`endif

// {ALTERA_MODULE_END} DO NOT REMOVE THIS LINE!
endmodule
