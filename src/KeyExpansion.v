// File: KeyExpansion_fixed_final.v
// Module KeyExpansion đ? s?a t?t c? các l?i đ? xác đ?nh

module KeyExpansion(
    input wire          CLK,
    input wire          RST,
    input wire          start_in,
    input wire [31:0]   key0_in,
    input wire [31:0]   key1_in,
    input wire [31:0]   key2_in,
    input wire [31:0]   key3_in,
    output wire [31:0]  key0_out,
    output wire [31:0]  key1_out,
    output wire [31:0]  key2_out,
    output wire [31:0]  key3_out,
    output wire [1:0]   state_out
    );

    //State Declarations (S? d?ng đ? r?ng bit r? ràng)
    parameter IDLE        = 2'b00;
    parameter ROUND0      = 2'b01;
    parameter ROUND1to9   = 2'b10;
    parameter ROUND10     = 2'b11;

    ///// Tín hi?u wire
    wire [31:0]   w4_w;
    wire [31:0]   w5_w;
    wire [31:0]   w6_w;
    wire [31:0]   w7_w;

    wire [31:0]   rotword_w;
    wire [31:0]   subword_w;
    wire [31:0]   roundconst_w;

    ///// Tín hi?u reg
    reg [1:0]   state_r;
    reg [1:0]   next_state_r;
    reg [3:0]   round_r; // 4 bits là đ? (0-11)

    reg [31:0]   w0_r;
    reg [31:0]   w1_r;
    reg [31:0]   w2_r;
    reg [31:0]   w3_r;

    ///// M?ch t? h?p
    // Output logic: Xu?t khóa v?ng hi?n t?i ho?c khóa g?c
    assign key0_out   = (state_r == IDLE) ? 32'b0 : (state_r == ROUND0) ? key0_in : w4_w;
    assign key1_out   = (state_r == IDLE) ? 32'b0 : (state_r == ROUND0) ? key1_in : w5_w;
    assign key2_out   = (state_r == IDLE) ? 32'b0 : (state_r == ROUND0) ? key2_in : w6_w;
    assign key3_out   = (state_r == IDLE) ? 32'b0 : (state_r == ROUND0) ? key3_in : w7_w;

    // Output tr?ng thái FSM hi?n t?i
    assign state_out  = state_r;

    // Instantiation các module con cho hàm g (Gi? s? các module này đúng)
    RotWord rotword(
        .S0_in(w3_r[31:24]), .S1_in(w3_r[23:16]), .S2_in(w3_r[15:8]), .S3_in(w3_r[7:0]),
        .D0_out(rotword_w[31:24]), .D1_out(rotword_w[23:16]), .D2_out(rotword_w[15:8]), .D3_out(rotword_w[7:0])
    );

    SubWord subword(
        .S0_in(rotword_w[31:24]), .S1_in(rotword_w[23:16]), .S2_in(rotword_w[15:8]), .S3_in(rotword_w[7:0]),
        .D0_out(subword_w[31:24]), .D1_out(subword_w[23:16]), .D2_out(subword_w[15:8]), .D3_out(subword_w[7:0])
    );

    RoundConst roundconst(
        .round(round_r),
        .S0_in(subword_w[31:24]), .S1_in(subword_w[23:16]), .S2_in(subword_w[15:8]), .S3_in(subword_w[7:0]),
        .D0_out(roundconst_w[31:24]), .D1_out(roundconst_w[23:16]), .D2_out(roundconst_w[15:8]), .D3_out(roundconst_w[7:0])
    );

    // >>>>>>>>>>>>>>>>>> S?A L?I 1: TÍNH TOÁN KHÓA V?NG <<<<<<<<<<<<<<<<<<
    assign w4_w = w0_r ^ roundconst_w; // w4 = w0 ^ g(w3)
    assign w5_w = w1_r ^ w4_w;         // w5 = w1 ^ w4
    assign w6_w = w2_r ^ w5_w;         // w6 = w2 ^ w5
    assign w7_w = w3_r ^ w6_w;         // w7 = w3 ^ w6
    // >>>>>>>>>>>>>>>>>>>>>>>>>> K?T THÚC S?A 1 <<<<<<<<<<<<<<<<<<<<<<<<<<

    ///// M?ch tu?n t?

    // Always block c?p nh?t các thanh ghi lưu khóa v?ng trư?c (w0_r..w3_r)
    // >>>>>>>>>>>>>>>>>> S?A L?I 5: C?U TRÚC IF/ELSE <<<<<<<<<<<<<<<<<<<<<
    always @(posedge CLK or negedge RST) begin
        if (RST == 0) begin // Ưu tiên reset
            w0_r <= 32'b0;
            w1_r <= 32'b0;
            w2_r <= 32'b0;
            w3_r <= 32'b0;
        end
        else begin // Khi không reset
            if (state_r == IDLE) begin // Reset khi ? IDLE (ho?c gi? nguyên 0)
                w0_r <= 32'b0;
                w1_r <= 32'b0;
                w2_r <= 32'b0;
                w3_r <= 32'b0;
            end
            else if (state_r == ROUND0) begin // N?p khóa g?c khi b?t đ?u v?ng 0
                w0_r <= key0_in;
                w1_r <= key1_in;
                w2_r <= key2_in;
                w3_r <= key3_in;
            end
            // C?p nh?t khóa v?ng trư?c b?ng khóa v?ng m?i đ? tính (w4_w..w7_w)
            // Đi?u này x?y ra khi state_r là ROUND1to9 ho?c ROUND10
            else begin
                w0_r <= w4_w;
                w1_r <= w5_w;
                w2_r <= w6_w;
                w3_r <= w7_w;
            end
        end
    end
    // >>>>>>>>>>>>>>>>>>>>>>>>>> K?T THÚC S?A 5 <<<<<<<<<<<<<<<<<<<<<<<<<<

    // Always block c?p nh?t b? đ?m v?ng
    always @(posedge CLK or negedge RST) begin
        if (RST == 0) begin
            round_r <= 4'b0; // Reset v? 0
        end
        else begin
            if (state_r == IDLE) begin // Reset v? 0 khi ? IDLE
                round_r <= 4'b0;
            end
            // Ch? tăng khi b?t đ?u t? ROUND0 tr? đi VÀ tr?ng thái ti?p theo không ph?i IDLE
            // (Đ? tránh tăng lên 11 r?i m?i v? 0 khi k?t thúc ROUND10)
            else if (next_state_r != IDLE) begin
                 round_r <= round_r + 1;
            end
            // N?u tr?ng thái ti?p theo là IDLE (t?c là v?a xong ROUND10), th? reset round_r v? 0
            else begin // next_state_r == IDLE (ch? x?y ra sau ROUND10)
                 round_r <= 4'b0;
            end
       end
    end

    ///// Máy tr?ng thái FSM

    // Logic t? h?p xác đ?nh tr?ng thái ti?p theo
    always @(*) begin // S? d?ng @(*) cho logic t? h?p
        // M?c đ?nh gi? nguyên tr?ng thái n?u không có đi?u ki?n nào đư?c đáp ?ng
        next_state_r = state_r;
        case (state_r)
            IDLE: begin
                if (start_in) begin
                    next_state_r = ROUND0;
                end
                // else: next_state_r = IDLE; // Gi? nguyên
            end
            ROUND0: begin
                 // >>>>>>>>>>> S?A L?I 6: Chuy?n tr?ng thái t? ROUND0 <<<<<<<<<<<<<
                 // Chuy?n sang ROUND1to9 sau khi đ? ? ROUND0 1 chu k? (lúc round_r *s?p* tăng lên 1)
                 // Dùng giá tr? round_r hi?n t?i (là 0) đ? quy?t đ?nh
                 // Ho?c an toàn hơn là ch? round_r=1 như logic c? đ? s?a
                 if (round_r == 1) begin // Ki?m tra giá tr? round_r SAU khi đ? tăng
                     next_state_r = ROUND1to9;
                 end
                 // else: next_state_r = ROUND0; // Gi? nguyên n?u round_r chưa ph?i 1
            end
            ROUND1to9: begin
                 // >>>>>>>>>>> S?A L?I 7 (Logic r? ràng hơn) <<<<<<<<<<<<<
                 // ? l?i ROUND1to9 n?u round_r t? 1 đ?n 9 (tính khóa 1-9)
                 // round_r là giá tr? *trư?c* khi tăng ? c?nh clock t?i
                 if ((round_r >= 1) && (round_r <= 9)) begin
                     next_state_r = ROUND1to9; // ? l?i
                 end
                 // Chuy?n sang ROUND10 khi round_r = 10 (chu?n b? tính khóa 10)
                 else if (round_r == 10) begin // Nên ki?m tra r? ràng round_r == 10
                     next_state_r = ROUND10;
                 end
                 // else: Có th? thêm default v? IDLE n?u mu?n ch?t ch? hơn
            end
            // >>>>>>>>>>>>>>>>>> S?A L?I 8: Chuy?n tr?ng thái t? ROUND10 <<<<<<<<<<<<<<<<<<<<<
            ROUND10: begin
                // Sau khi ? ROUND10 m?t chu k? (đ? tính và xu?t key 10), chuy?n v? IDLE
                next_state_r = IDLE;
            end
            // >>>>>>>>>>>>>>>>>>>>>>>>>> K?T THÚC S?A 8 <<<<<<<<<<<<<<<<<<<<<<<<<<
            default: next_state_r = IDLE; // Tr?ng thái m?c đ?nh an toàn
        endcase
    end

    // Always block c?p nh?t tr?ng thái FSM theo clock
    always @(posedge CLK or negedge RST) begin
        if (RST == 0) begin
            state_r <= IDLE;
        end
        else begin
            state_r <= next_state_r;
        end
    end

endmodule
