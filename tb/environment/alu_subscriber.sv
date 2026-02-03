class alu_subscriber extends uvm_subscriber #(alu_sequence_item);
  `uvm_component_utils(alu_subscriber)

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

   function void write(alu_sequence_item item)
     subsc.A      = item.A;
     subsc.B      = item.B;
     subsc.opcode = item.opcode;
     subsc.Result = item.Result;
     subsc.Error  = item.Error;
     alu_coverage.smaple();
   endfunction

   // the last uvm phase 
   function void report_phase(uvm_phase phase);
     super.report_phase(phase);
     `uvm_info(get_type_name(), $sformatf("Coverage:  %.2f%%", alu_coverage.get_coverage()), UVM_LOW);
   endfunction 
endclass