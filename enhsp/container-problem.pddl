(define (problem container-problem)

    (:domain container)
    
    (:objects
        c1 c2 c3 c4 c5 c6 c7 c8
        h1 h2 h3 h4 stationF stationI
        train truck1 truck2 truck3 truck4
        spot_truck1 spot_truck2 spot_truck3 spot_truck4
        spot_train1 spot_train2 spot_train3 spot_train4
    
    )
    
    (:init
        (CONTAINER c1)(CONTAINER c2)(CONTAINER c3)(CONTAINER c4)(CONTAINER c5)(CONTAINER c6)(CONTAINER c7)(CONTAINER c8)
        (LOCATION h1)(LOCATION h2)(LOCATION h3)(LOCATION h4)(LOCATION stationF)(LOCATION stationI)
        (TRANSPORT train)(TRANSPORT truck1)(TRANSPORT truck2)(TRANSPORT truck3)(TRANSPORT truck4)
        (AVAILABLE spot_truck1)(AVAILABLE spot_truck2)(AVAILABLE spot_truck3)(AVAILABLE spot_truck4)
        (AVAILABLE spot_train1)(AVAILABLE spot_train2)(AVAILABLE spot_train3)(AVAILABLE spot_train4)
        (at-container c1 h1)(at-container c2 h1)(at-container c3 h1)(at-container c4 h1)
        (at-container c5 h2)(at-container c6 h2)(at-container c7 h2)(at-container c8 h2)
        (at-transport train stationI)(at-transport truck1 h1)(at-transport truck2 h2)
        (at-transport truck3 h3)(at-transport truck4 h4)
        (spot-transport train spot_train1)(spot-transport train spot_train2)
        (spot-transport train spot_train3)(spot-transport train spot_train4)
        (spot-transport truck1 spot_truck1)(spot-transport truck2 spot_truck2)
        (spot-transport truck3 spot_truck3)(spot-transport truck4 spot_truck4)
        
        (can-move train stationI stationF)(can-move train stationF stationI)
        (can-move truck1 h1 h2)(can-move truck1 h2 h1)(can-move truck1 h1 stationI)
        (can-move truck1 h2 stationI)(can-move truck1 stationI h1)(can-move truck1 stationI h2)
        (can-move truck2 h1 h2)(can-move truck2 h2 h1)(can-move truck2 h1 stationI)
        (can-move truck2 h2 stationI)(can-move truck2 stationI h1)(can-move truck2 stationI h2)
        (can-move truck3 h3 h4)(can-move truck3 h4 h3)(can-move truck3 h3 stationF)
        (can-move truck3 h4 stationF)(can-move truck3 stationF h3)(can-move truck3 stationF h4)
        (can-move truck4 h3 h4)(can-move truck4 h4 h3)(can-move truck4 h3 stationF)
        (can-move truck4 h4 stationF)(can-move truck4 stationF h3)(can-move truck4 stationF h4)
    )
    
    (:goal (and
    (at-container c1 h3)(at-container c2 h3)(at-container c3 h3)(at-container c4 h3)
    (at-container c5 h4)(at-container c6 h4)(at-container c7 h4)(at-container c8 h4)
    ))
)