//
//  UserDAO.swift
//  LiferayAlerts
//
//  Silvio Santos
//

import CoreData
import Foundation

class UserDAO {

	class func get(id : NSNumber) -> User? {
		var context = DatabaseHelper.getInstance().getContext()!

		var request: NSFetchRequest = NSFetchRequest()
		request.entity = _getEntityDescription()
		request.predicate = NSPredicate(format:"id = %@", id)

		var error: NSError?

		var users = context.executeFetchRequest(request, error:&error)

		if (error != nil) {
			NSLog("Coldn't get user \(error), \(error!.userInfo)")

			return nil
		}

		if (users!.count > 0) {
			return users![0] as? User
		}

		return nil
	}

	class func insert(
		id: NSNumber, fullName: String, portraitId: NSNumber, uuid: String,
		commit: Bool)
		-> User {

		var database = DatabaseHelper.getInstance();
		var context = database.getContext()!
		var user: User? = get(id)

		if (user == nil) {
			user = NSEntityDescription.insertNewObjectForEntityForName(
				"User", inManagedObjectContext:context) as? User

			user!.id = id
		}

		user!.fullName = fullName
		user!.portraitId = portraitId
		user!.uuid = uuid

		if (commit) {
			database.commit()
		}

		return user!
	}

	private class func _getEntityDescription() -> NSEntityDescription? {
		var database : DatabaseHelper = DatabaseHelper.getInstance()
		var context: NSManagedObjectContext? = database.getContext()

		return NSEntityDescription.entityForName(
			"User", inManagedObjectContext:context!)
	}

	let	FULL_NAME: String = "fullName"
	let PORTRAIT_ID: String = "portraitId"
	let USER_ID: String = "userId"
	let UUID: String = "uuid"

}