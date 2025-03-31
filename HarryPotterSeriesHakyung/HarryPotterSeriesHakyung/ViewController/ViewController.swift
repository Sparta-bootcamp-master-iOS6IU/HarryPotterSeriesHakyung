//
//  ViewController.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 3/28/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    private let harryPotterView = HarryPotterSeriseView()
    
    override func loadView() {
        super.loadView()
        view = harryPotterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
