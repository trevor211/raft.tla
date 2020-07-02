-------------------------------- MODULE MC -------------------------------
EXTENDS raft, TLC
-----------------------------------------------------------------------------

MCServer == {"s1","s2","s3"}
MCValue == {"v1", "v2", "v3"}
MCRequestVoteQuorum == {{"s1","s3"},{"s2","s3"},{"s1","s3"}}
MCAppendEntriesQuorum == {{"s1"},{"s2"},{"s3"}}
BothLeader(i, j) ==
    /\ i /= j
    /\ currentTerm[i] = currentTerm[j]
    /\ state[i] = Leader
    /\ state[j] = Leader

MoreThanOneLeader ==
    \E i, j \in MCServer: BothLeader(i, j)
AtMostOneLeaderPerTerm == \lnot MoreThanOneLeader
TermConstraint == \A i \in MCServer: currentTerm[i] < 3
\* LogConstraint == Cardinality(allLogs) < 2
LogConstraint == \A i \in MCServer: Len(log[i]) < 2
MessageConstraint == Cardinality(DOMAIN messages) < 2
=============================================================================