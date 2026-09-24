section .data
    line1 db "                         I", 0x0A
    line2 db "                        wrote", 0x0A
    line3 db "                       a poem", 0x0A
    line4 db "                     in the shape", 0x0A
    line5 db "                    of a Christmas", 0x0A
    line6 db "                  tree but then forgot", 0x0A
    line7 db "                to water it and only a few", 0x0A
    line8 db "                        days", 0x0A
    line9 db "                        later", 0x0A
    line10 db "                        there", 0x0A
    line11 db "                  were", 0x0A
    line12 db "                              words", 0x0A
    line13 db "              all", 0x0A
    line14 db "                         over", 0x0A
    line15 db "                    the", 0x0A
    line16 db "                                        carpet", 0x0A

    message db 0x49, 0x20, 0x4C, 0x6F, 0x56, 0x65, 0x20, 0x41, 0x73, 0x53, 0x65, 0x4D, 0x62, 0x4C, 0x79, 0x20, 0x50, 0x72, 0x4F, 0x67, 0x52, 0x61, 0x4D, 0x6D, 0x49, 0x6E, 0x67, 0x47, 0x20, 0x3A, 0x29, 0x0A

    student db 0x53, 0x74, 0x75, 0x64, 0x65, 0x6E, 0x74, 0x20, 0x4E, 0x75, 0x6D, 0x62, 0x65, 0x72, 0x3A, 0x20, 0x32, 0x30, 0x32, 0x33, 0x31, 0x30, 0x36, 0x33, 0x36, 0x0A

    firstname db 88, 72, 69, 65, 87, 78, 10
    middlename db 86, 73, 68, 65, 10
    lastname db 67, 82, 73, 83, 84, 79, 66, 65, 76, 10

section .text
global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, line1
    mov edx, 28
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line2
    mov edx, 30
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line3
    mov edx, 30
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line4
    mov edx, 34
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line5
    mov edx, 35
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line6
    mov edx, 39
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line7
    mov edx, 43
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line8
    mov edx, 29
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line9
    mov edx, 30
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line10
    mov edx, 30
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line11
    mov edx, 23
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line12
    mov edx, 36
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line13
    mov edx, 18
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line14
    mov edx, 30
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line15
    mov edx, 24
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, line16
    mov edx, 47
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, message
    mov edx, 32
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, student
    mov edx, 26
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, firstname
    mov edx, 7
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, middlename
    mov edx, 5
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, lastname
    mov edx, 10
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80
