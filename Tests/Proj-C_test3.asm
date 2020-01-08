
.data

.text

main:
addi  $1,  $0,  1		
la $t1, 0xFFFFFFF0
sw $t3, ($t1)
lw $4, ($t1)
add $1, $4, $4
lw $t5, ($t1)
lui  $5,  5		
addi  $2,  $0,  -6		
addi $2, $2, 8	
addiu  $9,  $0,  9		
addiu  $10, $9,  10		
add	 $11, $1,  $6		
addu	 $20, $11,  $4		
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
sll  $20, $20,  7		
srl  $21, $2,  6	
srl $2, $21, 8	
sra  $8, $8,  15		
sllv $6,$20,$10
srlv $11,$11,$6
srav $12,$1,$10
sra  $9, $9,  5		
subu $3,$3,$2
addi $4,$0,1
addi $5, $0, 1
sltu $6,$4,$2
slt  $10,$1,$2
bne $4, $5, exit
sltu $3,$4,$1
j skip 
	
skip:
	beq $4 $5 skip2
	
skip2:
	jal fun
	ori $s3 $0 0x1234
	ori $s4 $0 0x1234
	j exit

fun:
	ori $s2 $0 0x1234
	jr $ra
	
exit:

addi  $2,  $0,  10              # Place "10" in $v0 to signal an "exit" or "halt"
syscall                         # Actually cause the halt
