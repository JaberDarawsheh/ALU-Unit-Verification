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
