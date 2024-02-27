section .data

n_values dq 5
values dq 1,10,100,1000,10000

section .text

global _start
_start:

; sum all values
mov rax, 0
mov rcx, [n_values]
sumStep:
add rax, [values+(rcx-1)*8]
loop sumStep

; exit with success
exit:
mov rax, 60
mov rdi, 0
syscall
