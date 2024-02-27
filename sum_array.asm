section .data

n_values dq 5
values dq 1,10,100,1000,10000
result dq 0

section .text

global _start
_start:

; sum all values
mov rax, 0                     ; result
mov rcx, [n_values]            ; counter (decremental)
mov rsi, 0                     ; iterator
sumStep:
add rax, qword [values+rsi*8]  ; add element at iterator
inc rsi                        ; next item
loop sumStep
mov [result], qword rax        ; store result

; exit with success
exit:
mov rax, 60
mov rdi, 0
syscall
