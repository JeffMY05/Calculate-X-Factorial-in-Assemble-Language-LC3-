; This program uses R0 to R5 registers in the following manner:
; R0 contains 0 (registers contain zero after reset)
; R1 contains multiplication result in each step to calculate the factorial
;    eg. 5*4,20*3,60*2,120*1
; R2 contains \-1
; R3 contains counter for outer loop
; R4 contains counter for inner loop
; R5 contains current sum

    .ORIG x3000
    LD    R1,INPUT            ; R1 contains input number 
    AND   R2,R2,#0            ; Clear R2 to zero
    ADD   R2,R2,#-1           ; R2 contains \-1           
    ADD   R3,R1,R2            ; Initialize the outer count (input number minus one)
    AND   R5,R5,#0            ; Initialize the current sum to zero

OUTERLOOP   ADD   R4,R3,R2    ; Copy the outer count to inner count and minus 1
INNERLOOP   ADD   R5,R5,R1    ; Increment the current sum by the previous step's multiplication result
    ADD   R4,R4,R2            ; Decrement inner count
    BRzp  INNERLOOP           ; Branch to inner loop if inner count
                              ;                         is positive or zero
    ADD   R1,R5,#0            ; R1 now contains sum result from inner loop 
    AND   R5,R5,#0            ; Clear R5 (previous sum) to 0
    ADD   R3,R3,R2            ; Decrement outer count
    BRp  OUTERLOOP            ; Branch to outer loop if outer count
                              ;                      is positive
    ST  R1,STORE              ; This address contains X\!
    TRAP x25
  
INPUT    .FILL  x0005        ; Input for X\!, in this case X = 5
STORE .BLKW x1
    .END
