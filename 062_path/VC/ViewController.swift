//
//  ViewController.swift
//  062_path
//
//  Created by Oleg Kolomyitsev on 28/07/2018.
//  Copyright © 2018 Oleg Kolomyitsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Processor
    
    private lazy var processor: IProcessor = Processor(self)

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let canStart = processor.tryToStartWorking()
        
        guard canStart else {
            print("Error: failed to start processor")
            return
        }
    }
}
