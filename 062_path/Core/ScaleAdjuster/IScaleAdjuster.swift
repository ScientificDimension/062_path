//
//  IScaleAdjuster.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import Foundation

protocol IScaleAdjuster {
    func calibrate(_ points: PointsVector)
    func adjustPointsToScreenSize(_ points: PointsVector) -> PointsVector
}

