//
//  Student+CoreDataProperties.swift
//  keystone Park
//
//  Created by Rajat on 10/30/18.
//  Copyright © 2018 None. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String?
    @NSManaged public var lesson: Lesson?

}
