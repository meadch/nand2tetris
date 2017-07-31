// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

@i
M=1
@sum
M=0
@LOOP
0;JMP
// Loop, adding R0 to sum until i = R1 times
(LOOP)
  // Break if i - R1 is greater than 0
  @i
  D=M
  @R1
  D=D-M
  @BREAK
  D;JGT
  // If not breaking, add 1 to i
  @i
  M=M+1

  // Now add R0 to sum
  @R0
  D=M
  @sum
  M=M+D
  @LOOP
  0;JMP

(BREAK)
  @sum
  D=M
  @R2
  M=D
  @END

(END)
@END
0;JMP