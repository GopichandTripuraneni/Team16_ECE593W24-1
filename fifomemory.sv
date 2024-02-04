module fifomemory #(parameter DEPTH=360, DATA_WIDTH=8, ADDR_WIDTH=9)(
  input logic clk, w_en, r_en,
  input logic [ADDR_WIDTH:0] binary_wptr, binary_rptr,
  input logic [DATA_WIDTH-1:0] data_in,
  input logic full, empty,
  output logic [DATA_WIDTH-1:0] data_out
);
  logic [DATA_WIDTH-1:0] fifo[0:DEPTH-1];
 
  always_ff @(posedge clk) begin
    if (w_en && !full)
      fifo[binary_wptr[ADDR_WIDTH:0]] <= data_in;
  end

  always_ff @(posedge clk) begin
    if (r_en && !empty)
      data_out <= fifo[binary_rptr[ADDR_WIDTH:0]];
  end
endmodule
