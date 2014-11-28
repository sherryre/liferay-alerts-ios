/**
 * Copyright (c) 2000-2014 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

import CoreData

/**
 * @author Silvio Santos
 */
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

		var database: DatabaseHelper = DatabaseHelper.getInstance()
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