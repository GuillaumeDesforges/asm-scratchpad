section .data

array         dq 1,10,100,1000
len           dq 4
result        dq 0,0,0,0

section .text

; int_double(
;   x: uint64
; ): uint64
global int_double
int_double:
  ; prologue
  push rbp
  mov rbp, rsp
  ; body
  mov rax, rdi
  mov rdx, 2
  mul rdx
  ; epilogue
  mov rsp, rbp
  pop rbp
  ret

; qword_map(
;   f_address: (qword -> qword)*
;   source_array_address: array<qword>*
;   destination_array_address: array<qword>*
;   length: uint64
; ): void
global qword_map
qword_map:
  ; prologue
  push rbp
  mov rbp, rsp
  push rdi ; f_address
  push rsi ; source_array_address
  push rdx ; destination_array_address
  ; push rcx ; length ; not needed
  ; body
  ; mov rcx, [rbp+32] ; not needed
  mov rsi, 0
iterLoop:
  ; prepare call to f on item at source_array_address+rsi*8
  ; rdi <- *(&source_array_address + rsi * 8)
  mov rdi, qword [rbp-16]
  mov rdi, qword [rdi+(rsi*8)]
  ; rax <- f(rdi)
  push rsi ; rsi might disappear, save it
  push rcx ; rcx might disappear, save it
  call qword [rbp-8]
  pop rcx ; recover rcx
  pop rsi ; recover rsi
  ; *(&destination_array_address + rsi * 8) <- rax
  mov rdi, qword [rbp-24]
  mov qword [rdi+(rsi*8)], rax
  ; iterate
  inc rsi
  loop iterLoop
  ; epilogue
  mov rsp, rbp
  pop rbp
  ret

; basically
; map(&int_double, &array, &result, len)
global _start
_start:
  mov rdi, int_double
  mov rsi, array
  mov rdx, result
  mov rcx, qword [len]
  call qword_map
exit:
  ; exit program with success
  mov rax, 60
  mov rdi, 0
  syscall

