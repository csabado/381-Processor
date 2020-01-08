
.data

.text
main:
addi  $1,  $0,  1		
la $t1, 0xFFFF0010
sll $0, $0, 0
sll $0, $0, 0
sll $0, $0, 0
sll $0, $0, 0
sw $t3, ($t1)
lw $t4, ($t1)
lui  $5,  5		
addi  $2,  $0,  -6		
addi  $7,  $0,  -7		
addi  $8,  $0,  -8		
addiu  $9,  $0,  9		
addiu  $10, $0,  10		
add	 $11, $1,  $6		
addu	 $20, $1,  $4		
and 	 $13, $12, $4		
lui $1, 0x1000       
andi	 $14, $2, 5		
xor 	 $16, $15, $7		
xori   $17, $3, 8		
or 	 $2, $10, $9		
ori   $19, $18, 10 	
nor   $15, $1, $6		
slt 	 $21, $1, $20	 	
slti  $9, $9, 10
sll  $20, $8,  7		
srl  $21, $2,  6		
sra  $8, $8,  15		
sllv $6,$6,$10
srlv $11,$11,$10
srav $12,$1,$10
sra  $9, $9,  5		
subu $3,$3,$2
addi $4,$0,1
addi $5, $0, 1
sltu $6,$1,$2
slt  $10,$1,$2
bne $4, $5, exit
sll $0, $0, 0
sltu $3,$4,$1
j skip 
sll $0, $0, 0
	
skip:
	beq $4 $5 skip2
	sll $0, $0, 0
	
skip2:
	jal fun
	sll $0, $0, 0
	ori $s3 $0 0x1234
	ori $s4 $0 0x1234
	j exit
	sll $0, $0, 0

fun:
	ori $s2 $0 0x1234
	jr $ra
	sll $0, $0, 0
	
exit:

addi  $2,  $0,  10              # Place "10" in $v0 to signal an "exit" or "halt"
syscall                         # Actually cause the halt
