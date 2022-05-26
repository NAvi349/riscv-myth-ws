
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

# Day 2 - Application Binary Interface and verification flow

## Application Binary Interface (ABI)
### Intro to ABI

![image](https://user-images.githubusercontent.com/66086031/170488080-6818b07f-3ae7-4da8-b7d3-86a21550b442.png)

- ABI the interface present between the software application and the registers of the ISA
- It can be used to access the registers through system calls


```mermaid

graph TD
A[Application-Program] -->|API| Standard-Libraries
Standard-Libraries -->|System-call| Operating-System
Operating-System -->|ISA| RISC-V-Core

A -->|ABI| RISC-V-Core
```

- There are 32 registers each of 64 bits in the RV64.

### Memory Allocation for double words

- Memory is **byte-addressable**
- Each address contains 8 - bits (i.e.) - 1 byte
- RISC - V follows little-endian memory system.
- MSB bits have higher memory address and LSB have lower memory address

### Load, Add and Store instructions

![image](https://user-images.githubusercontent.com/66086031/170492880-2ef99afb-8015-4c07-8dc4-bfab27c1540c.png)

![image](https://user-images.githubusercontent.com/66086031/170493000-b7f224c5-e685-4a92-9b79-20ea367c1745.png)

![image](https://user-images.githubusercontent.com/66086031/170493204-b63292f6-2e10-420d-b5dc-cb54fd3e1846.png)

![image](https://user-images.githubusercontent.com/66086031/170493491-a7b70b35-fe83-439d-979c-0bedc71edf81.png)

### RV64I registers and their ABI Names

- Load, add and store belong to RV64I base instructions.
- Load is a I-type instruction
- Add is a R-type instruction
- Store is a S-type instruction
- rd is of size 5 bits => So $2^5 = 32$ registers
- Naming convention is x0 - x31

![image](https://user-images.githubusercontent.com/66086031/170494227-79438b1a-17ec-41e5-9ea8-dce2746424e2.png)

## Labs using ABI function call

### Sum of N numbers Flowchart
![image](https://user-images.githubusercontent.com/66086031/170495257-401375e5-7cd8-4fbd-b2a6-482af8bf3815.png)

### Assembly code for sum of N numbers

```assembly
.section .text
.global load
.type load, @function

load:
		add a4, a0, zero // a4 - sum register
		add a2, a0, a1   // a2 - count register, n
		add a3, a0, zero // a3 - intermediate register, i
		
loop:
		add a4, a3, a4	// add a3 to a4 every loop
		add a3, a3, 1 	// increment a3 by 1
		blt a3, a2, loop	// loop back as long as i < n
		add a0, a4, zero	// store result in a0
		ret		
```

#### C program to call the assembly code
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

#### Debug the code

```console
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o sumof_N.o sumof_N.c load.S
spike
```

![image](https://user-images.githubusercontent.com/66086031/170499741-88729f95-264c-4b93-9d11-c9de044a5533.png)

## Running c program on a test RISC-V core

![image](https://user-images.githubusercontent.com/66086031/170500540-12f8d57a-c5cf-4a6b-aaaa-441ca750c04d.png)

```console
git clone https://github.com/kunalg123/riscv_workshop_collaterals.git
```

```console
chmod 377 rv32im.sh
./rv32im.sh
```

- The instructions that we want to run are passed as HEX files into the RISC - V core

![image](https://user-images.githubusercontent.com/66086031/170502881-b3b81525-44fd-4bf0-b972-2e8a5425dcaf.png)

