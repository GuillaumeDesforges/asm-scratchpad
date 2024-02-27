section .data

n dq 3                ; n

x dq 0                ; fib(n)
y dq 0                ; fib(n+1)

section .text
global _start
_start:
  mov rcx, [n]
  mov qword [x], 0
  mov qword [y], 1
  cmp rcx, 1
  jle exit
loopStep:
  mov rax, qword [y]
  add rax, qword [x]  ; rax <- fib(n+1) + fib(n)
  mov rdx, qword [y]
  mov qword [x], rdx
  mov qword [y], rax  ; fib(n), fib(n+1) <- fib(n+1), rax
  loop loopStep
exit:
  ; result is in x
  mov rax, 60
  mov rdi, 0
  syscall                ; Exit program with success
