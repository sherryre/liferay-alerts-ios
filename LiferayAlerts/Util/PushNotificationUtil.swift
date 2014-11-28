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
class PushNotificationUtil {

	class func handleNotification(notification: [NSObject: AnyObject]) {
		var alertJsonObj: [NSObject: AnyObject] =
			notification["aps"] as [NSObject: AnyObject]

		var userJson: String = notification["fromUser"] as String
		var user: User = _createUser(userJson)

		alertJsonObj = alertJsonObj +
			_parseJson(notification["payload"] as String)

		AlertDAO.insert(alertJsonObj, user:user, commit:true)
	}

	class func registerForNotifications() {
		var types: UIUserNotificationType =
			(UIUserNotificationType.Alert | UIUserNotificationType.Badge |
			UIUserNotificationType.Sound)

		var settings: UIUserNotificationSettings = UIUserNotificationSettings(
			forTypes:types, categories:nil)

		var application: UIApplication = UIApplication.sharedApplication()

		application.registerUserNotificationSettings(settings)
		application.registerForRemoteNotifications()
	}

	private class func _createUser(json: String) -> User {
		var jsonObj = _parseJson(json)

		var id: NSNumber = jsonObj["userId"] as NSNumber
		var fullName: String = jsonObj["fullName"] as String
		var portraitId: NSNumber = jsonObj["portraitId"] as NSNumber
		var uuid: String = jsonObj["uuid"] as String

		var user: User = UserDAO.insert(
			id, fullName:fullName, portraitId:portraitId, uuid:uuid,
			commit:false)

		return user;
	}

	private class func _parseJson(json: String) -> [NSObject: AnyObject] {
		var jsonData: NSData? = json.dataUsingEncoding(NSUTF8StringEncoding)
		var error: NSError?

		var jsonObj = NSJSONSerialization.JSONObjectWithData(
			jsonData!, options:NSJSONReadingOptions(0), error:&error)
			as [NSObject: AnyObject]

		return jsonObj
	}

}