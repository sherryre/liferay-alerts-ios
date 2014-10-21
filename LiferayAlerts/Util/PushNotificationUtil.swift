//
//  PushNotificationUtil.swift
//  Liferay Alerts
//
//  Silvio Santos
//

import UIKit

class PushNotificationUtil {

	class func registerForNotifications() {
		let types: UIUserNotificationType =
			(UIUserNotificationType.Alert | UIUserNotificationType.Badge |
			UIUserNotificationType.Sound)

		var settings: UIUserNotificationSettings = UIUserNotificationSettings(
			forTypes:types, categories:nil)

		var application: UIApplication = UIApplication.sharedApplication()

		application.registerUserNotificationSettings(settings)
		application.registerForRemoteNotifications()
	}
}