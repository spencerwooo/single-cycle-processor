<img src="https://avatars2.githubusercontent.com/u/54571645?s=200&v=4" align="right" width="120px">

# 🎲 Single Cycle CPU

> 辛苦三星期，造台计算机！

BIT Personal project: a simple single cycle CPU. Initial steps of designing [the ZanPU](https://github.com/zan-pu).

## Source Code

All source codes are available at [single-cycle-cpu.srcs](./single-cycle-cpu.srcs).

- [Design Sources](./single-cycle-cpu.srcs/sources_1/new)
- [Simulation Sources](./single-cycle-cpu.srcs/sim_1/new)

Instruction, data memory and register files are initialized at [tests](./tests).

## Modules / Data Path

![](https://i.loli.net/2019/09/02/LIoGAp8nbwtxV1e.png)

Detailed documentation at: [🚡 Build Your PC - 个人项目 - 单周期 CPU](https://zanpu.spencerwoo.com/2_SingleCycle/2-1_Basic.html).

## Tests

Complete simulated tests for the following instructions.

### LUI

Test instructions:

```MIPS
lui $1, 1
lui $2, 2
```

```
<!-- instructions.txt -->
0x3c010001
0x3c020002
```

Expected:

```
<!-- GPR Register -->
gpr[2] 00020000
gpr[1] 00010000
gpr[0] 00000000
```

Results:

![](https://i.loli.net/2019/09/03/RTEY9ouF6a5phbL.png)

### ADDIU

Test instructions:

```MIPS
lui $1, 1
addiu $2, $1, 1024
```

```
<!-- instructions.txt -->
0x3c010001
0x24220400
```

Expected:

```
<!-- GPR Register -->
gpr[2] 00010400
gpr[1] 00010000
gpr[0] 00000000
```

Results:

![](https://i.loli.net/2019/09/03/MV3CbNYeUZQG2s6.png)

### ADD、SUBU

Test instructions:

```MIPS
lui $1, 1
lui $2, 2
add $3, $1, $2
subu $4, $2, $1
```

```
<!-- instructions.txt -->
0x3c010001
0x3c020002
0x00221820
0x00412023
```

Expected:

```
<!-- GPR Register -->
gpr[4] 00010000
gpr[3] 00030000
gpr[2] 00020000
gpr[1] 00010000
gpr[0] 00000000
```

Results:

![](https://i.loli.net/2019/09/03/OTlEVMueKIQ2qHS.png)

### LW

Test instructions:

```MIPS
lw $1, 0
lw $2, 4
```

```
<!-- instructions.txt -->
0x8c010000
0x8c020004
```

Initialize data memory with:

```
<!-- data_memory.txt -->
0x00000001
0x0000000f
```

Expected:

```
<!-- GPR Register -->
gpr[2] 0000000f
gpr[1] 00000001
gpr[0] 00000000
```

Results:

![](https://i.loli.net/2019/09/03/9SnktRysB4ahzqf.png)

### SW

Test instructions:

```MIPS
addiu $1, $0, 0x0009
sw $1, 8
```

```
<!-- instructions.txt -->
0x24010009
0xac010008
```

Expected:

```
<!-- Data Memory -->
dm[2] 00000009
dm[1] 0000000f
dm[0] 00000001
```

Results:

![](https://i.loli.net/2019/09/03/5jTZFCvB7nL96yU.png)

### BEQ

Test instructions:

```MIPS
addiu $11, $0, 0x0009
addiu $10, $0, 0x0009
beq $11, $10, target
lui $1, 1
lui $2, 2
target: lui $3, 3
lui $4, 4
```

```
<!-- instructions.txt -->
0x240b0009
0x240a0009
0x116a0002
0x3c010001
0x3c020002
0x3c030003
0x3c040004
```

Expected:

```
<!-- GPR Register -->
gpr[11] 00000009
gpr[10] 00000009
...
gpr[4]  00040000
gpr[3]  00030000
gpr[2]  00000000
gpr[1]  00000000
gpr[0]  00000000
```

Results:

![](https://i.loli.net/2019/09/03/bOJE4MeX2gNrqtU.png)

### J

Test instructions:

```MIPS
j target
lui $1, 1
lui $2, 2
target: lui $3, 3
lui $4, 4
```

```
<!-- instructions.txt -->
0x08100003
0x3c010001
0x3c020002
0x3c030003
0x3c040004
```

Expected:

```
<!-- GPR Register -->
gpr[4]  00040000
gpr[3]  00030000
gpr[2]  00000000
gpr[1]  00000000
gpr[0]  00000000
```

Results:

![](https://i.loli.net/2019/09/03/PfXU75sK1tHhkcR.png)

---

🎲 **Single Cycle CPU** ©Spencer Woo. Released under the [MIT License](./LICENSE).

Authored and maintained by Spencer Woo.

[@Portfolio](https://spencerwoo.com) · [@GitHub](https://github.com/spencerwooo) · [@BIT](http://www.bit.edu.cn/)
