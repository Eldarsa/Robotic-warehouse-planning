(define (problem warehouse_problem1) (:domain warehouse)
(:objects 
    ;l1 - loader
    c1 c2 c3 - crate
    m1 m2 - mover
    l - loader
)

(:init
    ; c1 => weight 70kg, dist 10
    ; c2 => weight 20kg, dist 20 (FRAGILE)
    ; c3 => weight 20kg, dist 20
    (= (weight c1) 70)
    (= (weight c2) 20)
    (= (weight c3) 20)

    (= (pos c1) 10)
    (= (pos c2) 20)
    (= (pos c3) 10)
    
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
    
    ; Loader states
    (loader-free l)
    ;(= (loading-time) 0)
)

(:goal ( and
    (on-conveyor c1)
    (on-conveyor c2)
    (on-conveyor c3)
))
)