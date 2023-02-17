---- MODULE MC ----
EXTENDS PokeModel, TLC

\* CONSTANT definitions @modelParameterConstants:0myStr
const_1676605248068144000 == 
<<"a","b","a">>
----

\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1676605248069145000 ==
doneValue = 0
----
=============================================================================
\* Modification History
\* Created Thu Feb 16 22:40:48 EST 2023 by ryan
