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
    (transporting ?m1 - mover ?m2 - mover ?c -crate)                 ; Moving     


    ; Crate states
    (on-ground ?c - crate)
    (in-transport ?c -crate)
    (on-bay ?c - crate)
    (on-conveyor ?c - crate)

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
        (on-ground ?c1)
        (< (weight ?c1) 50)
    )
    :effect (and 
        (targeting ?m1 ?c1)
        (not (available ?m1))
    )
)

(:action TARGET-HEAVY-CRATE
    :parameters (?m1 - mover ?m2 - mover ?c1 - crate)
    :precondition (and 
        (available ?m1)
        (available ?m2)
        (not (= ?m1 ?m2))
        (on-ground ?c1)
        (>= (weight ?c1) 50)
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
        (on-ground ?c1)                          ; .. and the crate is on the ground ofc..
    )
    :effect (and
        (increase (position ?m1) (* #t 1.0))
    )
)

(:process GOTO-CRATE-BACKWARD
    :parameters (?m1 - mover ?c1 - crate)
    :precondition (and
        (targeting ?m1 ?c1)
        (< (- (position ?c1) (position ?m1)) 0)
        (on-ground ?c1) 
    )
    :effect (and
        (decrease (position ?m1) (* #t 1.0))
    )
)

(:action PICK-UP-SINGLE
    :parameters (?m1 - mover ?c1 - crate)
    :precondition (and 
        (targeting ?m1 ?c1)
        (= (position ?c1) (position ?m1))
        (on-ground ?c1)
        (< (weight ?c1) 50)
    )
    :effect (and 
        (transporting ?m1 ?c1)
        (not (targeting ?m1 ?c1))
        (not (on-ground ?c1))
    )
)

(:action PICK-UP-DOUBLE
    :parameters (?m1 - mover ?m2 - mover ?c1 - crate)
    :precondition (and 
        (targeting ?m1 ?c1)
        (targeting ?m2 ?c1)
        (not (= ?m1 ?m2))
        (= (position ?c1) (position ?m1))
        (= (position ?c1) (position ?m2))
        (on-ground ?c1)
        (>= (weight ?c1) 50)
    )
    :effect (and 
        (transporting ?m1 ?m2 ?c1)
        (not (targeting ?m1 ?c1))
        (not (targeting ?m2 ?c1))
        (not (on-ground ?c1))
    )
)

)