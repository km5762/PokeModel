---------------------------- MODULE PokeModel ----------------------------

EXTENDS Naturals, Reals, Integers, Sequences

VARIABLE str

\*a = player attack, b = enemy attack, c = do nothing

CONSTANT myStr


maxHealth == 100

healthOptions == {x \in Int : x <= maxHealth}
aliveHealths == {x \in Nat : x > 0 /\ x <= maxHealth}
healths == healthOptions \times healthOptions

actions == {"PlayerAttack", "EnemyAttack", "Idle"}

VARIABLES playerHealth, enemyHealth

attackDamage == 60

\* Describe initial state
Init == 
    /\ str  = myStr
    /\ playerHealth = maxHealth
    /\ enemyHealth = maxHealth

playerHealthChange[health \in Int, a \in STRING] == 
    IF a = "b" THEN health - attackDamage
    ELSE health


enemyHealthChange[health \in Int, a \in STRING] == 
    IF a = "a" THEN health - attackDamage
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


=============================================================================
\* Modification History
\* Last modified Tue Feb 07 11:43:15 EST 2023 by ryan
\* Last modified Mon Jan 30 11:15:02 EST 2023 by ryan
\* Last modified Thu Jan 26 21:02:26 EST 2023 by Myles
