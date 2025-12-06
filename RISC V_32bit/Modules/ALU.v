`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2024 23:26:06
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU (
    input [31:0] A, B,       // Operands
    input [3:0] ALU_Control, // Control signal
    output reg [31:0] Result,
    output Zero, Carry, Overflow, Negative
);
    reg [32:0] temp_result; // For carry and overflow handling

    always @(*) begin
        case (ALU_Control)
            4'b0000: temp_result = A + B;        // ADD
            4'b0001: temp_result = A - B;        // SUB
            4'b0010: temp_result = A * B;             // MUL
            4'b0011: temp_result = (B != 0) ? A / B : 32'hDEAD_BEEF; // DIV, handle div by zero
            4'b0100: temp_result = A & B;             // AND
            4'b0101: temp_result = A | B;             // OR
            4'b0110: temp_result = A ^ B;             // XOR
            4'b0111: temp_result = ~A;                // COMPLEMENT (NOT)
            4'b1000: temp_result = A << B[4:0];       // Logical Shift Left
            4'b1001: temp_result = A >> B[4:0];       // Logical Shift Right
            4'b1010: temp_result = $signed(A) >>> B[4:0]; // Arithmetic Shift Right
            default: temp_result = 32'b0;
        endcase
        Result = temp_result[31:0];
    end

    // Status flags
    assign Zero = (Result == 0);
    assign Negative = Result[31];
    assign Carry = temp_result[32];
    assign Overflow = ((A[31] == B[31]) && (Result[31] != A[31]));
endmodule


