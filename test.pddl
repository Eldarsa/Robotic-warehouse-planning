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
    (= (weight c1) 20)
    (= (distance-crate c1) 10)

    
    ; Bay state
    (bay-free)

    ; Mover states
    (free m1)
    (free m2)
    (= (distance-mover m1) 0)
    (= (distance-mover m2) 0)

    ; Crate states
    (on-ground c1)
    (not (on-mover c1 m1))
    (not (on-mover c1 m2))
    (not (on-bay c1))
    (not (on-conveyor c1))

    ; Loader states
    (loader-free l1)
    (= (loading-time) 0)
)

(:goal (and
    ;todo: put the goal condition here
    ;(= (distance-mover m1) 10)
    ;(not (on-ground c1))
    (on-mover c1 m1)
)
)

;un-comment the following line if metric is needed
;(:metric minimize (???))

)