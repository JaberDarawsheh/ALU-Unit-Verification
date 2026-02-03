class alu_randome_test extends uvm_test;
  `uvm_component_utils(alu_randome_test)

  alu_environment env;
  alu_randome_sequence rseq;

  function new(string name = "alu_randome_test", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "inside constructor of the alu_randome_test", UVM_LOW);
  endfunction

  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    env = alu_environment::type_id::create("env");
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    seq = alu_randome_sequence::type_id::create("seq");

    repeat(500)
    begin
      seq.start(env.agent.sequencer);
    end

    phase.drop_objection(this);
    `uvm_info(get_type_name(), "The end of the testcase", UVM_LOW);
  endtask

endclass