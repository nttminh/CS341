#  count.s: count the number of char's in a string
#  bob wilson
#
	.text
	.globl count
count:
	# enter (setup stack frame)
        pushl %ebp
	movl %esp, %ebp
	movl 8(%ebp), %ecx   # get address of string
	movl $0, %eax        # initialize count to zero
loop1:	
	movb (%ecx), %dl     # while (the character from the string
	cmpb $0, %dl         # is not the null terminator)
	jz done              # {   
	cmpb 12(%ebp), %dl   #   if the characters match
	jnz loop2            #   {
incr:	addl $1, %eax        #     increment count (label to find address)
loop2:	                     #   }
	incl %ecx            #   increment the pointer
	jmp loop1            # }
done:	
	# leave (remove stack frame)
        movl %ebp, %esp
	popl %ebp
	ret
	.end

