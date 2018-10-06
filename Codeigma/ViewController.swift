//
//  ViewController.swift
//  Codeigma
//
//  Created by Lexie Kemp on 10/5/18.
//  Copyright © 2018 Lexie Kemp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = self.view.bounds

        //gradientLayer.colors = [UIColor.red.cgColor, codeigmaLightBlue.cgColor]
        gradientLayer.colors = [codeigmaDarkBlue.cgColor, codeigmaLightBlue.cgColor]

        gradientLayer.locations = [0.0, 1.0]

        let container = UIView()

        container.layer.addSublayer(gradientLayer)
        self.view.addSubview(container)
        self.view.sendSubviewToBack(container)
    }
}

