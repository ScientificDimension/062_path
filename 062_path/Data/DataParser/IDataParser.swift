//
//  IDataParser.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

typealias PointsVector = [CGPoint]
typealias DistanceMatrix = [[Double]]
typealias TransitionMatrix = [[Int]] 
typealias VisiblePointsMatrix = [[[CGPoint]]]

protocol IDataParser {
    func getPointsVector(from data: Container) -> PointsVector
    func getDistanceMatrix(from data: Container) -> DistanceMatrix
    func getTransitionMatrix(from data: Container) -> TransitionMatrix
    func getVisiblePointsMatrix(from data: Container) -> VisiblePointsMatrix
}
