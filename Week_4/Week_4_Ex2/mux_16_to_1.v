module mux16_1 (
  input wire [15:0] in,
  input wire [3:0] sel,
  output wire out
);

  wire out0, out1, out2, out3;

  mux4_1 mux0 (
    .in(in[3:0]),
    .sel(sel[1:0]),
    .out(out0)
  );

  mux4_1 mux1 (
    .in(in[7:4]),
    .sel(sel[1:0]),
    .out(out1)
  );

  mux4_1 mux2 (
    .in(in[11:8]),
    .sel(sel[1:0]),
    .out(out2)
  );

  mux4_1 mux3 (
    .in(in[15:12]),
    .sel(sel[1:0]),
    .out(out3)
  );

  mux4_1 mux4 (
    .in({out0, out1, out2, out3}),
    .sel(sel[3:2]),
    .out(out)
  );

endmodule