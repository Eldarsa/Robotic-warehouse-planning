(define (domain warehouse)

;remove requirements that are not needed
(:requirements :strips :time :fluents :typing :equality :timed-initial-literals  :conditional-effects :negative-preconditions :duration-inequalities)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
    mover
    crate
    loader
    weight
)
; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here

    ; Mover states
    (free ?m - mover)

    ; Crate states
    (on-ground ?c -crate)    
    (on-mover ?c - crate ?m - mover)
    (on-bay ?c - crate)
    (on-conveyor ?c - crate)

    ; Bay states
    (bay-free)

    ; Loader states
    (loader-free ?l)
    (loading ?l - loader ?c - crate)
)



(:functions ;todo: define numeric functions here
    (distance-mover ?m - mover) ;distance between mover and loading bay
    (distance-crate ?c - crate)
    (weight ?c - crate)
    (loading-time)
)

;define actions here


(:process MOVING-TO-CRATE
    :parameters (?m - mover ?c - crate)
    :precondition (and
            (free ?m)
            (> (- (distance-mover ?m) (distance-crate ?c)) 0)        
    )
    :effect (and
            (increase (distance-mover ?m) (* #t 10))
    )
)

(:action PICK-UP-SINGLE
    :parameters (?m - mover ?c - crate )
    :precondition (and 
            (< (weight ?c) 50) 
            (free ?m) 
            (on-ground ?c) 
            (= (distance-mover ?m) (distance-crate ?c))
    )
    :effect (and
            (not (on-ground ?c))
            (not (free ?m))
            (on-mover ?c ?m)
    )
)

(:action PICK-UP-DOUBLE
    :parameters (?m1 - mover ?m2 - mover ?c - crate )
    :precondition (and 
            (free ?m1)
            (free ?m2) 
            (on-ground ?c) 
            (= (distance-mover ?m1) (distance-crate ?c))
            (= (distance-mover ?m2) (distance-crate ?c))
    )
    :effect (and
            (not (on-ground ?c))
            (not (free ?m1))
            (not (free ?m2))
            (on-mover ?c ?m1)
            (on-mover ?c ?m2)
    )
)

(:process MOVING-TO-BAY-SINGLE
    :parameters (?m - mover ?c - crate)
    :precondition (and
        (on-mover ?c ?m)    
        (> (distance-mover ?m) 0)   
            
    )        
    :effect (and
        (decrease (distance-mover ?m) (* #t (/ 100 (weight-crate ?c))))
        
    )
)

(:process MOVING-TO-BAY-DOUBLE-LIGHT
    :parameters (?m1 - mover ?m2 - mover ?c - crate)
    :precondition (and
        (< (weight-crate ?c) 50)
        (on-mover ?c ?m1)
        (on-mover ?c ?m2)    
        (> (distance-mover ?m1) 0)
        (> (distance-mover ?m2) 0)            
    )        
    :effect (and
        (decrease (distance-mover ?m1) (* #t (/ 150 (weight-crate ?c))))
        (decrease (distance-mover ?m2) (* #t (/ 150 (weight-crate ?c))))
    )
)

(:process MOVING-TO-BAY-DOUBLE-HEAVY
    :parameters (?m1 - mover ?m2 - mover ?c - crate)
    :precondition (and
        (>= (weight-crate ?c) 50)
        (on-mover ?c ?m1)
        (on-mover ?c ?m2)    
        (> (distance-mover ?m1) 0)
        (> (distance-mover ?m2) 0)    
            
    )        
    :effect (and
        (decrease (distance-mover ?m1) (* #t (/ 100 (weight-crate ?c))))
        (decrease (distance-mover ?m2) (* #t (/ 100 (weight-crate ?c))))
    )
)

(:action put-down-crate-single
    :parameters (?c - crate ?m - mover)
    :precondition (and
            (on-mover ?c ?m)
            (not (free ?m))
            (= (distance-mover ?m) 0)
            (bay-free)
    )
    :effect (and
            (not (on-mover ?c))
            (on-bay ?c)
            (free ?m)
            (not (bay-free))
    )
)

(:action put-down-crate-double
    :parameters (?c - crate ?m1 - mover ?m2 - mover)
    :precondition (and
            (on-mover ?c ?m1)
            (on-mover ?c ?m2)
            (not (free ?m1))
            (not (free ?m2))
            (= (distance-mover ?m1) 0)
            (= (distance-mover ?m2) 0)
            (bay-free)
    )
    :effect (and
            (not (on-mover ?c ?m1))
            (not (on-mover ?c ?m2))
            (on-bay ?c)
            (free ?m1)
            (free ?m2)
            (not (bay-free))
    )
)

(:action START-LOADING-CRATE
    :parameters (?l - loader ?c - crate)
    :precondition (and
            (on-bay ?c)
            (loader-free ?l)
            (= (loading-time) 0)
    )
    :effect (and
            (not (on-bay ?c))
            (loading ?l ?c)
            (not (loader-free ?l))
            (bay-free)
    )
)

(:process LOADING    
    :parameters (?l - loader)
    :precondition (and
        (not (loader-free))
        (< (loading-time) 4)

    )
    :effect (increase (loading-time) (* #t 1))
    
)

(:event FINISH-LOADING-CRATE
    :parameters (?l - loader ?c - crate)
    :precondition(and
            ; Time loading finished
            (loading ?l ?c)
            (= (loading-time) 4)
    )
    :effect (and
            (on-conveyor ?c)
            (loader-free ?l)
            (not (loading ?l ?c))
            (assign (loading-time) 0)        
    )                 
)


)
