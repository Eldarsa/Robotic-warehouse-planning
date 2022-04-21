(define (domain container)

    (:requirements :strips)
    
    (:predicates 
        (CONTAINER ?c)
        (LOCATION ?l)
        (TRANSPORT ?t)
        (AVAILABLE ?n)
        (at-container ?c ?l)
        (at-transport ?t ?l)
        (spot-transport ?t ?n)
        (in-transport ?c ?t ?n)
        (can-move ?t ?from ?to)
    )
    
    (:action load
        :parameters(?c ?l ?t ?n)
        :precondition(and (CONTAINER ?c)(LOCATION ?l)(TRANSPORT ?t)(AVAILABLE ?n)
                    (at-container ?c ?l)(at-transport ?t ?l)(spot-transport ?t ?n))
        :effect(and (in-transport ?c ?t ?n)(not(at-container ?c ?l))(not(spot-transport ?t ?n)))
    )
    
    (:action unload
        :parameters(?c ?t ?l ?n)
        :precondition(and (CONTAINER ?c)(TRANSPORT ?t)(LOCATION ?l)(AVAILABLE ?n)
                    (at-transport ?t ?l)(in-transport ?c ?t ?n))
        :effect(and (not(in-transport ?c ?t ?n))(at-container ?c ?l)(spot-transport ?t ?n))
    )
    
    (:action move
        :parameters(?c ?from ?to ?t ?n)
        :precondition(and (CONTAINER ?c)(LOCATION ?from)(LOCATION ?to)(TRANSPORT ?t)(AVAILABLE ?n)
        (at-transport ?t ?from)(can-move ?t ?from ?to))
        :effect(and (not(at-transport ?t ?from))(at-transport ?t ?to))
    )
)

;; TEMP STORAGE!!
(:process GOTO-BAY
    :parameters (?m1 - mover)
    :precondition (and
        ; activation condition
    )
    :effect (and
        ; continuous effect(s)
    )
)


(:action PICK-UP-CRATE
    :parameters ()
)

(:process MOVE-TO-BAY
    :parameters
    :precondition
    :effect
)

(:action PUT-DOWN-CRATE
    :parameters ()
    :precondition (and 
        
    )
    :effect (and 
        
    )
)

(:process PROCESS-NAME
    :parameters
    :precondition
    :effect
)
