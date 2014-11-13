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

/**
* @author Josiane Bzerra
*/
class LinkCardView: CardView {

	override func setAlert(alert: Alert) {
		super.setAlert(alert)

		_setDivider()
		_setURL(alert.getURL()!)
	}

	private func _setDivider() {
		if (!alert!.hasMessage()) {
			divider.removeFromSuperview()

			return
		}

		divider.backgroundColor = UIColors.CARD_DIVIDER_COLOR
	}

	private func _setURL(url: String) {
		linkTextView.text = url

		var attrs: [String: AnyObject] = [
			NSForegroundColorAttributeName: UIColors.CARD_LINK_COLOR,
			NSFontAttributeName:TEXT_FONT,
			NSUnderlineStyleAttributeName:NSUnderlineStyle.StyleSingle.rawValue,
		]

		linkTextView.linkTextAttributes = attrs
	}

	@IBOutlet var divider: UIView!
	@IBOutlet var linkTextView: UITextView!

}