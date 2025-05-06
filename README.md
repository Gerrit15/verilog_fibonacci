# Verilog Fibonacci
This is a basic project I'm using to get comfortable with verilog,
through implementing fibonacci.

## Usage
Use the makefile to compile and run with icarusVerilog, the N register is the number of
iterations you go with. For example, the makefile currently has 0b0110, meaning we're calculating
the 6th digit of the sequence

## Implementation
This is a fairly simple implementation, and functions around having two memory cells, and a single bit flag to represent
which of the registers is acting as the "current," like frame buffers in graphics programming. There is a summing module, and it simply outputs the sum of the
two values into the appropriate memory cell (using the flag, which toggles each cycle).

### Example
| Mem1 | Mem2 | Flag | Mem1+ | Mem2+ | Flag+ |
|------|------|------|-------|-------|-------|
| 0    | 1    | 0    | 1     | 1     | 1     |
| 1    | 1    | 1    | 1     | 2     | 0     |
| 1    | 2    | 0    | 3     | 2     | 1     |
| 3    | 2    | 1    | 3     | 5     | 0     |
| 3    | 5    | 0    | 8     | 5     | 1     |

Note: for an unkown reason, odd iterations (eg "give me the Nth digit") operate as even iterations. Not worth fixing.
