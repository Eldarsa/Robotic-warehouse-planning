(define (domain warehouse)

(:requirements :strips :equality :fluents :durative-actions :timed-initial-literals :typing :negative-preconditions :duration-inequalities)

;(:requirements :strips :typing :durative-actions)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    mover
    crate
    loader
)
; un-comment following line if constants are needed
;(:constants )

(:predicates

    ; Mover states
    (available ?m - mover)
    (targeting ?m - mover ?c - crate)
    (by-crate ?m - mover ?c - crate)
    (transporting ?m - mover ?c - crate)
    (different ?m1 - mover ?m2 -mover)
    
    ; Crate states
    (waiting ?c - crate)
    (targeted ?c - crate)
    (in-transport ?c -crate)
    (on-bay ?c - crate)
    (on-loader ?c - crate)
    (on-conveyor ?c -crate)

    ; Bay states
    (bay-free)

    ; Loader states
    ;(loader-free ?l - loader)
    ;(loading ?l - loader ?c - crate)
)

(:functions
    (pos ?o)
    (weight ?c - crate)
)

(:action target-light
    :parameters (?m - mover ?c - crate)
    :precondition (and 
        (available ?m)
        (waiting ?c)
        (< (weight ?c) 50)
    )
    :effect (and
        (not (waiting ?c))
        (not (available ?m))
        (targeted ?c)
        (targeting ?m ?c)
    )
)

(:action target-heavy
    :parameters (?m1 - mover ?m2 - mover ?c - crate)
    :precondition (and 
        (available ?m1)
        (available ?m2)
        (different ?m1 ?m2)
        (waiting ?c)
        (>= (weight ?c) 50)  ;;NB
    )
    :effect (and 
        (not (waiting ?c))
        (not (available ?m1))
        (not (available ?m2))
        (targeted ?c)
        (targeting ?m1 ?c)
        (targeting ?m2 ?c)
    )
)


(:durative-action go-to-crate-forward
    :parameters (?m - mover ?c - crate)
    :duration(= ?duration (/ (- (pos ?c) (pos ?m)) 10))
    :condition (and 
       (at start (> (pos ?c) (pos ?m)))
       (at start (targeting ?m ?c))
       (at start (targeted ?c))
    )
    :effect (and 
        (at end (assign (pos ?m) (pos ?c)))
        (at end (by-crate ?m ?c))
    )
)

(:action pick-up-light
    :parameters (?m - mover ?c - crate)
    :precondition (and 
        ;(= (- (pos ?m) (pos ?c)) 0)
        (by-crate ?m ?c)
        (targeted ?c)
        (targeting ?m ?c)
        (< (weight ?c) 50)
        )
    :effect (and
        (in-transport ?c)
        (transporting ?m ?c)
        (not (targeted ?c))
        (not (targeting ?m ?c))
        )
)

(:action pick-up-heavy
    :parameters (?m1 - mover ?m2 - mover ?c - crate)
    :precondition (and 
        ;(= (- (pos ?m) (pos ?c)) 0)
        (different ?m1 ?m2)
        (by-crate ?m1 ?c)
        (by-crate ?m2 ?c)
        (targeted ?c)
        (targeting ?m1 ?c)
        (targeting ?m2 ?c)
        (>= (weight ?c) 50)
        )
    :effect (and
        (in-transport ?c)
        (transporting ?m1 ?c)
        (transporting ?m2 ?c)
        (not (targeted ?c))
        (not (targeting ?m1 ?c))
        (not (targeting ?m2 ?c))
        )
)



)