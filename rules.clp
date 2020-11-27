(deffunction lastchar (?s)
  (
    return
      (
        sub-string (str-length ?s) (str-length ?s) ?s
      )
  )
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
  (
    retract ?check
  )
  ;(
  ;  assert (divisible 2 ?x)
  ;)
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

(defrule red_end
  (fact_red_sum ?x 0 ?s)
  =>
  (if (> ?s 10) then
    (assert (fact_red_rec ?x ?s))
    (assert (fact_red ?s))
   else
    (assert (fact_last_check_3 ?x ?s))
  )
)

(defrule last_check_rule
  (fact_last_check_3 ?x ?s)
  (divisible ?s)
  =>
  (
    assert (divisible ?x)
  )
)

(defrule red_end_prune
  ?rednum <- (fact_red_sum ?x ?o ?s)
  (test (<> ?o 0))
  =>
  (
    retract ?rednum
  )
)

(defrule fact_red_recursive
  (fact_red_rec ?x ?s)
  ;?check <- (fact_red_rec ?x ?s)
  (fact_red_sum ?x 0 ?s)
  =>
  (
    assert (divisible 3 ?x)
  )
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
  ?check <- (checkdiv ?x)
  (test (< ?x 10))
  (test (= 3 ?x))
  =>
  (
    retract ?check
  )
  (
    assert (divisible 3 ?x)
  )
)

(defrule divisible316
  ?check <- (checkdiv ?x)
  (test (< ?x 10))
  (test (= 6 ?x))
  =>
  (
    retract ?check
  )
  (
    assert (divisible 3 ?x)
  )
)

(defrule divisible319
  ?check <- (checkdiv ?x)
  (test (< ?x 10))
  (test (= 9 ?x))
  =>
  (
    retract ?check
  )
  (
    assert (divisible 3 ?x)
  )
)

(defrule divisible5
  ?check <- (checkdiv ?x)
  (test (= (mod ?x 10) 5))
  =>
  (
    retract ?check
  )
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
  =>
  ;(
  ;  retract ?divisible
  ;)
  (
    printout t ?x " is divisible by (constant) " ?c crlf
  )
)

;(assert (checkdiv5 6))
;(assert (checkdiv5 10))
;(assert (checkdiv5 20))
;(assert (checkdiv5 15))
;
;(facts)
;(run)
;(facts)
;(exit)
;(
;  sub-string
;  1 ; position
;  2 ; length
;  "abc" ; string
;) ; expect "ab"
;(
;  sub-string
;  0 ; position
;  1 ; length
;  "abc" ; string
;) ; expect "a"
;(
;  sub-string
;  0 ; position
;  2 ; length
;  "abc" ; string
;) ; expect "ab"
;
;(assert (check-string (sub-string 0 0 "abc")))
;(assert (check-string (sub-string 0 1 "abc")))
;(assert (check-string (sub-string 0 2 "abc")))
;(assert (check-string (sub-string 0 3 "abc")))
;
;(facts)
;(run)
;(facts)

; (str-length "abc")
; (- (str-length "abc") 1)
; (- (str-length "abc") 2)
; (sub-string (str-length "123") (str-length "123") "123")
; (eval (sub-string (str-length "123") (str-length "123") "123"))
;
; (eval (str-cat "0" 23))

(printout t crlf "checks for the string version" crlf crlf)

(assert (checkdiv 0))
(assert (checkdiv 1))
(assert (checkdiv 2))
(assert (checkdiv 3))
(assert (checkdiv 4))
(assert (checkdiv 5))
(assert (checkdiv 6))
(assert (checkdiv 7))
(assert (checkdiv 8))
(assert (checkdiv 9))
(assert (checkdiv 10))
(assert (checkdiv 11))
(assert (checkdiv 12))
(assert (checkdiv 13))
(assert (checkdiv 14))
(assert (checkdiv 15))
(assert (checkdiv 16))
(assert (checkdiv 17))
(assert (checkdiv 18))
(assert (checkdiv 19))
(assert (checkdiv 20))
(assert (checkdiv 21))
(assert (checkdiv 22))
(assert (checkdiv 23))
(assert (checkdiv 24))
(assert (checkdiv 25))
(assert (checkdiv 26))
(assert (checkdiv 27))
(assert (checkdiv 28))
(assert (checkdiv 29))
(assert (checkdiv 30))
(assert (checkdiv 35))
(assert (checkdiv 40))
(assert (checkdiv 60))
(assert (checkdiv 75))

(facts)
(run)
(facts)

(exit)
