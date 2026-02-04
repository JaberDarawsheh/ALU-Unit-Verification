##  Project Overview
A UVM-based verification environment for a 32-bit ALU in SystemVerilog, ensuring that all arithmetic and logic operations work correctly under various scenarios.

##  Features
### ALU Operations:
The ALU is capable of executing the following operations on 32-bit signed and unsigned operands.

| Opcode | Operation    | Description                    |
|--------|--------------|--------------------------------|
| 3'b000 | Addition     | A + B   (with overflow detection)|
| 3'b001 | Subtraction  | A - B   (with underflow detection)|
| 3'b010 | AND          | A & B   (bitwise)               |
| 3'b011 | OR           | A \| B  (bitwise)              |
| 3'b100 | XOR          | A ^ B   (bitwise)               |
| 3'b101 | Reserved     | Undefined operation           |
| 3'b110 | Reserved     | Undefined operation           |
| 3'b111 | Reserved     | Undefined operation           |

## Testbench Architecture
  -  UVM Components
     - **Sequence_items**: Transactions (stimilus) packet carried data sent to DUT to process it.
     - **Sequence**: holds random test cases.
     - **Agent**: holds Sequence_items, sequence, sequencer, driver, monitor.
     - **Environment**: top level test holds agent, scoreboard, subscriber.
     - **scoreboard**: checker (compare the actual DUT output with expected values computed in reference model).
     - **Subscriber**: coverage collector - to ensure that all test scenarios have been tested.

  - Interface:
     - encapsulate related signals together into one block.
     - synchronize driving and monitoring. Used by uvm_driver and uvm_monitor to send or observe signals to/from DUT.

### Interface Signals

| Signal  | Direction | Width | Description                    |
|---------|-----------|-------|--------------------------------|
| clk     | Input     | 1     | Clock signal                   |
| rst     | Input     | 1     | Asynchronous reset (active high)|
| A       | Input     | 32    | First operand (signed)         |
| B       | Input     | 32    | Second operand (unsigned)      |
| Opcode  | Input     | 3     | Operation selection            |
| Result  | Output    | 32    | Operation result               |
| Error   | Output    | 1     | Error flag                     |
       
