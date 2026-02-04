`include "../interface/alu_interface.sv"

package alu_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  `include "../agent/alu_sequence_item.sv"
  `include "../agent/alu_sequencer.sv"
  `include "../agent/alu_driver.sv"
  `include "../agent/alu_monitor.sv"

  `include "../environment/alu_agent.sv"
  `include "../environment/alu_scoreboard.sv"
  `include "../environment/alu_subscriber.sv"
  `include "../environment/alu_environment.sv"

  `include "../sequences/alu_add_sequence.sv"
  `include "../sequences/alu_and_sequence.sv"
  `include "../sequences/alu_or_sequence.sv"
  `include "../sequences/alu_overflow_sequence.sv"
  `include "../sequences/alu_randome_sequence.sv"
  `include "../sequences/alu_sub_sequence.sv"
  `include "../sequences/alu_undefined_opcode_sequence.sv"
  `include "../sequences/alu_underflow_sequence.sv"
  `include "../sequences/alu_xor_sequence.sv"
    
  `include "../tests/alu_randome_test.sv"
  `include "../tests/alu_regression_test.sv"
endpackage
