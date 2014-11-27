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

		_setRectY()

		var path: UIBezierPath = UIBezierPath()

		_drawArrow(path)
		_drawRectangle(path, rect:rect)

		path.closePath()
		path.lineWidth = STROKE
		path.fill()
		path.stroke()
	}

	class func loadFromNib(name: String) -> CardView? {
		let nib: UINib = UINib(nibName: name, bundle: NSBundle.mainBundle())

		return nib.instantiateWithOwner(nil, options: nil)[0] as? CardView
	}

	func setAlert(alert: Alert) {
		self.contentMode = UIViewContentMode.Redraw
		self.alert = alert;

		_setMessage()
	}

	private func _drawArc(
		path: UIBezierPath, center: CGPoint, startAngle: CGFloat,
		endAngle: CGFloat) {

		path.addArcWithCenter(center, radius:RADIUS, startAngle:startAngle,
			endAngle:endAngle, clockwise:true)
	}

	private func _drawArrow(path: UIBezierPath) {
		if (leftArrow) {
			_drawArrowLeft(path)
		}
		else {
			_drawArrowTop(path)
		}
	}

	private func _drawArrowLeft(path: UIBezierPath) {
		var arrow: UIBezierPath = UIBezierPath()

		var bottom: CGPoint = CGPoint(
			x:ARROW_WIDTH,
			y:(ARROW_LEFT_START_Y + ARROW_HEIGHT))

		var left: CGPoint = CGPoint(
			x:0,
			y:(ARROW_LEFT_START_Y + (ARROW_HEIGHT / 2)))

		var top: CGPoint = CGPoint(
			x:ARROW_WIDTH,
			y:ARROW_LEFT_START_Y)

		arrow.moveToPoint(bottom)
		arrow.addLineToPoint(left)
		arrow.addLineToPoint(top)

		path.appendPath(arrow)
	}

	private func _drawArrowTop(path: UIBezierPath) {
		var arrow: UIBezierPath = UIBezierPath()

		var left: CGPoint = CGPoint(
			x:UIDimensions.CARD_ARROW_TOP_START_X,
			y:rectY)

		var top: CGPoint = CGPoint(
			x:(UIDimensions.CARD_ARROW_TOP_START_X + (ARROW_HEIGHT / 2)),
			y:(rectY - UIDimensions.CARD_ARROW_WIDTH))

		var right: CGPoint = CGPoint(
			x:(UIDimensions.CARD_ARROW_TOP_START_X + ARROW_HEIGHT),
			y:rectY)

		arrow.moveToPoint(left)
		arrow.addLineToPoint(top)
		arrow.addLineToPoint(right)

		path.appendPath(arrow)
	}

	private func _drawRectangle(path: UIBezierPath, rect: CGRect) {
		var width = rect.width - PADDING_HORIZONTAL
		var height = rect.height - rectY

		var left: CGFloat = (RADIUS + ARROW_WIDTH)
		var top: CGFloat = (RADIUS + rectY)
		var right: CGFloat = (width - RADIUS)
		var bottom: CGFloat = (height - RADIUS)

		var topLeftArcCenter = CGPoint(x:left, y:top)
		var topRightArcCenter = CGPoint(x:right, y:top)
		var bottomRightArcCenter = CGPoint(x:right, y:bottom)
		var bottomLeftArcCenter = CGPoint(x:left, y:bottom)

		if (leftArrow) {
			_drawArc(
				path, center:topLeftArcCenter, startAngle:PI, endAngle:3*PI/2)
		}

		_drawArc(
			path, center:topRightArcCenter, startAngle:3*PI/2, endAngle:2*PI)

		_drawArc(
			path, center:bottomRightArcCenter, startAngle:2*PI, endAngle:PI/2)

		_drawArc(path, center:bottomLeftArcCenter, startAngle:PI/2, endAngle:PI)

		if (!leftArrow) {
			_drawArc(
				path, center:topLeftArcCenter, startAngle:PI, endAngle:3*PI/2)
		}
	}

	private func _setMessage() {
		if (!alert!.hasMessage()) {
			messageTextView.removeFromSuperview()

			return
		}

		messageTextView.text = alert!.getMessage()
		messageTextView.textColor = UIColors.CARD_MESSAGE
		messageTextView.font = TEXT_FONT
	}

	private func _setRectY() {
		if (!leftArrow) {
			rectY = rectY + ARROW_WIDTH
		}
	}

	let ARROW_HEIGHT: CGFloat = UIDimensions.CARD_ARROW_HEIGHT
	let ARROW_LEFT_START_Y: CGFloat = UIDimensions.CARD_ARROW_LEFT_START_Y
	let ARROW_TOP_START_X: CGFloat = UIDimensions.CARD_ARROW_TOP_START_X
	let ARROW_WIDTH: CGFloat = UIDimensions.CARD_ARROW_WIDTH
	let PADDING_HORIZONTAL: CGFloat = UIDimensions.CARD_PADDING_HORIZONTAL
	let PADDING_VERTICAL: CGFloat = UIDimensions.CARD_PADDING_VERTICAL
	let PI: CGFloat = 3.1415
	let RADIUS: CGFloat = UIDimensions.CARD_RADIUS
	let STROKE: CGFloat = UIDimensions.CARD_STROKE

	let TEXT_FONT: UIFont = UIFont(
		name: "Helvetica-Light", size: UIDimensions.CARD_TEXT_SIZE)!

	var alert: Alert?
	var leftArrow: Bool = false
	var rectY: CGFloat = UIDimensions.CARD_PADDING_VERTICAL

	@IBOutlet var messageTextView: UITextView!

}