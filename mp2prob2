section .data
    lastname db 67, 82, 73, 83, 84, 79, 66, 65, 76, 10
    lastnameLen equ $ - lastname

    firstname db 32, 88, 72, 69, 65, 87, 78, 10
    firstnameLen equ $ - firstname

    middlename db 32, 32, 86, 73, 68, 65, 10
    middlenameLen equ $ - middlename

    nickname db 32, 32, 32, 83, 69, 66, 10
    nicknameLen equ $ - nickname

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

    mov eax, 4
    mov ebx, 1
    mov ecx, nickname
    mov edx, nicknameLen
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80
