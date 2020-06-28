//
//  Produce+CoreDataProperties.swift
//  PLUTrainer
//
//  Created by Cao Mai on 6/27/20.
//  Copyright © 2020 Mondale. All rights reserved.
//
//

import Foundation
import CoreData


extension Produce {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Produce> {
        return NSFetchRequest<Produce>(entityName: "Produce")
    }

    @NSManaged public var plu: String
    @NSManaged public var name: String
    @NSManaged public var image: Data?

}
