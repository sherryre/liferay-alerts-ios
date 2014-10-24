//
//  PushNotificationUtil.swift
//  Liferay Alerts
//
//  Silvio Santos
//

import CoreData
import UIKit

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
		var alertJson: [NSObject: AnyObject] =
			notification["aps"] as [NSObject: AnyObject]

		var userJsonString: String = notification["fromUser"] as String

		var userData: NSData? = userJsonString.dataUsingEncoding(
			NSUTF8StringEncoding)

		var error: NSError?

		var userJson: Dictionary = NSJSONSerialization.JSONObjectWithData(
			userData!, options:NSJSONReadingOptions(0), error:&error)
			as NSDictionary as Dictionary

		var id: NSNumber = userJson["userId"] as NSNumber
		var fullName: String = userJson["fullName"] as String
		var portraitId: NSNumber = userJson["portraitId"] as NSNumber
		var uuid: String = userJson["uuid"] as String

		var user: User = UserDAO.insert(
			id, fullName:fullName, portraitId:portraitId, uuid:uuid,
			commit:false)

		AlertDAO.insert(alertJson, user:user, commit:true)
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
}