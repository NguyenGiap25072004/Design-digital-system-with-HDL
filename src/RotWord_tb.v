// File: RotWord_tb.v
// Testbench cho module RotWord

`timescale 1ns / 1ps

module RotWord_tb;

    // Tín hiệu Testbench
    reg  [7:0] S0_in_r;
    reg  [7:0] S1_in_r;
    reg  [7:0] S2_in_r;
    reg  [7:0] S3_in_r;

    wire [7:0] D0_out_w;
    wire [7:0] D1_out_w;
    wire [7:0] D2_out_w;
    wire [7:0] D3_out_w;

    // Biến để kiểm tra
    integer test_num;
    integer fail_count;

    // Giá trị mong đợi
    reg [7:0] expected_D0;
    reg [7:0] expected_D1;
    reg [7:0] expected_D2;
    reg [7:0] expected_D3;

    // Instantiate the Design Under Test (DUT)
    RotWord dut (
        .S0_in(S0_in_r),
        .S1_in(S1_in_r),
        .S2_in(S2_in_r),
        .S3_in(S3_in_r),
        .D0_out(D0_out_w),
        .D1_out(D1_out_w),
        .D2_out(D2_out_w),
        .D3_out(D3_out_w)
    );

    // Test Sequence
    initial begin
        test_num = 0;
        fail_count = 0;

        $display("--- Bắt đầu Testbench RotWord ---");

        // Test Case 1: Chuỗi đơn giản
        test_num = test_num + 1;
        S0_in_r = 8'h01; S1_in_r = 8'h02; S2_in_r = 8'h03; S3_in_r = 8'h04;
        // Giá trị mong đợi: D0=S1, D1=S2, D2=S3, D3=S0
        expected_D0 = 8'h02; expected_D1 = 8'h03; expected_D2 = 8'h04; expected_D3 = 8'h01;
        #10; // Chờ cho tín hiệu lan truyền
        $display("--- Test Case %0d: Input = %h %h %h %h ---", test_num, S0_in_r, S1_in_r, S2_in_r, S3_in_r);
        $display("  Expected Output: %h %h %h %h", expected_D0, expected_D1, expected_D2, expected_D3);
        $display("  Actual Output:   %h %h %h %h", D0_out_w, D1_out_w, D2_out_w, D3_out_w);
        if (D0_out_w === expected_D0 && D1_out_w === expected_D1 && D2_out_w === expected_D2 && D3_out_w === expected_D3) begin
            $display("  Result: PASS");
        end else begin
            $display("  Result: FAIL ***");
            fail_count = fail_count + 1;
        end

        // Test Case 2: Giá trị đặc biệt
        test_num = test_num + 1;
        S0_in_r = 8'hFF; S1_in_r = 8'hAA; S2_in_r = 8'h55; S3_in_r = 8'h00;
        // Giá trị mong đợi: D0=S1, D1=S2, D2=S3, D3=S0
        expected_D0 = 8'hAA; expected_D1 = 8'h55; expected_D2 = 8'h00; expected_D3 = 8'hFF;
        #10;
        $display("--- Test Case %0d: Input = %h %h %h %h ---", test_num, S0_in_r, S1_in_r, S2_in_r, S3_in_r);
        $display("  Expected Output: %h %h %h %h", expected_D0, expected_D1, expected_D2, expected_D3);
        $display("  Actual Output:   %h %h %h %h", D0_out_w, D1_out_w, D2_out_w, D3_out_w);
        if (D0_out_w === expected_D0 && D1_out_w === expected_D1 && D2_out_w === expected_D2 && D3_out_w === expected_D3) begin
            $display("  Result: PASS");
        end else begin
            $display("  Result: FAIL ***");
            fail_count = fail_count + 1;
        end

        // Test Case 3: Giá trị từ KeyExpansion w3 = 67204675
        test_num = test_num + 1;
        S0_in_r = 8'h67; S1_in_r = 8'h20; S2_in_r = 8'h46; S3_in_r = 8'h75;
        // Giá trị mong đợi: D0=S1, D1=S2, D2=S3, D3=S0
        expected_D0 = 8'h20; expected_D1 = 8'h46; expected_D2 = 8'h75; expected_D3 = 8'h67;
        #10;
        $display("--- Test Case %0d: Input = %h %h %h %h ---", test_num, S0_in_r, S1_in_r, S2_in_r, S3_in_r);
        $display("  Expected Output: %h %h %h %h", expected_D0, expected_D1, expected_D2, expected_D3);
        $display("  Actual Output:   %h %h %h %h", D0_out_w, D1_out_w, D2_out_w, D3_out_w);
        if (D0_out_w === expected_D0 && D1_out_w === expected_D1 && D2_out_w === expected_D2 && D3_out_w === expected_D3) begin
            $display("  Result: PASS");
        end else begin
            $display("  Result: FAIL ***");
            fail_count = fail_count + 1;
        end

        // Test Case 4: Các giá trị giống nhau
        test_num = test_num + 1;
        S0_in_r = 8'hA5; S1_in_r = 8'hA5; S2_in_r = 8'hA5; S3_in_r = 8'hA5;
        // Giá trị mong đợi: D0=S1, D1=S2, D2=S3, D3=S0
        expected_D0 = 8'hA5; expected_D1 = 8'hA5; expected_D2 = 8'hA5; expected_D3 = 8'hA5;
        #10;
        $display("--- Test Case %0d: Input = %h %h %h %h ---", test_num, S0_in_r, S1_in_r, S2_in_r, S3_in_r);
        $display("  Expected Output: %h %h %h %h", expected_D0, expected_D1, expected_D2, expected_D3);
        $display("  Actual Output:   %h %h %h %h", D0_out_w, D1_out_w, D2_out_w, D3_out_w);
        if (D0_out_w === expected_D0 && D1_out_w === expected_D1 && D2_out_w === expected_D2 && D3_out_w === expected_D3) begin
            $display("  Result: PASS");
        end else begin
            $display("  Result: FAIL ***");
            fail_count = fail_count + 1;
        end

        // Final Summary
        $display("------------------------------------");
        if (fail_count == 0)
            $display("--- RotWord Testbench: ALL %0d TESTS PASSED ---", test_num);
        else
            $display("--- RotWord Testbench: %0d out of %0d TESTS FAILED ---", fail_count, test_num);
        $display("------------------------------------");

        $finish;
    end

endmodule