
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

    firstMsg db 'Enter first number: '
    firstLen equ $ - firstMsg

    secondMsg db 'Enter second number: '
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

    errorMsg db 'Invalid input!', 10
    errorLen equ $ - errorMsg

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

_start:

main_menu:
    mov ecx, clear
    mov edx, clearLen
    call print

    mov ecx, menu
    mov edx, menuLen
    call print

    mov ecx, choiceMsg
    mov edx, choiceLen
    call print

    call read_input
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

    mov ecx, errorMsg
    mov edx, errorLen
    call print
    jmp main_menu

get_numbers:
    mov ecx, firstMsg
    mov edx, firstLen
    call print

    call read_number
    mov [num1], eax

    mov ecx, secondMsg
    mov edx, secondLen
    call print

    call read_number
    mov [num2], eax

    mov al, [choice]

    cmp al, 'A'
    je addition
    cmp al, 'S'
    je subtraction
    cmp al, 'M'
    je multiplication
    cmp al, 'D'
    je division

addition:
    mov eax, [num1]
    add eax, [num2]
    mov [result], eax

    mov ecx, sumMsg
    mov edx, sumLen
    call print
    jmp show_result

subtraction:
    mov eax, [num1]
    sub eax, [num2]
    mov [result], eax

    mov ecx, subMsg
    mov edx, subLen
    call print
    jmp show_result

multiplication:
    mov eax, [num1]
    imul eax, [num2]
    mov [result], eax

    mov ecx, mulMsg
    mov edx, mulLen
    call print
    jmp show_result

division:
    cmp dword [num2], 0
    je divide_error

    mov eax, [num1]
    xor edx, edx
    div dword [num2]
    mov [result], eax

    mov ecx, divMsg
    mov edx, divLen
    call print
    jmp show_result

divide_error:
    mov ecx, zeroMsg
    mov edx, zeroLen
    call print
    jmp ask_again

show_result:
    mov eax, [result]
    call print_number

    mov ecx, newline
    mov edx, 1
    call print

ask_again:
    mov ecx, againMsg
    mov edx, againLen
    call print

    call read_input

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

print:
    mov eax, 4
    mov ebx, 1
    int 0x80
    ret

read_input:
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 32
    int 0x80
    ret

read_number:
    call read_input

    mov esi, input
    xor eax, eax
    xor ecx, ecx

convert_number:
    mov bl, [esi]

    cmp bl, 10
    je number_done

    cmp bl, 13
    je number_done

    cmp bl, '0'
    jb invalid_number

    cmp bl, '9'
    ja invalid_number

    inc ecx
    cmp ecx, 2
    ja invalid_number

    imul eax, eax, 10

    movzx edx, bl
    sub edx, '0'
    add eax, edx

    inc esi
    jmp convert_number

number_done:
    cmp ecx, 0
    je invalid_number
    ret

invalid_number:
    mov ecx, errorMsg
    mov edx, errorLen
    call print
    jmp read_number

print_number:
    cmp eax, 0
    jge positive

    push eax
    mov ecx, minus
    mov edx, 1
    call print
    pop eax
    neg eax

positive:
    mov edi, digits
    add edi, 15
    mov ebx, 10

convert_result:
    xor edx, edx
    div ebx

    add dl, '0'
    mov [edi], dl
    dec edi

    cmp eax, 0
    jne convert_result

    inc edi

    mov ecx, digits
    add ecx, 16
    sub ecx, edi

    mov edx, ecx
    mov ecx, edi
    call print
    ret
