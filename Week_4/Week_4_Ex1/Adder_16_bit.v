`timescale 1ns/1ps

module Adder_16_bit(
    input wire [15:0] A_i,
    input wire [15:0] B_i,
    input wire Cin_i,
    output wire [15:0] Sum_o,
    output wire Cout_o
);
    wire c1_w, c2_w;

    Adder_8_bit add8bit1(
        .A_i(A_i[7:0]),
        .B_i(B_i[7:0]),
        .Cin_i(Cin_i),
        .Sum_o(Sum_o[7:0]),
        .Cout_o(c1_w)
    );

    Adder_8_bit add8bit2(
        .A_i(A_i[15:8]),
        .B_i(B_i[15:8]),
        .Cin_i(c1_w),
        .Sum_o(Sum_o[15:8]),
        .Cout_o(c2_w)
    );

endmodule