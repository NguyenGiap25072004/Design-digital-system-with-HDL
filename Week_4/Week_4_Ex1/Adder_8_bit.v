`timescale 1ns/1ps

module Adder_8_bit(
    input wire [7:0] A_i,
    input wire [7:0] B_i,
    input wire Cin_i,
    output wire [7:0] Sum_o,
    output wire Cout_o
);
    wire c1_w, c2_w;

    Adder_4_bit add4bit1(
        .A_i(A_i[3:0]),
        .B_i(B_i[3:0]),
        .Cin_i(Cin_i),
        .Sum_o(Sum_o[3:0]),
        .Cout_o(c1_w)
    );

    Adder_4_bit add4bit2(
        .A_i(A_i[7:4]),
        .B_i(B_i[7:4]),
        .Cin_i(c1_w),
        .Sum_o(Sum_o[7:4]),
        .Cout_o(c2_w)
    );

endmodule