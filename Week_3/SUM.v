`timescale 1ns/1ps
module SUM (
	input wire A_i,
	input wire B_i,
	input wire Cin_i,
	output wire Sum_o
);
    wire xor1_out_w, xor2_out_w;
    
    XOR xor1 (
	.A_i(A_i),
	.B_i(B_i),
	.C_o(xor1_out_w)
    );
    
    XOR xor2 (
	.A_i(xor1_out_w),
	.B_i(Cin_i),
	.C_o(xor2_out_w)
    );
    
    assign Sum_o = xor2_out_w;

endmodule
