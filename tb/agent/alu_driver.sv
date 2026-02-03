class alu_driver extends uvm_driver #(alu_sequence_item);
  `uvm_component_utils(alu_driver)
  
   virtual alu_interface v_alu_intf;
   alu_sequence_item item;
  
  function new (string name = "alu_driver", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info(get_type_name(), "inside constructor of the alu_driver", UVM_LOW);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual alu_interface):: get(this, "", "v_alu_intf", v_alu_intf))
      `uvm_fatal(get_type_name(), "the driver not accessed to the dut's interface");
  endfunction
  
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    forever 
       begin
         item = alu_sequence_item::type_id::create("item");
         seq_item_port.get_next_item(item);
         drive(item);
         `uvm_info(get_type_name(), "Signal Driven to the Dut in successfully way", UVM_HIGH);
         seq_item_port.item_done();
       end
  endtask
  
  task drive(alu_sequence_item item);
    @(v_alu_intf.driver_cb);
    v_alu_intf.driver_cb.A      <= item.A;
    v_alu_intf.driver_cb.B      <= item.B;
    v_alu_intf.driver_cb.opcode <= item.opcode;
  endtask
endclass
