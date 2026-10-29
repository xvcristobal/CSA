
%macro print_text 2
    mov ecx, %1
    mov edx, %2
    call print_proc
%endmacro

%macro read_text 2
    mov ecx, %1
    mov edx, %2
    call input_proc
%endmacro

section .data
    title db 10, "===== COR ENROLLMENT SYSTEM =====", 10
    titleLen equ $-title

    menu db "1. Computer Programming       3 units", 10
         db "2. Data Structures            3 units", 10
         db "3. Information Management     3 units", 10
         db "4. Computer Architecture      3 units", 10
         db "5. Mobile Programming         3 units", 10
         db "6. Networking                 3 units", 10
         db "0. Finish Enrollment", 10
    menuLen equ $-menu

    prompt db "Select Subject: "
    promptLen equ $-prompt

    added db "Subject added!", 10
    addedLen equ $-added

    duplicate db "Subject already selected!", 10
    duplicateLen equ $-duplicate

    invalid db "Invalid input!", 10
    invalidLen equ $-invalid

    emptyMsg db "Select at least one subject.", 10
    emptyLen equ $-emptyMsg

    unitPriceMsg db 10, "Enter Tuition Price per Unit (PHP): "
    unitPriceLen equ $-unitPriceMsg

    miscMsg db "Enter Miscellaneous Fee (PHP): "
    miscLen equ $-miscMsg

    idMsg db "Enter ID Validation Fee (PHP): "
    idLen equ $-idMsg

    labMsg db "Enter Laboratory Fee for "
    labMsgLen equ $-labMsg

    labEnd db " (PHP): "
    labEndLen equ $-labEnd

    corTitle db 10, "==========================================", 10
             db "       CERTIFICATE OF REGISTRATION", 10
             db "==========================================", 10
    corTitleLen equ $-corTitle

    subjectHeader db "ENROLLED SUBJECTS", 10
                  db "------------------------------------------", 10
    subjectHeaderLen equ $-subjectHeader

    feeHeader db 10, "ASSESSMENT OF FEES", 10
              db "------------------------------------------", 10
    feeHeaderLen equ $-feeHeader

    subject1 db "Computer Programming"
    subject1Len equ $-subject1

    subject2 db "Data Structures"
    subject2Len equ $-subject2

    subject3 db "Information Management"
    subject3Len equ $-subject3

    subject4 db "Computer Architecture"
    subject4Len equ $-subject4

    subject5 db "Mobile Programming"
    subject5Len equ $-subject5

    subject6 db "Networking"
    subject6Len equ $-subject6

    subjectPtrs dd subject1, subject2, subject3
                dd subject4, subject5, subject6

    subjectLens dd subject1Len, subject2Len
                dd subject3Len, subject4Len
                dd subject5Len, subject6Len

    unitText db " - 3 units", 10
    unitTextLen equ $-unitText

    totalUnitsMsg db "Total Units: "
    totalUnitsLen equ $-totalUnitsMsg

    priceMsg db "Price per Unit: PHP "
    priceLen equ $-priceMsg

    tuitionMsg db "Tuition Fee: PHP "
    tuitionLen equ $-tuitionMsg

    miscLabel db "Miscellaneous Fee: PHP "
    miscLabelLen equ $-miscLabel

    idLabel db "ID Validation Fee: PHP "
    idLabelLen equ $-idLabel

    labLabel db "Laboratory Fee - "
    labLabelLen equ $-labLabel

    amountLabel db ": PHP "
    amountLabelLen equ $-amountLabel

    totalMsg db 10, "TOTAL ASSESSMENT: PHP "
    totalLen equ $-totalMsg

    footer db "==========================================", 10
    footerLen equ $-footer

    newline db 10
    dot db "."
    zero db "0"

section .bss
    input resb 64
    selected resb 6
    labFees resd 6

    units resd 1
    unitPrice resd 1
    tuition resd 1
    misc resd 1
    idFee resd 1
    total resd 1

    numberBuffer resb 16
    numberStart resd 1
    numberLen resd 1
    centsValue resd 1

section .text
    global _start

_start:
    mov dword [units], 0
    xor esi, esi

initialize:
    mov byte [selected + esi], 0
    mov dword [labFees + esi * 4], 0
    inc esi
    cmp esi, 6
    jl initialize

show_menu:
    print_text title, titleLen
    print_text menu, menuLen
    print_text prompt, promptLen

    read_text input, 64

    cmp eax, 1
    jl invalid_choice

    cmp byte [input + 1], 10
    je check_choice

    cmp byte [input + 1], 0
    jne invalid_choice

check_choice:
    mov al, [input]

    cmp al, '0'
    je finish_enrollment

    cmp al, '1'
    jb invalid_choice

    cmp al, '6'
    ja invalid_choice

    sub al, '1'
    movzx esi, al

    cmp byte [selected + esi], 1
    je already_selected

    mov byte [selected + esi], 1
    add dword [units], 3

    print_text added, addedLen
    jmp show_menu

already_selected:
    print_text duplicate, duplicateLen
    jmp show_menu

invalid_choice:
    print_text invalid, invalidLen
    jmp show_menu

finish_enrollment:
    cmp dword [units], 0
    je no_subjects

    print_text unitPriceMsg, unitPriceLen
    call read_money
    mov [unitPrice], eax

    mov ebx, [units]
    mul ebx
    mov [tuition], eax

    print_text miscMsg, miscLen
    call read_money
    mov [misc], eax

    print_text idMsg, idLen
    call read_money
    mov [idFee], eax

    xor esi, esi

ask_labs:
    cmp esi, 6
    jge calculate_total

    cmp byte [selected + esi], 1
    jne next_lab

    print_text labMsg, labMsgLen

    mov ecx, [subjectPtrs + esi * 4]
    mov edx, [subjectLens + esi * 4]
    call print_proc

    print_text labEnd, labEndLen

    push esi
    call read_money
    pop esi

    mov [labFees + esi * 4], eax

next_lab:
    inc esi
    jmp ask_labs

calculate_total:
    mov eax, [tuition]
    add eax, [misc]
    add eax, [idFee]

    xor esi, esi

add_labs:
    add eax, [labFees + esi * 4]
    inc esi
    cmp esi, 6
    jl add_labs

    mov [total], eax

    call generate_cor
    jmp exit_program

no_subjects:
    print_text emptyMsg, emptyLen
    jmp show_menu

exit_program:
    mov eax, 1
    xor ebx, ebx
    int 0x80

generate_cor:
    print_text corTitle, corTitleLen
    print_text subjectHeader, subjectHeaderLen

    xor esi, esi

display_subjects:
    cmp esi, 6
    jge subjects_done

    cmp byte [selected + esi], 1
    jne skip_subject

    mov ecx, [subjectPtrs + esi * 4]
    mov edx, [subjectLens + esi * 4]
    call print_proc

    print_text unitText, unitTextLen

skip_subject:
    inc esi
    jmp display_subjects

subjects_done:
    print_text totalUnitsMsg, totalUnitsLen

    mov eax, [units]
    call print_integer
    print_text newline, 1

    print_text feeHeader, feeHeaderLen

    print_text priceMsg, priceLen
    mov eax, [unitPrice]
    call print_money
    print_text newline, 1

    print_text tuitionMsg, tuitionLen
    mov eax, [tuition]
    call print_money
    print_text newline, 1

    print_text miscLabel, miscLabelLen
    mov eax, [misc]
    call print_money
    print_text newline, 1

    print_text idLabel, idLabelLen
    mov eax, [idFee]
    call print_money
    print_text newline, 1

    xor esi, esi

display_labs:
    cmp esi, 6
    jge labs_done

    cmp byte [selected + esi], 1
    jne skip_lab

    print_text labLabel, labLabelLen

    mov ecx, [subjectPtrs + esi * 4]
    mov edx, [subjectLens + esi * 4]
    call print_proc

    print_text amountLabel, amountLabelLen

    mov eax, [labFees + esi * 4]
    call print_money
    print_text newline, 1

skip_lab:
    inc esi
    jmp display_labs

labs_done:
    print_text totalMsg, totalLen
    mov eax, [total]
    call print_money
    print_text newline, 1

    print_text footer, footerLen
    ret

print_proc:
    push eax
    push ebx

    mov eax, 4
    mov ebx, 1
    int 0x80

    pop ebx
    pop eax
    ret

input_proc:
    mov eax, 3
    mov ebx, 0
    int 0x80
    ret

read_money:
read_again:
    read_text input, 64

    cmp eax, 1
    jl bad_money

    mov esi, input
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edi, edi

parse_money:
    mov dl, [esi]

    cmp dl, 10
    je money_end

    cmp dl, 0
    je money_end

    cmp dl, '.'
    je decimal_point

    cmp dl, '0'
    jb bad_money

    cmp dl, '9'
    ja bad_money

    cmp ecx, 2
    jge bad_money

    sub dl, '0'
    movzx edx, dl

    cmp eax, 20000000
    ja bad_money

    imul eax, 10
    add eax, edx

    inc ebx

    cmp edi, 0
    je next_digit

    inc ecx

next_digit:
    inc esi
    jmp parse_money

decimal_point:
    cmp edi, 1
    je bad_money

    mov edi, 1
    inc esi
    jmp parse_money

money_end:
    cmp ebx, 0
    je bad_money

    cmp edi, 0
    je whole_pesos

    cmp ecx, 1
    je one_decimal

    ret

one_decimal:
    imul eax, 10
    ret

whole_pesos:
    imul eax, 100
    ret

bad_money:
    print_text invalid, invalidLen
    jmp read_again

print_money:
    push eax
    push ebx
    push edx

    xor edx, edx
    mov ebx, 100
    div ebx

    mov [centsValue], edx

    call print_integer

    print_text dot, 1

    mov eax, [centsValue]
    cmp eax, 10
    jge print_cents

    print_text zero, 1

print_cents:
    mov eax, [centsValue]
    call print_integer

    pop edx
    pop ebx
    pop eax
    ret

print_integer:
    push eax
    push ebx
    push ecx
    push edx
    push edi

    mov edi, numberBuffer
    add edi, 16

    mov ebx, 10
    xor ecx, ecx

integer_loop:
    xor edx, edx
    div ebx

    add dl, '0'
    dec edi
    mov [edi], dl
    inc ecx

    test eax, eax
    jnz integer_loop

    mov [numberStart], edi
    mov [numberLen], ecx

    mov ecx, [numberStart]
    mov edx, [numberLen]
    call print_proc

    pop edi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
