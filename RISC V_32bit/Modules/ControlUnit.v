`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2024 23:28:56
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit (
    input [6:0] opcode,      // 7-bit opcode from instruction
    output reg branch, mem_read, mem_to_reg,
    output reg [1:0] alu_op, // Determines ALU operation type
    output reg mem_write, alu_src, reg_write
);
    always @(*) begin
        // Default values
        branch = 0; mem_read = 0; mem_to_reg = 0;
        mem_write = 0; alu_src = 0; reg_write = 0;
        alu_op = 2'b00;

        // Decode opcode (simplified example)
        case(opcode)
            7'b0110011: begin // R-type (ADD, SUB, MUL, etc.)
                alu_op = 2'b10;
                alu_src = 0;
                reg_write = 1;
            end
            7'b0000011: begin // Load (I-type)
                alu_op = 2'b00;
                alu_src = 1;
                reg_write = 1;
                mem_read = 1;
                mem_to_reg = 1;
            end
            7'b0100011: begin // Store (S-type)
                alu_op = 2'b00;
                alu_src = 1;
                mem_write = 1;
            end
            7'b1100011: begin // Branch (B-type)
                alu_op = 2'b01;
                branch = 1;
            end
            // Other cases can be added here...
            default: ; // No operation
        endcase
    end
endmodule

