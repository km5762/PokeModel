---- MODULE MC ----
EXTENDS PokeModel, TLC

\* CONSTANT definitions @modelParameterConstants:0myStr
const_167660144553923000 == 
<<"a","b","a">>
----

\* INVARIANT definition @modelCorrectnessInvariants:0
inv_167660144553924000 ==
myStr /= <<"a","b">>
----
=============================================================================
\* Modification History
\* Created Thu Feb 16 21:37:25 EST 2023 by ryan
