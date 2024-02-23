section .data

n_values dq 5;
values dq 1,10,100,1000,10000;
result dq 0;

section .text

global _start
_start:

; sum all values
mov rax, [result]
mov rbx, 0
sumStep:
mov rcx, [values+rbx*8]
add rax, rcx
inc rbx
cmp rbx, [n_values]
jge exit
jmp sumStep

; exit with success
exit:
mov rax, 60
mov rdi, 0
syscall
