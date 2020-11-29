(deffunction lastchar (?s)
  (
    return
      (
        sub-string (str-length ?s) (str-length ?s) ?s
      )
  )
)

(defrule looking
  (checkdiv ?x)
  =>
  (assert (looking ?x))
)

(defrule zero
  ?check <- (checkdiv 0)
  =>
  (retract ?check)
)

(defrule one
  ?check <- (checkdiv 1)
  =>
  (retract ?check)
)

(defrule divisible20
  (checkdiv ?x)
  ;?check <- (checkdiv ?x)
  (test (<> ?x 0))
  (test (= (mod ?x 10) 0))
  =>
  ;(
  ;  retract ?check
  ;)
  (
    assert (divisible 2 ?x)
  )
  (
    assert (divisible 5 ?x)
  )
)

(defrule divisible22
  (checkdiv ?x)
  ;?check <- (checkdiv ?x)
  (test (<> ?x 0))
  (test (= (mod ?x 10) 2))
  =>
  ;(
  ;  retract ?check
  ;)
  (
    assert (divisible 2 ?x)
  )
)

(defrule divisible24
  (checkdiv ?x)
  ;?check <- (checkdiv ?x)
  (test (<> ?x 0))
  (test (= (mod ?x 10) 4))
  =>
  ;(
  ;  retract ?check
  ;)
  (
    assert (divisible 2 ?x)
  )
)

(defrule divisible26
  (checkdiv ?x)
  ;?check <- (checkdiv ?x)
  (test (<> ?x 0))
  (test (= (mod ?x 10) 6))
  =>
  ;(
  ;  retract ?check
  ;)
  (
    assert (divisible 2 ?x)
  )
)

(defrule divisible28
  (checkdiv ?x)
  ;?check <- (checkdiv ?x)
  (test (<> ?x 0))
  (test (= (mod ?x 10) 8))
  =>
  ;(
  ;  retract ?check
  ;)
  (
    assert (divisible 2 ?x)
  )
)

(defrule reducer
  (fact_red ?x)
  ;?rednum <- (fact_red ?x)
  =>
  ;(
  ;  retract ?rednum
  ;)
  (
    assert (fact_red_sum ?x ?x 0)
  )
)

(defrule red_helper
  (fact_red_sum ?x ?y ?s)
  ;?rednum <- (fact_red_sum ?x ?x ?s)
  (test (<> ?y 0))
  =>
  ;(
  ;  retract ?rednum
  ;)
  ;(
  ;  printout t "red_helper with: " ?x ", " ?y ", and " ?s crlf
  ;)
  (
    assert (fact_red_sum ?x (div ?y 10) (+ ?s (mod ?y 10)))
  )
)

(defrule the_fix3
  (fact_red_sum ?x 0 ?y)
  (fact_last_check_3 ?y 3)
  =>
  (assert (divisible 3 ?x))
)

(defrule the_fix6
  (fact_red_sum ?x 0 ?y)
  (fact_last_check_3 ?y 6)
  =>
  (assert (divisible 3 ?x))
)

(defrule the_fix9
  (fact_red_sum ?x 0 ?y)
  (fact_last_check_3 ?y 9)
  =>
  (assert (divisible 3 ?x))
)

(defrule red_end
  (fact_red_sum ?x 0 ?s)
  =>
  (if (> ?s 10) then
    (assert (fact_red ?s))
   else
    (assert (fact_last_check_3 ?x ?s))
  )
)

(defrule last_check_rule
  (fact_last_check_3 ?x ?s)
  (divisible 3 ?s)
  =>
  (
    assert (divisible 3 ?x)
  )
)

(defrule red_end_prune
  (fact_red_sum ?x ?o ?s)
  ;?rednum <- (fact_red_sum ?x ?o ?s)
  (test (<> ?o 0))
  =>
  ;(
  ;  retract ?rednum
  ;)
)

(defrule fact_last_check_3_rule3
  (fact_last_check_3 ?x ?s)
  ;?check <- (fact_last_check_3 ?x ?s)
  (test (= 3 ?s))
  =>
  ;(
  ;  retract ?check
  ;)
  (
    assert (divisible 3 ?x)
  )
)

(defrule fact_last_check_3_rule6
  (fact_last_check_3 ?x ?s)
  ;?check <- (fact_last_check_3 ?x ?s)
  (test (= 6 ?s))
  =>
  ;(
  ;  retract ?check
  ;)
  (
    assert (divisible 3 ?x)
  )
)

(defrule fact_last_check_3_rule9
  (fact_last_check_3 ?x ?s)
  ;?check <- (fact_last_check_3 ?x ?s)
  (test (= 9 ?s))
  =>
  ;(
  ;  retract ?check
  ;)
  (
    assert (divisible 3 ?x)
  )
)

(defrule divisible3
  (checkdiv ?x)
  (test (> ?x 10))
  =>
  (
    assert (fact_red ?x)
  )
)

(defrule divisible313
  (checkdiv ?x)
  ;?check <- (checkdiv ?x)
  (test (< ?x 10))
  (test (= 3 ?x))
  =>
  ;(
  ;  retract ?check
  ;)
  (
    assert (divisible 3 ?x)
  )
)

(defrule divisible316
  (checkdiv ?x)
  ;?check <- (checkdiv ?x)
  (test (< ?x 10))
  (test (= 6 ?x))
  =>
  ;(
  ;  retract ?check
  ;)
  (
    assert (divisible 3 ?x)
  )
)

(defrule divisible319
  (checkdiv ?x)
  ;?check <- (checkdiv ?x)
  (test (< ?x 10))
  (test (= 9 ?x))
  =>
  ;(
  ;  retract ?check
  ;)
  (
    assert (divisible 3 ?x)
  )
)

(defrule divisible5
  (checkdiv ?x)
  ;?check <- (checkdiv ?x)
  (test (= (mod ?x 10) 5))
  =>
  ;(
  ;  retract ?check
  ;)
  (
    assert (divisible 5 ?x)
  )
)

;(defrule divisible7
;  ?check <- (checkdiv ?x)
;  =>
;  (
;    retract ?check
;  )
;  (
;    assert (checkdiv ?x 7)
;  )
;)

;(defrule divisible11
;  ?check <- (checkdiv ?x)
;  =>
;  (
;    retract ?check
;  )
;  (
;    assert (checkdiv ?x 11)
;  )
;)

;(defrule divisible13
;  ?check <- (checkdiv ?x)
;  =>
;  (
;    retract ?check
;  )
;  (
;    assert (checkdiv ?x 13)
;  )
;)

(defrule divisible
  (divisible ?c ?x)
  ;?divisible <- (divisible ?c ?x)
  (looking ?x)
  =>
  ;(
  ;  retract ?divisible
  ;)
  (
    printout t ?x " is divisible by (constant) " ?c crlf
  )
)

;(assert (checkdiv 0))  ; none
;(assert (checkdiv 1))  ; none
;(assert (checkdiv 2))  ; 2 only? maybe none
;(assert (checkdiv 3))  ; 3 only? maybe none
;(assert (checkdiv 4))  ; 2 only
;(assert (checkdiv 5))  ; 5 only? maybe none
;(assert (checkdiv 6))  ; 2 and 3
;(assert (checkdiv 7))  ; 7 only? maybe none
;(assert (checkdiv 8))  ; 2 only
;(assert (checkdiv 9))  ; 3 only
;(assert (checkdiv 10)) ; 2 and 5
;(assert (checkdiv 11)) ; 11 only? maybe none
;(assert (checkdiv 12)) ; 2 and 3
;(assert (checkdiv 13)) ; 13 only? maybe none
;(assert (checkdiv 14)) ; 2 and 7
;(assert (checkdiv 15)) ; 3 and 5
;(assert (checkdiv 16)) ; 2 only
;(assert (checkdiv 17)) ; none
;(assert (checkdiv 18)) ; 2 and 3
;(assert (checkdiv 19)) ; none
;(assert (checkdiv 20)) ; 2 and 5
;(assert (checkdiv 21)) ; 3 and 7
;(assert (checkdiv 22)) ; 2 and 11
;(assert (checkdiv 23)) ; none
;(assert (checkdiv 24)) ; 2 and 3
;(assert (checkdiv 25)) ; 5 only
;(assert (checkdiv 26)) ; 2 and 13
;(assert (checkdiv 27)) ; 3 only
;(assert (checkdiv 28)) ; 2 and 7
;(assert (checkdiv 29)) ; none
;(assert (checkdiv 30)) ; 2, 3 and 5
;(assert (checkdiv 35)) ; 5 and 7
;(assert (checkdiv 40)) ; 2 and 5
;(assert (checkdiv 60)) ; 2, 3 and 5
;(assert (checkdiv 75)) ; 3 and 5

(assert (checkdiv 999999))

(facts)
(run)
(facts)

(exit)
