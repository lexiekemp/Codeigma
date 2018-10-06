//
//  RoundedView.swift
//  Codeigma
//
//  Created by Lexie Kemp on 10/6/18.
//  Copyright © 2018 Lexie Kemp. All rights reserved.
//

import Foundation
import UIKit

class RoundedView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        //Custom manually positioning layout goes here (auto-layout pass has already run first pass)
    }
}
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
