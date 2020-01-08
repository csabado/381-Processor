.data
N: .word 52,54,49,48,55,57 #4,6,1,0,7,9
.text
.globl main
main:
addi $t0, $zero, 0 # i
addi $t1, $zero, 0 # j
addi $t2, $zero, 6 # length
#la $a0,N #address of array
lui $a0,0x00001001 
addi $t6,$zero,-1 #print loop
#la $a1,N #print address
lui $a1,0x00001001 
j loopI
sll $zero, $zero, 0

loopO:
#addi $t3,$t2,-1 #length-1
addi $t0,$t0,1 #i++
addi $t1,$0,0  #j=0
#la $a0,N #load address N(0)
lui $a0,0x00001001 
sll $zero, $zero, 0
sll $zero, $zero, 0
slt $t3,$t0,$t2 #exit if i>=n
sll $zero, $zero, 0
sll $zero, $zero, 0
sll $zero, $zero, 0
sll $zero, $zero, 0
beq $t3,$zero, print
sll $zero, $zero, 0
j loopI
sll $zero, $zero, 0


#addi $s1, $s1, 1
#beq $s0, $s2, exit 
#addi $s0,$s0,5
#j loop

loopI:
#addi $t5,$t2,-1#length-1
#sub $t4,$t2,$t0#length-i
sll $zero, $zero, 0
slt $t5,$t1,$t2 #exit if j>=n-i
sll $zero, $zero, 0
sll $zero, $zero, 0
sll $zero, $zero, 0
sll $zero, $zero, 0
beq $t5,$zero, loopO
sll $zero, $zero, 0

lw $s0,0($a0)#first element in N
lw $s1,4($a0)#second element in N
sll $zero, $zero, 0
sll $zero, $zero, 0
sll $zero, $zero, 0
sll $zero, $zero, 0
slt $t5,$s0,$s1#N(1)<N(2)
sll $zero, $zero, 0
sll $zero, $zero, 0
sll $zero, $zero, 0
sll $zero, $zero, 0
beq $t5,$zero, swap
sll $zero, $zero, 0
addi $t1,$t1,1#j++
addi $a0,$a0,4#address++
j loopI
sll $zero, $zero, 0

swap:
sw $s0,4($a0)
sw $s1,0($a0)
j loopI
sll $zero, $zero, 0


print:
# Print output

lw $a0, 0($a1)
li $v0, 11
syscall
addi $t6,$t6,1
addi $a1,$a1,4
sll $zero, $zero, 0
sll $zero, $zero, 0
sll $zero, $zero, 0
beq $t6,$t2,exit
sll $zero, $zero, 0
j print
sll $zero, $zero, 0

exit:
li $v0, 10
syscall
