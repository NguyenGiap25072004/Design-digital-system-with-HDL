`timescale 1ns/1ps

module tb_adder_128_bit();

    reg [127:0] A_i, B_i;
    reg Cin_i;
    wire [127:0] Sum_o;
    wire Cout_o;

    Adder_128_bit adder_128_bit(
        .A_i(A_i),
        .B_i(B_i),
        .Cin_i(Cin_i),
        .Sum_o(Sum_o),
        .Cout_o(Cout_o)
    );

    initial begin
        // Test case 1
        A_i = 128'h00000000000000000000000000000001;
        B_i = 128'h00000000000000000000000000000001;
        Cin_i = 1'b0;
        #10;
        
        // Test case 2
        A_i = 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
        B_i = 128'h00000000000000000000000000000001;
        Cin_i = 1'b0;
        #10;
        
        // Test case 3
        A_i = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
        B_i = 128'h55555555555555555555555555555555;
        Cin_i = 1'b1;
        #10;
        
        // Test case 4
        A_i = 128'h1234567890ABCDEF1234567890ABCDEF;
        B_i = 128'hFEDCBA0987654321FEDCBA0987654321;
        Cin_i = 1'b0;
        #10;
        
        // Test case 5
        A_i = 128'h00000000000000000000000000000000;
        B_i = 128'h00000000000000000000000000000000;
        Cin_i = 1'b1;
        #10;
        
        $stop;
    end

endmodule




        
