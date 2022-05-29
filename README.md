![image](https://user-images.githubusercontent.com/66086031/170859580-f1ab7aa9-5c02-4a6b-ac74-4322c3972bb1.png)

# Table of Contents

- [Table of Contents](#table-of-contents)
  - [Day 1 - Introduction to RISC - V ISA and GNU compiler toolchain](#day-1---introduction-to-risc---v-isa-and-gnu-compiler-toolchain)
    - [RISC - V ISA](#risc---v-isa)
      - [Intro to ISA](#intro-to-isa)
      - [Types of instruction](#types-of-instruction)
    - [Lab for software toolchain](#lab-for-software-toolchain)
      - [C Program to compute Sum from 1 to N](#c-program-to-compute-sum-from-1-to-n)
        - [C code](#c-code)
        - [Command to execute](#command-to-execute)
      - [gcc compiler and dissassemble](#gcc-compiler-and-dissassemble)
        - [Normal speed](#normal-speed)
        - [Fast](#fast)
      - [Spike simulation and debug](#spike-simulation-and-debug)
        - [Debugging](#debugging)
    - [Number systems](#number-systems)
      - [64-bit Number system](#64-bit-number-system)
      - [2's Complement representation](#2s-complement-representation)
      - [Lab for signed and unsigned magnitude](#lab-for-signed-and-unsigned-magnitude)
  - [Day 2 - Application Binary Interface and Verification flow](#day-2---application-binary-interface-and-verification-flow)
    - [Application Binary Interface (ABI)](#application-binary-interface-abi)
      - [Intro to ABI](#intro-to-abi)
      - [Memory Allocation for double words](#memory-allocation-for-double-words)
      - [Load, Add and Store instructions](#load-add-and-store-instructions)
      - [RV64I registers and their ABI Names](#rv64i-registers-and-their-abi-names)
    - [Labs using ABI function call](#labs-using-abi-function-call)
      - [Sum of N numbers Flowchart](#sum-of-n-numbers-flowchart)
      - [Assembly Function Call](#assembly-function-call)
        - [Assembly code for the sum of N](#assembly-code-for-the-sum-of-n)
        - [C program to call the assembly code](#c-program-to-call-the-assembly-code)
        - [Compiling through a RISC-V core](#compiling-through-a-risc-v-core)
    - [Passing the C program as a HEX file](#passing-the-c-program-as-a-hex-file)
  - [Day 3 - Digital Logic with TL-Verilog and Makerchip](#day-3---digital-logic-with-tl-verilog-and-makerchip)
    - [Combinational Logic](#combinational-logic)
      - [Labs using Makerchip](#labs-using-makerchip)
        - [Pipelined Pythagorean Example](#pipelined-pythagorean-example)
        - [Basic Logic Gates Example](#basic-logic-gates-example)
        - [Vectors](#vectors)
        - [Mux_2x1](#mux_2x1)
        - [Combinational Calculator](#combinational-calculator)
    - [Sequential Logic](#sequential-logic)
      - [Finite State Machine](#finite-state-machine)
      - [Fibonacci Series implmenetation](#fibonacci-series-implmenetation)
      - [Up-counter implementation](#up-counter-implementation)
      - [Sequential Calculator](#sequential-calculator)
    - [Pipelined Logic](#pipelined-logic)
      - [Intro to Pipelining and Re - timing](#intro-to-pipelining-and-re---timing)
        - [Re-timing](#re-timing)
      - [Benefits of pipelining](#benefits-of-pipelining)
      - [Pipelined fibo series implementation](#pipelined-fibo-series-implementation)
      - [Error Conditions within Computation Pipeline](#error-conditions-within-computation-pipeline)
      - [2-Cycle Calculator](#2-cycle-calculator)
    - [Validity](#validity)
      - [Intro to validity](#intro-to-validity)
        - [Clock Gating](#clock-gating)
      - [Lab on validity and computing total distance](#lab-on-validity-and-computing-total-distance)
      - [2-cycle Calculator with Validity](#2-cycle-calculator-with-validity)
      - [Calculator single-value Memory](#calculator-single-value-memory)
  - [Day 4 - Micro-architecture of a Single Cycle RISC - V Core](#day-4---micro-architecture-of-a-single-cycle-risc---v-core)
    - [Intro to Microarchitecture](#intro-to-microarchitecture)
      - [Micro-architecture](#micro-architecture)
      - [Basic Instruction-Execution Cycle](#basic-instruction-execution-cycle)
    - [Fetch and Decode](#fetch-and-decode)
      - [Program Counter Implementation](#program-counter-implementation)
      - [Fetch Stage Implementation](#fetch-stage-implementation)
      - [Decoding instruction type](#decoding-instruction-type)
      - [Immediate Decode](#immediate-decode)
      - [Instruction Decode](#instruction-decode)
      - [Validity in Instruction decode](#validity-in-instruction-decode)
      - [Determining individual instruction](#determining-individual-instruction)
    - [Control Logic](#control-logic)
      - [Register File Read](#register-file-read)
      - [ALU Decoder](#alu-decoder)
      - [Register File Write](#register-file-write)
      - [Branch Decisions](#branch-decisions)
      - [Branch to Target](#branch-to-target)
    - [Verification](#verification)
  - [Day 5 - Pipelined RISC-V Core](#day-5---pipelined-risc-v-core)
    - [Intro to Pipelining](#intro-to-pipelining)
    - [Pipelining the CPU](#pipelining-the-cpu)
      - [3 - Cycle Valid Signal](#3---cycle-valid-signal)
      - [Invalid Instructions](#invalid-instructions)
      - [Re-Timing](#re-timing-1)
    - [Solving Hazards](#solving-hazards)
      - [RAW Hazard](#raw-hazard)
      - [Branch Hazards](#branch-hazards)
      - [Remaining Instruction Decode](#remaining-instruction-decode)
      - [Complete ALU](#complete-alu)
    - [Loads/Stores](#loadsstores)
      - [Implementing loads and Redirecting](#implementing-loads-and-redirecting)
      - [Valid Loads](#valid-loads)
      - [Instantiate Data Memory](#instantiate-data-memory)
      - [Testing Loads/Stores](#testing-loadsstores)
      - [Jumps](#jumps)
      - [Final Work](#final-work)
  - [Acknowledgements](#acknowledgements)

## Day 1 - Introduction to RISC - V ISA and GNU compiler toolchain

### RISC - V ISA

#### Intro to ISA

- ISA describes the operations supported by a particular specification.
- RISC - V is an open-source ISA Standard.
- So, anyone can develop their own processor free from licensing fees.

#### Types of instruction

- Pseudo Instructions - Move instructions
- RV64I - Integer
- RV64M _ Multiply
- RV64F, RV64D - Floating Point, Double Floating Point
- RV64-IMFD - All of the above

Application Binary Interface - System calls through which the programmers can access the registers of the RISC - V Core.

### Lab for software toolchain

#### C Program to compute Sum from 1 to N

##### C code

```c
#include <stdio.h>

int main () {
  int i = 0, sum = 0;
  int n = 10;
  for (i = 1; i < n; ++i) {
    sum += i;
  }
  
  printf("\nSum of numbers from 1 to %d = %d\n", n, sum);
  return 0;
}
```

##### Command to execute

```console
gcc sumofn.c -o sumofn
./sumofn
```

![image](https://user-images.githubusercontent.com/66086031/170158604-aeac5978-1288-4dac-95b8-744ca5fae4ab.png)

#### gcc compiler and dissassemble

- Now we run the compiled code in a test RISC - V Core

##### Normal speed

```console
riscv64-unknown-elf-gcc -O1 -mabi=lp64 -march=rv64i -o sumofn.o sumofn.c
riscv64-unknown-elf-objdump -d sumofn.o | less
```

![image](https://user-images.githubusercontent.com/66086031/170160320-7aec7d5a-0efd-4d18-982e-e245aebb10a2.png)

![image](https://user-images.githubusercontent.com/66086031/170161243-eb52b474-a49d-43e7-abc4-b37fab131010.png)

Number of instructions = $(101ac-10184)/4 + 1 = 11$ instructions

##### Fast

```console
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o sumofn.o sumofn.c
riscv64-unknown-elf-objdump -d sumofn.o | less
```

![image](https://user-images.githubusercontent.com/66086031/170161041-84c37cfa-7382-4fcf-a5bb-25a3fb448e7f.png)

#### Spike simulation and debug

![image](https://user-images.githubusercontent.com/66086031/170253889-8bdbdee9-0158-43e8-b87d-c421bea14e16.png)

This command is used for displaying the program after it gets executed by the RISC - V core.

```console
spike pk sumofn.o
```

Debug command

```console
spike pk -d sumofn.o

```

This command will run all the instructions until 100b0 Address

```console
until pc 0 100b0
```

This command is used for the checking the content of a register

```console
reg 0 a0
```

##### Debugging

![image](https://user-images.githubusercontent.com/66086031/170256907-95f60649-d30e-458d-bc79-c599d7973eeb.png)

- Here the value of the immediate 0x00021000 is loaded into the r0 register

![image](https://user-images.githubusercontent.com/66086031/170257627-b4aa36c4-b1bd-49fd-9601-6a485d12a483.png)

- Here the value of stack pointer is decreased by -10 in hex.

### Number systems

#### 64-bit Number system

- 8 bits => 1 byte
- 4 bytes => 1 word
- 8 bytes => 2 words

Number of combinations using n bits => $2^n$

Highest number represented by 64-bit system => (2^64) - 1

#### 2's Complement representation

- Take 1's complement and then add +1.
- MSB indicates sign
- MSB = 0 indicates Positive Numbers
- MSB = 1 indicates Negative Numbers
- Range 0 to 2^63
- Range -1 to -2^63

#### Lab for signed and unsigned magnitude

- Highest unsigned long long number is $18446744073709551615$.

![image](https://user-images.githubusercontent.com/66086031/170858162-cbb960a9-7e66-4f33-90fd-a94169961864.png)

- Signed Numbers Max and Min

![image](https://user-images.githubusercontent.com/66086031/170858434-53763d82-387a-46b5-bf18-2c34b14d3c73.png)

long long int occupies 8 bytes = $8 * 8 = 64 bits$

## Day 2 - Application Binary Interface and Verification flow

### Application Binary Interface (ABI)

#### Intro to ABI

![image](https://user-images.githubusercontent.com/66086031/170488080-6818b07f-3ae7-4da8-b7d3-86a21550b442.png)

- ABI is the system-call interface present between the software application and the registers of the ISA
- It can be used to access the registers through system calls

```mermaid

graph TD
A[Application-Program] -->|API| Standard-Libraries
Standard-Libraries -->|System-call| Operating-System
Operating-System -->|ISA| RISC-V-Core

A -->|ABI| RISC-V-Core
```

- There are 32 registers each of 64 bits in the RV64.

#### Memory Allocation for double words

- Memory is **byte-addressable**
- Each address contains 8 - bits (i.e.) - 1 byte
- RISC - V follows little-endian memory system.
- MSB bits have higher memory address and LSB have lower memory address

#### Load, Add and Store instructions

- Load - ld x8, 16(x23) - loads Memory[16+x23] into x8
- Add - x8, x24, x8
- Store - x8, 8(x23) - Store cotent of x8 into Memory[x23+8]

#### RV64I registers and their ABI Names

- Load, add and store belong to $RV64I$ base instructions.
- Load is a I-type instruction
- Add is a R-type instruction
- Store is a S-type instruction
- $rd$ is of size 5 bits => So $2^5 = 32$ registers
- Naming convention is $x0$ to $x31$

<!-- ![image](https://user-images.githubusercontent.com/66086031/170494227-79438b1a-17ec-41e5-9ea8-dce2746424e2.png) -->

### Labs using ABI function call

#### Sum of N numbers Flowchart

```mermaid
graph TD;
S[Start a0 = 0, a1 = count] --> M[temp variable, a4 = 0]
M --> R[incrementing variable, a3 = 0]
R --> N[Store count in a2]
N --> Q[a4 = a3 + a4]
Q --> I[a3 = a3 + 1]
I --> D{Is a3 < a2 ?}
D -->|yes| Q
D -->|no| F[a0 = a4 + zero]
F --> End
```

- Value of a0 is returned to the main program.

#### Assembly Function Call

##### Assembly code for the sum of N

```assembly
.section .text
.global load
.type load, @function

load:
  add a4, a0, zero // a4 - sum register
  add a2, a0, a1   // a2 - count register, n
  add a3, a0, zero // a3 - intermediate register, i
  
loop:
  add a4, a3, a4 // add a3 to a4 every loop
  add a3, a3, 1  // increment a3 by 1
  blt a3, a2, loop // loop back as long as i < n
  add a0, a4, zero // store result in a0
  ret  
```

##### C program to call the assembly code

```c
#include <stdio.h>

extern int load(int x, int y);

int main () {
 int result = 0;
 int count = 10;
 result = load(0x0, count+1);
 printf("Sum of numbers from 1 to %d is %d\n", count, result);
 return 0;
} 
```

![image](https://user-images.githubusercontent.com/66086031/170498879-1920ab36-96c5-41c2-b347-5423c969d997.png)

##### Compiling through a RISC-V core

```console
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o sumof_N.o sumof_N.c load.S
spike pk sumof_N.o
```

![image](https://user-images.githubusercontent.com/66086031/170499741-88729f95-264c-4b93-9d11-c9de044a5533.png)

### Passing the C program as a HEX file

```mermaid
graph LR;

Memory --> RISC-V
RISC-V --> R[Display the result]

```

```console
git clone https://github.com/kunalg123/riscv_workshop_collaterals.git
```

```console
chmod 377 rv32im.sh
./rv32im.sh
```

- The instructions that we want to run are passed as HEX files into the RISC - V core

![image](https://user-images.githubusercontent.com/66086031/170502881-b3b81525-44fd-4bf0-b972-2e8a5425dcaf.png)

## Day 3 - Digital Logic with TL-Verilog and Makerchip

### Combinational Logic

- Output depends only on the present input.
- No state is associated and no memory elements.

#### Labs using Makerchip

##### Pipelined Pythagorean Example

![image](https://user-images.githubusercontent.com/66086031/170714110-49abcceb-4391-491a-95b5-dfe84bb2b075.png)

##### Basic Logic Gates Example

- Load Default template

![image](https://user-images.githubusercontent.com/66086031/170716547-dbe2d36d-93d9-4feb-878c-e3a857bf6b36.png)

```verilog
$reset = *reset;

$out1 = ~$in1;  // NOT
$out2 = $in1 || $in2; // bitwise - OR
$out3 = $in1 && $in2; // bitwise - AND
$out4 = $in1 ^ $in2; // bitwise - XOR
$out5 = ~($in1 ^ $in2); // bitwise - XNOR
```

##### Vectors

- Code

```verilog
$out[4:0] = $in1[3:0] + $in2[3:0];
```

- Output Waveform

![image](https://user-images.githubusercontent.com/66086031/170718420-b49fa8ab-cb3a-47c3-b2d6-ce91b8ced9d8.png)

##### Mux_2x1

- 2x1 Mux

```verilog
$out = $sel ? $in1 : $in0; // 2x1 MUX
```

- Output Waveform

![image](https://user-images.githubusercontent.com/66086031/170719127-31375253-5cb5-4eee-8cb4-71bed7d563ff.png)

- 2x1 Mux (vector)

```verilog
$out[7:0] = $sel ? $in1[7:0] : $in0[7:0]; // 2x1 MUX
```

- Output Waveform

![image](https://user-images.githubusercontent.com/66086031/170719971-67ce95ae-e37a-4b74-b651-0af7103a11c4.png)

##### Combinational Calculator

- Code

```verilog
   $reset = *reset;


   // YOUR CODE HERE
   $val1[31:0] = $rand1[3:0];
   $val2[31:0] = $rand2[3:0];

   $sum[31:0] = $val1 + $val2;  //00
   $diff[31:0] = $val1 - $val2; //01
   $prod[31:0] = $val1 * $val2; //10
   $quot[31:0] = $val1 / $val2; //11

   $out[31:0] = ($op[1:0] == 2'b00) ? $sum :
               ($op[1:0] == 2'b01) ? $diff :
               ($op[1:0] == 2'b10) ? $prod :
               ($op[1:0] == 2'b11) ? $quot : 32'b0;
```

- Output Waveform

![image](https://user-images.githubusercontent.com/66086031/170805393-76330955-5761-42a1-9028-a12f692c403c.png)

### Sequential Logic

- Present state depends on past state.
- Memory is associated with sequential logic.
- It retains its value till a clock edge or (level comes).

#### Finite State Machine

![image](https://user-images.githubusercontent.com/66086031/170738050-a5720bb2-e3f2-4a5f-8325-0ce05d178959.png)

#### Fibonacci Series implmenetation

- Code

```verilog
$num[31:0] = $reset ? 1 : (>>1$num + >>2$num);
```

- Output Waveform

![image](https://user-images.githubusercontent.com/66086031/170740123-6cb3a104-7159-4329-a168-00a982991568.png)

#### Up-counter implementation

- Code

```verilog
$num[31:0] = $reset ? 0 : (>>1$num + 1);
```

- Output Waveform

![image](https://user-images.githubusercontent.com/66086031/170741198-952b935c-f42e-4845-9638-a1966c014039.png)

#### Sequential Calculator

- Here the last output becomes one of the present input.

- Code

```verilog
   $reset = *reset;


   //$val1[31:0] = $rand1[3:0];
   $val2[31:0] = $rand2[3:0];

   //$num[31:0] = $reset ? 0 : (>>1$num + 1);

   $sum[31:0] = $out + $val2;  //00
   $diff[31:0] = $out - $val2; //01
   $prod[31:0] = $out * $val2; //10
   $quot[31:0] = $out / $val2; //11

   $tout[31:0] = ($op[1:0] == 2'b00) ? $sum :
                  ($op[1:0] == 2'b01) ? $diff :
                  ($op[1:0] == 2'b10) ? $prod :
                  ($op[1:0] == 2'b11) ? $quot : 32'b0;

   $out[31:0] = $reset ? 0 : >>1$tout;
```

- Output Waveform

![image](https://user-images.githubusercontent.com/66086031/170805338-84ef90c0-2278-475d-9141-648275c25a87.png)

### Pipelined Logic

#### Intro to Pipelining and Re - timing

- We divide the long combinational circuit into smaller parts by inserting registers.
- Each smaller part has less propagation delay.
- So now each stage can be executed at higher frequency.
- Pipelining allows us to overlap the execution of one instruction with the earlier stage of another instruction.
- It increases system response time, as we don't need to wait till the entire instruction is executed.

##### Re-timing

- We can move the flip flops to achieve equal delays in each stage.

#### Benefits of pipelining

- Max. frequency of the clock, depends on the propagation delay between flip flops.
- By inserting more flip flops, the propagation delay reduces
- It increases the throughtout

#### Pipelined fibo series implementation

- $lower_case: pipe signal
- $PascalCase: state signal
- $UPPER_CASE: keyword

- Everything in TL-Verilog is implicitly pipelined.
- This fibo implementation is equivalent to the earlier implementation.
![image](https://user-images.githubusercontent.com/66086031/170804569-3f40f3cd-6ff8-430b-a5db-be0a2ffd74b4.png)

#### Error Conditions within Computation Pipeline

- Code

```verilog
   $reset = *reset;

   //...
   |comp
      @1
         $err1 = $bad_input + $illegal_op;
         
      @3
         $err2 = $over_flow + $err1;
      @6
         $err3 = $div_by_zero + $err2;   
```

- Output Waveform
  
![image](https://user-images.githubusercontent.com/66086031/170805061-8c3628af-8428-4768-b38d-7c39f8fc6403.png)

#### 2-Cycle Calculator

i. First we shall include the counter and calculator in the first stage.

<!-- ![image](https://user-images.githubusercontent.com/66086031/170805921-c02e3b01-9e6b-4806-9eb4-0d920693a85b.png) -->

ii. Change alignment of $out to have two cycle latency

<!-- ![image](https://user-images.githubusercontent.com/66086031/170805904-76cddf80-1a48-4529-ad04-4a3bea9b055b.png) -->

iii. Change counter to 1 - bit

<!-- ![image](https://user-images.githubusercontent.com/66086031/170805963-32571460-1a63-4a54-b80c-9e3add4bbf64.png) -->

iv. Use the counter as valid signal. The output gets the Mux output every two clock cycles.

<!-- ![image](https://user-images.githubusercontent.com/66086031/170806478-e24ddcf8-2be7-4092-a7f2-4f9b81717024.png) -->

v. Now we re-time(move the mux) to second stage. The output gets the Mux output every other clock cycle.

![image](https://user-images.githubusercontent.com/66086031/170807210-4cd0d74e-b1f3-4409-8b46-2b173ace0b73.png)

- Code

```verilog
   |calc
      @0
         $reset = *reset;
         
      @1   
         //$val1[31:0] = $rand1[3:0];
         $val2[31:0] = $rand2[3:0];

         $valid = $reset ? 0 : (>>1$valid + 1);

         $sum[31:0] = $out + $val2;  //00
         $diff[31:0] = $out - $val2; //01
         $prod[31:0] = $out * $val2; //10
         $quot[31:0] = $out / $val2; //11   
         
         $out[31:0] = ($reset | ~($valid)) ? 0 : >>2$tout;
         
      @2
         $tout[31:0] = ($op[1:0] == 2'b00) ? $sum :
                     ($op[1:0] == 2'b01) ? $diff :
                     ($op[1:0] == 2'b10) ? $prod :
                     ($op[1:0] == 2'b11) ? $quot : 32'b0;
```

### Validity

#### Intro to validity

- Validity checks can be included in the design
- It is helpful in better debugging
- Leads to cleaner design

##### Clock Gating

- Toggling of the clock consumes lot of power
- Clock gating avoids toggling for invalid inputs

#### Lab on validity and computing total distance

- In this we compute the pythagorean distance and add it to the previous value.

![image](https://user-images.githubusercontent.com/66086031/170811056-8c65762e-d713-4da5-89c0-3464dcaa418e.png)

#### 2-cycle Calculator with Validity

- In this implementation, the computation is carried out, only when the validity is enabled.

<details>

   <summary> Code </summary>

```verilog
   |calc
      @0
         $reset = *reset;
         
      @1   
         //$val1[31:0] = $rand1[3:0];
         $val2[31:0] = $rand2[3:0];

         $valid = $reset ? 0 : (>>1$valid + 1);
         
         $valid_or_reset = $valid || $reset;
         
      ?$valid_or_reset
         @1
            $out[31:0] = $reset ? 0 : >>2$tout;
            
            $sum[31:0] = $out + $val2;  //00
            $diff[31:0] = $out - $val2; //01
            $prod[31:0] = $out * $val2; //10
            $quot[31:0] = $out / $val2; //11               

         @2
            $tout[31:0] = ($op[1:0] == 2'b00) ? $sum :
                        ($op[1:0] == 2'b01) ? $diff :
                        ($op[1:0] == 2'b10) ? $prod :
                        ($op[1:0] == 2'b11) ? $quot : 32'b0;
```

</details>

- Output Waveform

![image](https://user-images.githubusercontent.com/66086031/170811957-316e4e4e-132c-419b-9f04-ea148d822add.png)

#### Calculator single-value Memory

- We can implement a memory system using a Mux that has a feedback path.
- op = 100 => memory read (recall)
- op = 101 => memory write

<details>
   <summary> Code </summary>

```verilog
   |calc
      @0
         $reset = *reset;

      @1   
         //$val1[31:0] = $rand1[3:0];
         $val2[31:0] = $rand2[3:0];

         $valid = $reset ? 0 : (>>1$valid + 1);
         
         $valid_or_reset = $valid || $reset;
         
      ?$valid_or_reset
         @1
            $out[31:0] = $reset ? 0 : >>2$tout;
            
            $sum[31:0] = $out + $val2;  //00
            $diff[31:0] = $out - $val2; //01
            $prod[31:0] = $out * $val2; //10
            $quot[31:0] = $out / $val2; //11   
            
            
         @2
            // op = 100 => memory read
            // op = 101 => memory write
            
            // memory
            $mem[31:0] = $reset ? 0 :
                                  ($op[2:0] == 3'b101) ? >>2$tout :
                                  >>2$mem;

            $tout[31:0] = ($op[2:0] == 3'b000) ? $sum :
                        ($op[2:0] == 3'b001) ? $diff :
                        ($op[2:0] == 3'b010) ? $prod :
                        ($op[2:0] == 3'b011) ? $quot :
                        ($op[2:0] == 3'b100) ? >>2$mem : >>2$tout;
```

</details>

![image](https://user-images.githubusercontent.com/66086031/170814317-fb4e759f-5fd3-4b23-b242-932da8f614d3.png)

- Here at the 32th clock cycle, we are writing the value ffd into the memory.

![image](https://user-images.githubusercontent.com/66086031/170814637-3104816f-c573-4987-96e2-e25865b7cac9.png)

- It take 2 cycles to write.

## Day 4 - Micro-architecture of a Single Cycle RISC - V Core

### Intro to Microarchitecture

#### Micro-architecture

- A Micro-architecture is an implementation of an ISA.
- A Single ISA can have multiple Mirco-architectures.
- We shall implement the below micro-architecture in TL-Verilog

#### Basic Instruction-Execution Cycle

- **Fetch** the Instruction pointed by the PC from the Instruction Memory.
- **Decode** the the Instruction
- **Execute** the instruction (ALU)
- Perform **Memory Access** if needed (Data Memory)
- **Write Back** the result into the Register File

![image](https://user-images.githubusercontent.com/66086031/170815832-646673e6-3556-47c4-a7fb-2224ffa03b6d.png)

### Fetch and Decode

#### Program Counter Implementation

- Increments by +4 bytes every clock cycle.
- Resets to 0 at the next clock cycle, if reset instruction is asserted.

```verilog
   |cpu
      @0
         $reset = *reset;      
         $pc[31:0] = (>>1$reset) ? 32'b0 : >>1$pc + 32'd4;
```

![image](https://user-images.githubusercontent.com/66086031/170817110-78f9b0b9-10d1-4d76-a75a-61e64485d001.png)

#### Fetch Stage Implementation

```verilog
   |cpu
      @0
         $reset = *reset;
      // YOUR CODE HERE
      // ...
      
         $pc[31:0] = (>>1$reset) ? 32'b0 : >>1$pc + 32'd4;
         $imem_rd_en = ~($reset);
      
      @1
      ?$imem_rd_en
         @1
            $imem_rd_addr[31:0] = $pc[M4_IMEM_INDEX_CNT+1:2];
      
      @1   
         $instr[31:0] = $imem_rd_data[31:0];
```

![image](https://user-images.githubusercontent.com/66086031/170820753-80fe3a5e-f043-40d9-be36-76253659a47a.png)

#### Decoding instruction type

![image](https://user-images.githubusercontent.com/66086031/170821540-02879643-897f-4873-915c-68f0e2db53eb.png)

![image](https://user-images.githubusercontent.com/66086031/170821518-35310faf-009b-406f-8ad4-bc0d216d9c89.png)

#### Immediate Decode

![image](https://user-images.githubusercontent.com/66086031/170821724-996fb31e-31f7-4109-9307-297100f9b49b.png)

- Based on the instruction type, we need to form the immediate.

![image](https://user-images.githubusercontent.com/66086031/170822409-78c51583-fbe5-4881-a13a-6033bb45b632.png)

#### Instruction Decode

- Similiary, we can extract other fields of information

![image](https://user-images.githubusercontent.com/66086031/170822721-72dd44a1-23ee-45a3-93c4-0ef32cecf9e2.png)

![image](https://user-images.githubusercontent.com/66086031/170823049-88b61ad9-7a31-460b-9d0b-66944086f150.png)

#### Validity in Instruction decode

- Now add validity checks when extract the fields

![image](https://user-images.githubusercontent.com/66086031/170824353-995c7c88-bd22-4da5-b29f-af9b2c5c96fb.png)

#### Determining individual instruction

- Using funct7, opcode and funct3 decode each type of instruction

![image](https://user-images.githubusercontent.com/66086031/170825166-71496325-f86a-4483-ab2c-a62174166629.png)

![image](https://user-images.githubusercontent.com/66086031/170825155-cfba2c7f-09d0-4b14-bb13-9002e52f6ffd.png)

### Control Logic

#### Register File Read

![image](https://user-images.githubusercontent.com/66086031/170825988-06a5e53d-f10f-4851-9ded-9a21b2dd568b.png)

- When rs1, rs2 needed we can enable register read and provide the location of the source regsiters.
- By checking r-type and i-type we can check whether this is correct.

![image](https://user-images.githubusercontent.com/66086031/170826118-552520b2-9264-4575-a337-8ff82d13deb2.png)

#### ALU Decoder

![image](https://user-images.githubusercontent.com/66086031/170826391-2572e0c7-1d65-4551-af16-f47ef45c753b.png)

#### Register File Write

- We cannot write to r0 register.

![image](https://user-images.githubusercontent.com/66086031/170826837-188d218c-33cd-4a3d-a47d-c03479e1acd9.png)

#### Branch Decisions

- We take a branch only if it is branch instruction and condition is true.

![image](https://user-images.githubusercontent.com/66086031/170828036-ddae9969-83bd-4bb3-80ae-bcef83e90581.png)

#### Branch to Target

- We modify the PC Mux to take a branch when the previous instruction is a branch instruction (taken branch)

![image](https://user-images.githubusercontent.com/66086031/170828381-7bd5c7dd-0393-49f3-b1e2-b94d921899b3.png)

### Verification

```verilog
*passed = |cpu/xreg[10]>>5$value == (1+2+3+4+5+6+7+8+9);
```

- The design successfully produces the sum!

![image](https://user-images.githubusercontent.com/66086031/170834175-1c1bbc7c-037e-4dee-bda4-d734b132a1f8.png)

- This is the final image for day 4.
  
![image](https://user-images.githubusercontent.com/66086031/170834377-a68620a9-2004-4c64-a20f-675409c414a2.png)

## Day 5 - Pipelined RISC-V Core

### Intro to Pipelining

![image](https://user-images.githubusercontent.com/66086031/170847924-80db50f1-5d40-484c-9498-ce7958332035.png)

- Instead of executing the instructions one by one, we can divide the combinational circuit.
- We can overlap the execution of one instruction with the earlier stage of another instruction.
- It is a analogous to a queue or a waterfall.
- This is also known as temporal parallelism.

### Pipelining the CPU

#### 3 - Cycle Valid Signal

- We insert a new instruction every third cycle to avoid hazards

![image](https://user-images.githubusercontent.com/66086031/170848439-466b0c08-5668-4fb5-9eeb-34915fdcf0c8.png)

#### Invalid Instructions

- Avoid writing RF for invalid instructions
- Avoid redirecting PC for invalid intructions

![image](https://user-images.githubusercontent.com/66086031/170848664-7bbdce9f-4aef-46e8-923e-16c225ce0e48.png)

![image](https://user-images.githubusercontent.com/66086031/170849445-964de4ac-0786-4434-b902-c5c9c4448dec.png)

- But it takes 100 clock cycles

#### Re-Timing

![image](https://user-images.githubusercontent.com/66086031/170851116-7bebca9a-8ec8-484f-beec-ad78f180a0b1.png)

### Solving Hazards

#### RAW Hazard

- If Source register is equal to destination register of previous instruction, use bypass

![image](https://user-images.githubusercontent.com/66086031/170851407-9562b858-8088-492c-8d15-7bd403e08737.png)

#### Branch Hazards

![image](https://user-images.githubusercontent.com/66086031/170852274-e03e1827-ff0c-4fc6-91b6-a8d6b0bc60c1.png)

- We have wait to till @3 stage (4th Stage), to tell whether branch is taken or not.
- We can use a branch predictor but it is difficult to implement.
- So, we will not allow the next two instructions to write to register file whenever branch is detected

![image](https://user-images.githubusercontent.com/66086031/170852206-ab63b9c1-8e78-4b60-8b40-1d2d2dcc7273.png)

![image](https://user-images.githubusercontent.com/66086031/170852213-4ea52124-f9f0-4444-a9f3-41e8a1ac30b2.png)

#### Remaining Instruction Decode

- We consider all loads as same for simplicity.
![image](https://user-images.githubusercontent.com/66086031/170852688-b08f30ec-8248-4d5d-9c83-22c2e61e3d92.png)

![image](https://user-images.githubusercontent.com/66086031/170852683-83469b28-01c2-4f26-a0b6-a224de3a5feb.png)

#### Complete ALU

- We implement the remaining two instructions

![image](https://user-images.githubusercontent.com/66086031/170853367-72b134d5-a838-487d-9302-dec65edd4435.png)

![image](https://user-images.githubusercontent.com/66086031/170853363-c5c3c0e0-447a-4741-99bf-53e54fa15ae0.png)

### Loads/Stores

#### Implementing loads and Redirecting

- Load - Loading from Data Memory into the Register file

![image](https://user-images.githubusercontent.com/66086031/170853616-98e88e13-0754-4cd3-b7e5-323100609d57.png)

- We have to wait till the end of execute stage to obtain the valid load data.
- So, we have to flush the next two instructions
- We then forward the result.

#### Valid Loads

- When there is valid load two cycles ago, we can enable the write pin for the register
- We also add a Mux for selecting between load and ALU Writes

![image](https://user-images.githubusercontent.com/66086031/170855000-40c5b079-ff3b-48d3-9299-6025f27338ef.png)

#### Instantiate Data Memory

- Now uncomment macro of data memory
- Connect the interface signals

![image](https://user-images.githubusercontent.com/66086031/170855681-3cf2acf7-2b49-4030-97f8-3b1f02c90221.png)

#### Testing Loads/Stores

![image](https://user-images.githubusercontent.com/66086031/170856035-ae2b024d-5f49-4a9d-864d-3860e5da0d40.png)

- The test is successfully passed.

#### Jumps

- Jumps are unconditional branches
- JAL => jump to PC + imm
- JALR => src1 + imm

![image](https://user-images.githubusercontent.com/66086031/170856795-b78cffdf-52e7-452c-9d6b-72258a655c6c.png)

#### Final Work

- Thus a Five Stage Pipelined RISC - V Core of RV64I is successfully designed and verified.

![image](https://user-images.githubusercontent.com/66086031/170856984-ed7ffa8b-3a12-4c65-baa9-d9ca4c38a384.png)

## Acknowledgements

[1] Kunal Ghosh - Founder, VSD

[2] Steve Hoover - Founder, RedWood EDA

[3] Shon Taware - Teaching Assistant, VSD

[4] VSD Team
