`timescale 1ns/1ps

module Adder_128_bit(
    input wire [127:0] A_i,
    input wire [127:0] B_i,
    input wire Cin_i,
    output wire [127:0] Sum_o,
    output wire Cout_o
);
    wire c1_w, c2_w;

    Adder_64_bit add64bit1(
        .A_i(A_i[63:0]),
        .B_i(B_i[63:0]),
        .Cin_i(Cin_i),
        .Sum_o(Sum_o[63:0]),
        .Cout_o(c1_w)
    );

    Adder_64_bit add64bit2(
        .A_i(A_i[127:64]),
        .B_i(B_i[127:64]),
        .Cin_i(c1_w),
        .Sum_o(Sum_o[127:64]),
        .Cout_o(c2_w)
    );

endmodule