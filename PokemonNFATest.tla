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

VARIABLES playerHealth, enemyHealth, playerTurn, playerAttackDamage, playerAttack2Damage, playerBuffCount, playerHealCount, enemyAttackDamage, enemyAttack2Damage, enemyBuffCount, enemyHealCount

Init ==
  /\ playerHealth = maxHealth
  /\ enemyHealth = maxHealth
  /\ playerTurn = TRUE
  /\ playerAttackDamage = 10
  /\ playerAttack2Damage = 5
  /\ enemyAttackDamage = 10
  /\ enemyAttack2Damage = 5
  /\ playerBuffCount = 7
  /\ playerHealCount = 7
  /\ enemyBuffCount = 7
  /\ enemyHealCount = 7
  
Invariant ==  
 /\ <<playerHealth, enemyHealth>> \in healths
\* /\ \E x \in  {playerHealth, enemyHealth} : x \in aliveHealths

PlayerAttack == 
  /\ playerTurn
  /\ enemyHealth \in aliveHealths
  /\ <<playerHealth, enemyHealth - playerAttackDamage>> \in healths
  /\ enemyHealth - playerAttackDamage \in aliveHealths
  /\ \E x \in  {playerHealth, enemyHealth - playerAttackDamage} : x \in aliveHealths \*Takes out 0,0 as a state
  /\ playerHealth' = playerHealth
  /\ enemyHealth' = enemyHealth - playerAttackDamage
  /\ playerTurn' = FALSE
  /\ playerAttackDamage' = playerAttackDamage
  /\ playerAttack2Damage' = playerAttack2Damage
  /\ playerBuffCount' = playerBuffCount
  /\ playerHealCount' = playerHealCount
  /\ enemyAttackDamage' = enemyAttackDamage
  /\ enemyAttack2Damage' = enemyAttack2Damage
  /\ enemyBuffCount' = enemyBuffCount
  /\ enemyHealCount' = enemyHealCount
 
  
PlayerAttack2 == 
  /\ playerTurn
  /\ enemyHealth \in aliveHealths
  /\ <<playerHealth, enemyHealth - playerAttack2Damage>> \in healths
  /\ enemyHealth - playerAttack2Damage \in aliveHealths
  /\ \E x \in  {playerHealth, enemyHealth - playerAttack2Damage} : x \in aliveHealths \*Takes out 0,0 as a state
  /\ playerHealth' = playerHealth
  /\ enemyHealth' = enemyHealth - playerAttack2Damage
  /\ playerTurn' = FALSE
  /\ playerAttackDamage' = playerAttackDamage
  /\ playerAttack2Damage' = playerAttack2Damage
  /\ playerBuffCount' = playerBuffCount
  /\ playerHealCount' = playerHealCount
  /\ enemyAttackDamage' = enemyAttackDamage
  /\ enemyAttack2Damage' = enemyAttack2Damage
  /\ enemyBuffCount' = enemyBuffCount
  /\ enemyHealCount' = enemyHealCount
  
PlayerBuff == 
  /\ playerTurn
  /\ playerBuffCount > 0
  /\ enemyHealth \in aliveHealths
  /\ <<playerHealth, enemyHealth>> \in healths
  /\ \E x \in  {playerHealth, enemyHealth} : x \in aliveHealths \*Takes out 0,0 as a state
  /\ playerHealth' = playerHealth
  /\ enemyHealth' = enemyHealth
  /\ playerTurn' = FALSE
  /\ playerAttackDamage' = playerAttackDamage + 10
  /\ playerAttack2Damage' = playerAttack2Damage + 10
  /\ playerBuffCount' = playerBuffCount - 1
  /\ playerHealCount' = playerHealCount
  /\ enemyAttackDamage' = enemyAttackDamage
  /\ enemyAttack2Damage' = enemyAttack2Damage
  /\ enemyBuffCount' = enemyBuffCount
  /\ enemyHealCount' = enemyHealCount
  
PlayerHeal == 
  /\ playerTurn
  /\ playerHealCount > 0
  /\ playerHealth + 20 <= 100
  /\ enemyHealth \in aliveHealths
  /\ <<playerHealth, enemyHealth>> \in healths
  /\ \E x \in  {playerHealth, enemyHealth} : x \in aliveHealths \*Takes out 0,0 as a state
  /\ playerHealth' = playerHealth + 20
  /\ enemyHealth' = enemyHealth
  /\ playerTurn' = FALSE
  /\ playerAttackDamage' = playerAttackDamage
  /\ playerAttack2Damage' = playerAttack2Damage
  /\ playerBuffCount' = playerBuffCount
  /\ playerHealCount' = playerHealCount - 1
  /\ enemyAttackDamage' = enemyAttackDamage
  /\ enemyAttack2Damage' = enemyAttack2Damage
  /\ enemyBuffCount' = enemyBuffCount
  /\ enemyHealCount' = enemyHealCount

EnemyAttack == 
  /\ ~playerTurn
  /\ playerHealth \in aliveHealths
  /\ <<playerHealth - enemyAttackDamage, enemyHealth>> \in healths
  /\ playerHealth - enemyAttackDamage \in aliveHealths
  /\ \E x \in  {playerHealth - enemyAttackDamage, enemyHealth} : x \in aliveHealths \*Takes out 0,0 as a state
  /\ playerHealth' = playerHealth - enemyAttackDamage
  /\ enemyHealth' = enemyHealth
  /\ playerTurn' = TRUE
  /\ playerAttackDamage' = playerAttackDamage
  /\ playerAttack2Damage' = playerAttack2Damage
  /\ playerBuffCount' = playerBuffCount
  /\ playerHealCount' = playerHealCount
  /\ enemyAttackDamage' = enemyAttackDamage
  /\ enemyAttack2Damage' = enemyAttack2Damage
  /\ enemyBuffCount' = enemyBuffCount
  /\ enemyHealCount' = enemyHealCount
  
EnemyAttack2 == 
  /\ ~playerTurn
  /\ playerHealth \in aliveHealths
  /\ <<playerHealth - enemyAttack2Damage, enemyHealth>> \in healths
  /\ playerHealth - enemyAttack2Damage \in aliveHealths
  /\ \E x \in  {playerHealth - enemyAttack2Damage, enemyHealth} : x \in aliveHealths \*Takes out 0,0 as a state
  /\ playerHealth' = playerHealth - enemyAttack2Damage
  /\ enemyHealth' = enemyHealth
  /\ playerTurn' = TRUE
  /\ playerAttackDamage' = playerAttackDamage
  /\ playerAttack2Damage' = playerAttack2Damage
  /\ playerBuffCount' = playerBuffCount
  /\ playerHealCount' = playerHealCount
  /\ enemyAttackDamage' = enemyAttackDamage
  /\ enemyAttack2Damage' = enemyAttack2Damage
  /\ enemyBuffCount' = enemyBuffCount
  /\ enemyHealCount' = enemyHealCount
  
EnemyBuff == 
  /\ ~playerTurn
  /\ enemyBuffCount > 0
  /\ playerHealth \in aliveHealths
  /\ <<playerHealth, enemyHealth>> \in healths
  /\ playerHealth \in aliveHealths
  /\ \E x \in  {playerHealth, enemyHealth} : x \in aliveHealths \*Takes out 0,0 as a state
  /\ playerHealth' = playerHealth 
  /\ enemyHealth' = enemyHealth
  /\ playerTurn' = TRUE
  /\ playerAttackDamage' = playerAttackDamage
  /\ playerAttack2Damage' = playerAttack2Damage
  /\ playerBuffCount' = playerBuffCount
  /\ playerHealCount' = playerHealCount
  /\ enemyAttackDamage' = enemyAttackDamage + 10
  /\ enemyAttack2Damage' = enemyAttack2Damage + 10
  /\ enemyBuffCount' = enemyBuffCount - 1
  /\ enemyHealCount' = enemyHealCount
  
  
EnemyHeal == 
  /\ ~playerTurn
  /\ enemyHealCount > 0
  /\ enemyHealth + 20 <= 100
  /\ playerHealth \in aliveHealths
  /\ <<playerHealth, enemyHealth>> \in healths
  /\ playerHealth \in aliveHealths
  /\ \E x \in  {playerHealth, enemyHealth} : x \in aliveHealths \*Takes out 0,0 as a state
  /\ playerHealth' = playerHealth 
  /\ enemyHealth' = enemyHealth + 20
  /\ playerTurn' = TRUE
  /\ playerAttackDamage' = playerAttackDamage
  /\ playerAttack2Damage' = playerAttack2Damage
  /\ playerBuffCount' = playerBuffCount
  /\ playerHealCount' = playerHealCount
  /\ enemyAttackDamage' = enemyAttackDamage
  /\ enemyAttack2Damage' = enemyAttack2Damage
  /\ enemyBuffCount' = enemyBuffCount
  /\ enemyHealCount' = enemyHealCount - 1
  
playerWin == 
    /\ playerTurn
    /\ ~(enemyHealth - playerAttackDamage \in aliveHealths) \/ ~(enemyHealth - playerAttack2Damage \in aliveHealths)
    /\ playerHealth \in aliveHealths
    /\ playerHealth' = playerHealth
    /\ enemyHealth' = 0
    /\ playerTurn' = TRUE
    /\ playerAttackDamage' = playerAttackDamage
    /\ playerAttack2Damage' = playerAttack2Damage
    /\ playerBuffCount' = playerBuffCount
    /\ playerHealCount' = playerHealCount
    /\ enemyAttackDamage' = enemyAttackDamage
    /\ enemyAttack2Damage' = enemyAttack2Damage
    /\ enemyBuffCount' = enemyBuffCount
    /\ enemyHealCount' = enemyHealCount

playerLose == 
    /\ ~playerTurn
    /\ ~(playerHealth - enemyAttackDamage \in aliveHealths) \/ ~(enemyHealth - enemyAttack2Damage \in aliveHealths)
    /\ enemyHealth \in aliveHealths
    /\ playerHealth' = 0
    /\ enemyHealth' = enemyHealth
    /\ playerTurn' = FALSE
    /\ playerAttackDamage' = playerAttackDamage
    /\ playerAttack2Damage' = playerAttack2Damage
    /\ playerBuffCount' = playerBuffCount 
    /\ playerHealCount' = playerHealCount
    /\ enemyAttackDamage' = enemyAttackDamage
    /\ enemyAttack2Damage' = enemyAttack2Damage
    /\ enemyBuffCount' = enemyBuffCount
    /\ enemyHealCount' = enemyHealCount

Next ==
  /\ Invariant
  /\ \/ PlayerAttack
     \/ EnemyAttack
     \/ PlayerAttack2
     \/ EnemyAttack2
     \/ PlayerBuff
     \/ EnemyBuff
     \/ PlayerHeal
     \/ EnemyHeal
     \/ playerWin
     \/ playerLose
 
Spec == Init /\ [][Next]_<<playerHealth, enemyHealth, playerTurn, playerAttackDamage, playerAttack2Damage, playerBuffCount, playerHealCount, enemyAttackDamage, enemyAttack2Damage, enemyBuffCount, enemyHealCount>>

=============================================================================
\* Modification History
\* Last modified Sun Feb 26 13:21:44 EST 2023 by Myles
\* Last modified Sat Feb 25 13:07:17 EST 2023 by Myles
\* Last modified Thu Feb 02 21:31:55 EST 2023 by ryan
\* Created Thu Feb 02 11:12:03 EST 2023 by ryan
