section .data
    line1 db 72, 32, 32, 32, 32, 32, 32, 32, 88, 72, 69, 65, 87, 78, 10
    line1Len equ $ - line1

    line2 db 32, 32, 32, 32, 69, 32, 32, 32, 32, 32, 32, 32, 86, 73, 68, 65, 10
    line2Len equ $ - line2

    line3 db 32, 32, 32, 32, 32, 32, 32, 32, 76, 32, 32, 32, 32, 32, 32, 32, 67, 82, 73, 83, 84, 79, 66, 65, 76, 10
    line3Len equ $ - line3

    line4 db 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 76, 10
    line4Len equ $ - line4

    line5 db 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 79, 10
    line5Len equ $ - line5

section .text
global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, line1
    mov edx, line1Len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line2
    mov edx, line2Len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line3
    mov edx, line3Len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line4
    mov edx, line4Len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line5
    mov edx, line5Len
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80
