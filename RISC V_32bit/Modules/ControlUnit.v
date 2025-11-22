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
    output reg branch,
    output reg [1:0] alu_op, // Determines ALU operation type
    output reg reg_write
);
    always @(*) begin
        // Default values
        branch = 0; 
       reg_write = 0;
        alu_op = 2'b00;

        // Decode opcode (simplified example)
        case(opcode)
            7'b0110011: begin // R-type (ADD, SUB, MUL, etc.)
                alu_op = 2'b10;
               
                reg_write = 1;
            end
            7'b0000011: begin // Load (I-type)
                alu_op = 2'b00;
               
                reg_write = 1;
                
            end
            7'b0100011: begin // Store (S-type)
                alu_op = 2'b00;
               
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

