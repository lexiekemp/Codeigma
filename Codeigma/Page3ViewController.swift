//
//  Page3ViewController.swift
//  Codeigma
//
//  Created by Bart Chrzaszcz on 2018-10-06.
//  Copyright © 2018 Lexie Kemp. All rights reserved.
//

import UIKit

class Page3ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {

    var capturedImage: UIImage!

    // Next button on this page acts as the button to open up the camera
    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    // Gets called after user selects a photo.
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Save image and segue to next page to loading
        // Possibly send the file using Alamofire here too
        capturedImage = image
        dismiss(animated:true) {
            self.performSegue(withIdentifier: "goToLoading", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLoading" {
            if let loadingVC = segue.destination as? LoadingViewController, capturedImage != nil {
                loadingVC.codeImage = capturedImage
            }
        }
    }
}
