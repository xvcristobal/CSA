SYS_EXIT  equ 1
SYS_WRITE equ 4
STDOUT    equ 1

section .text
    global _start

_start:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, line1
    mov edx, len_line1
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, line2
    mov edx, len_line2
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, line3
    mov edx, len_line3
    int 0x80

    mov eax, SYS_EXIT
    xor ebx, ebx
    int 0x80

section .data
    line1 db 'Assembly Laboratory', 0xa
    len_line1 equ $ - line1

    line2 db 'Mode: NASM 32-bit', 0xa
    len_line2 equ $ - line2

    line3 db 'Status: Ready', 0xa
    len_line3 equ $ - line3
