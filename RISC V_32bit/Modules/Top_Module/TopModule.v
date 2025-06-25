`timescale 1ns/1ps

module TopModule (
    input clk,
    input reset,
    output [31:0] instruction,
    output [31:0] pc,
    output [31:0] alu_result,
    output [31:0] read_data1,
    output [31:0] read_data2,
    output zero, carry, overflow, negative,
    output [31:0] write_data,
    output [31:0] alu_operand2,
    output branch, mem_read, mem_to_reg, mem_write, alu_src, reg_write,
    output [3:0] alu_control,   // Added output for ALU control signal
    output [1:0] alu_op         // Added output for ALU operation code
);

    // Wires for internal connections
    wire [31:0] instruction_mem_data;
    wire [31:0] pc_in, pc_out;
    wire [31:0] alu_operand1, alu_operand2_internal;
    wire [31:0] alu_control_out;
    wire [31:0] read_data1_int, read_data2_int;

    // Program Counter and Instruction Fetch Unit
    InstructionFetch IF(
        .clk(clk),
        .reset(reset),
        .branch_taken(branch & zero),
        .branch_target(alu_result),
        .instruction(instruction),
        .pc(pc)
    );

    // Control Unit
    ControlUnit CU(
        .opcode(instruction[6:0]),
        .branch(branch),
        .mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
        .alu_op(alu_op),  // ALU operation code from Control Unit
        .mem_write(mem_write),
        .alu_src(alu_src),
        .reg_write(reg_write)
    );

    // Register File
    RegisterFile RF(
        .clk(clk),
        .reg_write(reg_write),
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // ALU Decoder
    ALUDecoder ALUD(
        .alu_op(alu_op),             // Input from the Control Unit
        .funct(instruction[14:12]),  // Function bits from instruction
        .ALU_Control(alu_control)    // Output the ALU control signal
    );

    // ALU Operand Multiplexing (for I-type and R-type instructions)
    assign alu_operand2_internal = (alu_src) ? {{20{instruction[31]}}, instruction[31:20]} : read_data2;
    assign alu_operand2 = alu_operand2_internal;  // Connecting alu_operand2 output for observation

    // ALU
    ALU ALU1(
        .A(read_data1),
        .B(alu_operand2_internal),
        .ALU_Control(alu_control),
        .Result(alu_result),
        .Zero(zero),
        .Carry(carry),        // Connecting carry output if applicable
        .Overflow(overflow),  // Connecting overflow output if applicable
        .Negative(negative)   // Connecting negative output if applicable
    );

    // Write-back Data Multiplexing (this can be extended based on your memory model)
    assign write_data = (mem_to_reg) ? alu_result : alu_result; // This is simplified; you may extend with actual memory if needed

endmodule
