bits 32

section .text
global _AddFour

_AddFour:
        push ebp
        mov ebp, esp

        mov eax, [ebp + 8]
        add eax, 4

        mov esp, ebp
        pop ebp
        ret
