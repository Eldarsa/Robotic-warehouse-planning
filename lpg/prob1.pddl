(define (problem warehouse_problem1) (:domain warehouse)
(:objects 
    ;l1 - loader
    c1 c2 c3 - crate
    m1 m2 - mover
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
    ; (not (targeting m1 c1))
    ; (not (targeting m1 c2))
    ; (not (targeting m1 c3))
    ; (not (targeting m2 c1))
    ; (not (targeting m2 c2))
    ; (not (targeting m2 c3))
    ; (not (by-crate m1 c1))
    ; (not (by-crate m2 c1))
    ; (not (by-crate m1 c2))
    ; (not (by-crate m2 c2))
    ; (not (by-crate m1 c3))
    ; (not (by-crate m2 c3))
    ; (not (transporting m1 c1))
    ; (not (transporting m1 c2))
    ; (not (transporting m1 c3))
    ; (not (transporting m2 c1))
    ; (not (transporting m2 c2))
    ; (not (transporting m2 c3))
    ; Crate states
    (waiting c1)
    (waiting c2)
    (waiting c3)
    ; (not (targeted c1))
    ; (not (targeted c2))
    ; (not (targeted c3))
    ; (not (in-transport c1))
    ; (not (in-transport c2))
    ; (not (in-transport c3))
    ; (not (on-bay c1))
    ; (not (on-bay c2))
    ; (not (on-bay c3))
    ; (not (on-loader c1))
    ; (not (on-loader c2))
    ; (not (on-loader c3))
    ; (not (on-conveyor c1))
    ; (not (on-conveyor c2))
    ; (not (on-conveyor c3))
    

    ; Loader states
    ;(loader-free l1)
    ;(= (loading-time) 0)
)

(:goal ( and
    ;(different m1 m2)
    ;(targeting m1 c2)
    ;(targeting m2 c2)
    ;(targeted c3)
    ;(= (pos m1) (pos c1))
    ;(= (pos m2) (pos c1))
    ;(in-transport c2)
    (in-transport c2)
    ;)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))

)