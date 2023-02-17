---- MODULE MC ----
EXTENDS PokeModel, TLC

\* CONSTANT definitions @modelParameterConstants:0myStr
const_167660135628219000 == 
<<"a","b","a","a">>
----

\* INVARIANT definition @modelCorrectnessInvariants:0
inv_167660135628220000 ==
myStr /= <<>>
----
=============================================================================
\* Modification History
\* Created Thu Feb 16 21:35:56 EST 2023 by ryan
