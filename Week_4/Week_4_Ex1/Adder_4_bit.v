`timescale 1ns/1ps

module Adder_4_bit(
    input wire [3:0] A_i,
    input wire [3:0] B_i,
    input wire Cin_i,
    output wire [3:0] Sum_o,
    output wire Cout_o
);
    wire c1_w, c2_w, c3_w;

    SUM sum0(
        .A_i(A_i[0]),
        .B_i(B_i[0]),
        .Cin_i(Cin_i),
        .Sum_o(Sum_o[0]),
        .Cout_o(c1_w)
    );

    SUM sum1(
        .A_i(A_i[1]),
        .B_i(B_i[1]),
        .Cin_i(c1_w),
        .Sum_o(Sum_o[1]),
        .Cout_o(c2_w)
    );

    SUM sum2(
        .A_i(A_i[2]),
        .B_i(B_i[2]),
        .Cin_i(c2_w),
        .Sum_o(Sum_o[2]),
        .Cout_o(c3_w)
    );

    SUM sum3(
        .A_i(A_i[3]),
        .B_i(B_i[3]),
        .Cin_i(c3_w),
        .Sum_o(Sum_o[3]),
        .Cout_o(Cout_o)
    );

endmodule