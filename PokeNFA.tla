------------------------------ MODULE PokeNFA ------------------------------

EXTENDS Naturals

\* CONSTANTS

POS == {0,1,2}
POS2 == POS \times POS
DIR == {"Left","Right","Up","Down"}

PatientX == 0
PatientY == 0

VARIABLES botX, botY, armDir


Init ==
  /\ botX = 2
  /\ botY = 2
  /\ armDir = "Left"

armPos[x \in POS, y \in POS, d \in DIR] ==
  IF d = "Left" THEN <<x-1,y>>
  ELSE IF d = "Right" THEN <<x+1,y>>
  ELSE IF d = "Up" THEN <<x,y+1>>
  ELSE <<x,y-1>>

Invariant ==  
 <<botX, botY>> \in POS2
\* /\ armPos[botX,botY,armDir] /= <<patientX,patientY>

armLeft[dir \in DIR] ==
  IF dir = "Up" THEN "Left"
  ELSE IF dir = "Left" THEN "Down"
  ELSE IF dir = "Down" THEN "Right"
  ELSE "Up" 

armRight[dir \in DIR] ==
  IF dir = "Up" THEN "Right"
  ELSE IF dir = "Right" THEN "Down"
  ELSE IF dir = "Down" THEN "Left"
  ELSE "Up" 

TurnLeft ==
  /\ armPos[botX,botY,armLeft[armDir]] /= <<PatientX,PatientY>>
  /\ armDir' = armLeft[armDir]
  /\ botX' = botX
  /\ botY' = botY
  
TurnRight ==
  /\ armDir' = armRight[armDir]
  /\ armPos[botX,botY,armRight[armDir]] /= <<PatientX,PatientY>>
  /\ botX' = botX
  /\ botY' = botY
  
MoveLeft ==
  /\ <<botX-1, botY>> \in POS2
  /\ armPos[botX-1,botY,armDir] /= <<PatientX,PatientY>>
  /\ botX' = botX - 1
  /\ botY' = botY
  /\ armDir' = armDir

MoveRight ==
  /\ <<botX+1, botY>> \in POS2
  /\ armPos[botX+1,botY,armDir] /= <<PatientX,PatientY>>
  /\ botX' = botX + 1
  /\ botY' = botY
  /\ armDir' = armDir

MoveUp ==
  /\ <<botX, botY+1>> \in POS2
  /\ armPos[botX,botY+1,armDir] /= <<PatientX,PatientY>>
  /\ botX' = botX 
  /\ botY' = botY + 1
  /\ armDir' = armDir

MoveDown ==
  /\ <<botX, botY-1>> \in POS2
  /\ armPos[botX,botY-1,armDir] /= <<PatientX,PatientY>>
  /\ botX' = botX 
  /\ botY' = botY - 1
  /\ armDir' = armDir

Next ==
  /\ Invariant
  /\ \/ MoveLeft
     \/ MoveRight
     \/ MoveUp
     \/ MoveDown
     \/ TurnLeft
     \/ TurnRight
 
Spec == Init /\ [][Next]_<<botX,botY,armDir>>

=============================================================================
\* Modification History
\* Last modified Thu Feb 02 11:06:26 EST 2023 by ryan
\* Created Thu Feb 02 11:04:59 EST 2023 by ryan
