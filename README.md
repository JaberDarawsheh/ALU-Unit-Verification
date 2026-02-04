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


##   ALU Unit Verification Project Structure 

```text
ALU_Unit_Verification/
├── rtl/
│ └── alu.sv
├── tb/
│ ├── agent/
│ │ ├── alu_sequence_item.sv
│ │ ├── alu_sequence.sv
│ │ ├── alu_driver.sv
│ │ └── alu_monitor.sv
│ ├── environment/
│ │ ├── alu_agent.sv
│ │ ├── alu_environment.sv
│ │ ├── alu_scoreboard.sv
│ │ └── alu_subscriber.sv
│ ├── interface/
│ │ └── alu_interface.sv
│ ├── pkg/
│ │ └── alu_pkg.sv
│ ├── sequences/
│ │ ├── alu_add_sequence.sv
│ │ ├── alu_and_sequence.sv
│ │ ├── alu_or_sequence.sv
│ │ ├── alu_overflow_sequence.sv
│ │ ├── alu_random_sequence.sv
│ │ ├── alu_sub_sequence.sv
│ │ ├── alu_undefined_opcode_sequence.sv
│ │ ├── alu_underflow_sequence.sv
│ │ └── alu_xor_sequence.sv
│ ├── tests/
│ │ ├── alu_random_test.sv
│ │ └── alu_regression_test.sv
│ └── top/
│ └── testbench.sv
```

##   Detected RTL Design Bugs During Hardware Verification

##   Bugs & Fixes

### 1️⃣ Reset Signal Issue
**Issue:**  
Reset signal was not cleared after internal operations, which caused incorrect outputs when reset was asserted.

**Fix:**  
Modified reset handling logic to ensure reset has priority and correctly initializes all registers and outputs.

---

### 2️⃣ Overflow and Underflow Detection Error
**Issue:**  
Overflow and underflow flags were incorrectly detected in some arithmetic operations.

**Correct Detection Rules:**

#### ➤ Addition Overflow
Overflow happens when adding two numbers with the same sign gives a result with a different sign:

- Positive + Positive → Negative  → **Overflow**
- Negative + Negative → Positive → **Overflow**

---

#### ➤ Subtraction Underflow
Underflow happens when subtracting numbers with different signs gives an unexpected sign result:

- Positive − Negative → Negative → **Underflow**
- Negative − Positive → Positive → **Underflow**

---

**Fix:**  
Updated overflow and underflow detection logic using operand sign bits and result sign comparison to ensure correct flag generation.

---

### 3️⃣ Missing clk and rst in Module Port List
**Issue:**  
Clock (`clk`) and Reset (`rst`) signals were missing from the module port declaration, causing integration and simulation issues.

**Fix:**  
Added `clk` and `rst` signals to the module port list and updated module instantiations accordingly.


