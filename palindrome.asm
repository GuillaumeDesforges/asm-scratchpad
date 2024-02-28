section .data

array         db "kaya"
len           db 5
is_palindrome db 1

section .text
global _start

_start:

  movzx rcx, byte [len]
  mov rsi, 0
pushLoop:
  movzx rax, byte [array+rsi]
  push rax
  inc rsi
  loop pushLoop

  movzx rcx, byte [len]
  mov rsi, 0
cmpLoop:
  pop rax
  movzx rdx, byte [array+rsi]
  cmp rax, rdx
  je sameLetter
  mov byte [is_palindrome], 0
  jmp exit
sameLetter:
  inc rsi
  loop cmpLoop

exit:
  mov rax, 60
  mov rdi, 0
  syscall                ; Exit program with success
