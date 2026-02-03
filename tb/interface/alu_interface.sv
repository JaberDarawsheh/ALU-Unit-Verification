interface alu_intf (input logic clk, rst);

 // inputs and outputs signals
  logic signed [31:0] A;
  logic signed [31:0] B;
  logic        [2:0]  opcode;
  logic        [31:0] Result;
  logic               Error;

clocking driver_cb @(negedge clk);
  default input #1 output #0;
  output A;
  output B;
  output opcode;
endclocking

clocking monitor_cb @(posedge clk);
  default input #0 output #1;
  input A;
  input B;
  input opcode;
  input Result;
  input Error;
endclocking

modport driver (clocking driver_cb, input clk);
modport monitor (clocking monitor_cb, input clk);

endinterface