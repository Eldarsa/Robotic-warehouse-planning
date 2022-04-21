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
    ;(= (weight c1) 60)
    ;(= (weight c2) 60)
    ;(= (weight c3) 60)

    (not (heavy c1))
    (heavy c2)
    (not (heavy c3))

    (= (position c1) 60)
    (= (position c2) 10)
    (= (position c3) 20)
    
    ; Bay state
    (bay-free)

    ; Mover states
    (available m1)
    (available m2)
    (= (position m1) 0)
    (= (position m2) 0)
    (different m1 m2)
    (different m2 m1)
    ;(not (= m1 m2))
    ; Crate states
    (onground c1)
    (onground c2)
    (onground c3)

    ; Loader states
    ;(loader-free l1)
    ;(= (loading-time) 0)
)

(:goal ( and
    ;(not (= m1 m2))
    ;(different m1 m2)
    ;(targeting m1 c2)
    ;(targeting m2 c2)
    ;(= (position c2) (position m1))
    ;(= (position c2) (position m2))
    ;(onground c2)
    (not (onground c2))
    ;(= (position ?c1) (position ?m1))
    ;(= (position ?c1) (position ?m2))
    )
)

;un-comment the following line if metric is needed
;(:metric minimize (???))

)