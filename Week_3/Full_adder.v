`timescale 1ns/1ps
module Full_adder (
    input wire A_i,
    input wire B_i,
    input wire Cin_i,
    output wire Sum_o,
    output wire Cout_o
);

    // Instance SUM module
    SUM sum_unit (
        .A_i(A_i),
        .B_i(B_i),
        .Cin_i(Cin_i),
        .Sum_o(Sum_o)
    );

    // Instance COUT module
    COUT cout_unit (
        .A_i(A_i),
        .B_i(B_i),
        .Cin_i(Cin_i),
        .Cout_o(Cout_o)
    );

endmodule