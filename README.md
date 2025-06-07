# 🧮 8x8 Synchronous FIFO in Verilog

This project implements an **8-depth, 8-bit wide Synchronous FIFO (First-In First-Out)** memory buffer in **Verilog HDL**. FIFO is a fundamental memory structure used widely in digital systems to handle temporary data storage, clock domain crossing, and data rate mismatch between two subsystems.

> 🔧 Designed and simulated on **EDA Playground**  
> 📦 Includes Verilog RTL, testbench, and waveform illustrations  
> 📋 Covers overrun/underrun, flag handling, and internal memory inspection

---

## 📐 FIFO Overview

- **Depth (Slots)**: 8  
- **Data Width**: 8 bits  
- **Type**: Synchronous (Single Clock Domain)

FIFO is used for:
- ✅ Clock Domain Crossing (CDC)
- ✅ Handling Data Rate Mismatch
- ✅ Temporary Data Buffering

---

### 🧾 Interface

| Signal        | Direction | Description                             |
|---------------|-----------|-----------------------------------------|
| `clk`         | Input     | Clock signal                            |
| `rst`         | Input     | Active low synchronous reset            |
| `wen`         | Input     | Write enable                            |
| `ren`         | Input     | Read enable                             |
| `w_data`      | Input     | 8-bit write data                        |
| `r_data`      | Output    | 8-bit read data                         |
| `full`        | Output    | FIFO is full (write not allowed)        |
| `empty`       | Output    | FIFO is empty (read not allowed)        |
| `almost_full` | Output    | FIFO nearing full (count ≥ 6)           |
| `almost_empty`| Output    | FIFO nearing empty (count ≤ 2)          |
| `wp`          | Output    | Write pointer                           |
| `rp`          | Output    | Read pointer                            |

---

## 🔁 FIFO Control Logic

```text
When wen = 1 AND full = 0  => Write data into FIFO and increment write pointer (wp)
When ren = 1 AND empty = 0 => Read data from FIFO and increment read pointer (rp)

Condition for almost_full  => count >= 6
Condition for almost_empty => count <= 2
Condition for full         => count == 8 (FIFO depth)
Condition for empty        => count == 0
```
- almost_full: Used to prevent overrun
- almost_empty: Used to prevent underrun

Also includes explicit overrun and underrun condition reporting

## 🧪 Testbench Simulation Flow
The testbench performs the following sequence of operations:

- ✅ Write Phase: Random 8-bit data written into FIFO (until full)
- 🔍 Internal Inspection: View FIFO memory before any reads (Producer view)
- ✅ Read Phase: Data read one-by-one (until empty)
- 🔍 Post-Read Inspection: View FIFO after complete read (Consumer view)

## 🧪 Functional Test Scenarios Covered
- ✔️ Normal operation (write → read)
- ✔️ Full and Empty flag behavior
- ✔️ Almost Full and Almost Empty thresholds
- ✔️ Reset FIFO mid-operation
- ✔️ Overrun and Underrun flag conditions
- ✔️ Pointer roll-over at max depth
- ✔️ Read without write & vice versa (error protection)

## 📊 Simulation Waveform
🔎 Waveform shows write and read operations, pointer increment, and full/empty flag transitions.


## 🌐 Run It Online (EDA Playground)
Simulate the FIFO live in your browser using the following link:
🔗 EDA Playground: (https://www.edaplayground.com/x/8bZb)

## ⚙️ Tools & Technologies
- Language: Verilog HDL (IEEE 1364-2001)
- Simulator: Synopsys VCS / Aldec Riviera (via EDA Playground)
- Platform: Web-based (No installation required)