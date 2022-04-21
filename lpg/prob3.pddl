(define (problem warehouse_problem1) (:domain warehouse)
(:objects 
    ;l1 - loader
    c1 c2 c3 c4 - crate
    m1 m2 - mover
    l - loader
)

(:init
    ; c1 => weight 70kg, dist 20 (HEAVY)
    ; c2 => weight 80kg, dist 20 (HEAVY, FRAGILE)
    ; c3 => weight 60kg, dist 30 (HEAVY)
    ; c4 => weight 30kg, dist 10 (LIGHT)
    (= (weight c1) 70)
    (= (weight c2) 80)
    (= (weight c3) 60)
    (= (weight c4) 30)

    (= (pos c1) 20)
    (= (pos c2) 20)
    (= (pos c3) 30)
    (= (pos c4) 10)

    ; Bay state
    (bay-free)

    ; Mover states
    (available m1)
    (available m2)
    (= (pos m1) 0)
    (= (pos m2) 0)
    (different m1 m2)
    (different m2 m1)

    ; Crate states
    (waiting c1)
    (waiting c2)
    (waiting c3)
    (waiting c4)

    

    ; Loader states
    (loader-free l)
    ;(= (loading-time) 0)
)

(:goal ( and
    (on-conveyor c1)
    (on-conveyor c2)
    (on-conveyor c3)
    (on-conveyor c4)
    ;)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))

)