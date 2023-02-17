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
VARIABLES playerHealth, enemyHealth,playerLastAttacked

doneValue == 0

playerAttackDamage == 60
playerAttack2Damage == 30
playerAttackModifier == 0

enemyAttackDamage == 49
enemyAttack2Damage == 30
enemyAttackModifier == 0

healAmmount == 20

min[a \in Int, b \in Int] == 
   IF a < b THEN a ELSE b

\*playerLastAttacked == 0

\* Describe initial state
Init == 
    /\ str  = myStr
    /\ playerHealth = maxHealth
    /\ enemyHealth = maxHealth
    /\ playerLastAttacked = 0

playerHealthChange[health \in Int, a \in STRING] == 
    IF      a = "b" THEN health - (enemyAttackDamage + enemyAttackModifier)
    ELSE IF a = "d" THEN min[health + healAmmount,maxHealth]
    ELSE IF a = "g" THEN health - (enemyAttack2Damage + enemyAttackModifier)
    ELSE health

enemyHealthChange[health \in Int, a \in STRING] ==   
    IF      a = "a" THEN health - (playerAttackDamage + playerAttackModifier)
    ELSE IF a = "e" THEN min[health + healAmmount,maxHealth]
    ELSE IF a = "f" THEN health - (playerAttack2Damage + playerAttackModifier)
    ELSE health

nextAttcked[a \in STRING] ==
    IF a = "a" THEN 1
    ELSE IF a = "d" THEN 1
    ELSE IF a = "f" THEN 1
    ELSE IF a = "h" THEN 1
    ELSE IF a = "b" THEN -1
    ELSE IF a = "e" THEN -1
    ELSE IF a = "g" THEN -1
    ELSE IF a = "i" THEN -1
    ELSE 0


\* Describe next states for each action
(* IMPORTANT SYNTAX:  primed variables x' mean new value of x *)

Invariant == 
 /\ <<playerHealth, enemyHealth>> \in healths
 /\ \E x \in  {playerHealth, enemyHealth} : x \in aliveHealths
 /\ \/ str = << >>
    \/ playerLastAttacked' /= playerLastAttacked


\* Now need Player ORder
\* And Dead cant attack
\* and Dead cant be attacked

Next == 
IF str = << >> THEN
 /\ str' = str 
 /\ playerHealth' = playerHealth 
 /\ enemyHealth' = enemyHealth
 /\ playerLastAttacked' = playerLastAttacked 
 /\ Invariant
 /\ doneValue = 0
 
ELSE 
    /\ playerLastAttacked' = nextAttcked[str[1]]
    /\ Invariant
    /\ IF str[1] = "h" THEN playerAttackModifier = playerAttackModifier + 10 ELSE playerAttackModifier = playerAttackModifier
    /\ IF str[1] = "i" THEN enemyAttackModifier = enemyAttackModifier + 10 ELSE enemyAttackModifier = enemyAttackModifier
    /\ playerHealth' = playerHealthChange[playerHealth, str[1]]
    /\ enemyHealth'  = enemyHealthChange[enemyHealth, str[1]]
    /\ <<playerHealth, enemyHealth>> \in aliveHealths \times aliveHealths
    /\ str'  = Tail(str)

Spec == Init /\ [][Next]_<<str,playerHealth,enemyHealth,playerLastAttacked>>



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
\* Last modified Thu Feb 16 22:40:34 EST 2023 by ryan
\* Last modified Mon Jan 30 11:15:02 EST 2023 by ryan
\* Last modified Thu Jan 26 21:02:26 EST 2023 by Myles
