section .data

x dq 0

section .text
global _start
_start:
  mov rax, x
exit:
  mov rax, 60
  mov rdi, 0
  syscall                ; Exit program with success

