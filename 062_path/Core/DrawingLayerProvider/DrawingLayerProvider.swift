//
//  DrawingLayerProvider.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 29/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class DrawingLayerProvider: IDrawingLayerProvider {
    
    // MARK: - IDrawingLayerProvider
    
    lazy var pointsLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = Constants.Drawing.Point.color.cgColor
        
        return layer
    }()
    
    lazy var routesLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = Constants.Drawing.Route.color.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = Constants.Drawing.Route.width
        layer.lineCap = kCALineCapRound
        
        return layer
    }()
    
    lazy var startPointLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = Constants.Drawing.Point.color.cgColor
        
        return layer
    }()
    
    lazy var finalPointLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = Constants.Drawing.Point.color.cgColor
        
        return layer
    }()
    
}
