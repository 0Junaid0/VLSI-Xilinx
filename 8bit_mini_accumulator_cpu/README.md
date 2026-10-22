# 8-bit Mini Accumulator CPU — Xilinx ISE (VHDL)

A small 8-bit accumulator-based CPU written entirely as structural, gate-level VHDL and simulated in Xilinx ISE. It fetches 12-bit instructions from a 16-word program ROM, decodes them in a control unit, and executes them on an 8-bit ALU, one instruction per clock cycle. Every block, including the ROM, control unit, and ALU output mux, is built from NAND/NOT/AND/OR/XOR/NOR gate components, multiplexers, latches, and flip-flops.

## Features

- 8-bit accumulator (`ACC`) and an 8-bit holding register (`R`)
- 12-bit instruction word: 4-bit opcode + 8-bit immediate
- 5 instructions: `LDI`, `ADD`, `AND`, `STA`, `LDR` (plus `NOP`)
- Zero flag (`Z`) updated by `LDI`, `ADD`, `AND`, `LDR`
- 4-bit program counter, 16 x 12-bit program ROM
- Synchronous reset, single-cycle execution (one instruction per rising clock edge)
- Fully structural design:
  - ROM = 4-to-16 decoder + OR-gate tree
  - Control unit = 4-to-16 decoder + OR gates
  - ALU = ripple-carry adder + AND gates + eight 4-to-1 muxes + NOR/AND zero detector
  - Registers = master-slave D flip-flops with enable and reset muxes

## Architecture

```
            +------------+  ADDR   +-------------+  instr[11:0]
  CLK ----> |  PC_4bit   |-------->| Program_ROM |-------------+
  RESET --> | (PC + 1)   |         | 16 x 12-bit |             |
            +------------+         +-------------+     opcode[11:8]   operand[7:0]
                                                            |              |
                                                   +--------v------+       |
                                                   |  Control_Unit |       |
                                                   +--+--+--+--+---+       |
                                          ALU_SEL[2:0]|  |  |  |           |
                                       ACC_EN R_EN Z_EN  |                |
                                                          v                v
                     +-----+  ACC   +----------------------------------------+
                     | ACC |------->|                ALU_8bit                |--> RESULT
                     +--^--+        |  ADD / AND / pass operand / pass R     |--> Z_OUT
                        |           +------------------^---------------------+
                  RESULT|                              |R_VAL
                        |                         +----+----+
                        +                         |    R    |<---- ACC (STA)
                                                  +---------+
```

### Hierarchy

```
CPU_top
 ├── PC_4bit
 │    ├── Reg_4bit  (PC register, always enabled)
 │    ├── Full_Adder_4bit  (PC + 1)
 │    └── MUX_2to1 x4  (PC+1 vs. JUMP_ADDR)
 ├── Program_ROM
 │    ├── Decoder_4to16 → Decoder_2to4 x2 + AND_gate x16
 │    └── OR_gate tree  (one OR network per ROM data bit)
 ├── Control_Unit
 │    ├── Decoder_4to16
 │    └── OR_gate x5
 ├── ALU_8bit
 │    ├── Full_Adder_8bit → Full_Adder_4bit x2 → Full_Adder x8 → Half_Adder x2 + OR_gate
 │    ├── AND_gate x8
 │    ├── MUX_4to1 x8  → MUX_2to1 x3 each  (result select)
 │    └── Zero_Detector  (NOR_gate x4 + AND_gate x3)
 ├── Reg_8bit  (ACC)
 ├── Reg_8bit  (R)
 └── NOT_gate + Reg_1bit  (Z flag)
```

Every register is built the same way: `Reg_8bit` → `Reg_4bit` x2 → `Reg_1bit` x4 → two `MUX_2to1` (enable and reset) + `Master_slave_d_flipflop` → `D_latch` x2 → `SR_latch` → `NAND_gate`.

## Instruction Set

Instruction format: `instr[11:8]` = opcode, `instr[7:0]` = 8-bit immediate (ignored by `STA`, `LDR`, `NOP`).

| Mnemonic | Opcode | Operation | `ALU_SEL` | Flags |
|---|---|---|---|---|
| `NOP` | `0000` | no operation | — | unchanged |
| `LDI imm` | `0001` | `ACC <= imm` | `000` | Z updated |
| `ADD imm` | `0010` | `ACC <= ACC + imm` | `001` | Z updated |
| `AND imm` | `0100` | `ACC <= ACC AND imm` | `010` | Z updated |
| `STA` | `1010` | `R <= ACC` | `000` | Z unchanged |
| `LDR` | `1011` | `ACC <= R` | `011` | Z updated |

Unrecognised opcodes behave as `NOP`.

### Control signals

The control unit decodes the opcode into 16 one-hot lines (`dec(n)` = opcode `n`) and combines them with OR gates:

| Signal | Equation | Meaning |
|---|---|---|
| `ACC_EN`, `Z_EN` | `dec(1) + dec(2) + dec(4) + dec(11)` | `LDI`, `ADD`, `AND`, `LDR` |
| `R_EN` | `dec(10)` | `STA` |
| `ALU_SEL(0)` | `dec(2) + dec(11)` | `ADD` or `LDR` |
| `ALU_SEL(1)` | `dec(4) + dec(11)` | `AND` or `LDR` |
| `ALU_SEL(2)` | `0` | unused |
| `JUMP` | `0` | no branch instruction yet |

| Instruction | `ALU_SEL` | `ACC_EN` | `R_EN` | `Z_EN` |
|---|---|---|---|---|
| `LDI` | `000` | 1 | 0 | 1 |
| `ADD` | `001` | 1 | 0 | 1 |
| `AND` | `010` | 1 | 0 | 1 |
| `STA` | `000` | 0 | 1 | 0 |
| `LDR` | `011` | 1 | 0 | 1 |
| `NOP` | `000` | 0 | 0 | 0 |

## Top-Level Ports (`CPU_top`)

| Port | Direction | Type | Description |
|---|---|---|---|
| `CLK` | in | `std_logic` | Clock (rising edge) |
| `RESET` | in | `std_logic` | Synchronous reset — clears `PC`, `ACC`, `R`, sets `Z = 1` |
| `Q` | out | `std_logic_vector(7 downto 0)` | Accumulator value |
| `Z` | out | `std_logic` | Zero flag |
| `PC_OUT` | out | `std_logic_vector(3 downto 0)` | Current program counter |
| `R_OUT` | out | `std_logic_vector(7 downto 0)` | `R` register value (for observation) |

## Design Notes

- **ROM as logic.** `Program_ROM` has no stored array: the address is decoded to 16 word lines (`w(0)`–`w(15)`) and each of the 12 data bits is an OR of the word lines where that bit is 1 (for example `DATA(8) = w(0) + w(4) + w(8) + w(9)`, `DATA(7) = 0`). Changing the program means re-deriving these OR equations.
- **Zero flag storage.** The `Z` flag register stores `NOT(ALU zero)` and the CPU reads the register's `Qn` output as `Z`. Reset clears the register to 0, so `Qn = 1` and `Z = 1`, which matches `ACC = 0x00` after reset.
- **Program counter.** `PC_4bit` has jump support (a 2:1 mux selects `PC + 1` or `JUMP_ADDR`), but `CPU_top` ties `JUMP` to `'0'`, so the PC only increments. `Control_Unit` has a `JUMP` output (constant `'0'`) and a `Z_FLAG` input that is currently unused — they are the hook for a future `JZ` instruction.
- **Wrap-around.** The PC is 4 bits and ROM addresses 10–15 hold `NOP`, so after the program ends the PC wraps to 0 and the program runs again.
- **Carry out.** The ALU adder's carry-out is not used; arithmetic is modulo 256.

## Test Program

`Program_ROM` holds this program, and `CPU_top_tb.vhd` steps through it (20 ns clock, one cycle per instruction):

| Addr | Instruction | Hex | ACC | R | Z |
|---|---|---|---|---|---|
| 0 | `LDI 0x1E` | `0x11E` | `0x1E` | `0x00` | 0 |
| 1 | `STA` | `0xA00` | `0x1E` | `0x1E` | 0 |
| 2 | `ADD 0x22` | `0x222` | `0x40` | `0x1E` | 0 |
| 3 | `AND 0x60` | `0x460` | `0x40` | `0x1E` | 0 |
| 4 | `LDR` | `0xB00` | `0x1E` | `0x1E` | 0 |
| 5 | `ADD 0x01` | `0x201` | `0x1F` | `0x1E` | 0 |
| 6 | `AND 0x0F` | `0x40F` | `0x0F` | `0x1E` | 0 |
| 7 | `STA` | `0xA00` | `0x0F` | `0x0F` | 0 |
| 8 | `LDI 0x00` | `0x100` | `0x00` | `0x0F` | 1 |
| 9 | `LDR` | `0xB00` | `0x0F` | `0x0F` | 0 |

## Repository Structure

| File | Description |
|---|---|
| `CPU_top.vhd` / `CPU_top_tb.vhd` | Top-level CPU and testbench |
| `PC_4bit.vhd` / `PC_4bit_tb.vhd` | Program counter with increment and jump mux |
| `Program_ROM.vhd` / `Program_ROM_tb.vhd` | 16 x 12-bit instruction ROM (decoder + OR tree) |
| `Control_Unit.vhd` / `Control_Unit_tb.vhd` | Opcode decoder (decoder + OR gates) |
| `ALU_8bit.vhd` / `ALU_8bit_tb.vhd` | ALU (LDI pass, ADD, AND, LDR pass) with zero detect |
| `Zero_Detector.vhd` / `Zero_Detector_tb.vhd` | 8-bit zero detector (NOR/AND tree) |
| `Full_Adder_8bit.vhd`, `Full_Adder_4bit.vhd`, `Full_Adder.vhd`, `Half_adder.vhd` (+ `_tb`) | Ripple-carry adder hierarchy |
| `one_bit_adder.vhd` / `One_bit_adder_tb.vhd` | Standalone 1-bit adder |
| `MUX_4to1.vhd` / `MUX_4to1_tb.vhd` | 4-to-1 mux built from three 2-to-1 muxes (ALU result select) |
| `MUX_2to1_tb.vhd` | Testbench for the 2-to-1 mux (source file: see Repository Notes) |
| `Reg_8bit.vhd`, `Reg_4bit.vhd`, `Reg_1bit.vhd` (+ `_tb`) | Registers with enable and synchronous reset |
| `Master_slave_d_flipflop.vhd` / `_tb.vhd` | Master-slave D flip-flop (two D latches) |
| `D_latch.vhd`, `SR_latch.vhd` (+ `_tb`) | Latch building blocks |
| `Decoder_2ot4.vhd` (entity `Decoder_2to4`), `Decoder_4to16.vhd` (+ `_tb`) | Decoders used by `Program_ROM` and `Control_Unit` |
| `AND_gate`, `OR_gate`, `NAND_gate`, `NOR_gate`, `XOR_gate`, `NOT_gate` `.vhd` (+ `_tb`) | Basic gate components |
| `CPU.xise` | Xilinx ISE project file |

## Repository Notes

`MUX_2to1.vhd` is not in this folder (only `MUX_2to1_tb.vhd` and a synthesis report, `MUX_2to1.syr`). `Reg_1bit`, `PC_4bit`, and `MUX_4to1` instantiate `MUX_2to1`, so the design will not elaborate from a fresh clone until that file is added.

## Getting Started

### Prerequisites

- [Xilinx ISE Design Suite](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive-ise.html) (ISim), or any VHDL-93 simulator (GHDL, ModelSim).

### Simulating in Xilinx ISE

1. Open `CPU.xise` in ISE (or create a project and add all `.vhd` files in this folder, including `MUX_2to1.vhd`).
2. Set `CPU_top_tb.vhd` as the simulation top module.
3. Run **Behavioral Simulation** in ISim. Run for about 15 clock periods (300 ns) and watch `PC_OUT`, `Q`, `R_OUT`, and `Z` against the test-program table above.
4. To check one block in isolation, simulate its own testbench (e.g. `ALU_8bit_tb.vhd`, `Control_Unit_tb.vhd`).

## Author

**Junaid**
B.Sc. in Computer Science & Engineering, University of Asia Pacific (UAP), Dhaka, Bangladesh
GitHub: [@0Junaid0](https://github.com/0Junaid0)
