//
//  GradientViewController.swift
//  Codeigma
//
//  Created by Bart Chrzaszcz on 2018-10-06.
//  Copyright © 2018 Lexie Kemp. All rights reserved.
//

import UIKit

class GradientViewController: UIViewController {

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
