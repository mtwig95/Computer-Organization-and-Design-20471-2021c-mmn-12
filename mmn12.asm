# Author:	Maytal Twig
# Date:		Aug 9, 2021
# Description:	Get words from user and print some word analysis.

        .data
	prompt:   .asciiz "Please enter some words: "      # filename for output
	userInput: .space 81 #space for input string
	longestWord: .space 81 #space for the longest word 
	shortestWord: .space 81 #space for the shortest word 
	yes: .ascii  " yesss"
	numWord: .asciiz "\nNumber of words = "
	numLong: .asciiz "\nLetters in longest word = "
	numShort: .asciiz "\nLetters in shortest word = "
	diff: .asciiz "\nDifference = "
	total: .asciiz "\nTotal number of letters = "
	longest: .asciiz "\nThe longest word = "
	shortest: .asciiz "\nThe shortest word ="
	exit: .asciiz "\nEXIT!"
	spcaee: .asciiz "\nSPACE!!!"
	blankSpace: .ascii  " "

.text
    main:
    	#Prompt the user to enter some words
        li $v0, 4
        la $a0, prompt
        syscall   
        
   	#Get the user input
        li $v0, 8
        la $t0, userInput
        li $a1, 81
        syscall
        
        addi $sp,$sp,-28 # make room on stack for 7 registers
	sw $ra,24($sp) # save $ra on stack
	sw $s5,20($sp) # save $s3 on stack
	sw $s4,16($sp) # save $s3 on stack
	sw $s3,12($sp) # save $s3 on stack
	sw $s2, 8($sp) # save $s2 on stack
	sw $s1, 4($sp) # save $s1 on stack
	sw $s0, 0($sp) # save $s0 on stack
	
        #reg S2- store the sum of char in the longest word
	#reg S3- store the sum of char in the shortest word
	#reg S4- store the longest word
	#reg S5- store the shortest word
	#reg t4- store the sum of char and than current word
	#reg t5- store the sum of current word
	#reg t6- store the sum of total char at string
	#reg t5- store the num of words
	
	
	#loop pass all the string until end of string
loop:
	lb $t1,($t0)
	beqz $t1,exit_loop # if NULL, we are done
	
	#check if the char legal -> ask for new input (main)
	#legal: 2 space togethe, i char at least, string not end with space
	
	#If char is space->	
	li $a2, 0x20 
        beq $t1, $a2, new_word
	#else	
	jal next_char
	sb $t1,($t0)
	
next_char:
        #If char is not space->
	#t3+1, t4+1
	addi $t3, $zero , 4
	addi $t4, $zero , 4
	
	addiu $t0,$t0,1 # increment pointer
	j loop
	
	
   
       
new_word:
  	#found space
        li $v0, 4
        la $a0, spcaee
        syscall   
        
           
exit_loop:
	li $v0,10 # exit

	syscall

	#diplay output num of words - 	#reg t5
        li $v0, 4
        la $a0 ,numWord
        syscall 
        la $t0, ($t5)
        
        #diplay output num of words - 	#reg t5
        li $v0, 4
        la $a0 ,numWord
        syscall 
        la $t0, userInput
                
        #diplay output Letters in longest word - reg S2- 
        li $v0, 4
        la $a0 ,numLong
        syscall 
        la $t0, userInput
        
        #diplay output Letters in shortest word - reg S3- 
        li $v0, 4
        la $a0 ,numShort
        syscall 
        la $t0, userInput
        
        #diplay output Difference - (reg s2-reg s3)
        li $v0, 4
        la $a0 ,diff
        syscall 
        la $t0, userInput
                       
        #diplay output longest word - from reg S2 loop (s2) times
        li $v0, 4
        la $a0 ,longest
        syscall 
        la $t0, longestWord
        
        
        #diplay output shortest word - from reg S3 loop (s3) times
        li $v0, 4
        la $a0 ,shortest
        syscall 
        la $t0, shortestWord
        
        #diplay output - Total number of letters - reg t4- store the sum of tOTAL CHAR at string
        li $v0, 4
        la $a0 ,total
        syscall 
        la $t0, userInput
