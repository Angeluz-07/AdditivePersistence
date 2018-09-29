	
	.data
msg01: .asciiz "Loading....\n"
msg02: .asciiz "Welcome Mr. Stark!\n"
msg03: .asciiz "Please, input a number : "
msg04: .asciiz "\nThe additive persistence is : "
arrow: .asciiz " --> "
CR:	   .asciiz "\n"
NT:    .asciiz "\nIt was a pleasure. Good Bye Mr. Stark..."

	.text
	.globl main
	
main:
	#just print my nice msg's
	li $v0, 4	
	la $a0,msg01
	syscall
	la $a0,msg02
	syscall
	la $a0,msg03
	syscall
	
	###Body of the program###	
	li $v0,5 #ask for a number and is stored in $v0	
	syscall
	
	move $s0,$v0 # $s0 contains the number to be processed
	li $s1,0 #Additive persistence, initial value		
	
while_main: 
	#Print the current value
	li $v0,1
	move $a0,$s0
	syscall
			
	#if from the beggining is less than 10, then END with p=0
	blt $s0,10, END #keep while $s0>=10 | exit when $s0<10	
	
	#Print the arrow
	li $v0,4
	la $a0,arrow
	syscall
	
	j Sumation
	
Sumation:
	li $t0,0 #current sumation
	li $t1,10 # $t1=10 just to use with div
	move $t2,$s0 #store the argument on $t2

while_sumation:		
	#keep while $t2>0 | exit when $t2<=0
	ble $t2,$zero,end_sumation		
	div $t2,$t1
	mflo $t2 #k=k/10
	mfhi $t3 #r=k%10
	add $t0,$t0,$t3 #s+=r
	j while_sumation	

end_sumation:	
	move $s0,$t0
	addi $s1,$s1,1 #increase the additive persistence
	j while_main
	
END:
	li $v0,4
	la $a0,msg04 #"The additive persistence is:"
	syscall 
	
	#show the final value, stored in $s1
	li $v0,1
	move $a0,$s1
	syscall
	
	#normal termination
	li $v0,4
	la $a0,NT
	syscall
		
	#exit
	li $v0,10
	syscall	