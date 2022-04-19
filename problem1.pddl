(define (problem warehouse_problem1) (:domain warehouse)
(:objects 
    l1 - loader
    c1 c2 c3 - crate
    m1 m2 - mover
)

(:init
    ;todo: put the initial state's facts and numeric values here
    ; c1 => weight 70kg, dist 10
    ; c2 => weight 20kg, dist 20 (FRAGILE)
    ; c3 => weight 20kg, dist 20
    (= (weight c1) 70)
    (= (weight c2) 20)
    (= (weight c3) 20)

    (= (distance-crate c1) 10)
    (= (distance-crate c2) 20)
    (= (distance-crate c3) 20)
    
    ; Bay state
    (bay-free)

    ; Mover states
    (free m1)
    (free m2)
    (= (distance-mover m1) 0)
    (= (distance-mover m1) 0)

    ; Crate states
    (on-ground c1)
    (on-ground c2)
    (on-ground c3)

    ; Loader states
    (loader-free l1)
)

(:goal (and
    ;todo: put the goal condition here
    (on-conveyor c1)
    (on-conveyor c2)
    (on-conveyor c3)
)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)

)