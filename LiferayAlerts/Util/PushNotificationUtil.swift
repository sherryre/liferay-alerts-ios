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
import UIKit

/**
 * @author Silvio Santos
 */
class PushNotificationUtil {

	class func addDevice(token: String) {
		var server: String = SettingsUtil.getServer()
		var callback: AddPushNotificationDeviceCallback =
			AddPushNotificationDeviceCallback()

		var session: LRSession = LRSession(server:server, callback:callback)

		var service: LRPushnotificationsdeviceService_v62 =
			LRPushnotificationsdeviceService_v62(session:session)

		var error: NSError?

		service.addPushNotificationsDeviceWithToken(
			token, platform:"apple", error:&error)
	}

	class func getToken(tokenData: NSData) -> String {
		var token: String = tokenData.description

		var set: NSCharacterSet = NSCharacterSet(charactersInString:"<>")
		token = token.stringByTrimmingCharactersInSet(set)
		token = token.stringByReplacingOccurrencesOfString(" ", withString:"")

		return token
	}

	class func handleNotification(notification: [NSObject: AnyObject]) {
		var alertJsonObj: [NSObject: AnyObject] =
			notification["aps"] as [NSObject: AnyObject]

		var userJson: String = notification["fromUser"] as String
		var user: User = _createUser(userJson)

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
		var jsonData: NSData? = json.dataUsingEncoding(NSUTF8StringEncoding)
		var error: NSError?

		var jsonObj: Dictionary = NSJSONSerialization.JSONObjectWithData(
			jsonData!, options:NSJSONReadingOptions(0), error:&error)
			as NSDictionary as Dictionary

		var id: NSNumber = jsonObj["userId"] as NSNumber
		var fullName: String = jsonObj["fullName"] as String
		var portraitId: NSNumber = jsonObj["portraitId"] as NSNumber
		var uuid: String = jsonObj["uuid"] as String

		var user: User = UserDAO.insert(
			id, fullName:fullName, portraitId:portraitId, uuid:uuid,
			commit:false)

		return user;
	}
}