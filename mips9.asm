.data
print1:  .asciiz"\nMat1:"
.align   2
newline: .asciiz"\n"
space:   .asciiz" "
print2:  .asciiz"\nMat2:"
.align   2
print3:  .asciiz"\nMat3:"
.align   2
matrix1: .space 262140
           # for storing arrays of 65535
matrix2: .space 262140
                  # for arrays of size 65535
matrix3: .space 262140
.text

.globl main
main:
li $s0,1
li $t1, 0
L1:
        li $t4,6
       li $s0,2
        
        li $t2, 0  # j = 0
        la $a0,  newline     
        li $v0, 4
        syscall 

        loop1:
            mul $t3, $t1, $s0  # i * n
            add $t3, $t1, $t2  # i * n + j
            sll $t3, $t3, 2    # 4 * (i * n + j)

            sw  $t4, matrix1($t3)

            add $a0, $t4, $zero
            li  $v0, 1
            syscall
            la  $a0, space      
            li  $v0, 4
            syscall

            add $t2, $t2, 1
              
            bne $t2, $s0, loop1

        add $t1, $t1, 1
        bne $t1, $s0, L1

    la $a0, print1
    li $v0, 4
    syscall
li $t4,0
    #li $t4, 17
    #li $t1, 0      # i = 0
   li $t1, 0
L2:
 li $t4,4
       li $s0,2
        
        li $t2, 0  # j = 0
        la $a0,  newline     
        li $v0, 4
        syscall 

        loop2:
            mul $t3, $t1, $s0  # i * n
            add $t3, $t1, $t2  # i * n + j
            sll $t3, $t3, 2    # 4 * (i * n + j)

        
            sw  $t4, matrix2($t3)

            add $a0, $t4, $zero
            li  $v0, 1
            syscall
            la  $a0, space      
            li  $v0, 4
            syscall

            add $t2, $t2, 1
              
            bne $t2, $s0, loop2

        add $t1, $t1, 1
        bne $t1, $s0, L2

    li $t4,0

 li $t1, 0           # i = 0
    K1: 
        li $t2, 0       # j = 0
     
         K2: 
          add $s1, $zero, $zero
      add $t5, $zero, $zero
      add $t4, $zero, $zero
      add $t3, $zero, $zero
            li  $t3, 0  # k = 0
            

            inner:
                mul $s3, $t1, $s0  # i * n
                add $s4, $s3, $t2  # i * n + k
                sll $s4, $s4, 2    # 4 * (i * n + k)
                lw   $t4, matrix1($s4)
                
                mul $s3, $t2, $s0  # k * n
                add $s4, $s3, $t1  # k * n + j
                sll $s4, $s4, 2    # 4 * (k * n + j)
              
            
                lw $t5, matrix2($s4)
                
                
                mul $t6, $t4, $t5  # x[i][k] * y[k][j]
                add $s1, $s1, $t6  # z[i][j] = z[i][j] + x[i][k] * y[k][j]
                
                add $t3, $t3, 1
                bne $t3, $s0, inner

            mul $s3, $t1, $s0  #i*n
            add $s4, $s3, $t2 #i*n+j
            sll $s4, $s4, 2   #4*(i*n+j)
            sw  $s1, matrix3($s4)
           
            add $t2, $t2, 1  #j=j+1
            bne $t2, $s0, K2 #test loop condition

        add $t1, $t1, 1  #i=i+1
        bne $t1, $s0, K1 #test loop condition

    la $a0, print3
    li $v0, 4
    syscall
     li $t1, 0
 L3:  li $t2, 0  #j=0
        la $a0,  newline     
        li $v0, 4
        syscall 

        loop3:
            mul $t3, $t1, $s0  # i * n
            add $t3, $t1, $t2  # i * n + j
            sll $t3, $t3, 2    # 4 * (i * n + j)
            lw  $t4, matrix3($t3)
            add $a0, $t4, $zero
            li  $v0, 1
            syscall
            la  $a0,  space      
            li  $v0, 4
            syscall
            add $t2, $t2, 1
           bne $t2, $s0, loop3

        add $t1, $t1, 1
        bne $t1, $s0, L3

    li $v0, 10
    syscall
