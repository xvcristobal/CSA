SYS_EXIT  equ 1
SYS_WRITE equ 4
STDOUT    equ 1

section .text
    global _start

_start:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, message1
    mov edx, len_message1
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, message2
    mov edx, len_message2
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, message3
    mov edx, len_message3
    int 0x80

    mov eax, SYS_EXIT
    xor ebx, ebx
    int 0x80

section .data
    message1 db 'Assembler ready', 0xa
    len_message1 equ $ - message1

    message2 db 'Linker ready', 0xa
    len_message2 equ $ - message2

    message3 db 'Program ready', 0xa
    len_message3 equ $ - message3
