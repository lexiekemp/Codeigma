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
        codeImage = UIImage(named: "bill1")
        if let tesseract = G8Tesseract(language: "eng") {
            tesseract.delegate = self
            tesseract.image = codeImage.g8_blackAndWhite()
            tesseract.recognize()
            progressView.setProgress(1.0, animated: true)
            percentageLabel.text = "100%"
            translateCodes(tesseract.recognizedText) { bill in
                self.performSegue(withIdentifier: "goToResult", sender: bill)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        progressView.setProgress(Float(tesseract.progress)/100, animated: true)
        percentageLabel.text = "\(Int(tesseract.progress))%"
    }
    
    func translateCodes(_ codeList: String, completion: @escaping (Bill?) -> ()) {
        let codes = codeList.components(separatedBy: .whitespacesAndNewlines)
        var codesdict = [String: String]()
        for i in 0..<codes.count {
            if codes[i].count > 0 {
                codesdict[String(i)] = codes[i]
            }
        }
        if codesdict.count == 0 {
            completion(nil)
            return
        }
        let parameters: [String: AnyObject] = [
            "codes" : (codesdict as AnyObject)
        ]
        
        Alamofire.request("https://codigma.herokuapp.com/code", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            print(response)
            var json:JSON
            if let data = response.result.value {
                json = JSON(data)
                if json.count == 0 {
                    completion(nil)
                    return
                }
            }
            else {
                completion(nil)
                return
            }
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
