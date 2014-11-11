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

import UIKit

/**
 * @author Silvio Santos
 * @author Josiane Bzerra
 */
class CardView: UIView {

	override func drawRect(rect: CGRect) {
		super.drawRect(rect)

		UIColors.CARD_SHAPE_BACKGROUND.setFill()
		UIColors.CARD_SHAPE_STROKE.setStroke()

		var path: UIBezierPath = UIBezierPath();
		path.lineWidth = STROKE

		_drawArrow(path)
		_drawRectangle(path, rect:rect)

		path.closePath()
		path.fill()
		path.stroke()
	}

	class func loadFromNib(name: String) -> CardView? {
		let nib: UINib = UINib(nibName: name, bundle: NSBundle.mainBundle())

		return nib.instantiateWithOwner(nil, options: nil)[0] as? CardView
	}

	func setAlert(alert: Alert) {
		_setMessage(alert.getMessage()!)
	}

	private func _drawArc(
		path: UIBezierPath, center: CGPoint, startAngle: CGFloat,
		endAngle: CGFloat) {

		path.addArcWithCenter(center, radius:RADIUS, startAngle:startAngle,
			endAngle:endAngle, clockwise:true)
	}

	private func _drawArrow(path: UIBezierPath) {
		var bottom: CGPoint = CGPoint(
			x:ARROW_WIDTH, y:(ARROW_START_Y + ARROW_HEIGHT))

		var left: CGPoint = CGPoint(x:0, y:(ARROW_START_Y + ARROW_HEIGHT/2))
		var top: CGPoint = CGPoint(x:ARROW_WIDTH, y:ARROW_START_Y)

		path.moveToPoint(bottom)
		path.addLineToPoint(left)
		path.addLineToPoint(top)
	}

	private func _drawRectangle(path: UIBezierPath, rect: CGRect) {
		var width = rect.width - PADDING_HORIZONTAL
		var height = rect.height - PADDING_VERTICAL

		var left: CGFloat = (RADIUS + ARROW_WIDTH)
		var top: CGFloat = (RADIUS + 1)
		var right: CGFloat = (width - RADIUS)
		var bottom: CGFloat = (height - RADIUS)

		var topLeftArcCenter = CGPoint(x:left, y:top)
		var topRightArcCenter = CGPoint(x:right, y:top)
		var bottomRightArcCenter = CGPoint(x:right, y:bottom)
		var bottomLeftArcCenter = CGPoint(x:left, y:bottom)

		_drawArc(path, center:topLeftArcCenter, startAngle:PI, endAngle:3*PI/2)
		path.addLineToPoint(CGPoint(x:right, y:PADDING_VERTICAL))

		_drawArc(path, center:topRightArcCenter, startAngle:3*PI/2,
			endAngle:2*PI)

		path.addLineToPoint(CGPoint(x:width, y:bottom))

		_drawArc(path, center:bottomRightArcCenter, startAngle:2*PI,
			endAngle:PI/2)

		path.addLineToPoint(CGPoint(x:left, y:height))

		_drawArc(path, center:bottomLeftArcCenter, startAngle:PI/2, endAngle:PI)
	}

	private func _setMessage(message: String) {
		messageLabel.text = message
		messageLabel.textColor = UIColors.CARD_MESSAFE

		var frame: CGRect = messageLabel.frame
		frame.size.height = messageLabel.sizeThatFits(frame.size).height

		messageLabel.frame = frame
	}

	let ARROW_HEIGHT: CGFloat = 11.0
	let ARROW_START_Y: CGFloat = 15.0
	let ARROW_WIDTH: CGFloat = 6.5
	let PADDING_HORIZONTAL: CGFloat = 2.0
	let PADDING_VERTICAL: CGFloat = 1.0
	let PI: CGFloat = 3.1415
	let RADIUS: CGFloat = 5.6
	let STROKE: CGFloat = 1.0

	@IBOutlet var messageLabel: UILabel!

}