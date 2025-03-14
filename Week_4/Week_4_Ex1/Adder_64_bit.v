`timescale 1ns/1ps

module Adder_64_bit(
    input wire [63:0] A_i,
    input wire [63:0] B_i,
    input wire Cin_i,
    output wire [63:0] Sum_o,
    output wire Cout_o
);
    wire c1_w, c2_w;

    Adder_32_bit add32bit1(
        .A_i(A_i[31:0]),
        .B_i(B_i[31:0]),
        .Cin_i(Cin_i),
        .Sum_o(Sum_o[31:0]),
        .Cout_o(c1_w)
    );

    Adder_32_bit add32bit2(
        .A_i(A_i[63:32]),
        .B_i(B_i[63:32]),
        .Cin_i(c1_w),
        .Sum_o(Sum_o[63:32]),
        .Cout_o(c2_w)
    );

endmodule