//
//  LoadingViewController.swift
//  Codeigma
//
//  Created by Lexie Kemp on 10/5/18.
//  Copyright © 2018 Lexie Kemp. All rights reserved.
//

import UIKit
import TesseractOCR
import Alamofire
import SwiftyJSON

class LoadingViewController: UIViewController, G8TesseractDelegate {
    
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var codeImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tesseract = G8Tesseract(language: "eng") {
            tesseract.delegate = self
            tesseract.image = codeImage.g8_blackAndWhite()
            tesseract.recognize()
            translateCodes(tesseract.recognizedText) { bill in
                self.performSegue(withIdentifier: "goToResult", sender: bill)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        progressView.progress = Float(tesseract.progress)
    }
    
    func translateCodes(_ codeList: String, completion: @escaping (Bill?) -> ()) {
        let codes = codeList.components(separatedBy: .whitespacesAndNewlines)
        var codesdict = [String: String]()
        if codesdict.count == 0 { completion(nil) }
        for i in 0..<codes.count {
            codesdict[String(i)] = codes[i]
        }
        let parameters: [String: AnyObject] = [
            "codes" : (codesdict as AnyObject)
        ]
        
        Alamofire.request("https://71ba8e65.ngrok.io/code", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print(response)
            let json = JSON(response)
            guard let newBill = Bill.addBill() else {
                completion(nil)
                return
            }
            let iterator = json.makeIterator()
            for item in iterator {
                Code.addCodeFromJSON(bill: newBill, jsonTuple: item)
            }
            completion(newBill)
        }
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            if let resultVC = segue.destination as? ResultViewController {
                if let bill = sender as? Bill {
                    resultVC.bill = bill
                }
            }
        }
    }
}
