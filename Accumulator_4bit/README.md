# 4-bit Accumulator — Xilinx ISE (VHDL)

A structural, gate-level 4-bit accumulator built in VHDL and simulated in Xilinx ISE. A 4-bit ripple-carry adder feeds a 4-bit register: on each rising clock edge the adder's sum is stored in the register and appears on `Q`.

## Design Hierarchy

```
Accumulator_4bit
 ├── Full_Adder_4bit            (ripple-carry adder, Cin tied to '0')
 │    └── Full_Adder  x4        (XOR / AND / OR gate components)
 └── Reg_4bit                   (4-bit register, shared CLK / RESET)
      └── Reg_1bit  x4
           └── MS_D_FF          (Master-Slave D flip-flop)
```

A 1-bit version is also included: `Accumulator_1bit` = one `Full_Adder` + one `Reg_1bit`, with the carry-in and carry-out exposed.

## Repository Structure

| File | Description |
|---|---|
| `Accumulator_4bit.vhd` / `Accumulator_4bit_tb.vhd` | Top-level 4-bit accumulator and testbench |
| `Accumulator_1bit.vhd` | 1-bit accumulator slice (1-bit adder + 1-bit register) |
| `Full_Adder_4bit.vhd` / `Full_Adder_4bit_tb.vhd` | 4-bit ripple-carry adder and testbench |
| `full_adder_gate.vhd` / `full_adder_gate_tb.vhd` | 1-bit Full Adder built from XOR/AND/OR gate components, and testbench |
| `Reg_4bit.vhd` | 4-bit register — four `Reg_1bit` instances on a common clock |
| `Reg_1bit.vhd` / `Reg_1bit_tb.vhd` | 1-bit register wrapping an `MS_D_FF`, and testbench |

## Dependencies

These components are instantiated but defined in other folders of this repository. Add them to the ISE project before simulating:

- `MS_D_FF`, `D_latch`, `SR_latch`, `NAND_gate`, `NOT_gate` — from [`8Bit Register/`](../8Bit%20Register)
- `AND_gate`, `OR_gate`, `XOR_gate`, `NAND_gate` — from [`Full_Adder_1bit/`](../Full_Adder_1bit)

## Port Interface

**`Accumulator_4bit`**

| Port | Direction | Type | Description |
|---|---|---|---|
| `A` | in | `std_logic_vector(3 downto 0)` | First 4-bit operand |
| `B` | in | `std_logic_vector(3 downto 0)` | Second 4-bit operand |
| `CLK` | in | `std_logic` | Clock — register updates on the rising edge |
| `RESET` | in | `std_logic` | Reset input, routed to the register stage |
| `Q` | out | `std_logic_vector(3 downto 0)` | Registered sum, `(A + B)` mod 16 |

## How It Works

1. `Full_Adder_4bit` computes `A + B` (carry-in fixed to `'0'`) as a chain of four 1-bit `Full_Adder` cells.
2. The 4-bit sum goes to the `D` inputs of `Reg_4bit`.
3. On the rising edge of `CLK`, the register captures the sum and drives it onto `Q`. The final carry-out is left unconnected.

## Testbench

`Accumulator_4bit_tb.vhd` uses a 20 ns clock and applies a reset step followed by these operand pairs, one per clock period:

| Step | A | B | Expected Q after next rising edge |
|---|---|---|---|
| 1 | `0011` | `0101` | `1000` |
| 2 | `0010` | `0001` | `0011` |
| 3 | `1111` | `0001` | `0000` (overflow, carry dropped) |
| 4 | `1010` | `0101` | `1111` |

## Getting Started

### Prerequisites

- [Xilinx ISE Design Suite](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive-ise.html) (ISim), or any VHDL-93 simulator (GHDL, ModelSim).

### Simulating in Xilinx ISE

1. Create a new ISE project and add the files in this folder plus the dependencies listed above.
2. Set `Accumulator_4bit_tb.vhd` as the top module (or `Full_Adder_4bit_tb.vhd` to test the adder alone).
3. Run **Behavioral Simulation** in ISim and check `Q` against the table above.

## Author

**Junaid**
B.Sc. in Computer Science & Engineering, University of Asia Pacific (UAP), Dhaka, Bangladesh
GitHub: [@0Junaid0](https://github.com/0Junaid0)
