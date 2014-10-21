//
//  PushNotificationUtil.swift
//  Liferay Alerts
//
//  Silvio Santos
//

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