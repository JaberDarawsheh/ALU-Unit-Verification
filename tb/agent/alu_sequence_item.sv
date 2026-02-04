class alu_sequence_item extends uvm_sequence_item;
  
  // Group the inputs and outputs sigal
  rand logic               rst;
  rand logic signed [31:0] A;
  rand logic signed [31:0] B;
  rand logic        [2:0]  opcode;
  logic        [31:0] Result;
  logic               Error;
  
  // macros to register the class and it's fields into the uvm factory
  `uvm_object_utils_begin(alu_sequence_item)
    `uvm_field_int(rst,    UVM_ALL_ON)
    `uvm_field_int(A,      UVM_ALL_ON)
    `uvm_field_int(B,      UVM_ALL_ON)
    `uvm_field_int(opcode, UVM_ALL_ON)
    `uvm_field_int(Result, UVM_ALL_ON)
    `uvm_field_int(Error,  UVM_ALL_ON)
  `uvm_object_utils_end
  
  // constructor
  function new(string name = "alu_sequence_item");
    super.new(name);
    `uvm_info(get_type_name(), "inside the constructor of the alu_sequence_item", UVM_LOW);
  endfunction
endclass
