# strncpy.s: assy version of library strcpy function
#
#	My calling sequence based on standard library calling sequence:
#	char *mystrncpy(char *s, char *ct, int n);
#
#	caller must ensure array s is large enough to contain string ct
#	plus its null terminator
#
#	return value is a copy of pointer to s
 
       .text
       .globl  mystrncpy
mystrncpy:
	pushl	%ebp			# setup stack frame 
	movl	%esp, %ebp		
	movl	8(%ebp), %ecx		# get argument s
	movl	12(%ebp), %edx		# get argument ct
        movl    16(%ebp), %edi          # get argument n
loop:					# do 
        movb	(%edx), %al		# { move a byte from source
        movb	%al, (%ecx)		#   via al to destination
        incl	%ecx			#   increment to pointer
        incl	%edx			#   increment from pointer
        decl    %edi                    #   decrement number of byte moved n 
        cmpb    $0, %al			#   check for null terminator
 	jz      exit			#   jump if  byte moved was the terminator
        cmpl    $0, %edi                #   check to see if n=0
        jnz     loop                    # } while number of byte moved !=0

add_null: movb  $0, (%ecx)

exit: 	movl	8(%ebp), %eax		# then return address of s in %eax
 	movl	%ebp, %esp		# remove stack frame
	popl	%ebp
 	ret
        .end


