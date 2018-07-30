//
//  RouteDistanceEstimator.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

class RouteDistanceEstimator: IRouteDistanceEstimator {
    
    // MARK: - Memory Management
    
    let distanceMatrix: DistanceMatrix
    
    init(_ distanceMatrix: DistanceMatrix) {
        self.distanceMatrix = distanceMatrix
    }
    
    // MARK: - IRouteDistanceEstimator
    
    func getRouteWithMinimalDistance(_ routes: Routes) -> [Vertex] {
        precondition(!routes.isEmpty, "Routes should not be empty")
        guard routes.count > 1 else {
            
            return routes.first!
        }
        let distances = routes.map { route in
            return zip(route.dropLast(), route.dropFirst())
                .map{ distanceMatrix[$0.0][$0.1] }
                .reduce(0, + )
        }
        let index = distances.getIndexOfMinimalElement()
        
        return routes[index]
    }
}
