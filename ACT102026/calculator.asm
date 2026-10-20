
section .data
    clear db 27, '[2J', 27, '[H'
    clearLen equ $ - clear

    menu db '----------------------------------', 10
         db 'MENU', 10
         db '[A]dd', 10
         db '[S]ubtract', 10
         db '[M]ultiply', 10
         db '[D]ivide', 10
         db '----------------------------------', 10
    menuLen equ $ - menu

    choiceMsg db 'Enter your choice: '
    choiceLen equ $ - choiceMsg

    firstMsg db 'Enter first number (0-99): '
    firstLen equ $ - firstMsg

    secondMsg db 'Enter second number (0-99): '
    secondLen equ $ - secondMsg

    sumMsg db 'The sum is '
    sumLen equ $ - sumMsg

    subMsg db 'The difference is '
    subLen equ $ - subMsg

    mulMsg db 'The product is '
    mulLen equ $ - mulMsg

    divMsg db 'The quotient is '
    divLen equ $ - divMsg

    againMsg db 10, 'Do you want to try again (Y/N): '
    againLen equ $ - againMsg

    invalidMsg db 'Invalid input. Try again.', 10
    invalidLen equ $ - invalidMsg

    zeroMsg db 'Cannot divide by zero!', 10
    zeroLen equ $ - zeroMsg

    newline db 10
    minus db '-'

section .bss
    input resb 32
    choice resb 1
    num1 resd 1
    num2 resd 1
    result resd 1
    digits resb 16

section .text
    global _start

%macro print 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 0x80
%endmacro

_start:
main_menu:
    call clear_screen
    call show_menu

    print choiceMsg, choiceLen
    call read_line

    mov al, [input]
    and al, 0xDF
    mov [choice], al

    cmp al, 'A'
    je get_numbers
    cmp al, 'S'
    je get_numbers
    cmp al, 'M'
    je get_numbers
    cmp al, 'D'
    je get_numbers

    print invalidMsg, invalidLen
    jmp main_menu

get_numbers:
    print firstMsg, firstLen
    call read_number
    mov [num1], eax

    print secondMsg, secondLen
    call read_number
    mov [num2], eax

    call calculate

    print againMsg, againLen
    call read_line

    mov al, [input]
    and al, 0xDF

    cmp al, 'Y'
    je main_menu

    cmp al, 'N'
    je exit_program

    jmp exit_program

exit_program:
    mov eax, 1
    xor ebx, ebx
    int 0x80

; -------------------------------
; CLEAR SCREEN PROCEDURE
; -------------------------------
clear_screen:
    print clear, clearLen
    ret

; -------------------------------
; DISPLAY MENU PROCEDURE
; -------------------------------
show_menu:
    print menu, menuLen
    ret

; -------------------------------
; READ INPUT PROCEDURE
; -------------------------------
read_line:
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 32
    int 0x80
    ret

; -------------------------------
; READ NUMBER PROCEDURE
; Converts ASCII to integer
; -------------------------------
read_number:
read_again:
    call read_line

    mov esi, input
    xor eax, eax
    xor ecx, ecx

convert_input:
    mov bl, [esi]

    cmp bl, 10
    je input_done

    cmp bl, 13
    je input_done

    cmp bl, '0'
    jb bad_number

    cmp bl, '9'
    ja bad_number

    inc ecx
    cmp ecx, 2
    ja bad_number

    imul eax, eax, 10

    movzx edx, bl
    sub edx, '0'
    add eax, edx

    inc esi
    jmp convert_input

input_done:
    cmp ecx, 0
    je bad_number

    ret

bad_number:
    print invalidMsg, invalidLen
    jmp read_again

; -------------------------------
; CALCULATION PROCEDURE
; -------------------------------
calculate:
    mov al, [choice]

    cmp al, 'A'
    je addition

    cmp al, 'S'
    je subtraction

    cmp al, 'M'
    je multiplication

    cmp al, 'D'
    je division

    ret

addition:
    mov eax, [num1]
    add eax, [num2]
    mov [result], eax

    print sumMsg, sumLen
    jmp display_result

subtraction:
    mov eax, [num1]
    sub eax, [num2]
    mov [result], eax

    print subMsg, subLen
    jmp display_result

multiplication:
    mov eax, [num1]
    imul eax, [num2]
    mov [result], eax

    print mulMsg, mulLen
    jmp display_result

division:
    cmp dword [num2], 0
    je divide_zero

    mov eax, [num1]
    xor edx, edx
    div dword [num2]
    mov [result], eax

    print divMsg, divLen
    jmp display_result

divide_zero:
    print zeroMsg, zeroLen
    ret

display_result:
    mov eax, [result]
    call print_number
    print newline, 1
    ret

; -------------------------------
; PRINT INTEGER PROCEDURE
; Supports negative numbers
; -------------------------------
print_number:
    cmp eax, 0
    jge positive_number

    push eax
    print minus, 1
    pop eax
    neg eax

positive_number:
    mov edi, digits
    add edi, 15
    mov ebx, 10

convert_result:
    xor edx, edx
    div ebx

    add dl, '0'
    mov [edi], dl
    dec edi

    test eax, eax
    jnz convert_result

    inc edi

    mov ecx, digits
    add ecx, 16
    sub ecx, edi
    mov edx, ecx

    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    int 0x80
    ret
