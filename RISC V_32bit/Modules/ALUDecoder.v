`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2024 23:30:30
// Design Name: 
// Module Name: ALUDecoder
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

module ALUDecoder (
    input [1:0] alu_op,         // Control Unit signal
    input [3:0] funct,          // Function field from instruction
    output reg [3:0] ALU_Control // ALU operation signal
);
    always @(*) begin
        case (alu_op)
            2'b00: ALU_Control = 4'b0000; // ADD (default for load/store)
            2'b01: ALU_Control = 4'b0001; // SUB (for branches)
            2'b10: begin
                case (funct)
                    4'b0000: ALU_Control = 4'b0000; // ADD
                    4'b1000: ALU_Control = 4'b0001; // SUB
                    4'b0001: ALU_Control = 4'b0010; // MUL
                    4'b0010: ALU_Control = 4'b0011; // DIV
                    4'b0110: ALU_Control = 4'b0100; // AND
                    4'b0111: ALU_Control = 4'b0101; // OR
                    4'b1000: ALU_Control = 4'b0110; // XOR
                    4'b1100: ALU_Control = 4'b0111; // COMPLEMENT (NOT)
                    // Add further cases for shifts
                    default: ALU_Control = 4'b0000;
                endcase
            end
            default: ALU_Control = 4'b0000; // Default to ADD
        endcase
    end
endmodule



