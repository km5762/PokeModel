---------------------------- MODULE PokeModel ----------------------------

EXTENDS Naturals, Reals, Integers, Sequences

VARIABLE str

\*a = player attack, b = enemy attack, c = do nothing

CONSTANT myStr


maxHealth == 100

healthOptions == {x \in Int : x <= maxHealth}
aliveHealths == {x \in Nat : x > 0 /\ x <= maxHealth}
healths == healthOptions \times healthOptions

\*actions == {"PlayerAttack", "EnemyAttack", "Idle", "Player Heal", "Enemy Heal"}

VARIABLES playerHealth, enemyHealth

attackDamage == 60
healAmmount == 60

\* Describe initial state
Init == 
    /\ str  = myStr
    /\ playerHealth = maxHealth
    /\ enemyHealth = maxHealth

playerHealthChange[health \in Int, a \in STRING] == 
    IF a = "b" THEN health - attackDamage
    ELSE IF a = "d" THEN health + healAmmount
    ELSE health


enemyHealthChange[health \in Int, a \in STRING] == 
    IF a = "a" THEN health - attackDamage
    ELSE IF a = "e" THEN health + healAmmount
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
\* Last modified Thu Feb 09 20:06:32 EST 2023 by ryan
\* Last modified Mon Jan 30 11:15:02 EST 2023 by ryan
\* Last modified Thu Jan 26 21:02:26 EST 2023 by Myles
