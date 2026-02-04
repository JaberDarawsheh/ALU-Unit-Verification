class alu_scoreboard extends uvm_scoreboard;
 `uvm_component_utils(alu_scoreboard)
 uvm_analysis_imp #(alu_sequence_item, alu_scoreboard) Scoreboard_port;
 alu_sequence_item item_ref;
 alu_sequence_item packetsQueue[$];
 alu_sequence_item packet;

 function new (string name = "alu_scoreboard", uvm_component parent);
   super.new(name, parent);
   item_ref = alu_sequence_item::type_id::create("item_ref");
   `uvm_info(get_type_name(), "inside constructor of the alu_scoreboard", UVM_LOW);
 endfunction

 function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  Scoreboard_port = new("Scoreboard_port", this);
 endfunction

 function void write(alu_sequence_item item);
   packetsQueue.push_back(item);
 endfunction

 task run_phase(uvm_phase phase);
   super.run_phase(phase);
   forever begin
    wait(packetsQueue.size() > 0);
    packet = packetsQueue.pop_front();

    // copy the input fields to the reference item
    this.item_ref.rst    = packet.rst;
    this.item_ref.A      = packet.A;
    this.item_ref.B      = packet.B;
    this.item_ref.opcode = packet.opcode;

    //here calling the reference model to compute the expexted output value
    alu_reference_modle(packet.rst, packet.A, packet.B, packet.opcode, this.item_ref.Result, this.item_ref.Error);

    if(is_equal(packet, this.item_ref)) begin
       `uvm_info("pass", $sformatf("----- :: Match:: -----"), UVM_LOW);
    end else begin
       `uvm_error("fail", $sformatf("-----:: MisMatch :: -----"));
    end
    
    `uvm_info("ACTUAL PACKET", $sformatf("Actual Packet :  A = %0d, B = %0d, opcode = %0d, Result = %0d, Error = %0d", packet.A, packet.B, packet.opcode, packet.Result, packet.Error), UVM_LOW);
    `uvm_info("EXPECTED PACKET" ,$sformatf("EXpected Packet :  A = %0d, B = %0d, opcode = %0d, Result = %0d, Error = %0d", item_ref.A, item_ref.B, item_ref.opcode, item_ref.Result, item_ref.Error) , UVM_LOW);
    $display("------------------------------------------------------------");
   end
 endtask

 function bit is_equal(alu_sequence_item reference, alu_sequence_item packet);
   if(reference.A == packet.A && reference.B == packet.B && reference.opcode == packet.opcode && reference.Result == packet.Result && reference.Error == packet.Error) return 1;
   else return 0;
 endfunction

 // alu reference model
 static task alu_reference_modle(
   input  logic               rst,
   input  logic signed [31:0] A,
   input  logic signed [31:0] B,
   input  logic        [2:0]  opcode,
   output logic        [31:0] Result,
   output logic               Error
 );

 if(rst) begin
   Result = 32'b0;
   Error  = 1'b0;
 end
  else begin
   Error = 1'b0;
   case(opcode)
     3'b000: begin
            // addition operation
            Result = A + B;
            // here you need to detect the overflow in the sign bit
            // the addition overflow occur when positive + positive = negative or negative + negative = positive
            if ((A >= 0 && B >= 0 && $signed(A + B) < 0) || (A < 0 && B < 0 && $signed(A + B) >= 0))
               Error = 1;
     end
     3'b001: begin
            // subtraction operation
            Result = A - B;
            // here you need to detect the underflow in the sign bit
            // the underflow occur when pos - neg = neg  or neg - pos = pos
            if ((A >= 0 && B < 0 && $signed(A - B) < 0) || (A < 0 && B >= 0 && $signed(A - B) >= 0))
                Error = 1;
     end
     3'b010:begin
           // AND operation
           Result = A & B;
     end
     3'b011: begin
          // OR operation
          Result = A | B;
     end
     3'b100: begin
        // XOR operation
        Result = A ^ B;
     end
     default : begin
          // case invalid opcode
          Result = 32'b0;
          Error  = 1'b1; // turn on the Error flag
     end
   endcase
  end
 endtask
endclass