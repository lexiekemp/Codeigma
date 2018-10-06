//
//  Code+CoreDataClass.swift
//  Codeigma
//
//  Created by Lexie Kemp on 10/5/18.
//  Copyright © 2018 Lexie Kemp. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit
import SwiftyJSON

enum Eval: Int64 {
    case none = 0
    case incorrect = 1
    case correct = 2
}

@objc(Code)
public class Code: NSManagedObject {
    class func addCode(bill: Bill, codeString: String, title: String, detail: String) -> Code? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request:NSFetchRequest<NSFetchRequestResult> = Code.fetchRequest()
        request.predicate = NSPredicate(format: "bill = %@ AND code = %@", bill, codeString)
    
        if let code = (try? context.fetch(request))?.first as? Code {
            return code
        }
        else if let code = NSEntityDescription.insertNewObject(forEntityName:"Code", into: context) as? Code {
            code.bill = bill
            code.code = codeString
            code.title = title
            code.detail = detail
            code.evaluation = Eval.none.rawValue
            
            do {
                try context.save()
            } catch {
                print("Failed saving")
                return nil
            }
            return code
        }
        return nil
    }
    
    class func addCodeFromJSON(bill: Bill, jsonTuple data: (String, JSON)) -> Code? {
        guard let codeString = data.1["code"].string else { return nil }
        guard let title = data.1["shortdescription"].string else { return nil }
        guard let detail = data.1["longdescription"].string else { return nil }
        return addCode(bill: bill, codeString: codeString, title: title, detail: detail)
    }
    
    class func updateEval(code: Code, eval: Int64) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        code.setValue(eval, forKey: "evaluation")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
}
