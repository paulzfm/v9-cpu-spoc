root/usr/os/os0.c  1: // os0.c -- simple timer isr test
root/usr/os/os0.c  2: 
root/usr/os/os0.c  3: #include <u.h>
root/lib/u.h  1: // u.h
root/lib/u.h  2: 
root/lib/u.h  3: // instruction set
root/lib/u.h  4: enum {
root/lib/u.h  5:   HALT,ENT ,LEV ,JMP ,JMPI,JSR ,JSRA,LEA ,LEAG,CYC ,MCPY,MCMP,MCHR,MSET, // system
root/lib/u.h  6:   LL  ,LLS ,LLH ,LLC ,LLB ,LLD ,LLF ,LG  ,LGS ,LGH ,LGC ,LGB ,LGD ,LGF , // load a
root/lib/u.h  7:   LX  ,LXS ,LXH ,LXC ,LXB ,LXD ,LXF ,LI  ,LHI ,LIF ,
root/lib/u.h  8:   LBL ,LBLS,LBLH,LBLC,LBLB,LBLD,LBLF,LBG ,LBGS,LBGH,LBGC,LBGB,LBGD,LBGF, // load b
root/lib/u.h  9:   LBX ,LBXS,LBXH,LBXC,LBXB,LBXD,LBXF,LBI ,LBHI,LBIF,LBA ,LBAD,
root/lib/u.h  10:   SL  ,SLH ,SLB ,SLD ,SLF ,SG  ,SGH ,SGB ,SGD ,SGF ,                     // store
root/lib/u.h  11:   SX  ,SXH ,SXB ,SXD ,SXF ,
root/lib/u.h  12:   ADDF,SUBF,MULF,DIVF,                                                   // arithmetic
root/lib/u.h  13:   ADD ,ADDI,ADDL,SUB ,SUBI,SUBL,MUL ,MULI,MULL,DIV ,DIVI,DIVL,
root/lib/u.h  14:   DVU ,DVUI,DVUL,MOD ,MODI,MODL,MDU ,MDUI,MDUL,AND ,ANDI,ANDL,
root/lib/u.h  15:   OR  ,ORI ,ORL ,XOR ,XORI,XORL,SHL ,SHLI,SHLL,SHR ,SHRI,SHRL,
root/lib/u.h  16:   SRU ,SRUI,SRUL,EQ  ,EQF ,NE  ,NEF ,LT  ,LTU ,LTF ,GE  ,GEU ,GEF ,      // logical
root/lib/u.h  17:   BZ  ,BZF ,BNZ ,BNZF,BE  ,BEF ,BNE ,BNEF,BLT ,BLTU,BLTF,BGE ,BGEU,BGEF, // conditional
root/lib/u.h  18:   CID ,CUD ,CDI ,CDU ,                                                   // conversion
root/lib/u.h  19:   CLI ,STI ,RTI ,BIN ,BOUT,NOP ,SSP ,PSHA,PSHI,PSHF,PSHB,POPB,POPF,POPA, // misc
root/lib/u.h  20:   IVEC,PDIR,SPAG,TIME,LVAD,TRAP,LUSP,SUSP,LCL ,LCA ,PSHC,POPC,MSIZ,
root/lib/u.h  21:   PSHG,POPG,NET1,NET2,NET3,NET4,NET5,NET6,NET7,NET8,NET9,
root/lib/u.h  22:   POW ,ATN2,FABS,ATAN,LOG ,LOGT,EXP ,FLOR,CEIL,HYPO,SIN ,COS ,TAN ,ASIN, // math
root/lib/u.h  23:   ACOS,SINH,COSH,TANH,SQRT,FMOD,
root/lib/u.h  24:   IDLE
root/lib/u.h  25: };
root/lib/u.h  26: 
root/lib/u.h  27: // system calls
root/lib/u.h  28: enum {
root/lib/u.h  29:   S_fork=1, S_exit,   S_wait,   S_pipe,   S_write,  S_read,   S_close,  S_kill,
root/lib/u.h  30:   S_exec,   S_open,   S_mknod,  S_unlink, S_fstat,  S_link,   S_mkdir,  S_chdir,
root/lib/u.h  31:   S_dup2,   S_getpid, S_sbrk,   S_sleep,  S_uptime, S_lseek,  S_mount,  S_umount,
root/lib/u.h  32:   S_socket, S_bind,   S_listen, S_poll,   S_accept, S_connect, 
root/lib/u.h  33: };
root/lib/u.h  34: 
root/lib/u.h  35: typedef unsigned char uchar;
root/lib/u.h  36: typedef unsigned short ushort;
root/lib/u.h  37: typedef unsigned int uint;
root/lib/u.h  38: 
root/usr/os/os0.c  4: 
root/usr/os/os0.c  5: int current;
root/usr/os/os0.c  6: 
root/usr/os/os0.c  7: out(port, val)  { asm(LL,8); asm(LBL,16); asm(BOUT); } // output a char
00000000  0000080e  LL    0x8 (D 8)		// a = val
00000004  00001026  LBL   0x10 (D 16)	// b = port
00000008  0000009a  BOUT				// print
root/usr/os/os0.c  8: ivec(void *isr) { asm(LL,8); asm(IVEC); } // set interrupt vector
0000000c  00000002  LEV   0x0 (D 0)
00000010  0000080e  LL    0x8 (D 8)
00000014  000000a4  IVEC
root/usr/os/os0.c  9: stmr(int val)   { asm(LL,8); asm(TIME); }		// set timeout
00000018  00000002  LEV   0x0 (D 0)
0000001c  0000080e  LL    0x8 (D 8)		
00000020  000000a7  TIME 				
root/usr/os/os0.c  10: halt(val)       { asm(LL,8); asm(HALT); }	// halt system
00000024  00000002  LEV   0x0 (D 0)
00000028  0000080e  LL    0x8 (D 8)
0000002c  00000000  HALT
root/usr/os/os0.c  11: 
root/usr/os/os0.c  12: alltraps()
00000030  00000002  LEV   0x0 (D 0)
root/usr/os/os0.c  13: {
root/usr/os/os0.c  14:   asm(PSHA);
00000034  0000009d  PSHA	// sp -= 8, *sp = a (push a)
root/usr/os/os0.c  15:   asm(PSHB);
00000038  000000a0  PSHB	// sp -= 8, *sp = b (push b)
root/usr/os/os0.c  16: 
root/usr/os/os0.c  17:   current++;
0000003c  00000015  LG    0x0 (D 0)
00000040  ffffff57  SUBI  0xffffffff (D -1)
00000044  00000045  SG    0x0 (D 0)
root/usr/os/os0.c  18: 
root/usr/os/os0.c  19:   asm(POPB);
00000048  000000a1  POPB	// b = *sp, sp += 8 (pop b)
root/usr/os/os0.c  20:   asm(POPA);
0000004c  000000a3  POPA	// a = *sp, sp += 8 (pop a)
root/usr/os/os0.c  21:   asm(RTI);
00000050  00000098  RTI 	// return from interrupt
root/usr/os/os0.c  22: }
root/usr/os/os0.c  23: 
root/usr/os/os0.c  24: main()
00000054  00000002  LEV   0x0 (D 0)
root/usr/os/os0.c  25: {
root/usr/os/os0.c  26:   current = 0;
00000058  00000023  LI    0x0 (D 0)
0000005c  00000045  SG    0x0 (D 0)
root/usr/os/os0.c  27: 
root/usr/os/os0.c  28:   stmr(1000);
00000060  0003e89e  PSHI  0x3e8 (D 1000)
00000064  ffffb405  JSR   0xffffffb4 (TO 0x1c)
00000068  00000801  ENT   0x8 (D 8)
root/usr/os/os0.c  29:   ivec(alltraps);
0000006c  ffffc408  LEAG  0xffffffc4 (D -60)
00000070  0000009d  PSHA
00000074  ffff9805  JSR   0xffffff98 (TO 0x10)
00000078  00000801  ENT   0x8 (D 8)
root/usr/os/os0.c  30:   
root/usr/os/os0.c  31:   asm(STI);
0000007c  00000097  STI 
root/usr/os/os0.c  32:   
root/usr/os/os0.c  33:   while (current < 10) {
00000080  00000003  JMP   <fwd>
root/usr/os/os0.c  34:     if (current & 1) out(1, '1'); else out(1, '0'); // output the lowest bit of current
00000084  00000015  LG    0x0 (D 0)
00000088  00000169  ANDI  0x1 (D 1)
0000008c  00000084  BZ    <fwd>
00000090  0000319e  PSHI  0x31 (D 49)
00000094  0000019e  PSHI  0x1 (D 1)
00000098  ffff6405  JSR   0xffffff64 (TO 0x0)
0000009c  00001001  ENT   0x10 (D 16)
000000a0  00000003  JMP   <fwd>
000000a4  0000309e  PSHI  0x30 (D 48)
000000a8  0000019e  PSHI  0x1 (D 1)
000000ac  ffff5005  JSR   0xffffff50 (TO 0x0)
000000b0  00001001  ENT   0x10 (D 16)
root/usr/os/os0.c  35:   }
root/usr/os/os0.c  36: 
root/usr/os/os0.c  37:   halt(0);
000000b4  00000015  LG    0x0 (D 0)
000000b8  00000a3b  LBI   0xa (D 10)
000000bc  0000008c  BLT   <fwd>
000000c0  0000009e  PSHI  0x0 (D 0)
000000c4  ffff6005  JSR   0xffffff60 (TO 0x28)
000000c8  00000801  ENT   0x8 (D 8)
root/usr/os/os0.c  38: }
root/usr/os/os0.c  39: 
000000cc  00000002  LEV   0x0 (D 0)
