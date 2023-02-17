---- MODULE MC ----
EXTENDS PokeModel, TLC

\* CONSTANT definitions @modelParameterConstants:0myStr
const_1676604882314134000 == 
<<"a","b","d","e","d","e","d","d">>
----

\* INVARIANT definition @modelCorrectnessInvariants:0
inv_1676604882314135000 ==
doneValue = 0
----
=============================================================================
\* Modification History
\* Created Thu Feb 16 22:34:42 EST 2023 by ryan
