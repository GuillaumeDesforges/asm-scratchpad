section .data

array         dq 1,10,100,1000
len           dq 4
result        dq 0,0,0,0

section .text

; int_double :: uint64* -> uint64* -> void
global int_double
int_double:
  ; prologue
  push rbp
  mov rbp, rsp
  ; body
  mov rax, qword [rdi]
  mov rdx, 2
  mul rdx
  mov qword [rsi], rax
  ; epilogue
  mov rsp, rbp
  pop rbp
  ret

global _start

_start:

  mov rcx, [len]
  mov rsi, 0
iterLoop:
  ; prepare call to int_double on item at &array+$rsi*8
  ; rdi <- &array + $rsi * 8
  mov rdi, array
  mov rax, rsi
  mov rdx, 8
  mul rdx
  add rdi, rax
  ; rsi <- &result + $rsi * 8
  mov rax, rsi
  push rsi ; save iterator here since rsi is part of the call convention (second uint64 arg)
  mov rsi, result
  mov rdx, 8
  mul rdx
  add rsi, rax
  call int_double
  pop rsi ; recover iterator
  inc rsi ; iterate
  loop iterLoop

exit:
  mov rax, 60
  mov rdi, 0
  syscall                ; Exit program with success

