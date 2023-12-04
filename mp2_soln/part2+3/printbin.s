#printbin.s:	 printbin routine that takes a parameter (called from C)
# (printbinc.c is the C driver for this code)
.global printbin
.text
printbin: 
	# enter (setup stack frame)
	pushl %ebp			# setup stack frame (enter)
	movl %esp, %ebp

	movb 8(%ebp), %al		# Put value to display in al
	movl $string, %edx		# set up pointer to string
	call donibble			# Conv. to 4 ASCII bits and add
	movb $' ', (%edx)		# add a space to the string
	incl %edx			# and increment pointer
	call donibble			# Conv. to 4 ASCII bits and add
	movl $string, %eax		# set up return value in %eax

	movl %ebp, %esp			# remove stack frame (leave)
	popl %ebp
	ret				# return to C caller

# do one nibble: convert 4 msb of %al to 4 ascii digits and add to string
# assumptions:
# on first entry, original (unshifted) character is in %al
# on subsequent entry, previously shifted character remains in %al

donibble:
	movl $4, %ecx			# loop 4 times
loop0:
	shlb $1, %al			# shift msb bit to carry flag
	jc loop1			# if carry flag not set
	movb $'0', (%edx)		#    add ascii 0 to string
	jmp loop2			# else
loop1:
	movb $'1', (%edx)		#    add ascii 1 to string
loop2:
	incl %edx			# increment pointer to string
	loop loop0			# decrement, test, and branch back or
	ret				# return to caller

	.data
string:                                 # static storage for the return string
	.asciz "xxxx xxxx\n"            # each x will be overwritten by '0', '1', or ' '
