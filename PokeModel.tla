---------------------------- MODULE PokeModel ----------------------------

EXTENDS Naturals, Reals, Integers, Sequences

VARIABLE str

\*a = player attack, b = enemy attack, c = do nothing

CONSTANT myStr


maxHealth == 100

healthOptions == {x \in Int : x <= maxHealth}
aliveHealths == {x \in Nat : x > 0 /\ x <= maxHealth}
healths == healthOptions \times healthOptions

\*actions == {"PlayerAttack", "EnemyAttack", "Idle", "Player Heal", "Enemy Heal", player attack 2, Enemy attack 2s, Player buff attack, Enemy buff attack}
\*                    a             b           c         d               e            f                g                 h                  i

VARIABLES playerHealth, enemyHealth

playerAttackDamage == 60
playerAttack2Damage == 30
playerAttackModifier == 0

enemyAttackDamage == 60
enemyAttack2Damage == 30
enemyAttackModifier == 0

healAmmount == 20

\* Describe initial state
Init == 
    /\ str  = myStr
    /\ playerHealth = maxHealth
    /\ enemyHealth = maxHealth

playerHealthChange[health \in Int, a \in STRING] == 
    IF      a = "b" THEN health - (enemyAttackDamage + enemyAttackModifier)
    ELSE IF a = "d" THEN health + healAmmount
    ELSE IF a = "g" THEN health - (enemyAttack2Damage + enemyAttackModifier)
    ELSE health

enemyHealthChange[health \in Int, a \in STRING] == 
    IF      a = "a" THEN health - (playerAttackDamage + playerAttackModifier)
    ELSE IF a = "e" THEN health + healAmmount
    ELSE IF a = "f" THEN health - (playerAttack2Damage + playerAttackModifier)
    ELSE health
    
\* Describe next states for each action
(* IMPORTANT SYNTAX:  primed variables x' mean new value of x *)

Next == 
IF str = << >> THEN
 /\ str' = str 
 /\ playerHealth' = playerHealth 
 /\ enemyHealth' = enemyHealth
 /\ <<playerHealth, enemyHealth>> \in healths
 /\ \E x \in  {playerHealth, enemyHealth} : x \in aliveHealths
 
ELSE 
    /\ IF str[1] = "h" THEN playerAttackModifier = playerAttackModifier + 10 ELSE playerAttackModifier = playerAttackModifier
    /\  IF str[1] = "i" THEN enemyAttackModifier = enemyAttackModifier + 10 ELSE enemyAttackModifier = enemyAttackModifier
    /\ playerHealth' = playerHealthChange[playerHealth, str[1]]
    /\ enemyHealth'  = enemyHealthChange[enemyHealth, str[1]]
    /\ str'  = Tail(str)
    
Spec == Init /\ [][Next]_<<str,playerHealth,enemyHealth>>



\*Init ==
\*  /\ playerHealth = maxHealth
\*  /\ enemyHealth = maxHealth
\*
\*Invariant ==  
\* /\ <<playerHealth, enemyHealth>> \in healths
\*
\*PlayerAttack == 
\*  /\ enemyHealth \in aliveHealths
\*  /\ <<playerHealth, enemyHealth - attackDamage>> \in healths
\*  /\ \E x \in  {playerHealth, enemyHealth - attackDamage} : x \in aliveHealths \*Takes out 0,0 as a state
\*  /\ playerHealth' = playerHealth
\*  /\ enemyHealth' = enemyHealth - attackDamage
\*
\*EnemyAttack == 
\*  /\ playerHealth \in aliveHealths
\*  /\ <<playerHealth - attackDamage, enemyHealth>> \in healths
\*  /\ \E x \in  {playerHealth - attackDamage, enemyHealth} : x \in aliveHealths \*Takes out 0,0 as a state
\*  /\ playerHealth' = playerHealth - attackDamage
\*  /\ enemyHealth' = enemyHealth
\*
\*Idle == 
\*  /\ <<playerHealth, enemyHealth>> \in healths
\*  /\ playerHealth' = playerHealth
\*  /\ enemyHealth' = enemyHealth
\*
\*
\*Next ==
\*  /\ Invariant
\*  /\ \/ PlayerAttack
\*     \/ EnemyAttack
\*     \/ Idle
\* 
\*Spec == Init /\ [][Next]_<<playerHealth, enemyHealth>>

=============================================================================
\* Modification History
\* Last modified Thu Feb 16 22:34:54 EST 2023 by Myles
\* Last modified Thu Feb 16 22:05:08 EST 2023 by Myles
\* Last modified Thu Feb 09 20:17:23 EST 2023 by ryan
\* Last modified Mon Jan 30 11:15:02 EST 2023 by ryan
