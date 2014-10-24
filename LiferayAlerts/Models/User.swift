//
//  LiferayAlerts.swift
//  LiferayAlerts
//
//  Created by Silvio Santos on 10/23/14.
//  Copyright (c) 2014 Liferay. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var fullName: String
    @NSManaged var id: NSNumber
    @NSManaged var portraitId: NSNumber
    @NSManaged var uuid: String
    @NSManaged var alerts: NSSet

}
