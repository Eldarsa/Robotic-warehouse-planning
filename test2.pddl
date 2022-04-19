(define (problem warehouse_problem1) (:domain warehouse)
(:objects 
    l1 - loader
    c1 - crate
    m1 m2 - mover
)

(:init
    ;todo: put the initial state's facts and numeric values here
    ; c1 => weight 70kg, dist 10
    ; c2 => weight 20kg, dist 20 (FRAGILE)
    ; c3 => weight 20kg, dist 20
    (= (weight c1) 70.0)
    (= (distance-crate c1) 10.0)

    
    ; Bay state
    (bay-free)

    ; Mover states
    (free m1)
    (free m2)
    (= (distance-mover m1) 0.0)
    (= (distance-mover m2) 0.0)

    ; Crate states
    (on-ground c1)

    ; Loader states
    (loader-free l1)
    (= (loading-time) 0.0)
)

(:goal
    (not (on-ground c1))
)

)