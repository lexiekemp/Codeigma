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
    @IBOutlet weak var googleLogin: UIView!
    @IBOutlet weak var scanNow: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.nextView(_:)))
        self.scanNow.addGestureRecognizer(gesture)

        googleLogin.layer.cornerRadius = 30
        scanNow.layer.cornerRadius = 30

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

    @objc func nextView(_ sender:UITapGestureRecognizer){
        performSegue(withIdentifier: "cropSegue", sender: nil)
    }
}

