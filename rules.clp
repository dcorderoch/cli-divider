(deffunction lastchar (?s)
  (
    return
    (
      sub-string (str-length ?s) (str-length ?s) ?s
    )
  )
)

(defrule nocheck
  ?check <- (checkdiv ?x ?c)
  (test (neq 0 (str-compare (lastchar ?x) ?c)))
  =>
  (
    retract ?check
  )
)

(defrule divisible20
  ?check <- (checkdiv ?x)
  (test (> (str-length ?x) 1))
  (test (eq 0 (str-compare (lastchar ?x) "0")))
  =>
  (
    retract ?check
  )
  (
    assert (divisible "2" ?x)
  )
  (
    assert (divisible "5" ?x)
  )
)

(defrule divisible22
  ?check <- (checkdiv ?x)
  (test (eq 0 (str-compare (lastchar ?x) "2")))
  =>
  (
    retract ?check
  )
  (
    assert (divisible "2" ?x)
  )
)

(defrule divisible24
  ?check <- (checkdiv ?x)
  (test (eq 0 (str-compare (lastchar ?x) "4")))
  =>
  (
    retract ?check
  )
  (
    assert (divisible "2" ?x)
  )
)

(defrule divisible26
  ?check <- (checkdiv ?x)
  (test (eq 0 (str-compare (lastchar ?x) "6")))
  =>
  (
    retract ?check
  )
  (
    assert (divisible "2" ?x)
  )
)

(defrule divisible28
  ?check <- (checkdiv ?x)
  (test (eq 0 (str-compare (lastchar ?x) "8")))
  =>
  (
    retract ?check
  )
  (
    assert (divisible "2" ?x)
  )
)

(defrule divisible3
  ?check <- (checkdiv ?x)
  =>
  (
    retract ?check
  )
  (
    assert (checkdiv ?x "3")
  )
)

(defrule divisible5
  ?check <- (checkdiv ?x)
  (test (> (str-length ?x) 1))
  (test (eq 0 (str-compare (lastchar ?x) "5")))
  =>
  (
    retract ?check
  )
  (
    assert (divisible "5" ?x)
  )
)

(defrule divisible7
  ?check <- (checkdiv ?x)
  =>
  (
    retract ?check
  )
  (
    assert (checkdiv ?x "7")
  )
)

(defrule divisible11
  ?check <- (checkdiv ?x)
  =>
  (
    retract ?check
  )
  (
    assert (checkdiv ?x "11")
  )
)

(defrule divisible13
  ?check <- (checkdiv ?x)
  =>
  (
    retract ?check
  )
  (
    assert (checkdiv ?x "13")
  )
)

(defrule last-is-2
  ?value <- (lastchar ?x)
  (
    test (
      eq 0 (
        str-compare ?x "0"
      )
    )
  )
  =>
  (
    retract ?value
  )
  (
    assert (divisible 5 ?x)
  )
  (
    assert (divisible 2 ?x)
  )
)

(defrule last-is-5
  ?value <- (lastchar ?x)
  (
    test (
      eq 0 (
        str-compare ?x "5"
      )
    )
  )
  =>
  (
    retract ?value
  )
  (
    assert (divisible 5 ?x)
  )
)

(defrule divisible
  ?divisible <- (divisible ?c ?x)
  =>
  (
    retract ?divisible
  )
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

(assert (checkdiv "0"))
(assert (checkdiv "1"))
(assert (checkdiv "2"))
(assert (checkdiv "3"))
(assert (checkdiv "4"))
(assert (checkdiv "5"))
(assert (checkdiv "6"))
(assert (checkdiv "7"))
(assert (checkdiv "8"))
(assert (checkdiv "9"))
(assert (checkdiv "10"))
(assert (checkdiv "11"))
(assert (checkdiv "12"))
(assert (checkdiv "13"))
(assert (checkdiv "14"))
(assert (checkdiv "15"))
(assert (checkdiv "16"))
(assert (checkdiv "17"))
(assert (checkdiv "18"))
(assert (checkdiv "19"))
(assert (checkdiv "20"))
(assert (checkdiv "21"))
(assert (checkdiv "22"))
(assert (checkdiv "23"))
(assert (checkdiv "24"))
(assert (checkdiv "25"))
(assert (checkdiv "26"))

(run)

(exit)
