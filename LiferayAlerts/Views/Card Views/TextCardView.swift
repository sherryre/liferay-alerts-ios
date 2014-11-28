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
 * @author Silvio Santos
 */
class TextCardView: BaseCardView {

	class func loadFromNib(name: String) -> TextCardView? {
		let nib: UINib = UINib(nibName: name, bundle: NSBundle.mainBundle())

		return nib.instantiateWithOwner(nil, options: nil)[0] as? TextCardView
	}

	override func awakeFromNib() {
		commentLabel.textColor = UIColors.CARD_BOTTOM_BAR_TEXT
		likeLabel.textColor = UIColors.CARD_BOTTOM_BAR_TEXT
	}

	func setAlert(alert: Alert) {
		self.contentMode = UIViewContentMode.Redraw
		self.alert = alert;

		_setMessage()
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

	let TEXT_FONT: UIFont = UIFont(
		name: "Helvetica-Light", size: UIDimensions.CARD_TEXT_SIZE)!

	var alert: Alert?

	@IBOutlet var commentLabel: UILabel!
	@IBOutlet var likeLabel: UILabel!
	@IBOutlet var messageTextView: UITextView!
}