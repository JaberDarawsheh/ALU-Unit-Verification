import uvm_pkg::*;
`include "uvm_macros.svh"

`include "../pkg/alu_pkg.sv"
import alu_pkg::*;

module testbench;
  logic clk, rst;

  // clk generator
  always #5 clk = ~clk;

  alu_interface vitf(.clk(clk), .rst(rst));
  alu dut (
        .clk    (vitf.clk),
        .rst    (vitf.rst),
        .A      (vitf.A),
        .B      (vitf.B),
        .opcode (vitf.opcode),
        .Result (vitf.Result),
        .Error  (vitf.Error)
    );
  initial begin
        // setting the interface to the config_db
        uvm_config_db#(virtual alu_interface)::set(uvm_root::get(), "*", "vitf", vitf);
    end

  // setup the wave form view
  initial begin
        $dumpfile("alu_waveform.vcd");
        $dumpvars;

        clk = 0;
        rst = 0;
    end
  initial begin
        // run_test("alu_randome_test");
        run_test("alu_regression_test");
    end
   // initial begin
   //     $fsdbDumpfile("debug.fsdb"); // Set the output file for waveforms
   //     $fsdbDumpvars; // Dump all variables to the waveform file
   //     $fsdbDumpvars("+mda"); // Include multidimensional array data
   //     $fsdbDumpvars("+struct"); // Include struct data
   //     $fsdbDumpvars("+all"); // Include all data for debugging
   //     $fsdbDumpon; // Turn on waveform recording
    // end
endmodule
