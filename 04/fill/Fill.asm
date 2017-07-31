// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Calculate last pixel address for the screen
@8191 // 32 registers in a row * 256 rows
D=A
@SCREEN
D=D+A
@last_pixel_addr
M=D

@CHECK_KEYBOARD_VAL
M;JMP

(CHECK_KEYBOARD_VAL)
  @KBD
  D=M
  @FILL_BLACK
  D;JNE
  @FILL_WHITE
  D;JEQ
  @CHECK_KEYBOARD_VAL
  M;JMP

(FILL_BLACK)
  @fill_value
  M=-1
  @FILL
  M;JMP

(FILL_WHITE)
  @fill_value
  M=0
  @FILL
  M;JMP

(FILL)
  @SCREEN
  D=A
  @addr
  M=D

  @LOOP
  M;JMP
  
  (LOOP)
    @last_pixel_addr
    D=M
    @addr
    D=D-M
    @CHECK_KEYBOARD_VAL
    D;JLT

    @fill_value
    D=M
    @addr
    A=M
    M=D
    @addr
    M=M+1
    @LOOP
    M;JMP