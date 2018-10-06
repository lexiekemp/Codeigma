//
//  Bill+CoreDataProperties.swift
//  Codeigma
//
//  Created by Lexie Kemp on 10/5/18.
//  Copyright © 2018 Lexie Kemp. All rights reserved.
//
//

import Foundation
import CoreData


extension Bill {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bill> {
        return NSFetchRequest<Bill>(entityName: "Bill")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var codes: NSSet?

}

// MARK: Generated accessors for codes
extension Bill {

    @objc(addCodesObject:)
    @NSManaged public func addToCodes(_ value: Code)

    @objc(removeCodesObject:)
    @NSManaged public func removeFromCodes(_ value: Code)

    @objc(addCodes:)
    @NSManaged public func addToCodes(_ values: NSSet)

    @objc(removeCodes:)
    @NSManaged public func removeFromCodes(_ values: NSSet)

}
