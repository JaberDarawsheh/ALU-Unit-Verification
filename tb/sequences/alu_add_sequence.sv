class alu_add_sequence extends uvm_sequence #(alu_sequence_item);
  `uvm_object_utils(alu_add_sequence)

  function new(string name = "alu_add_sequence");
    super.new(name);
    `uvm_info(get_type_name(), "inside constructor of the alu_add_sequence", UVM_LOW);
  endfunction

  task body();
     // creating a new trasaction 
     alu_sequence_item item = alu_sequence_item::type_id::create("item");
     
     item.rst = 1;
     start_item(item);
     `uvm_info(get_type_name(), "Restarting the DUT", UVM_LOW);
     finish_item(item);

     #15;

     assert(item.randomize() with {
        rst == 0;
        opcode == 3'b000;
     });

     start_item(item);
     finish_item(item);

     #15;
  endtask
endclass