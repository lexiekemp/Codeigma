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
//    @IBOutlet weak var cropScrollView: UIScrollView!

    @IBOutlet var imageScrollView: UIScrollView!{
        didSet{
            imageScrollView.delegate = self
            imageScrollView.minimumZoomScale = 1.0
            imageScrollView.maximumZoomScale = 10.0
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
    @IBAction func confirmZoom(_ sender: Any) {
        imageScrollView.isUserInteractionEnabled = false

        //imageScrollView.pinchGestureRecognizer?.isEnabled = false
        //imageScrollView.panGestureRecognizer.isEnabled = false

//        cropScrollView.isHidden = false
//        cropScrollView.isExclusiveTouch = true
//        cropScrollView.delegate = self
//        cropScrollView.minimumZoomScale = 1.0
//        cropScrollView.maximumZoomScale = 10.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        cropScrollView.isHidden = true
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imagePicked.image = image
        dismiss(animated:true, completion: nil)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imagePicked
    }

    var cropArea: CGRect {
        get{
            let factor = imagePicked.image!.size.width/view.frame.width
            let scale = 1/imageScrollView.zoomScale
            let imageFrame = imagePicked.imageFrame()
            let x = (imageScrollView.contentOffset.x + cropAreaView.frame.origin.x - imageFrame.origin.x) * scale * factor
            let y = (imageScrollView.contentOffset.y + cropAreaView.frame.origin.y - imageFrame.origin.y) * scale * factor
            let width = cropAreaView.frame.size.width * scale * factor
            let height = cropAreaView.frame.size.height * scale * factor
            return CGRect(x: x, y: y, width: width, height: height)
        }
    }

    @IBAction func crop(_ sender: UIButton) {
        let croppedCGImage = imagePicked.image?.cgImage?.cropping(to: cropArea)
        let croppedImage = UIImage(cgImage: croppedCGImage!)
        imagePicked.image = croppedImage

        imageScrollView.zoomScale = 1
    }
}

extension UIImageView {
    func imageFrame() -> CGRect{
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
