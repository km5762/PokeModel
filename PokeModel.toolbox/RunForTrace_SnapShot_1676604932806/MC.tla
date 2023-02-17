---- MODULE MC ----
EXTENDS PokeModel, TLC

\* CONSTANT definitions @modelParameterConstants:0myStr
const_1676604928126142000 == 
<<"a","b","a">>
----

\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1676604928126143000 ==
doneValue = 0
----
=============================================================================
\* Modification History
\* Created Thu Feb 16 22:35:28 EST 2023 by ryan
