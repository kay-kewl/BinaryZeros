%include "io.inc"

;   eax         new numbers
;   ecx         counter
;   edx         i
;   ebx         pointer
;   esp         -
;   ebp         -
;   esi         new numbers
;   edi         N

section .bss
    stack       resd 1024 ; Stack to hold the numbers

section .text
global main
main:
    GET_DEC     4, edi ; N
    GET_DEC     4, ebx ; K
    cmp         ebx, 30
    jg          print_zero

    ; Build the first number that has exactly K zeros
    mov         eax, 1
    mov         cl, bl
    shl         eax, cl

    mov         ebx, stack ; stack_ptr
    mov         ecx, 0 ; counter

    cmp         eax, edi
    jg          end
    mov         [ebx], eax ; Push the number onto the stack
    add         ebx, 4

    ; Increase counter
    inc         ecx

next_number:
    mov         edx, 1 ; i

    ; Pop the number from the stack
    sub         ebx, 4

    ; Check if the stack is empty
    cmp         ebx, stack
    jb          end
    mov         eax, [ebx]

    ; Create new number
    mov         esi, eax
    shl         esi, 1
    add         esi, edx
    cmp         esi, edi
    jg          next_number

    ; Push the new number onto the stack
    mov         [ebx], esi
    add         ebx, 4
    inc         ecx

new_number:
    ; Create new number
    add         esi, edx
    cmp         esi, edi
    jg          next_number
    shl         edx, 1
    mov         eax, esi
    and         eax, edx
    cmp         eax, 0
    je          next_number

    ; Push the new number onto the stack
    mov         [ebx], esi
    add         ebx, 4
    inc         ecx

    jmp         new_number

print_zero:
    mov         ecx, 0

end:
    PRINT_DEC   4, ecx

    xor         eax, eax
    ret
