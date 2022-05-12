(define (problem warehouse_problem1) (:domain warehouse)
(:objects 
    c1 c2 c3 - crate
    m1 m2 - mover
    lh ll - loader
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

    (not-fragile c1)
    (not-fragile c3)
    (fragile c2)
    
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
    (loader-free ll)
    (loader-free lh)
    (loader-heavy-free lh)
)

(:goal ( and
    (on-conveyor c1)
    (on-conveyor c2)
    (on-conveyor c3)
))

)