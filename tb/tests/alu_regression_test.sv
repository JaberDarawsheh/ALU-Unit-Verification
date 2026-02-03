class alu_regression_test extends uvm_test;
 `uvm_component_utils(alu_regression_test)

 // creating alu environment handel
 alu_environment env;

 // creating handels from all sequences
 alu_add_sequence               add_sequence;
 alu_and_sequence               and_sequence;
 alu_or_sequence                or_sequence;
 alu_overflow_sequence          overflow_sequence;
 alu_randome_sequence           randome_sequence;
 alu_sub_sequence               sub_sequence;
 alu_undefined_opcode_sequence  undef_opcode_sequence;
 alu_underflow_sequence         underflow_sequence;
 alu_xor_sequence               xor_sequence;

 function new(string name = "alu_regression_test", uvm_component parent);
   super.new(name, parent);
   `uvm_info(get_type_name(), "inside constructor of the alu_regression_test", UVM_LOW);
 endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  env = alu_environment::type_id::create("env",this);
endfunction

task run_phase(uvm_phase phase);
   super.run_phase(phase);
   phase.raise_objection(this);

   add_sequence = alu_add_sequence:type_id::create("add_sequence");
   add_sequence.start(env.agent.sequencer);

   and_sequence = alu_and_sequence::type_id::create("and_sequence");
   and_sequence.start(env.agent.sequencer);

   or_sequencec = alu_or_sequence::type_id::create("or_sequence");
   or_sequence.start(env.agent.sequencer);

   overflow_sequence = alu_overflow_sequence::type_id::create("overflow_sequence");
   overflow_sequence.start(env.agent.sequencer);

   randome_sequence = alu_randome_sequence::type_id::create("randome_sequence");
   randome_sequence.start(env.agent.sequencer);

   sub_sequence = alu_sub_sequence::type_id::create("sub_sequence");
   sub_sequence.start(env.agent.sequencer);

   undef_opcode_sequence = alu_undefined_opcode_sequence::type_id::create("undef_opcode_sequence");
   undef_opcode_sequence.start(env.agent.sequencer);

   underflow_sequence = alu_underflow_sequence::type_id::create("underflow_sequence");
   underflow_sequence.start(env.agent.sequencer);

   xor_sequence = alu_xor_sequence::type_id::create("xor_sequence");
   xor_sequence.start(env.agent.sequencer);

   phase.drop_objection(this);

   `uvm_info(get_type_name(), "The end of the regression test", UVM_LOW);

endtask


endclass