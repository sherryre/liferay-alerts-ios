//
//  AlertDAO.swift
//  LiferayAlerts
//
//  Silvio Santos
//

import CoreData
import Foundation

class AlertDAO {

	class func get() -> [Alert]? {
		var context = DatabaseHelper.getInstance().getContext()!

		var request: NSFetchRequest = NSFetchRequest()
		request.entity = NSEntityDescription.entityForName(
			"Alert", inManagedObjectContext:context)

		var error: NSError?

		let alerts: [Alert] = context.executeFetchRequest(request, error:&error)
			as [Alert]

		if (error != nil) {
			NSLog("Coldn't get users \(error), \(error!.userInfo)")

			return nil
		}

		return alerts
	}

	class func insert(
		payload: [NSObject: AnyObject], user: User, commit: Bool)
		-> Alert {

		var database: DatabaseHelper = DatabaseHelper.getInstance();
		var context: NSManagedObjectContext = database.getContext()!

		var alert: Alert = NSEntityDescription.insertNewObjectForEntityForName(
			"Alert", inManagedObjectContext:context) as Alert

		alert.payload = payload
		alert.user = user

		if (commit) {
			database.commit()
		}

		return alert
	}

}