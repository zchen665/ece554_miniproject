// fifo.sv
// Implements delay buffer (fifo)
// On reset all entries are set to 0
// Shift causes fifo to shift out oldest entry to q, shift in d

module fifo
  #(
  parameter DEPTH=8,
  parameter BITS=64
  )
  (
  input clk,rst_n,en,
  input [BITS-1:0] d,
  output logic [BITS-1:0] q
  );

  logic [BITS-1:0]queue [DEPTH-1:0];
  // logic bitsout[BITS-1:0];
  always@(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
      for(integer i = 0; i < DEPTH; i++) begin
        queue[i] <= 0;
      end
    end
    if (en) begin
      for(integer i = 0; i < DEPTH-1; i++) begin
        queue[DEPTH-1-i] <= queue[DEPTH-2-i];
      end
      queue[0]<= d;
    end
  end
  assign q = queue[DEPTH-1];

endmodule // fifo