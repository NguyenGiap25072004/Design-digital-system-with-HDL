`timescale 1ns/1ps
module Full_adder_tb;

    reg A_tb;
    reg B_tb;
    reg Cin_tb;
    wire Sum_tb;
    wire Cout_tb;

    Full_adder DUT (
        .A_i(A_tb),
        .B_i(B_tb),
        .Cin_i(Cin_tb),
        .Sum_o(Sum_tb),
        .Cout_o(Cout_tb)
    );

    initial begin
        
        A_tb = 0;
        B_tb = 0;
        Cin_tb = 0;

        // Test case 1: 0 + 0 + 0 = 0 carry 0
        #10; 
        $display("Test Case 1: A=0, B=0, Cin=0, Sum=%b, Cout=%b", A_tb, B_tb, Cin_tb, Sum_tb, Cout_tb);

        // Test case 2: 0 + 0 + 1 = 1 carry 0
        Cin_tb = 1;
        #10;
        $display("Test Case 2: A=0, B=0, Cin=1, Sum=%b, Cout=%b", A_tb, B_tb, Cin_tb, Sum_tb, Cout_tb);
        // Test case 3: 0 + 1 + 0 = 1 carry 0
        Cin_tb = 0;
        B_tb = 1;
        #10;
        $display("Test Case 3: A=0, B=1, Cin=0, Sum=%b, Cout=%b", A_tb, B_tb, Cin_tb, Sum_tb, Cout_tb);
        // Test case 4: 0 + 1 + 1 = 0 carry 1
        Cin_tb = 1;
        #10;
        $display("Test Case 4: A=0, B=1, Cin=1, Sum=%b, Cout=%b", A_tb, B_tb, Cin_tb, Sum_tb, Cout_tb);
        // Test case 5: 1 + 0 + 0 = 1 carry 0
        Cin_tb = 0;
        B_tb = 0;
        A_tb = 1;
        #10;
        $display("Test Case 5: A=1, B=0, Cin=0, Sum=%b, Cout=%b", A_tb, B_tb, Cin_tb, Sum_tb, Cout_tb);
        // Test case 6: 1 + 0 + 1 = 0 carry 1
        Cin_tb = 1;
        #10;
        $display("Test Case 6: A=1, B=0, Cin=1, Sum=%b, Cout=%b", A_tb, B_tb, Cin_tb, Sum_tb, Cout_tb);
        // Test case 7: 1 + 1 + 0 = 0 carry 1
        Cin_tb = 0;
        B_tb = 1;
        #10;
        $display("Test Case 7: A=1, B=1, Cin=0, Sum=%b, Cout=%b", A_tb, B_tb, Cin_tb, Sum_tb, Cout_tb);
        // Test case 8: 1 + 1 + 1 = 1 carry 1
        Cin_tb = 1;
        #10;
        $display("Test Case 8: A=1, B=1, Cin=1, Sum=%b, Cout=%b", A_tb, B_tb, Cin_tb, Sum_tb, Cout_tb);
        $finish; 
    end
endmodule