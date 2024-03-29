.data
	userInput: .space 1001
	output: .asciiz "\n"
	notvalid: .asciiz "Invalid input"
.text
    main:
    #Lets user input string
      li $v0, 8
.data
	userInput: .space 1001
	output: .asciiz "\n"
	notvalid: .asciiz "Invalid input"
.text
    main:
    #Lets user input string
      li $v0, 8
      la $a0, userInput
      li $a1, 1001
      syscall
      jal start
      
      j finish
    before:
    #Loads address of inputted string into $t0
      la $t0, userInput
      add $t0,$t0,$t1
      lb $s0, ($t0)
      beq $s0, 0, end
      beq $s0, 9, jump
      beq $s0, 32, jump
      move $t6, $t1
      j while

    jump:
    #If tab or space jump to next character
      addi $t1, $t1, 1
      j start
	
    while:
    #During the program
      li $t7, -1
      la $t0, userInput
      add $t0, $t0, $t1
      lb $s0, ($t0)
      bge $t2, 5, invalid
      bge $t3, 1, invalid
      addi $t1, $t1, 1
      j check
      
    check:
    #Checks character all characters of the string
      beq $s0, 9,  gap
      beq $s0, 32, gap
      
      beq $s0, 10, convert
      beq $s0, 0, convert
      
      ble $s0, 47, special
      
      ble $s0, 57, integer
      
      ble $s0, 64, special
      
      ble $s0, 84, integer
      
      ble $s0, 96, special
	
      ble $s0, 116, integer
      
      bge $s0, 117, special
      
    special:
	j invalid


    gap:
    #Accounts if there is gap in string
    addi $t3,$t3, -1
    j while			

    integer:	
      addi $t2, $t2, 1	
      mul $t3, $t3, $t7
      j while
	

    convert:
    #Converts ascii values
	la $t0, userInput
	add $t0,$t0,$t6
	lb $s0, ($t0)
	addi $t2,$t2, -1
	addi $t6, $t6, 1
	blt $t2, 0, done
	move $t8, $t2	
	ble $s0, 57, num
	ble $s0, 84, upper
	ble $s0, 116, lower

    num:
    #For numbers
      li $t5, 48
      sub $s0, $s0, $t5
      beq $t2, 0, combine
      li $t9, 30
      j exp
      
    upper:
    
    #For uppercase Ascii
      li $t5, 55
      sub $s0, $s0, $t5
      beq $t2, 0, combine
      li $t9, 30
      j exp
      ial
      
