--------------------------- MODULE PokemonNFATest ---------------------------
EXTENDS Naturals

\* CONSTANTS

\*healthOptions = x: x <= 100 /\ x >= 0 x \in NATURALS
\*CONSTANT health
\*ASSUME health \in Nat /\ health <= 100 /\ health >= 0

healthOptions == {0,50,100}
aliveHealths == {50,100}
healths == healthOptions \times healthOptions

\*POS == {0,1,2}
\*POS2 == POS \times POS
\*DIR == {"Left","Right","Up","Down"}

actions == {"PlayerAttack", "EnemyAttack", "Idle"}

\*PatientX == 0
\*PatientY == 0

\*startPlayerHealth == 100
\*startEnemyHealth == 100

\*VARIABLES botX, botY, armDir
VARIABLES playerHealth, enemyHealth


Init ==
\*  /\ botX = 2
  /\ playerHealth = 100
  /\ enemyHealth = 100
\*  /\ botY = 2
\*  /\ armDir = "Left"
\*
\*armPos[x \in POS, y \in POS, d \in DIR] ==
\*  IF d = "Left" THEN <<x-1,y>>
\*  ELSE IF d = "Right" THEN <<x+1,y>>
\*  ELSE IF d = "Up" THEN <<x,y+1>>
\*  ELSE <<x,y-1>>

Invariant ==  
 /\ <<playerHealth, enemyHealth>> \in healths
 /\ \E x \in  <<playerHealth, enemyHealth>> : x \in aliveHealths
\* /\ armPos[botX,botY,armDir] /= <<patientX,patientY>

\*armLeft[dir \in DIR] ==
\*  IF dir = "Up" THEN "Left"
\*  ELSE IF dir = "Left" THEN "Down"
\*  ELSE IF dir = "Down" THEN "Right"
\*  ELSE "Up" 
\*
\*armRight[dir \in DIR] ==
\*  IF dir = "Up" THEN "Right"
\*  ELSE IF dir = "Right" THEN "Down"
\*  ELSE IF dir = "Down" THEN "Left"
\*  ELSE "Up" 


PlayerAttack == 
  /\ <<playerHealth, enemyHealth - 50>> \in healths
\*  /\ \E x \in  <<playerHealth, enemyHealth - 50>> : x \in aliveHealths
  /\ playerHealth' = playerHealth
  /\ enemyHealth' = enemyHealth - 50

EnemyAttack == 
  /\ <<playerHealth - 50, enemyHealth>> \in healths
\*  /\ \E x \in  <<playerHealth- 50, enemyHealth>> : x \in aliveHealths
  /\ playerHealth' = playerHealth - 50
  /\ enemyHealth' = enemyHealth

Idle == 
  /\ <<playerHealth, enemyHealth>> \in healths
  /\ playerHealth' = playerHealth
  /\ enemyHealth' = enemyHealth


\*TurnLeft ==
\*  /\ armPos[botX,botY,armLeft[armDir]] /= <<PatientX,PatientY>>
\*  /\ armDir' = armLeft[armDir]
\*  /\ botX' = botX
\*  /\ botY' = botY
\*  
\*TurnRight ==
\*  /\ armDir' = armRight[armDir]
\*  /\ armPos[botX,botY,armRight[armDir]] /= <<PatientX,PatientY>>
\*  /\ botX' = botX
\*  /\ botY' = botY
\*  
\*MoveLeft ==
\*  /\ <<botX-1, botY>> \in POS2
\*  /\ armPos[botX-1,botY,armDir] /= <<PatientX,PatientY>>
\*  /\ botX' = botX - 1
\*  /\ botY' = botY
\*  /\ armDir' = armDir
\*
\*MoveRight ==
\*  /\ <<botX+1, botY>> \in POS2
\*  /\ armPos[botX+1,botY,armDir] /= <<PatientX,PatientY>>
\*  /\ botX' = botX + 1
\*  /\ botY' = botY
\*  /\ armDir' = armDir
\*
\*MoveUp ==
\*  /\ <<botX, botY+1>> \in POS2
\*  /\ armPos[botX,botY+1,armDir] /= <<PatientX,PatientY>>
\*  /\ botX' = botX 
\*  /\ botY' = botY + 1
\*  /\ armDir' = armDir
\*
\*MoveDown ==
\*  /\ <<botX, botY-1>> \in POS2
\*  /\ armPos[botX,botY-1,armDir] /= <<PatientX,PatientY>>
\*  /\ botX' = botX 
\*  /\ botY' = botY - 1
\*  /\ armDir' = armDir

Next ==
  /\ Invariant
  /\ \/ PlayerAttack
     \/ EnemyAttack
     \/ Idle
 
Spec == Init /\ [][Next]_<<playerHealth, enemyHealth>>

=============================================================================
\* Modification History
\* Last modified Thu Feb 02 11:34:03 EST 2023 by ryan
\* Created Thu Feb 02 11:12:03 EST 2023 by ryan
