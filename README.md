
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

```c
int main () {
  int i = 0, sum = 0;
  int n = 10;
  for (auto i = 1; i < n; ++i) {
    sum += i;
  }
  
  printf("\nSum of number from 1 to %d = %d\n", n, sum);
  return 0;
}
```
