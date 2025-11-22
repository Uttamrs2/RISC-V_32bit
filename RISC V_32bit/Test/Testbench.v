`timescale 1ns/1ps

module TopModule_tb();

    // Inputs to TopModule
    reg clk;
    reg reset;

    // Wires to observe outputs from the TopModule
    wire [31:0] instruction;
    wire [31:0] pc;
    wire [31:0] alu_result;
    wire [31:0] read_data1;
    wire [31:0] read_data2;
    wire zero, carry, overflow, negative;
    wire [31:0] write_data;
    wire [31:0] alu_operand2;
    wire branch,reg_write;
    wire [3:0] alu_control;
    wire [1:0] alu_op;

    // Instantiate the Top Module (Unit Under Test)
    TopModule uut (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .pc(pc),
        .alu_result(alu_result),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .zero(zero),
        .carry(carry),
        .overflow(overflow),
        .negative(negative),
        .write_data(write_data),
        .alu_operand2(alu_operand2),
        .branch(branch),
        .reg_write(reg_write),
        .alu_control(alu_control),
        .alu_op(alu_op)
    );

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period (100MHz)
    end

    // Testbench Initialization
    initial begin
        // Apply reset
        reset = 1;
        #15;  // Reset for 15ns
        reset = 0;

        // Wait to observe execution
        #200;  // Wait for the processor to run through some instructions

        // End simulation
        $stop;
    end

    // Monitor the outputs to observe the results of each instruction execution
    initial begin
        $monitor("Time = %0t | PC = %h | Instruction = %h | ALU Result = %h | Read Data1 = %h | Read Data2 = %h | Zero = %b | Carry = %b | Overflow = %b | Negative = %b | ALU Control = %b | ALU Op = %b",
                 $time, pc, instruction, alu_result, read_data1, read_data2, zero, carry, overflow, negative, alu_control, alu_op);
    end

endmodule
