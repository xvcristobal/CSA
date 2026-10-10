section .data
    clear db 27, '[2J', 27, '[H'
    clearLen equ $ - clear

    cyan db 27, '[1;36m'
    cyanLen equ $ - cyan

    pink db 27, '[1;35m'
    pinkLen equ $ - pink

    white db 27, '[1;37m'
    whiteLen equ $ - white

    reset db 27, '[0m'
    resetLen equ $ - reset

    titleLine db '============================================================', 10
    titleLineLen equ $ - titleLine

    titleText db '                        MY SLAMBOOK', 10
    titleTextLen equ $ - titleText

    border db '------------------------------------------------------------', 10
    borderLen equ $ - border

    welcome db 10
            db 'Welcome to your interactive Slambook!', 10
            db 'Please answer the following questions.', 10, 10
    welcomeLen equ $ - welcome

    completed db '                  MY PERSONAL SLAMBOOK', 10
    completedLen equ $ - completed

    enterMsg db 10
             db 'Press ENTER to view your completed Slambook...', 10
    enterMsgLen equ $ - enterMsg

    newline db 10

    fish:
        db "                 ___", 10
        db "  ___======____=---=)", 10
        db "/T            \_--===)", 10
        db "[ \ (0)   \~    \_-==)", 10
        db " \      / )J~~    \-=)", 10
        db "   \\___/ )JJ~~~   \)", 10
        db "    \_____/JJJ~~~~   \", 10
        db "   / \  , \J~~~~~     \", 10
        db "  (-\)\=|\\\~~~~       L__", 10
        db "  (\\)  (\\\)_            \==__", 10
        db "   \V    \\\) ===_____   \\\\\\", 10
        db "           \V)    \_)  \\\JJ\J\)", 10
        db "                      /J\JT\JJJJ)", 10
        db "                      (JJJ| \UUU)", 10
        db "                       (UU)", 10
    fishLen equ $ - fish

    q1  db 'Name: ', 0
    q2  db 'Email: ', 0
    q3  db 'Blog/Website: ', 0
    q4  db 'First big achievement: ', 0
    q5  db 'First risk I took: ', 0
    q6  db 'First time I felt completely happy: ', 0
    q7  db 'Favorite color/s: ', 0
    q8  db 'Favorite perfume: ', 0
    q9  db 'Favorite music: ', 0
    q10 db 'Favorite singer/s: ', 0
    q11 db 'Favorite song: ', 0
    q12 db 'Favorite food: ', 0
    q13 db 'Main hobby: ', 0
    q14 db 'Favorite TV show: ', 0
    q15 db 'Favorite movie: ', 0
    q16 db 'Favorite book: ', 0
    q17 db 'Role model: ', 0
    q18 db 'Ambition: ', 0
    q19 db 'Motto: ', 0

    questions dd q1, q2, q3, q4, q5, q6, q7, q8, q9, q10
              dd q11, q12, q13, q14, q15, q16, q17, q18, q19

section .bss
    answers resb 1216
    waitBuf resb 64
    counter resd 1

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
    print clear, clearLen

    print pink, pinkLen
    print titleLine, titleLineLen
    print cyan, cyanLen
    print titleText, titleTextLen
    print pink, pinkLen
    print titleLine, titleLineLen

    print pink, pinkLen
    print border, borderLen

    print white, whiteLen
    print welcome, welcomeLen

    mov dword [counter], 0

ask_loop:
    cmp dword [counter], 19
    jge ask_done

    mov eax, [counter]
    mov eax, [questions + eax * 4]
    call print_string

    mov eax, [counter]
    imul eax, 64
    add eax, answers

    mov ecx, eax
    mov eax, 3
    mov ebx, 0
    mov edx, 63
    int 0x80

    inc dword [counter]
    jmp ask_loop

ask_done:
    print white, whiteLen
    print enterMsg, enterMsgLen

    mov eax, 3
    mov ebx, 0
    mov ecx, waitBuf
    mov edx, 63
    int 0x80

    print clear, clearLen

    print pink, pinkLen
    print titleLine, titleLineLen
    print cyan, cyanLen
    print titleText, titleTextLen
    print pink, pinkLen
    print titleLine, titleLineLen

    print pink, pinkLen
    print border, borderLen
    print cyan, cyanLen
    print completed, completedLen
    print pink, pinkLen
    print border, borderLen

    print cyan, cyanLen
    print fish, fishLen

    print white, whiteLen
    print newline, 1

    mov dword [counter], 0

show_loop:
    cmp dword [counter], 19
    jge show_done

    mov eax, [counter]
    mov eax, [questions + eax * 4]
    call print_string

    mov eax, [counter]
    imul eax, 64
    add eax, answers
    call print_string

    inc dword [counter]
    jmp show_loop

show_done:
    print pink, pinkLen
    print border, borderLen

    print reset, resetLen

    mov eax, 1
    mov ebx, 0
    int 0x80

print_string:
    mov esi, eax
    mov edx, 0

count_loop:
    cmp byte [esi + edx], 0
    je count_done
    inc edx
    jmp count_loop

count_done:
    mov eax, 4
    mov ebx, 1
    mov ecx, esi
    int 0x80
    ret
