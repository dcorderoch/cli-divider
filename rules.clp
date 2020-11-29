(defrule looking
  (checkdiv ?x)
  =>
  (assert (looking ?x))
)

;(defrule zero
;  ?check <- (checkdiv 0)
;  =>
;  (retract ?check)
;)

;(defrule one
;  ?check <- (checkdiv 1)
;  =>
;  (retract ?check)
;)

(defrule divisible20
  (checkdiv ?x)
  (test (<> ?x 0))
  (test (= (mod ?x 10) 0))
  =>
  (assert (divisible 2 ?x))
  (assert (divisible 5 ?x))
)

(defrule divisible2
  (checkdiv ?x)
  (test (<> ?x 0))
  (
    or (= (mod ?x 10) 2)
        (= (mod ?x 10) 4)
        (= (mod ?x 10) 6)
        (= (mod ?x 10) 8)
  )
  =>
  (assert (divisible 2 ?x))
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

(defrule divisible7
  ?check <- (checkdiv ?x)
  =>
  (bind ?n ?x)
  (while (> ?n 10)
    (
      bind ?n (
        - (div ?n 10) (* (mod ?n 10) 2)
      )
    )
  )
  (if (or (= ?n -7)
          (= ?n  0)
          (= ?n  7)) then
    (assert (divisible 7 ?x))
  )
)

(defrule divisible11
  (checkdiv ?x)
  =>
  (bind ?n ?x)
  (bind ?sign 1)
  (bind ?sum 0)
  (while (> ?n 0)
    (bind ?sum (+ ?sum (* ?sign (mod ?n 10))))
    (bind ?sign (* -1 ?sign))
    (if (<= ?n 0) then
      (break)
    )
    (bind ?n (div ?n 10))
  )
  (if (= ?sum 0) then
    (assert (divisible 11 ?x))
  )
)

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
    printout t ?x " is divisible by " ?c crlf
  )
)

(defrule get-input
  ?f <- (get-next-input)
  =>
  (printout t "Input a number to check (or, 'exit' without quotes to end)? ")
  (bind ?input (readline))
  (if (neq ?input "exit")
    then
      ;(retract ?f)
      ;(assert (get-next-input))
      (assert (print ?input))
    else
      (exit)
  )
)

(defrule print-input
  ?input <- (print ?x)
  =>
  (retract ?input)
  ;(assert (get-next-input)) ; this is the thing that would move
  (assert (checkdiv (eval ?x)))
  (run)
)

(assert (get-next-input))
(run)
