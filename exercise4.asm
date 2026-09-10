SYS_EXIT  equ 1
SYS_WRITE equ 4
STDOUT    equ 1

section .text
    global _start

_start:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, workflow
    mov edx, workflow_len
    int 0x80

    mov eax, SYS_EXIT
    xor ebx, ebx
    int 0x80

section .data
    workflow db 'Step 1: Edit', 0xa
             db 'Step 2: Assemble', 0xa
             db 'Step 3: Run', 0xa
    workflow_len equ $ - workflow
