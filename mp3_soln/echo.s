# echo.s: echo characters until receive escape character

# uart register and bit definitions needed (from serial.h)

	UART_RX 	= 0
	UART_TX 	= 0
	UART_LSR	= 5

	UART_LSR_THRE	= 0x20
	UART_LSR_DR	= 0x01

	.globl echo
	.text
echo:
	movl 4(%esp), %edx		# get the com port address
loop0:
	addl $UART_LSR, %edx		# point to line status port
loop1:
	inb (%dx), %al			# get dr for now
	andb $UART_LSR_DR, %al		# if dr
	jz loop1
	subl $UART_LSR, %edx		# point to data port
	inb (%dx), %al			# get the char which is ready
	cmpb 8(%esp), %al		# if char == escape
	jz end				# break, we are done
# no need to check thre since rx timing should prevent tx overrun
	outb %al, (%dx)			# echo the char
	jmp loop0			# and keep looping
end:
	ret
	.end