// Test bench for 128-bit adder
`timescale 1ns/1ps

module tb_adder_128_bit();
    reg [127:0] A_i, B_i;
    reg Cin_i;
    wire [127:0] Sum_o;
    wire Cout_o;

    Adder_128_bit add128bit(
        .A_i(A_i),
        .B_i(B_i),
        .Cin_i(Cin_i),
        .Sum_o(Sum_o),
        .Cout_o(Cout_o)
    );

    initial begin
        A_i = 128'h
        
