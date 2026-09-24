section .data
    lastname db 0x43, 0x52, 0x49, 0x53, 0x54, 0x4F, 0x42, 0x41, 0x4C, 0x0A
    lastnameLen equ $ - lastname

    firstname db 0x58, 0x48, 0x45, 0x41, 0x57, 0x4E, 0x0A
    firstnameLen equ $ - firstname

    middlename db 0x56, 0x49, 0x44, 0x41, 0x0A
    middlenameLen equ $ - middlename

section .text
global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, lastname
    mov edx, lastnameLen
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, firstname
    mov edx, firstnameLen
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, middlename
    mov edx, middlenameLen
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80
