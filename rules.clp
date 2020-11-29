(defrule looking
  (checkdiv ?x)
  =>
  (assert (looking ?x))
)

(defrule zero
  (checkdiv 0)
  =>
  (assert (get-next-input))
)

(defrule divisible2
  (checkdiv ?x)
  (test (> ?x 0))
  (test
    (or (= (mod ?x 10) 0)
         (= (mod ?x 10) 2)
         (= (mod ?x 10) 4)
         (= (mod ?x 10) 6)
         (= (mod ?x 10) 8)
    )
  )
  =>
  (assert (checked2 ?x))
  (assert (divisible 2 ?x))
)

(defrule notdivisible2
  (checkdiv ?x)
  (test (> ?x 0))
  (test
    (or
      (= (mod ?x 10) 1)
      (= (mod ?x 10) 3)
      (= (mod ?x 10) 5)
      (= (mod ?x 10) 7)
      (= (mod ?x 10) 9)
    )
  )
  =>
  (assert (checked2 ?x))
)

(defrule divisible3
  (checkdiv ?x)
  (test (> ?x 0))
  =>
  (assert (checked3 ?x))
  (bind ?n ?x)
  (bind ?sum 0)
  (while (> ?n 0)
    (bind ?sum (+ ?sum (mod ?n 10)))
    (bind ?n (div ?n 10))
  )
  (while (> ?sum 10) then
    (bind ?n ?sum)
    (bind ?sum 0)
    (while (> ?n 0)
      (bind ?sum (+ ?sum (mod ?n 10)))
      (bind ?n (div ?n 10))
    )
  )
  (if
    (or
      (= ?sum 3)
      (= ?sum 6)
      (= ?sum 9)
    ) then
    (assert (divisible 3 ?x))
  )
)

(defrule divisible5
  (checkdiv ?x)
  (test (> ?x 0))
  (test
    (or
      (= (mod ?x 10) 5)
      (= (mod ?x 10) 0)
    )
  )
  =>
  (assert (checked5 ?x))
  (assert (divisible 5 ?x))
)

(defrule notdivisible5
  (checkdiv ?x)
  (test (> ?x 0))
  (test
    (and
      (<> (mod ?x 10) 5)
      (<> (mod ?x 10) 0)
    )
  )
  =>
  (assert (checked5 ?x))
)

(defrule divisible7
  ?check <- (checkdiv ?x)
  (test (> ?x 0))
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
  (assert (checked7 ?x))
)

(defrule divisible11
  (checkdiv ?x)
  (test (> ?x 0))
  =>
  (assert (checked11 ?x))
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

(defrule divisible13
  ?check <- (checkdiv ?x)
  (test (> ?x 0))
  =>
  (assert (checked13 ?x))
  (bind ?n ?x)
  (while (> ?n 10)
    (
      bind ?n (
        - (div ?n 10) (* (mod ?n 10) 9)
      )
    )
  )
  (if (or (= (abs ?n)  0)
          (= (abs ?n) 13)
          (= (abs ?n) 26)
          (= (abs ?n) 39)
          (= (abs ?n) 52)
          (= (abs ?n) 65)
          (= (abs ?n) 78)
      ) then
    (assert (divisible 13 ?x))
  )
)

(defrule allchecks
  ?ch <- (checkdiv ?x)
  ?ch2 <- (checked2 ?x)
  ?ch3 <- (checked3 ?x)
  ?ch5 <- (checked5 ?x)
  ?ch7 <- (checked7 ?x)
  ?ch11 <- (checked11 ?x)
  ?ch13 <- (checked13 ?x)
  ?looking <- (looking ?x)
  =>
  (retract ?ch)
  (retract ?ch2)
  (retract ?ch3)
  (retract ?ch5)
  (retract ?ch7)
  (retract ?ch11)
  (retract ?ch13)
  (retract ?looking)
  (assert (get-next-input))
)

(defrule divisible
  (divisible ?c ?x)
  (looking ?x)
  =>
  (
    printout t ?x " is divisible by " ?c crlf
  )
)

(defrule get-input
  ?f <- (get-next-input)
  =>
  (printout t "Input a number to check (or, 'exit' without quotes to end) ")
  (bind ?input (readline))
  (if (neq ?input "exit")
    then
      (retract ?f)
      (assert (print ?input))
    else
      (exit)
  )
)

(defrule print-input
  ?input <- (print ?x)
  =>
  (retract ?input)
  (assert (checkdiv (eval ?x)))
  (run)
)

(assert (get-next-input))
(run)
