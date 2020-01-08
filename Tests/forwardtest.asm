
.data

.text
addi $1, $0, 3
add $4, $1, $zero
add $5, $zero, $1
add $6, $1, $zero
bne $6, $1, skip

skip:
addi $7, $0, 3
beq $7, $1, exit


exit:
addi  $2,  $0,  10              # Place "10" in $v0 to signal an "exit" or "halt"
syscall  
