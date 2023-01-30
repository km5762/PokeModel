---------------------------- MODULE PokeModel ----------------------------
EXTENDS Sequences, Naturals
\*VARIABLE qcur
VARIABLE str

\*a = player attack, b = enemy attack, c = do nothing
\*q0 = (100,100), q1 = (100,50),q2 = (50,100) ,q3 = (50,50) ,q4 = Victory, q5 = Defeat

CONSTANT myStr

ExampleModel == 
<<{"a","b","c"},             \* Sigma
  {"q0","q1","q2","q3", "q4", "q5"}, \* States
  \* Transition function
  [qa \in (STRING \times STRING) |-> 
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
    ELSE qa[1]],
    "q0", \* Start state
    {"q4", "q5"} \* Accepting state(s)
>>
    
Delta == ExampleModel[3]
Accept == ExampleModel[5]

VARIABLE qcur
Init ==
 /\ qcur = ExampleModel[4]
 /\ str  = myStr
 
 
Next == 
IF Len(str) = 0 THEN
 qcur \in Accept /\ qcur' = qcur /\ str' = str
ELSE 
  <<qcur',str'>> = <<Delta[qcur,str[1]],Tail(str)>>
  
 Spec == Init /\ [][Next]_<<qcur,str>>
=============================================================================
\* Modification History
\* Last modified Mon Jan 30 11:25:31 EST 2023 by ryan
\* Last modified Mon Jan 30 11:15:02 EST 2023 by ryan
\* Last modified Thu Jan 26 21:02:26 EST 2023 by Myles
