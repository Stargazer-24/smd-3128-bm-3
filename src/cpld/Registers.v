//Use RegTris8 but leave output o unconnected ?
module Reg #(parameter SIZE = 8) (input clk, input noe, input [SIZE-1:0]d, output [SIZE-1:0]q);
reg [SIZE-1:0] data;
assign q = noe ? {SIZE{1'bZ}} : data;

always @ (posedge clk) begin
	data <= d;
end

endmodule


module Reg7loq(input clk, input n_oe, input [6:0]d, output [6:0]o, output [7:0]tris8);
reg [6:0] data;

assign o = data;
assign tris8 = n_oe ? 8'bZ : {data, 1'b0}; 
 
always @ (posedge clk) begin
	data <= d;
end
endmodule


module RegTris8 #(parameter SIZE=8) (input clk, input n_oe, input [SIZE-1:0]d, output [SIZE-1:0]o, output [7:0]tris8);
reg [SIZE-1:0] data;
assign o = data;
assign tris8 = n_oe ? 8'bZ : {{(8-SIZE){1'b0}}, data };

always @ (posedge clk) begin
	data <= d;
end
endmodule


module RegRst #(parameter SIZE=8, parameter [SIZE-1:0] INITVAL=0)(input clk, input n_reset, input [SIZE-1:0]d, output reg [SIZE-1:0]o);
always @ (posedge clk or negedge n_reset) begin
	if (~n_reset)
		o <= INITVAL;
	else
		o <= d;
end
endmodule
