class alu_monitor extends uvm_monitor;
  `uvm_component_utils(alu_monitor)
   virtual alu_interface V_alu_intf;
   alu_sequence_item item;
   uvm_analysis_port #(alu_sequence_item) monitor_port;
   
   function new (string name = "alu_monitor", uvm_component parent);
     super.new(name, parent);
     `uvm_info(get_type_name(), "inside constructor of the alu_monitor", UVM_LOW);
   endfunction
  
   function void build_phase (uvm_phase phase);
     super.build_phase(phase);
     if(!uvm_config_db #(virtual alu_interface):: get(this, "", "v_alu_intf", v_alu_intf))
       `uvm_fatal(get_type_name(), "the monitor not accessed to the dut's interface");
   endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever
      begin
        item = alu_sequence_item::type_id::create("item");
        wait(! v_alu_intf);
        
        // wait until the driver to drive the input signals to the DUT
        @(negedge v_alu_intf.clk);
        
        // now at posedge of clk smaple and observe the input signals
        @(posedge v_alu_intf.clk);
        item.A  =     v_alu_intf.A;
        item.B =      v_alu_intf.B;
        item.opcode = v_alu_intf.opcode;
        
        // sample and observe the output signals from the DUT
        @(posedge v_alu_intf.clk);
        item.Result = v_alu_intf.Result;
        item.Error  = v_alu_intf.Error;
        
        // now the monitor send the item to the scoreboard and subsecriber
        monitor_port.write(item);
      end
  endtask
endclass