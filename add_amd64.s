//+build !noasm !appengine
// AUTO-GENERATED BY GOASMC -- DO NOT EDIT

TEXT ·SumFloat64(SB), $0-24

	MOVQ buf+0(FP), DI
	MOVQ l+8(FP), SI
	MOVQ res+16(FP), DX

	LONG $0x03c6f640         // test    sil, 3
	JNE  LBB0_9
	WORD $0x8548; BYTE $0xf6 // test    rsi, rsi
	JE   LBB0_2
	LONG $0xff468d4c         // lea    r8, [rsi - 1]
	WORD $0x8944; BYTE $0xc1 // mov    ecx, r8d
	WORD $0xe9c1; BYTE $0x02 // shr    ecx, 2
	WORD $0xc183; BYTE $0x01 // add    ecx, 1
	LONG $0x07e18348         // and    rcx, 7
	JE   LBB0_4
	WORD $0xf748; BYTE $0xd9 // neg    rcx
	LONG $0xc057fdc5         // vxorpd    ymm0, ymm0, ymm0
	WORD $0xc031             // xor    eax, eax

LBB0_6:
	LONG $0x0458fdc5; BYTE $0xc7 // vaddpd    ymm0, ymm0, yword [rdi + 8*rax]
	LONG $0x04c08348             // add    rax, 4
	LONG $0x01c18348             // add    rcx, 1
	JNE  LBB0_6
	JMP  LBB0_7

LBB0_2:
	LONG $0xc057fdc5 // vxorpd    ymm0, ymm0, ymm0
	JMP  LBB0_8

LBB0_4:
	WORD $0xc031     // xor    eax, eax
	LONG $0xc057fdc5 // vxorpd    ymm0, ymm0, ymm0

LBB0_7:
	LONG $0x1cf88349 // cmp    r8, 28
	JB   LBB0_8

LBB0_10:
	LONG $0x0458fdc5; BYTE $0xc7         // vaddpd    ymm0, ymm0, yword [rdi + 8*rax]
	LONG $0x4458fdc5; WORD $0x20c7       // vaddpd    ymm0, ymm0, yword [rdi + 8*rax + 32]
	LONG $0x4458fdc5; WORD $0x40c7       // vaddpd    ymm0, ymm0, yword [rdi + 8*rax + 64]
	LONG $0x4458fdc5; WORD $0x60c7       // vaddpd    ymm0, ymm0, yword [rdi + 8*rax + 96]
	QUAD $0x000080c78458fdc5; BYTE $0x00 // vaddpd    ymm0, ymm0, yword [rdi + 8*rax + 128]
	QUAD $0x0000a0c78458fdc5; BYTE $0x00 // vaddpd    ymm0, ymm0, yword [rdi + 8*rax + 160]
	QUAD $0x0000c0c78458fdc5; BYTE $0x00 // vaddpd    ymm0, ymm0, yword [rdi + 8*rax + 192]
	QUAD $0x0000e0c78458fdc5; BYTE $0x00 // vaddpd    ymm0, ymm0, yword [rdi + 8*rax + 224]
	LONG $0x20c08348                     // add    rax, 32
	WORD $0x3948; BYTE $0xf0             // cmp    rax, rsi
	JB   LBB0_10

LBB0_8:
	LONG $0xc07cfdc5               // vhaddpd    ymm0, ymm0, ymm0
	LONG $0x197de3c4; WORD $0x01c1 // vextractf128    xmm1, ymm0, 1
	LONG $0xc158fbc5               // vaddsd    xmm0, xmm0, xmm1
	LONG $0x0211fbc5               // vmovsd    qword [rdx], xmm0

LBB0_9:
	VZEROUPPER
	RET
