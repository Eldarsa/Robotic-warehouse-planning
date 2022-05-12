(define (domain warehouse)

(:requirements :strips :equality :fluents :durative-actions :timed-initial-literals :typing :negative-preconditions :duration-inequalities)

(:types
    mover
    crate
    loader
)

(:predicates
    ; Mover states
    (available ?m - mover)
    (targeting ?m - mover ?c - crate)
    (by-crate ?m - mover ?c - crate)
    (transporting ?m - mover ?c - crate)
    (different ?m1 - mover ?m2 -mover)
    
    ; Crate states
    (not-fragile ?c - crate)
    (fragile ?c - crate)
    (waiting ?c - crate)
    (targeted ?c - crate)
    (in-transport ?c -crate)
    (on-bay ?c - crate)
    (on-conveyor ?c -crate)

    ; Bay states
    (bay-free)

    ; Loader states
    (loader-free ?l - loader)
    (loader-heavy-free ?l - loader)
)

(:functions
    
    (pos ?o)             ; Position of object with respect to bay
    (weight ?c - crate)     ; Weight of crates
)

(:action target-light
    :parameters (?m - mover ?c - crate)
    :precondition (and 
        (not-fragile ?c)
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

(:action target-double
    :parameters (?m1 - mover ?m2 - mover ?c - crate)
    :precondition (and 
        (available ?m1)
        (available ?m2)
        (different ?m1 ?m2)
        (waiting ?c)
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

; Move to crate with 10 distance units per time unit
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
        (not-fragile ?c)
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

(:action pick-up-two
    :parameters (?m1 - mover ?m2 - mover ?c - crate)
    :precondition (and 
        (different ?m1 ?m2)
        (by-crate ?m1 ?c)
        (by-crate ?m2 ?c)
        (targeted ?c)
        (targeting ?m1 ?c)
        (targeting ?m2 ?c)
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

; Transport light, non-fragile crate to bay with duration = distance*weight/100
(:durative-action transport-to-bay-single
    :parameters (?m - mover ?c - crate)
    :duration (= ?duration (/ (* (pos ?c) (weight ?c)) 100))
    :condition (and 
        (at start (not-fragile ?c))
        (at start (in-transport ?c))
        (at start (transporting ?m ?c))
        (at start (< (weight ?c) 50))
    )
    :effect (and 
        (at end (on-bay ?c ))
        (at end (not (bay-free)))
        (at end (not (in-transport ?c)))
        (at end (not (transporting ?m ?c)))
        (at end (assign (pos ?m) 0))
        (at end (available ?m))
    )
)

; Transport heavy crate to bay with duration = distance*weight/100
(:durative-action transport-to-bay-heavy
    :parameters (?m1 - mover ?m2 - mover ?c - crate)
    :duration (= ?duration (/ (* (pos ?c) (weight ?c)) 100))
    :condition (and 
        (at start (in-transport ?c))
        (at start (transporting ?m1 ?c))
        (at start (transporting ?m2 ?c))
        (at start (different ?m1 ?m2))
        (at start (>= (weight ?c) 50))
    )
    :effect (and 
        (at end (on-bay ?c))
        (at end (not (bay-free)))
        (at end (not (in-transport ?c)))
        (at end (not (transporting ?m1 ?c)))
        (at end (not (transporting ?m2 ?c)))
        (at end (assign (pos ?m1) 0))
        (at end (assign (pos ?m2) 0))
        (at end (available ?m1))
        (at end (available ?m2))
    )
)

; Transport light or light-fragile crate to bay with duration = distance*weight/150
(:durative-action transport-to-bay-double-light
    :parameters (?m1 - mover ?m2 - mover ?c - crate)
    :duration (= ?duration (/ (* (pos ?c) (weight ?c)) 150))
    :condition (and 
        (at start (in-transport ?c))
        (at start (transporting ?m1 ?c))
        (at start (transporting ?m2 ?c))
        (at start (different ?m1 ?m2))
        (at start (< (weight ?c) 50))
    )
    :effect (and 
        (at end (on-bay ?c))
        (at end (not (bay-free)))
        (at end (not (in-transport ?c)))
        (at end (not (transporting ?m1 ?c)))
        (at end (not (transporting ?m2 ?c)))
        (at end (assign (pos ?m1) 0))
        (at end (assign (pos ?m2) 0))
        (at end (available ?m1))
        (at end (available ?m2))
    )
)

; Non-fragile crates: duration = 4
; Use loader to transfer light, non-fragile crate to conveyor belt
(:durative-action transfer-to-conveyor-light
    :parameters (?l - loader ?c - crate)
    :duration (= ?duration 4)
    :condition (and 
        (at start (not-fragile ?c))
        (at start (on-bay ?c))
        (at start (loader-free ?l))
        (at start (< (weight ?c) 50))
        
    )
    :effect (and 
        (at start (not (loader-free ?l)))  
        (at start (bay-free))
        (at end (on-conveyor ?c))
        (at end (loader-free ?l))
    )
)

; Use loader to transfer heavy, non-fragile crate to conveyor belt
(:durative-action transfer-to-conveyor-heavy
    :parameters (?l - loader ?c - crate)
    :duration (= ?duration 4)
    :condition (and 
        (at start (not-fragile ?c))
        (at start (on-bay ?c))
        (at start (loader-heavy-free ?l))
        (at start (loader-free ?l))
        (at start (> (weight ?c) 50))

    )
    :effect (and 
        (at start (not (loader-heavy-free ?l))) 
        (at start (not (loader-free ?l))) 
        (at start (bay-free))
        (at end (on-conveyor ?c))
        (at end (loader-heavy-free ?l))
        (at end (loader-free ?l))
    )
)

; Fragile crates: duration = 6
; Use loader to transfer light, fragile crate to conveyor belt
(:durative-action transfer-to-conveyor-light-fragile
    :parameters (?l - loader ?c - crate)
    :duration (= ?duration 6)
    :condition (and 
        (at start (fragile ?c))
        (at start (on-bay ?c))
        (at start (loader-free ?l))
        (at start (< (weight ?c) 50))
    )
    :effect (and 
        (at start (not (loader-free ?l)))  
        (at start (bay-free))
        (at end (on-conveyor ?c))
        (at end (loader-free ?l))
    )
)

(:durative-action transfer-to-conveyor-heavy-fragile
    :parameters (?l - loader ?c - crate)
    :duration (= ?duration 6)
    :condition (and 
        (at start (fragile ?c))
        (at start (on-bay ?c))
        (at start (loader-heavy-free ?l))
        (at start (loader-free ?l))
        (at start (> (weight ?c) 50))
        
    )
    :effect (and 
        (at start (not (loader-heavy-free ?l)))  
        (at start (not (loader-free ?l)))
        (at start (bay-free))
        (at end (on-conveyor ?c))
        (at end (loader-heavy-free ?l))
        (at end (loader-free ?l))
    )
)
)