`timescale 1ns/1ps
module OR (
	input wire A_i,
	input wire B_i,
	output wire C_o
);

	assign C_o = A_i | B_i;
endmodule
