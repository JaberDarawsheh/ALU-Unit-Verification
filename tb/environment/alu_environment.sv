class alu_environment extends uvm_env;
`uvm_component_utils(alu_environment)
alu_scoreboard scoreboard;
alu_subscriber subscriber;
alu_agent agent;

function new (string name = "alu_environment", uvm_component parent);
  super.new(name, parent);
  `uvm_info(get_type_name(), "inside constructor of the alu_environment", UVM_LOW);
endfunction

function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   scoreboard = alu_scoreboard::type_id::create("scoreboard", this);
   subscriber = alu_subscriber::type_id::create("subscriber", this);
   agent      = alu_agent::type_id::create("agent", this);
endfunction

function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   agent.monitor.monitor_port.connect(scoreboard.Scoreboard_port);
   agent.monitor.monitor_port.connect(subscriber.subscriber_port);
endfunction
endclass