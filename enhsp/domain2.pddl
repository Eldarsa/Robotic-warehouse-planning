(define (domain warehouse)

(:requirements :typing :strips :fluents :equality :negative-preconditions) 

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    mover
    crate
    loader
)

(:predicates

    ; Mover states
    (available ?m - mover)              ; Available for assignment
    (targeting ?m - mover ?c - crate)
    (transporting ?m - mover ?c - crate)   
    ;(transporting ?m1 - mover ?m2 - mover ?c -crate)                 ; Moving
    (different ?m1 - mover ?m2 - mover)

    ; Crate states
    (onground ?c - crate)
    (in-transport ?c -crate)
    (on-bay ?c - crate)
    (on-conveyor ?c - crate)
    (heavy ?c - crate)

    ; Bay states
    (bay-free)

    ; Loader states
    (loader-free ?l)
    (loading ?l - loader ?c - crate)

)

(:functions
    (position ?o1)
    (weight ?c - crate)
    (loading-time)
)

(:action TARGET-LIGHT-CRATE
    :parameters (?m1 - mover ?c1 - crate)
    :precondition (and
        (available ?m1) 
        (onground ?c1)
        ;(< (weight ?c1) 50)
        (not (heavy ?c1))
    )
    :effect (and 
        (targeting ?m1 ?c1)
        (not (available ?m1))
    )
)

(:action TARGET-HEAVY-CRATE
    :parameters (?m1 - mover ?m2 - mover ?c1 - crate)
    :precondition (and 
        ;(not (= ?m1 ?m2))
        (different ?m1 ?m2)
        (available ?m1)
        (available ?m2)
        (onground ?c1)
        ;(>= (weight ?c1) 50.0)
        (heavy ?c1)
    )
    :effect (and 
        (targeting ?m1 ?c1)
        (targeting ?m2 ?c1)
        (not (available ?m1))
        (not (available ?m2))
    )
)


(:process GOTO-CRATE-FORWARD
    :parameters (?m1 - mover ?c1 - crate)
    :precondition (and
        (targeting ?m1 ?c1)                     ; If assigned crate
        (> (- (position ?c1) (position ?m1)) 0)   ; but not already at same pos
        (onground ?c1)                          ; .. and the crate is on the ground ofc..
    )
    :effect (and
        (increase (position ?m1) (* #t 10))
    )
)

(:process GOTO-CRATE-BACKWARD
    :parameters (?m1 - mover ?c1 - crate)
    :precondition (and
        (targeting ?m1 ?c1)
        (< (- (position ?c1) (position ?m1)) 0)
        (onground ?c1) 
    )
    :effect (and
        (decrease (position ?m1) (* #t 10))
    )
)

(:action PICK-UP-SINGLE
    :parameters (?m1 - mover ?c1 - crate)
    :precondition (and 
        (targeting ?m1 ?c1)
        (= (position ?c1) (position ?m1))
        (onground ?c1)
        (not (heavy ?c1))
        ;(< (weight ?c1) 50.0)
    )
    :effect (and 
        (transporting ?m1 ?c1)
        (not (targeting ?m1 ?c1))
        (not (onground ?c1))
    )
)

(:action PICK-UP-DOUBLE
    :parameters (?m1 - mover ?m2 - mover ?c - crate)
    :precondition (and 
        ;(not (= ?m1 ?m2))
        (different ?m1 ?m2)
        (targeting ?m1 ?c)
        (targeting ?m2 ?c)
        (= (position ?c) (position ?m1))
        (= (position ?c) (position ?m2))
        (onground ?c)
        (heavy ?c)
    )
    :effect (and 
        ;(transporting ?m1 ?m2 ?c)
        ;(transporting ?m1 ?c)
        ;(transporting ?m2 ?c)
        ;(not (targeting ?m1 ?c))
        ;(not (targeting ?m2 ?c))
        (not (onground ?c))
    )
)

)