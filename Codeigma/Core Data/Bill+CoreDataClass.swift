//
//  Bill+CoreDataClass.swift
//  Codeigma
//
//  Created by Lexie Kemp on 10/5/18.
//  Copyright © 2018 Lexie Kemp. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit
@objc(Bill)
public class Bill: NSManagedObject {
    class func addBill() -> Bill? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if let bill = NSEntityDescription.insertNewObject(forEntityName:"Bill", into: context) as? Bill {
            bill.date = NSDate()
            
            do {
                try context.save()
            } catch {
                print("Failed saving")
                return nil
            }
            return bill
        }
        return nil
    }
}
