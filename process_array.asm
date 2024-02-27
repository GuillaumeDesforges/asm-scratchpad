section .data

n_values dq 5
values dq 1,10,100,1000,10000
sum dq 0
min dq 0xffffffff
max dq 0

section .text

global _start
_start:
  mov rcx, [n_values]                   ; counter (decremental)
  mov rsi, 0                            ; iterator
iterStep:
  mov rdx, qword [values+rsi*8]         ; find current element 
  mov rax, qword [sum]
  add rax, rdx
  mov [sum], qword rax                  ; add current element
  cmp rdx, qword [min]
  jge notNewMin                         ; check if new min
  mov qword [min], rdx                  ;   if so, update min
notNewMin:
  cmp rdx, qword [max]
  jle notNewMax                         ; check if new max
  mov [max], rdx                        ;   if so, update min
notNewMax:
  inc rsi                               ; next item
  loop iterStep

exit:
  mov rax, 60
  mov rdi, 0
  syscall                               ; exit with success
