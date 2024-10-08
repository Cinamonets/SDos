rem Calculator Application (CALC.BAS)
rem A small calculator application.
rem Version 1.2.1
rem Made by SD
rem Made with MB++ framework 3.0b1

INCLUDE "MBPP.BAS"

START:
  CLS
  REM no interface
  $Z = "NOINT"
  rem enable animations (you may not want this on slow machines)
  $Y = "ENABLE"
  REM set the text colour and highlight (for the menu)
  C = 6
  H = 14
  REM set the box colour
  T = 4
  MOVE 30 13
  PRINT "Calculating..."
GOTO MAIN

MAIN:
  REM main menu
  $T = "Calculator"
  $5 = "Simple Calculations"
  $6 = "Advanced Maths"
  $7 = "Enable Animations"
  IF $Y = "ENABLE" THEN $7 = "Disable Animations"
  $8 = "Change Colour"
  $9 = "Exit"
  GOSUB MENUBOX
  IF V = 1 THEN GOSUB BASEMATH
  IF V = 2 THEN GOSUB ADVMATH
  IF V = 3 THEN GOSUB TOGGLEANI
  IF V = 4 THEN GOSUB COLCHANGE
  IF V = 5 THEN GOSUB ENDPROG
GOTO MAIN

COLCHANGE:
  $5 = "Input a new colour for outline"
  $6 = "Must be between 0-255."
  $E = "Invalid colour"
  V = 0
  GOSUB INPBOX
  IF V < 0 THEN GOTO ERRBOX
  IF V > 255 THEN GOTO ERRBOX
  T = V
RETURN
  
TOGGLEANI:
  IF $Y = "DISABLE" THEN GOTO TAE
  $Y = "DISABLE"
RETURN

TAE:
  $Y = "ENABLE"
RETURN

BASEMATH:
  REM set the menu title
  $T = "Simple Calculations"
  REM set items in the menu
  $5 = "Addition"
  $6 = "Subtraction"
  $7 = "Multiplication"
  $8 = "Division"
  $9 = "Back"
  REM call a menu
  GOSUB MENUBOX
  REM find out what they selected and gosub there
  IF V = 1 THEN GOSUB ADD
  IF V = 2 THEN GOSUB SUB
  IF V = 3 THEN GOSUB MUL
  IF V = 4 THEN GOSUB DIV
  REM if we used one of them then loop this menu
  IF V < 4 THEN GOTO BASEMATH
  REM if not (back was selected) clear the value of V and return
  V = 0
RETURN

ADD:
  REM INPBOX and DINBOX use V to choose between text and numerical input
  REM we want numerical
  V = 0
  REM set the title
  $T = "Addition"
  REM first input prompt
  $5 = "Input first number..."
  REM second input prompt
  $6 = "Input second number..."
  REM DINBOX is similar to INPBOX (Print text and asks for input) but
  REM it asks for two inputs rather than just one.
  GOSUB DINBOX
  REM do the actual calculation
  REM the first input is A and the second is B
  a = a + b
  REM prompt above first number
  $5 = "Answer is:"
  REM prompt about second
  REM this is set to a blank string so it won't print it (we only need one)
  $6 = ""
  REM call a number box to print our answer
  GOSUB NUMBOX
  REM back to main menu
RETURN

SUB:
  v = 0
  $T = "Subtraction"
  $5 = "Input number to subtract from..."
  $6 = "Input number to subtract..."
  GOSUB DINBOX
  A = A - B
  $5 = "Answer is:"
  $6 = ""
  GOSUB NUMBOX
RETURN

MUL:
  v = 0
  $T = "Multiplication"
  $5 = "Input first number..."
  $6 = "Input second number..."
  GOSUB DINBOX
  A = A * B
  $5 = "Answer is:"
  $6 = ""
  GOSUB NUMBOX
RETURN

DIV:
  v = 0
  $T = "Division"
  $5 = "Input number to be divided..."
  $6 = "Input number to divide by..."
  GOSUB DINBOX
  REM define error message
  REM if either number is zero then display an error message box
  $E = "Attempted to divide by zero!"
  IF A = 0 THEN GOTO ERRBOX
  IF B = 0 THEN GOTO ERRBOX
  D = A / B
  E = A % B
  A = D
  B = E
  $5 = "Answer is:"
  $6 = "Reminder is:"
  GOSUB NUMBOX
RETURN

ADVMATH:
  $T = "Advanced Maths"
  $5 = "Square/Cube Number"
  $6 = "Power"
  $7 = "Back"
  $8 = ""
  $9 = ""
  GOSUB MENUBOX
  IF V = 1 THEN GOSUB SQUARE
  IF V = 2 THEN GOSUB POWER
  IF V < 3 THEN GOTO ADVMATH
  V = 0
RETURN

SQUARE:
  $T = "Square/Cube Number"
  $5 = ""
  $6 = "Input a number to square and cube"
  V = 0
  GOSUB INPBOX
  A = V
  D = A
  A = A * D
  B = A * D
  $T = "Square/Cube Number"
  $5 = "Number Squared is:"
  $6 = "Number Cubed is:"
  GOSUB NUMBOX
RETURN

POWER:
  $T = "Power"
  $5 = "Input a number"
  $6 = "Input power to raise to"
  V = 0
  GOSUB DINBOX
  D = A
  IF B = 0 THEN A = 1
  IF B = 0 THEN GOTO POWERSKIP
  IF B = 1 THEN GOTO POWERSKIP
  DO
    A = A * D
    B = B - 1
  LOOP UNTIL B = 1
  POWERSKIP:
  $T = "Power"
  $5 = "Answer is:"
  $6 = ""
  GOSUB NUMBOX
RETURN
