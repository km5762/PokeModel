---- MODULE MC ----
EXTENDS PokeModel, TLC

\* CONSTANT definitions @modelParameterConstants:0myStr
const_167660147539025000 == 
<<"a","b","a">>
----

\* INVARIANT definition @modelCorrectnessInvariants:0
inv_167660147539026000 ==
myStr /= <<"a","b">>
----
=============================================================================
\* Modification History
\* Created Thu Feb 16 21:37:55 EST 2023 by ryan
