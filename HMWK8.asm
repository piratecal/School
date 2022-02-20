.ORIG x3000
      GETC 
      LD  R1, FOO
      ADD R1, R1, R0
      LEA R2, BAR
      ADD R0, R1, R2
      PUTS
      HALT
FOO   .FILL xFFD0
BAR   .STRINGZ "0123456789"
      .END