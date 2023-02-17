---- MODULE MC ----
EXTENDS PokeModel, TLC

\* CONSTANT definitions @modelParameterConstants:0myStr
const_1676604913054138000 == 
<<"a","b","a","b">>
----

\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1676604913054139000 ==
doneValue = 0
----
=============================================================================
\* Modification History
\* Created Thu Feb 16 22:35:13 EST 2023 by ryan
