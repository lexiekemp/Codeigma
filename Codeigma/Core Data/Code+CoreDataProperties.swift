//
//  Code+CoreDataProperties.swift
//  Codeigma
//
//  Created by Lexie Kemp on 10/5/18.
//  Copyright © 2018 Lexie Kemp. All rights reserved.
//
//

import Foundation
import CoreData


extension Code {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Code> {
        return NSFetchRequest<Code>(entityName: "Code")
    }

    @NSManaged public var evaluation: Int64
    @NSManaged public var detail: String?
    @NSManaged public var title: String?
    @NSManaged public var code: String?
    @NSManaged public var bill: Bill?

}
