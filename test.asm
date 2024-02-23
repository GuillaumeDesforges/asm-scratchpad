section .data
; -----
; Define constants
EXIT_SUCCESS equ 0 ; successful operation
SYS_exit equ 60 ; call code for terminate
; -----
; Variables for addition
dq_n dq 0
dq_i dq 0
dq_x dq 0
dq_y dq 0
; ************************************************************
; Code Section
section .text
global _start
_start:
  mov qword [dq_n], 5
  mov qword [dq_i], 1
  mov qword [dq_x], 0
  mov qword [dq_y], 1
  jmp loopStep
loopStep:
  inc qword [dq_i]
  mov rax, qword [dq_y]
  mov rdx, qword [dq_y]
  add rax, qword [dq_x]
  mov qword [dq_x], rdx
  mov qword [dq_y], rax
  mov rax, qword [dq_i]
  cmp rax, qword [dq_n]
  jle loopStep
; ************************************************************
; Done, terminate program.
last:
 mov rax, SYS_exit ; Call code for exit
 mov rdi, EXIT_SUCCESS ; Exit program with success
 syscall
