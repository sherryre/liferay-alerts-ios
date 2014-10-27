//
//  AlertExtension.swift
//  LiferayAlerts
//
//  Silvio Santos
//

import Foundation

extension Alert {

	func getMessage() -> String? {
		return payload["alert"] as String?
	}
}