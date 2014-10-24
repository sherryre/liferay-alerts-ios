//
//  AppDelegate.swift
//  Liferay Alerts
//
//  Silvio Santos
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(
		application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?)
		-> Bool {

		var window = UIWindow(frame: UIScreen.mainScreen().bounds)
		window.rootViewController = MainViewController()
		window.makeKeyAndVisible()

		PushNotificationUtil.registerForNotifications()

		return true
	}

	func application(
		application: UIApplication,
		didFailToRegisterForRemoteNotificationsWithError error: NSError) {

		println(error.localizedDescription)
	}

	func application(
		application: UIApplication,
		didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {

		var token: String = PushNotificationUtil.getToken(deviceToken)

		PushNotificationUtil.addDevice(token);
	}

	func application(
		application: UIApplication,
		didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {

		PushNotificationUtil.handleNotification(userInfo)
	}

}

