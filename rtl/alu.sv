module alu (
    input logic signed [31:0] A,  // operand 1
    input logic [31:0] B,  // operand 2
    input logic [2:0] opcode,     // opcode
    input logic clk,
    input logic rst,
    output logic [31:0] Result,   // result
    output logic Error            // error flag for overflow
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            Result <= 32'b0;
            Error <= 1'b0;
        end
        else begin
          case (opcode)
                3'b000: begin
                    // Addition operation
                    Result = A + B;

                    // Detect overflow in signed addition
                if ((A < 0 && B > 0 && Result > A) || (A > 0 && B < 0 && Result < A)) 
                    Error = 1;
                end

                3'b001: begin
                    // Subtraction operation (A - B)
                    Result = A - B;

                    // Detect overflow in signed subtraction
                if ((A < 0 && B > 0 && Result > A) || (A > 0 && B < 0 && Result < A)) 
                    Error = 1;
                end

                3'b010: begin
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

                default: begin
                    Result = 32'b0;  // Default to 0 for unsupported opcodes
                    Error = 1'b1;         // Set error flag for invalid opcode
                end
            endcase

        end
    end
endmodule