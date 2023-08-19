---- MODULE PlusCalExample ----
(* TLA+/PlusCal example program. *)
(* Multi-line
   (* nested *)
   comment *)
\* Single-line comment

\* The code below appears to be a TLA+ comment but is PlusCal code which should
\* be line-counted.
\* Grammar rules for PlusCal are specified in appendices A and C of A PlusCal
\* User’s Manual: https://lamport.azurewebsites.net/tla/c-manual.pdf
(*
PlusCal options (-sf)
--algorithm Example {
  process (A = 0) {
    Start: skip;
  }
}
This is a comment line.
*)

\* The code between BEGIN( )TRANSLATION and END( )TRANSLATION should not be
\* line-counted because it is generated and not written by hand.
\* BEGIN TRANSLATION (chksum(pcal) = "7bf2389f" /\ chksum(tla) = "dd78b4d4")
VARIABLE pc

vars == << pc >>

ProcSet == {0}

Init == /\ pc = [self \in ProcSet |-> "Start"]

Start == /\ pc[0] = "Start"
         /\ TRUE
         /\ pc' = [pc EXCEPT ![0] = "Done"]

A == Start

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == /\ \A self \in ProcSet: pc[self] = "Done"
               /\ UNCHANGED vars

Next == A
           \/ Terminating

Spec == /\ Init /\ [][Next]_vars
        /\ SF_vars(A)

Termination == <>(\A self \in ProcSet: pc[self] = "Done")

\* END TRANSLATION 

====
