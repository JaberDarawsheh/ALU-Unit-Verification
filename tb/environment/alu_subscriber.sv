class alu_subscriber extends uvm_subscriber #(alu_sequence_item);
  `uvm_component_utils(alu_subscriber)
   uvm_analysis_export #(alu_sequence_item) subscriber_port;
   alu_sequence_item subsc;
   covergroup alu_coverage;
     A:      coverpoint subsc.A;
     B:      coverpoint subsc.B;
     opcode: coverpoint subsc.opcode;
     Result: coverpoint subsc.Result;
     Error:  coverpoint subsc.Error;
   endgroup

   // constructor: new
   function new(string name = "alu_subscriber", uvm_component parent);
      super.new(name, parent);
      // creating object from alu coverage
      alu_coverage = new();
      // creating object from the sequence item
      subsc = new();
      `uvm_info(get_type_name(), "inside constructor of the alu_subscriber", UVM_LOW);
   endfunction

   virtual function void write(alu_sequence_item t);
     subsc.A      = t.A;
     subsc.B      = t.B;
     subsc.opcode = t.opcode;
     subsc.Result = t.Result;
     subsc.Error  = t.Error;
     alu_coverage.sample();
   endfunction

   // the last uvm phase 
   function void report_phase(uvm_phase phase);
     super.report_phase(phase);
     `uvm_info(get_type_name(), $sformatf("Coverage:  %.2f%%", alu_coverage.get_coverage()), UVM_LOW);
   endfunction 
endclass
