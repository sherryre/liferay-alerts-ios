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
class TextCardViewCell: UICollectionViewCell {

	override func awakeFromNib() {
		let radius = portraitImageView.frame.size.width / 2

		portraitImageView.layer.cornerRadius = radius
		portraitImageView.clipsToBounds = true
	}

	func setAlert(alert: Alert) {
		textLabel.text = alert.getMessage()

		_setPortrait(alert.user)
	}

	private func _setPortrait(user: User) {
		let session = LRSession(server: SettingsUtil.getServer())

		let portraitURL = LRPortraitUtil.getPortraitURL(session, male: true,
			portraitId: user.portraitId.longLongValue, uuid: user.uuid)

		let URL = NSURL(string: portraitURL)

		portraitImageView.sd_setImageWithURL(URL)
	}

	@IBOutlet var portraitImageView: UIImageView!
	@IBOutlet var textLabel: UILabel!

}