`timescale 1ns/1ps
module COUT (
	input wire A_i,
	input wire B_i,
	input wire Cin_i,
	output wire Cout_o
);
    wire and1_out_w, and2_out_w, xor_out_w, or_out_w;
    AND and1 (
	 .A_i(A_i),
	 .B_i(B_i),
	 .Cout_o(and1_w)
    );
    
    XOR xor1 (
	.A_i(A_i),
	.B_i(B_i),
	.C_o(xor_out_w)
    );
    
    AND and2 (
	 .A_i(Cin_i),
	 .B_i(xor_out_w),
	 .Cout_o(and2_out_w)
    );
    
    OR or1 (
	.A_i(and1_w),
	.B_i(and2_out_w),
	.C_o(or_out_w)
    );
    
    
    assign Cout_o = or_out_w;
   

endmodule
