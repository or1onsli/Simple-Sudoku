//
//  RoundedButton.swift
//  StanfordCalculator
//
//  Created by Fabio Cipriani on 04/09/16.
//  Copyright © 2016 Fabio Cipriani. All rights reserved.
//

import UIKit

protocol RoundedCorners {}
extension RoundedCorners where Self: Button {
    
    func roundCornersAndDropShadow(cornerRadius: CGFloat, shadowColor: CGColor, shadowOpacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat) -> Void {
        
        layer.cornerRadius = cornerRadius//30
        layer.shadowColor = shadowColor//UIColor.black.cgColor
        layer.shadowOpacity = shadowOpacity//0.7
        layer.shadowOffset = shadowOffset //.zero
        layer.shadowRadius = shadowRadius //100
    }
}
