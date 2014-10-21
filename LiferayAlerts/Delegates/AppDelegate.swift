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

		return true
	}

}

