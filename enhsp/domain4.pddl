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
    (waiting ?c - crate)
    (targeted ?c - crate)
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
    :parameters (?m - mover ?c - crate)
    :precondition (and
        (available ?m) 
        ;(waiting ?c)
        ;(< (weight ?c) 50)
        (not (heavy ?c))
    )
    :effect (and 
        (targeting ?m ?c)
        ;(targeted ?c)
        (not (available ?m))
        ;(not (waiting ?c))
    )
)

(:action TARGET-HEAVY-CRATE
    :parameters (?m1 - mover ?m2 - mover ?c - crate)
    :precondition (and 
        ;(not (= ?m1 ?m2))
        (different ?m1 ?m2)
        (available ?m1)
        (available ?m2)
        (waiting ?c)
        ;(>= (weight ?c) 50.0)
        (heavy ?c)
    )
    :effect (and 
        (targeting ?m1 ?c)
        (targeting ?m2 ?c)
        (targeted ?c)
        (not (available ?m1))
        (not (available ?m2))
        (not (waiting ?c))
    )
)

(:process GOTO-CRATE-FORWARD
    :parameters (?m - mover ?c - crate)
    :precondition (and
        (targeting ?m ?c)                     ; If assigned crate
        (> (- (position ?c) (position ?m)) 0)   ; but not already at same pos
        (targeted ?c) 
        (heavy ?c)                         ; .. and the crate is on the ground ofc..
    )
    :effect (and
        (increase (position ?m) (* #t 10))
    )
)

(:event ARRIVED-SINGLE
    :parameters (?m - mover ?c - crate)
    :precondition (and
        (targeting ?m ?c)
        (= (position ?c) (position ?m))
    )
    :effect (and
        ; discrete effect(s)
    )
)

(:process GOTO-CRATE-BACKWARD
    :parameters (?m1 - mover ?c - crate)
    :precondition (and
        (targeting ?m1 ?c)
        (< (- (position ?c) (position ?m1)) 0)
        (targeted ?c) 
    )
    :effect (and
        (decrease (position ?m1) (* #t 10))
    )
)

(:action PICK-UP-SINGLE
    :parameters (?m1 - mover ?c - crate)
    :precondition (and 
        (targeting ?m1 ?c)
        (= (position ?c) (position ?m1))
        (targeted ?c)
        (not (heavy ?c))
        ;(< (weight ?c) 50.0)
    )
    :effect (and 
        (transporting ?m1 ?c)
        (in-transport ?c)
        (not (targeting ?m1 ?c))
        (not (targeted ?c))

    )
)

(:action PICK-UP-DOUBLE
    :parameters (?m1 - mover ?m2 - mover ?c - crate)
    :precondition (and 
        ;(not (= ?m1 ?m2))
        (different ?m1 ?m2)
        (targeting ?m1 ?c)
        (targeting ?m2 ?c)
        (targeted ?c)
        (= (position ?c) (position ?m1))
        (= (position ?c) (position ?m2))
        (heavy ?c)
    )
    :effect (and 
        ;(transporting ?m1 ?m2 ?c)
        (transporting ?m1 ?c)
        (transporting ?m2 ?c)
        (not (targeting ?m1 ?c))
        (not (targeting ?m2 ?c))
        (in-transport ?c)
    )
)

)