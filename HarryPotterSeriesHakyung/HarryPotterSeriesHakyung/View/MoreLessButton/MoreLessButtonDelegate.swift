//
//  MoreLessButtonDelegate.swift
//  HarryPotterSeriesHakyung
//
//  Created by kingj on 4/2/25.
//

import UIKit

protocol MoreLessButtonDelegate: AnyObject {
    func didMoreLessButtonToggle(toggle isExpanded: Bool, _ text: String) 
}
