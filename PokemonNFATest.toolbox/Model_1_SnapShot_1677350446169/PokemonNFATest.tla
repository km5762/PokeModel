--------------------------- MODULE PokemonNFATest ---------------------------
EXTENDS Naturals, Reals, Integers, Sequences

\*healthOptions = x: x <= 100 /\ x >= 0 x \in NATURALS
\*CONSTANT health
\*ASSUME health \in Nat /\ health <= 100 /\ health >= 0

\*CONSTANT S1;
\*S1 SUBSET Nat;
\*S \in SUBSET Nat;
\*FilterExample == {x \in S1 : x*2 \in S2}

\*CONSTANTS S1
\*ASSUME /\ S1 \subseteq Nat

maxHealth == 100
healthOptions == {x \in Int : x <= maxHealth}
\*\A x \in S1 x <= 100 \*{0,50,100}
aliveHealths == {x \in Nat : x > 0 /\ x <= maxHealth}\*healthOptions - {0} \*{50,100}
healths == healthOptions \times healthOptions

actions == {"PlayerAttack", "EnemyAttack", "Idle"}

VARIABLES playerHealth, enemyHealth, playerTurn

attackDamage == 60


Init ==
  /\ playerHealth = maxHealth
  /\ enemyHealth = maxHealth
  /\ playerTurn = TRUE

Invariant ==  
 /\ <<playerHealth, enemyHealth>> \in healths
\* /\ \E x \in  {playerHealth, enemyHealth} : x \in aliveHealths

PlayerAttack == 
  /\ playerTurn
  /\ enemyHealth \in aliveHealths
  /\ <<playerHealth, enemyHealth - attackDamage>> \in healths
  /\ enemyHealth - attackDamage \in aliveHealths
  /\ \E x \in  {playerHealth, enemyHealth - attackDamage} : x \in aliveHealths \*Takes out 0,0 as a state
  /\ playerHealth' = playerHealth
  /\ enemyHealth' = enemyHealth - attackDamage
  /\ playerTurn' = FALSE

EnemyAttack == 
  /\ ~playerTurn
  /\ playerHealth \in aliveHealths
  /\ <<playerHealth - attackDamage, enemyHealth>> \in healths
  /\ playerHealth - attackDamage \in aliveHealths
  /\ \E x \in  {playerHealth - attackDamage, enemyHealth} : x \in aliveHealths \*Takes out 0,0 as a state
  /\ playerHealth' = playerHealth - attackDamage
  /\ enemyHealth' = enemyHealth
  /\ playerTurn' = TRUE
  
playerWin == 
    /\ playerTurn
    /\ ~(enemyHealth - attackDamage \in aliveHealths)
    /\ playerHealth \in aliveHealths

playerLose == 
    /\ ~playerTurn
    /\ ~(playerHealth - attackDamage \in aliveHealths)
    /\ enemyHealth \in aliveHealths

Next ==
  /\ Invariant
  /\ \/ PlayerAttack
     \/ EnemyAttack
 
Spec == Init /\ [][Next]_<<playerHealth, enemyHealth, playerTurn>>

=============================================================================
\* Modification History
\* Last modified Sat Feb 25 13:40:39 EST 2023 by Myles
\* Last modified Sat Feb 25 13:07:17 EST 2023 by Myles
\* Last modified Thu Feb 02 21:31:55 EST 2023 by ryan
\* Created Thu Feb 02 11:12:03 EST 2023 by ryan
