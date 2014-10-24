//
//  LiferayAlerts.swift
//  LiferayAlerts
//
//  Silvio Santos
//

import Foundation
import CoreData

class Alert: NSManagedObject {

    @NSManaged var payload: AnyObject
    @NSManaged var user: LiferayAlerts.User

}
