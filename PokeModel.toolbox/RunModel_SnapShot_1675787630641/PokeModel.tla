---------------------------- MODULE PokeModel ----------------------------

EXTENDS Naturals, Reals, Integers, Sequences

VARIABLE str
VARIABLE qcur

\*a = player attack, b = enemy attack, c = do nothing
\*q0 = (100,100), q1 = (100,50),q2 = (50,100) ,q3 = (50,50) ,q4 = Victory, q5 = Defeat

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
    /\ qcur = "q0"
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

Accepts == {"q4","q5"}
Delta [qa \in (STRING \times STRING)] == 
    IF      qa = <<"q0","c">> THEN "q0"
    ELSE IF qa = <<"q1","c">> THEN "q1"
    ELSE IF qa = <<"q2","c">> THEN "q2"
    ELSE IF qa = <<"q3","c">> THEN "q3"
    
    ELSE IF qa = <<"q0","a">> THEN "q1"
    ELSE IF qa = <<"q0","b">> THEN "q2"
    
    ELSE IF qa = <<"q1","a">> THEN "q4"
    ELSE IF qa = <<"q1","b">> THEN "q3"
    
    ELSE IF qa = <<"q2","a">> THEN "q3"
    ELSE IF qa = <<"q2","b">> THEN "q5"
    
    ELSE IF qa = <<"q3","a">> THEN "q4"
    ELSE IF qa = <<"q3","b">> THEN "q5"
    ELSE qa[1]

Next == 
IF str = << >> THEN
 /\ qcur \in Accepts
 /\ qcur' = qcur
 /\ str' = str 
 /\ playerHealth' = playerHealth 
 /\ enemyHealth' = enemyHealth
 /\ <<playerHealth, enemyHealth>> \in healths
 /\ \E x \in  {playerHealth, enemyHealth} : x \in aliveHealths
 
ELSE 
\*    /\ <<playerHealth, enemyHealth>> \in healths
\*    /\ \E x \in  {playerHealth, enemyHealth} : x \in aliveHealths
    
    /\ playerHealth' = playerHealthChange[playerHealth, str[1]]
    /\ enemyHealth'  = enemyHealthChange[enemyHealth, str[1]]
    
\*    /\ <<playerHealth', enemyHealth'>> \in healths
\*    /\ \E x \in  {playerHealth', enemyHealth'} : x \in aliveHealths
    /\ qcur' = Delta[<<qcur, str[1]>>]
    /\ str'  = Tail(str)

    

Spec == Init /\ [][Next]_<<qcur,str,playerHealth,enemyHealth>>



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
\* Last modified Tue Feb 07 11:33:17 EST 2023 by ryan
\* Last modified Mon Jan 30 11:15:02 EST 2023 by ryan
\* Last modified Thu Jan 26 21:02:26 EST 2023 by Myles
