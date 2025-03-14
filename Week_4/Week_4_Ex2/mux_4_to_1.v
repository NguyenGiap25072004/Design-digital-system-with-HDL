module mux4_1 (
  input wire [3:0] in,
  input wire [1:0] sel,
  output wire out
);

  wire out0, out1;

  mux2_1 mux0 (
    .a(in[0]),
    .b(in[1]),
    .sel(sel[0]),
    .out(out0)
  );

  mux2_1 mux1 (
    .a(in[2]),
    .b(in[3]),
    .sel(sel[0]),
    .out(out1)
  );

  mux2_1 mux2 (
    .a(out0),
    .b(out1),
    .sel(sel[1]),
    .out(out)
  );

endmodule