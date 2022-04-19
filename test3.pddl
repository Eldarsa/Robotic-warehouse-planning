(define (problem warehouse_problem1) (:domain warehouse)
(:objects 
    ;l1 - loader
    c1 c2 c3 - crate
    m1 m2 - mover
)

(:init
    ;todo: put the initial state's facts and numeric values here
    ; c1 => weight 70kg, dist 10
    ; c2 => weight 20kg, dist 20 (FRAGILE)
    ; c3 => weight 20kg, dist 20
    (= (weight c1) 70)
    (= (weight c2) 50)
    (= (weight c3) 20)

    (= (position c1) 10)
    (= (position c2) 30)
    (= (posiiton c3) 20)
    
    ; Bay state
    (bay-free)

    ; Mover states
    (available m1)
    (available m2)
    (= (position m1) 0)
    (= (position m2) 0)

    ; Crate states
    (on-ground c1)
    (on-ground c2)
    (on-ground c3)

    ; Loader states
    ;(loader-free l1)
    ;(= (loading-time) 0)
)

(:goal (and
    (targeting m1 c1)
    (= (position c1) (position m1))
    (on-ground c1)
    )
)

;un-comment the following line if metric is needed
;(:metric minimize (???))

)