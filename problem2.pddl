(define (problem warehouse_problem2) (:domain warehouse)
(:objects 
    l1 - loader
    c1 c2 c3 c4 - crate
    m1 m2 - mover
)

(:init
    ;todo: put the initial state's facts and numeric values here
    ; c1 => weight 70kg, dist 10 (HEAVY)
    ; c2 => weight 80kg, dist 20 (HEAVY, FRAGILE)
    ; c3 => weight 20kg, dist 20 (LIGHT)
    ; c4 => weight 30kg, dist 10 (LIGHT)
    (= (weight c1) 70)
    (= (weight c2) 80)
    (= (weight c3) 20)
    (= (weight c4) 30)

    (= (distance-crate c1) 10)
    (= (distance-crate c1) 20)
    (= (distance-crate c1) 20)
    (= (distance-crate c1) 10)

 
    ; Bay state
    (bay-free)
    (= (loading-time) 0)

    ; Mover states
    (free m1)
    (free m2)
    (= (distance-mover m1) 0)
    (= (distance-mover m1) 0)

    ; Crate states
    (on-ground c1)
    (on-ground c2)
    (on-ground c3)
    (on-ground c4)

    ; Loader states
    (loader-free l1)
)

(:goal (and
    ;todo: put the goal condition here
    (on-conveyor c1)
    (on-conveyor c2)
    (on-conveyor c3)
    (on-conveyor c4)
)

;un-comment the following line if metric is needed
;(:metric minimize (???))
)

)