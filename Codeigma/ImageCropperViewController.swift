//
//  ImageCropperViewController.swift
//  Codeigma
//
//  Created by Bart Chrzaszcz on 2018-10-05.
//  Copyright © 2018 Lexie Kemp. All rights reserved.
//

import UIKit

class ImageCropperViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var cropAreaView: CropAreaView!

    @IBOutlet var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = 10.0
        }
    }

    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        print("2@")
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imagePicked.image = image
        dismiss(animated:true, completion: nil)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imagePicked
    }

    var cropArea:CGRect{
        get{
            let factor = imagePicked.image!.size.width/view.frame.width
            let scale = 1/scrollView.zoomScale
            let imageFrame = imagePicked.imageFrame()
            let x = (scrollView.contentOffset.x + cropAreaView.frame.origin.x - imageFrame.origin.x) * scale * factor
            let y = (scrollView.contentOffset.y + cropAreaView.frame.origin.y - imageFrame.origin.y) * scale * factor
            let width = cropAreaView.frame.size.width * scale * factor
            let height = cropAreaView.frame.size.height * scale * factor
            return CGRect(x: x, y: y, width: width, height: height)
        }
    }

    @IBAction func crop(_ sender: UIButton) {
        let croppedCGImage = imagePicked.image?.cgImage?.cropping(to: cropArea)
        let croppedImage = UIImage(cgImage: croppedCGImage!)
        imagePicked.image = croppedImage

        scrollView.zoomScale = 1
    }
}

extension UIImageView {
    func imageFrame()->CGRect{
        let imageViewSize = self.frame.size

        guard let imageSize = self.image?.size else{return CGRect.zero}

        let imageRatio = imageSize.width / imageSize.height
        let imageViewRatio = imageViewSize.width / imageViewSize.height

        if imageRatio < imageViewRatio {
            let scaleFactor = imageViewSize.height / imageSize.height
            let width = imageSize.width * scaleFactor
            let topLeftX = (imageViewSize.width - width) * 0.5

            return CGRect(x: topLeftX, y: 0, width: width, height: imageViewSize.height)
        } else {
            let scalFactor = imageViewSize.width / imageSize.width
            let height = imageSize.height * scalFactor
            let topLeftY = (imageViewSize.height - height) * 0.5

            return CGRect(x: 0, y: topLeftY, width: imageViewSize.width, height: height)
        }
    }
}
