class alu_overflow_sequence extends uvm_sequence #(alu_sequence_item);
 `uvm_object_utils(alu_overflow_sequence)

 function new(string name = "alu_overflow_sequence");
    super.new(name);
    `uvm_info(get_type_name(), "inside constructor of the alu_overflow_sequence", UVM_LOW);
 endfunction

 task body();
   alu_sequence_item item = alu_sequence_item::type_id::create("item");

   item.rst = 1;
   start_item(item);
     `uvm_info(get_type_name(), "Restarting the DUT", UVM_LOW);
   finish_item(item);

   #15;

   item.randomize() with {
     rst == 0;
     opcode == 3'b000;
     A == 32'sh7FFFFFFF; // max positive number of A
     B == 32'sh1;  // 1
   };

   start_item(item);
   finish_item(item);

   #15;
 endtask
endclass