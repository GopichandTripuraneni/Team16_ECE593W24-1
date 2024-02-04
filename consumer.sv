module consumer #(parameter ADDR_WIDTH=9)(
  input logic  clk,r_en,r_rst,
  input logic [ADDR_WIDTH:0]gray_wptrsync,
  output logic empty,
  output logic [ADDR_WIDTH:0]gray_rptr,binary_rptr
);
 
 
  logic [ADDR_WIDTH:0]gray_rptr_nxt;
  logic [ADDR_WIDTH:0]binary_rptr_nxt;
  logic r_empty;
 
  assign binary_rptr_nxt = !r_empty ? binary_rptr + r_en : binary_rptr;
  assign gray_rptr_nxt = (binary_rptr_nxt>>1) ^ binary_rptr_nxt;
 
 
  always_ff@(posedge clk or negedge r_rst) begin
    if(!r_rst) begin
      binary_rptr <= 0;
      gray_rptr <= 0;
    end
    else begin
      binary_rptr <= binary_rptr_nxt;
      gray_rptr <= gray_rptr_nxt;
    end
  end
 
  assign r_empty = (gray_wptrsync == gray_rptr_nxt);
 
  always_ff@(posedge clk or negedge r_rst) begin
    if(!r_rst) empty <= 1;
    else       empty <= r_empty;
  end
endmodule
