section .data

l1  db "              %&&",10
l1L equ $-l1
l2  db "             =##&",10
l2L equ $-l2
l3  db "            ?%###&",10
l3L equ $-l3
l4  db "     O%&@########=",10
l4L equ $-l4
l5  db "   @##############=",10
l5L equ $-l5
l6  db "     O%###########",10
l6L equ $-l6
l7  db "        O########%",10
l7L equ $-l7
l8  db "         ########&=",10
l8L equ $-l8
l9  db "         &############@@@&&&%O?",10
l9L equ $-l9
l10 db "         %########################%?",10
l10L equ $-l10
l11 db "         @############################&?",10
l11L equ $-l11
l12 db "         =################################%",10
l12L equ $-l12
l13 db "          @##################################%",10
l13L equ $-l13
l14 db "           O###################################?",10
l14L equ $-l14
l15 db "             &#################################O",10
l15L equ $-l15
l16 db "              ##################################?",10
l16L equ $-l16
l17 db "             =##################################@",10
l17L equ $-l17
l18 db "            &###################################",10
l18L equ $-l18
l19 db "           =####&     %#########################",10
l19L equ $-l19
l20 db "           @####?       =#######################",10
l20L equ $-l20
l21 db "           ###@           =#####################@",10
l21L equ $-l21
l22 db "          ###&               ###################@",10
l22L equ $-l22
l23 db "          &#@ O                #################@",10
l23L equ $-l23
l24 db "          O                      ?##############=",10
l24L equ $-l24
l25 db "                                  ##############O",10
l25L equ $-l25
l26 db "                                 %##############@",10
l26L equ $-l26
l27 db "                                 ?#######=      &####=",10
l27L equ $-l27
l28 db "                                  =######?       &####&",10
l28L equ $-l28
l29 db "                                   ?#####         &###?",10
l29L equ $-l29
l30 db "                                    ####?         @###=",10
l30L equ $-l30
l31 db "                        =&#############=           &###=",10
l31L equ $-l31
l32 db "                     ==??############=              &###O",10
l32L equ $-l32
l33 db "                %&@@@##############%                 ?###@O",10
l33L equ $-l33
l34 db "                   ====?====                           O@####&O=",10
l34L equ $-l34
l35 db "                                                        ?%#####@%O=",10
l35L equ $-l35
l36 db "                                                            ?O%&####@&%O??=",10
l36L equ $-l36

hash db "#"
nl db 10

section .text

global _start

_start:

    mov ecx,l1
    mov edx,l1L
    call print

    mov ecx,l2
    mov edx,l2L
    call print

    mov ecx,l3
    mov edx,l3L
    call print

    mov ecx,l4
    mov edx,l4L
    call print

    mov ecx,l5
    mov edx,l5L
    call print

    mov ecx,l6
    mov edx,l6L
    call print

    mov ecx,l7
    mov edx,l7L
    call print

    mov ecx,l8
    mov edx,l8L
    call print

    mov ecx,l9
    mov edx,l9L
    call print

    mov ecx,l10
    mov edx,l10L
    call print

    mov ecx,l11
    mov edx,l11L
    call print

    mov ecx,l12
    mov edx,l12L
    call print

    mov ecx,l13
    mov edx,l13L
    call print

    mov ecx,l14
    mov edx,l14L
    call print

    mov ecx,l15
    mov edx,l15L
    call print

    mov ecx,l16
    mov edx,l16L
    call print

    mov ecx,l17
    mov edx,l17L
    call print

    mov ecx,l18
    mov edx,l18L
    call print

    mov ecx,l19
    mov edx,l19L
    call print

    mov ecx,l20
    mov edx,l20L
    call print

    mov ecx,l21
    mov edx,l21L
    call print

    mov ecx,l22
    mov edx,l22L
    call print

    mov ecx,l23
    mov edx,l23L
    call print

    mov ecx,l24
    mov edx,l24L
    call print

    mov ecx,l25
    mov edx,l25L
    call print

    mov ecx,l26
    mov edx,l26L
    call print

    mov ecx,l27
    mov edx,l27L
    call print

    mov ecx,l28
    mov edx,l28L
    call print

    mov ecx,l29
    mov edx,l29L
    call print

    mov ecx,l30
    mov edx,l30L
    call print

    mov ecx,l31
    mov edx,l31L
    call print

    mov ecx,l32
    mov edx,l32L
    call print

    mov ecx,l33
    mov edx,l33L
    call print

    mov ecx,l34
    mov edx,l34L
    call print

    mov ecx,l35
    mov edx,l35L
    call print

    mov ecx,l36
    mov edx,l36L
    call print

    mov esi,5

loop1:

    mov ecx,hash
    mov edx,1
    call print

    dec esi
    jnz loop1

    mov ecx,nl
    mov edx,1
    call print

    mov eax,1
    mov ebx,0
    int 0x80

print:

    mov eax,4
    mov ebx,1
    int 0x80
    ret