# 8-bit Register — Xilinx ISE (VHDL)

A structural, gate-level 8-bit positive-edge-triggered register built in VHDL, designed and simulated in Xilinx ISE. The design is built entirely bottom-up from NAND/NOT gates: **NAND/NOT → SR latch → D latch → Master-Slave D Flip-Flop → 1-bit Register → 8-bit Register**.

## Design Hierarchy

```
Reg_8bit
 └── Reg_1bit  x8   (one per bit, D(7:0) → Q(7:0), shared CLK)
      └── MS_D_FF                     (Master-Slave D Flip-Flop)
           ├── D_latch  (Master, transparent when CLK = 0)
           │    └── SR_latch + NAND_gate x2 + NOT_gate
           └── D_latch  (Slave, transparent when CLK = 1)
                └── SR_latch + NAND_gate x2 + NOT_gate
```

Each 1-bit slice of the register is an independent `Reg_1bit`, and all eight slices share the same `CLK` line, so `Reg_8bit` loads all 8 bits of `D` simultaneously on the same clock edge.

## Repository Structure

| File | Description |
|---|---|
| `Nand_Gate.vhd` / `Nand_gate_tb.vhd` | Base NAND gate primitive and testbench |
| `Not_gate.vhd` / `not_gate_tb.vhd` | Base NOT gate primitive and testbench |
| `SR_latch.vhd` / `SR_latch_tb.vhd` | Cross-coupled NAND SR latch (active-low `S_n`/`R_n`) and testbench |
| `D_latch.vhd` / `D_latch_tb.vhd` | Gated D latch (level-sensitive), built from an `SR_latch` plus NAND/NOT gating logic, and testbench |
| `MS_D_FF.vhd` / `MS_D_FF_tb.vhd` | Master-Slave D Flip-Flop, built from two `D_latch` stages, and testbench |
| `Reg_1bit.vhd` / `Reg_1bit_tb.vhd` | 1-bit register — wraps a single `MS_D_FF` (its `Qn` output left unused) and testbench |
| `Reg_8bit.vhd` / `Reg_8bit_tb.vhd` | Top-level 8-bit register — eight `Reg_1bit` instances sharing one `CLK`, and testbench |

## Port Interface

**`Reg_8bit`**

| Port | Direction | Type | Description |
|---|---|---|---|
| `D` | in | `std_logic_vector(7 downto 0)` | 8-bit data input |
| `CLK` | in | `std_logic` | Common clock for all 8 bits |
| `Q` | out | `std_logic_vector(7 downto 0)` | 8-bit registered output |

## How It Works

1. **`NAND_gate` / `NOT_gate`** — the only two logic primitives used; every other module is built from these.
2. **`SR_latch`** — two cross-coupled NAND gates, with active-low `S_n`/`R_n` inputs, forming the basic 1-bit memory cell.
3. **`D_latch`** — gates a `D` input through NAND logic into `S_n`/`R_n` for the internal `SR_latch`, controlled by an enable `EN`. It is **transparent** (Q follows D) while `EN = '1'`, and **holds** its last value while `EN = '0'`.
4. **`MS_D_FF`** — two `D_latch` stages (Master, Slave) with the Master's enable tied to `CLK_n` (inverted clock) and the Slave's enable tied to `CLK`. While `CLK = 0` the Master is transparent and follows `D`; while `CLK = 1` the Master is frozen and the Slave becomes transparent, passing the captured value to `Q`. The net effect is a **positive-edge-triggered** D flip-flop: `Q` updates to the value of `D` sampled just before the rising edge of `CLK`.
5. **`Reg_1bit`** — a thin wrapper around one `MS_D_FF`, exposing only `D`, `CLK`, and `Q` (the flip-flop's `Qn` is left unconnected).
6. **`Reg_8bit`** — eight `Reg_1bit` instances (`R0`–`R7`) driven by the same `CLK`, giving an 8-bit register that loads `D(7:0)` into `Q(7:0)` on every rising edge of `CLK`.

## Getting Started

### Prerequisites

- [Xilinx ISE Design Suite](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive-ise.html) (ISE / ISim), or any VHDL-93 compatible simulator (GHDL, ModelSim, etc.).

### Simulating in Xilinx ISE

1. Create a new ISE project and add all `.vhd` source files in this folder.
2. Add the matching testbenches as needed (`SR_latch_tb.vhd`, `D_latch_tb.vhd`, `MS_D_FF_tb.vhd`, `Reg_1bit_tb.vhd`, `Reg_8bit_tb.vhd`).
3. Set `Reg_8bit_tb.vhd` as the top module to test the full 8-bit register end-to-end, or use a lower-level testbench to verify an individual stage.
4. Run **Behavioral Simulation** in ISim and drive `D` and `CLK`; confirm `Q` updates to match `D` only on the rising edge of `CLK` and holds its value otherwise.

## Author
GitHub: [@0Junaid0](https://github.com/0Junaid0)
