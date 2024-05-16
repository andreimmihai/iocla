; SPDX-License-Identifier: BSD-3-Clause

section .text

global get_max

get_max:
	push ebp
	mov ebp, esp

	; save ebx in callee
	push ebx
	push esi

	; [ebp+8] is array pointer
	; [ebp+12] is array length
	; [epb+16] is pos pointer

	mov ebx, [ebp+8]
	mov ecx, [ebp+12]
	mov esi, [ebp+16]
	xor eax, eax
	xor edx, edx ; edx = max index
	xor edi, edi ; edi = current index

compare:
	; cmp eax, [ebx+ecx*4-4]
	; jge check_end
	; mov eax, [ebx+ecx*4-4]
	cmp edi, ecx
	jge check_end

	mov edx, [ebx + edi*4]
	cmp eax, edx
	jge skip_update

	mov eax, edx
	mov [esi], edi ; update max index

skip_update:
	inc edi
	jmp compare

check_end:
	;loopnz compare
	pop esi
	pop ebx

	leave
	ret
