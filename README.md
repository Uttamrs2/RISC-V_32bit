# RISC-V_32bit
# RISC-V 32-bit Processor (RV32I) - README

## 📌 Overview
This project implements a basic 32-bit RISC-V processor (RV32I ISA), supporting core instructions and pipeline stages. The processor is designed using Verilog/SystemVerilog and targets FPGA or simulation platforms.

> ISA Supported: **RV32I (Integer Base Instruction Set)**  

---

## 🛠️ Features

- ✅ 32-bit data path (RV32)
- ✅ Support for base RV32I instructions:
  - Arithmetic: `ADD`, `SUB`, `AND`, `OR`, `XOR`, `SLL`, `SRL`, `SRA`
  - Immediate: `ADDI`, `ORI`, `ANDI`, etc.
  - Load/Store: `LW`, `SW`, `LH`, `SH`, `LB`, `SB`
- ✅ Register File with 32 registers (x0-x31)
- ✅ Simple control unit based on opcode decoding
- ✅ Program Counter (PC) logic with branch/jump handling
- ✅ Simulation Testbench for functional validation

---

## 📁 Project Structure

```plaintext
RISC_V_32bit/
│
├── src/
│   ├── alu.v                  # Arithmetic Logic Unit
│   ├── control_unit.v         # Control signals generator
│   ├── datapath.v             # Top-level integration of pipeline
│   ├── imm_gen.v              # Immediate extractor
│   ├── pc.v                   # Program Counter logic
│   ├── register_file.v        # 32 general-purpose registers
│   ├── memory.v               # Instruction + Data Memory
│   └── top.v                  # Top-level module
│
├── tb/
│   └── tb_top.v               # Testbench for simulation
│
├── prog/
│   └── test_program.hex       # Sample RISC-V instructions in hex
│
├── docs/
│   └── architecture_diagram.png
│   └── instruction_formats.md
│
├── README.md
└── Makefile / run_sim.sh      # Scripts for compilation & simulation
