`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2024 23:32:02
// Design Name: 
// Module Name: InstructionFetch
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


module InstructionFetch (
    input clk,
    input reset,
    input branch_taken,
    input [31:0] branch_target,
    output [31:0] instruction,
    output reg [31:0] pc
);
    reg [31:0] memory [0:255]; // Small instruction memory
    // adding some instructions (machine code of instructions)
    initial begin
        memory[0] = 32'b00000000000100000000000010110011; // ADD x1, x0, x1 (R-type)
        memory[1] = 32'b00000000001000000010000100010011; // ADDI x2, x0, 2 (I-type)
        memory[2] = 32'b00000000001100001000001010110011; // ADD x5, x1, x3 (R-type)
        memory[3] = 32'b00000000001000000000000001100011; // BEQ x2, x0, 4 (B-type)
        memory[4] = 32'b00000000000100000010000000100011; // SW x1, 0(x0) (S-type)
        // Add more instructions as needed
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 0;
        else if (branch_taken)
            pc <= branch_target;
        else
            pc <= pc + 4;
    end

    assign instruction = memory[pc >> 2]; // quivalent to divide by 4 to bring at correct index
                                          // bcz here pc increase by 4 to fetch new instruction
endmodule

