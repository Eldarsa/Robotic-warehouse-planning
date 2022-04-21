(define (problem warehouse_problem1) (:domain warehouse)
(:objects 
    ;l1 - loader
    c1 c2 c3 c4 c5 c6 - crate
    m1 m2 - mover
    l - loader
)

(:init
    ; c1 => weight 30kg, dist 20 (LIGHT)
    ; c2 => weight 20kg, dist 20 (LIGHT, FRAGILE)
    ; c3 => weight 30kg, dist 10 (LIGHT)
    ; c4 => weight 20kg, dist 20 (LIGHT)
    ; c5 => weight 30kg, dist 30 (LIGHT)
    ; c6 => weight 20kg, dist 10 (LIGHT)
    (= (weight c1) 30)
    (= (weight c2) 20)
    (= (weight c3) 30)
    (= (weight c4) 20)
    (= (weight c5) 30)
    (= (weight c6) 20)

    (= (pos c1) 20)
    (= (pos c2) 20)
    (= (pos c3) 10)
    (= (pos c4) 20)
    (= (pos c5) 30)
    (= (pos c6) 10)

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
    (waiting c5)
    (waiting c6)

    

    ; Loader states
    (loader-free l)
    ;(= (loading-time) 0)
)

(:goal ( and
    (on-conveyor c1)
    (on-conveyor c2)
    (on-conveyor c3)
    (on-conveyor c4)
    (on-conveyor c5)
    (on-conveyor c6)
    ;)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))

)