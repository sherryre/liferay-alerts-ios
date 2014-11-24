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

import CoreData
import UIKit

/**
 * @author Silvio Santos
 * @author Josiane Bezerra
 */
class AlertViewCell: BaseAlertViewCell {

	override func awakeFromNib() {
		_setRadius(portraitImageView)
		_setRadius(typeBadge)
	}

	override func prepareForReuse() {
		for view in cardViewContainer.subviews {
			view.removeFromSuperview()
		}
	}

	override func setAlert(alert: Alert) {
		super.setAlert(alert)

		_setPortrait(alert.user)

		var cardView: CardView = CardViewFactory.create(alert)
		cardViewContainer.addSubview(cardView)

		cardView.setTranslatesAutoresizingMaskIntoConstraints(false)
		cardView.setFrameConstraints(equalsToView: cardViewContainer)

		self.layoutIfNeeded()
	}

	private func _setPortrait(user: User) {
		let session = LRSession(server: SettingsUtil.getServer())

		let portraitURL = LRPortraitUtil.getPortraitURL(session, male: true,
			portraitId: user.portraitId.longLongValue, uuid: user.uuid)

		let URL = NSURL(string: portraitURL)

		portraitImageView.sd_setImageWithURL(URL)
	}

	private func _setRadius(view: UIView) {
		let radius = view.frame.size.width / 2

		view.layer.cornerRadius = radius
		view.clipsToBounds = true
	}

	@IBOutlet var cardViewContainer: UIView!
	@IBOutlet var portraitImageView: UIImageView!
	@IBOutlet var typeBadge: UIView!

}