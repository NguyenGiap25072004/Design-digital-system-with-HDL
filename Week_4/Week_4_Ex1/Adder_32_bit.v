`timescale 1ns/1ps

module Adder_32_bit(
    input wire [31:0] A_i,
    input wire [31:0] B_i,
    input wire Cin_i,
    output wire [31:0] Sum_o,
    output wire Cout_o
);
    wire c1_w, c2_w;

    Adder_16_bit add16bit1(
        .A_i(A_i[15:0]),
        .B_i(B_i[15:0]),
        .Cin_i(Cin_i),
        .Sum_o(Sum_o[15:0]),
        .Cout_o(c1_w)
    );

    Adder_16_bit add16bit2(
        .A_i(A_i[31:16]),
        .B_i(B_i[31:16]),
        .Cin_i(c1_w),
        .Sum_o(Sum_o[31:16]),
        .Cout_o(c2_w)
    );

endmodule