`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.11.2024 23:29:42
// Design Name: 
// Module Name: RegisterFile
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

module RegisterFile (
    input clk,
    input reg_write,
    input [4:0] rs1, rs2, rd,  // Register addresses
    input [31:0] write_data,   // Data to be written
    output [31:0] read_data1, read_data2 // Read data
);
    reg [31:0] registers [0:31]; // 32 registers, 32-bit wide

    // Initialize register values
    initial begin //Added an initial block to initialize some register values.
                  //Register x0 is explicitly initialized to 0 since it is immutable in RISC-V.
        registers[0] = 32'h00000000; // Register x0 is always 0
        registers[1] = 32'h11111111;
        registers[2] = 32'h22222222;
        registers[3] = 32'h33333333;
        registers[4] = 32'h44444444;
        registers[5] = 32'h55555555;
        registers[6] = 32'h66666666;
        registers[7] = 32'h77777777;
        // Add more initial values as needed
    end

    // Read ports
    assign read_data1 = registers[rs1];
    assign read_data2 = registers[rs2];

    // Write port
    always @(posedge clk) begin
        if (reg_write && rd != 0) // Prevent writing to register x0
            registers[rd] <= write_data;
    end
endmodule
