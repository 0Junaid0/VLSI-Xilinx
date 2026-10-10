# VLSI-Xilinx

A collection of gate-level VLSI/digital logic designs in VHDL (combinational and sequential), built and simulated in **Xilinx ISE**. Designs are implemented structurally from basic gates (primarily NAND) rather than with behavioral operators, to demonstrate gate-level construction and the universal-gate property of NAND.

## Projects

| Project | Description |
|---|---|
| [`Full_Adder_1bit/`](./Full_Adder_1bit) | 1-bit Full Adder built from NAND-derived AND, OR, NOR, XOR, and Half Adder modules. This folder also holds the gate library reused by other projects. |
| [`Full_Adder_8bit/`](./Full_Adder_8bit) | 8-bit ripple-carry adder: eight 1-bit `Full_Adder` cells → two `Full_Adder_4bit` blocks → one `Full_Adder_8bit`. |
| [`8Bit Register/`](./8Bit%20Register) | 8-bit positive-edge-triggered register: NAND/NOT → SR latch → D latch → Master-Slave D flip-flop → 1-bit register → 8-bit register. |
| [`Accumulator_4bit/`](./Accumulator_4bit) | 4-bit accumulator: a 4-bit ripple-carry adder feeding a 4-bit register, with a 1-bit accumulator slice. |

Each folder has its own README with the module breakdown, ports, and simulation steps.

## Project Dependencies

The projects build on each other. When simulating one, add the files it depends on to the ISE project:

- `Full_Adder_8bit/` and `Accumulator_4bit/` use the `AND_gate`, `OR_gate`, `XOR_gate`, and `NAND_gate` components from `Full_Adder_1bit/`.
- `Accumulator_4bit/` also uses `MS_D_FF`, `D_latch`, `SR_latch`, and `NOT_gate` from `8Bit Register/`.

## Design Approach

- **Structural VHDL** — functions are composed from instantiated gate components, not behavioral operators.
- **NAND as the universal gate** — AND, OR, NOR, XOR, and the latches are all derived from NAND (and NOT).
- **Bottom-up hierarchy** — gates → latches/adders → flip-flops/registers → multi-bit and combined designs.
- **Testbenches** — most modules have a matching `*_tb.vhd` for standalone verification in ISim.

## Tools

- [Xilinx ISE Design Suite](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive-ise.html) (ISE / ISim), or any VHDL-93 simulator (GHDL, ModelSim).

## Author

**Junaid**
B.Sc. in Computer Science & Engineering, University of Asia Pacific (UAP), Dhaka, Bangladesh
GitHub: [@0Junaid0](https://github.com/0Junaid0)
