`timescale 1ns/1ps

module SUM
(
	input wire A_i,
	input wire B_i,
	input wire Cin_i,
	output wire Sum_o,
	output wire Cout_o
);
	wire xor1_out_w, xor2_out_w;

	
	XOR xor1
	(
		.A_i(A_i),
		.B_i(B_i),
		.C_o(xor1_out_w)
	);

	XOR xor2
	(
		.A_i(xor1_out_w),
		.B_i(Cin_i),
		.C_o(xor2_out_w)
	);
	
	assign Sum_o = xor2_out_w;

	wire and1_out_w, and2_out_w;

	AND and1 (
		.A_i(xor1_out_w),
		.B_i(Cin_i),
		.C_o(and1_out_w)
	);

	AND and2 (
		.A_i(A_i),
		.B_i(B_i),
		.C_o(and2_out_w)
	);

	XOR xor3 (
		.A_i(and1_out_w),
		.B_i(and2_out_w),
		.C_o(Cout_o)
	);

		
endmodule


