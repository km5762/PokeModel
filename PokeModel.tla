---------------------------- MODULE Lecture07DFAModelingex2 ----------------------------
EXTENDS Sequences

Sigma == {"Attack","DoNothing"}
Q == {"100:100","100:50","50:50","50:100", "Victory", "Defeat"}

VARIABLE qcur
VARIABLE str

\* Describe initial state
Init == qcur = "100:100"

\* Transition function
Delta[q \in Q, c \in Sigma] ==
  \* DEFINE DELTA 

\* Accept any state except defeated
Accept == {"Victory", "Defeat"}

\* Describe next states for each action
\* primed variables x' mean new value of x
Next == 
IF Len(str) = 0 THEN
 qcur \in Accept /\ qcur' = qcur /\ str' = str
ELSE 
  <<qcur',str'>> = <<Delta[qcur,str[1]],Tail(str)>>

(* See Lecture07DFAModelingex1 for explanation of [][...]_... syntax *)
Spec == Init /\ [][Next]_<<qcur,str>>
    
=============================================================================
\* Modification History
\* Last modified Thu Jan 26 20:52:15 EST 2023 by Myles
\* Last modified Wed Nov 16 13:07:57 EST 2022 by rbohrer
