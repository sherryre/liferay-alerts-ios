//
//  GradientUtil.swift
//  LiferayAlerts
//
//  Silvio Santos
//

import UIKit

class GradientUtil {

	class func createGradient(
		colors: [CGColor], frame: CGRect, startPoint: CGPoint, endPoint: CGPoint)
		-> CAGradientLayer {

		var gradient: CAGradientLayer = CAGradientLayer()

		gradient.frame = frame
		gradient.colors = colors
		gradient.startPoint = startPoint
		gradient.endPoint = endPoint

		return gradient
	}

}