
# Day 1 Introduction to RISC - V ISA and GNU compiler toolchain

## RISC - V ISA

### Intro to ISA

### From Apps to Hardware
![image](https://user-images.githubusercontent.com/66086031/170155862-83e9b749-9fd6-4593-a5f5-060e611b821c.png)

![image](https://user-images.githubusercontent.com/66086031/170156160-42bde070-abf6-40fa-9129-90990ed01bf2.png)

### Types of instruction

![image](https://user-images.githubusercontent.com/66086031/170157205-900b1cd7-273c-41f3-a71a-00f73292c588.png)

- Pseudo Instructions
- RV64I
- RV64M
- RV64F, RV64D
- RV64-IMFD

Application Binary Interface - System calls through which the programmers can access the registers of the RISC - V Core
Memory allocation and stack pointer

## Labs

### C Program to compute Sum from 1 to N

#### C Program file
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

#### Command to execute
```console
gcc sumofn.c -o sumofn
./sumofn
```

![image](https://user-images.githubusercontent.com/66086031/170158604-aeac5978-1288-4dac-95b8-744ca5fae4ab.png)

### gcc compiler and dissassemble

- Now we run the compiled code in a test RISC - V Core
- 
#### Normal speed
```console
riscv64-unknown-elf-gcc -O1 -mabi=lp64 -march=rv64i -o sumofn.o sumofn.c
riscv64-unknown-elf-objdump -d sumofn.o | less
```

![image](https://user-images.githubusercontent.com/66086031/170160320-7aec7d5a-0efd-4d18-982e-e245aebb10a2.png)

![image](https://user-images.githubusercontent.com/66086031/170161243-eb52b474-a49d-43e7-abc4-b37fab131010.png)


Number of instructions = 

#### Fast

```console
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o sumofn.o sumofn.c
riscv64-unknown-elf-objdump -d sumofn.o | less
```

![image](https://user-images.githubusercontent.com/66086031/170161041-84c37cfa-7382-4fcf-a5bb-25a3fb448e7f.png)

### Spike simulation and debug
![image](https://user-images.githubusercontent.com/66086031/170253889-8bdbdee9-0158-43e8-b87d-c421bea14e16.png)

```console
spike pk sumofn.o
```
This command is used for displaying the program after it gets executed by the RISC - V core.

```console
until pc 0 100b0
```
This command will run all the instructions until 100b0 Address

```console
reg 0 a0
```
This command is used for the checking the content of a register

#### Debugging

![image](https://user-images.githubusercontent.com/66086031/170256907-95f60649-d30e-458d-bc79-c599d7973eeb.png)
- Here the value of the immediate 0x00021000 is loaded into the r0 register

![image](https://user-images.githubusercontent.com/66086031/170257176-ff9c6f18-6356-4e15-b3bf-1aeb1f266499.png)

![image](https://user-images.githubusercontent.com/66086031/170257627-b4aa36c4-b1bd-49fd-9601-6a485d12a483.png)
- Here the value of stack pointer is decreased by -10 in hex. 


### Number systems

#### 64-bit Number system

- 8 bits => 1 byte
- 4 bytes => 1 word
- 8 bytes => 2 words

number of combinations using n bits => $2^n$

![image](https://user-images.githubusercontent.com/66086031/170261974-557d798d-9f79-4484-9f3d-a4d831c9d5ce.png)

Highest number represented by 64-bit system => $(2^64) - 1$

#### Signed number representation
#### Lab for signed and unsigned magnitude

# Day 2 - Application Binary Interface

## Intro to ABI

![image](https://user-images.githubusercontent.com/66086031/170488080-6818b07f-3ae7-4da8-b7d3-86a21550b442.png)

- It the interface present between the software application and the Hardware

```mermaid
Application-Program --> Standard-Libraries
Standard-Libraries --> Operating-System
Operating-System --> RISC-V-Core
```
