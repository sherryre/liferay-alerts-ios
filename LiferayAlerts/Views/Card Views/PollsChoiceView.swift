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

import Foundation

/**
 * @author Silvio Santos
 */
class PollsChoiceView: UIView {

	override func awakeFromNib() {
		choiceLabel.textColor = UIColors.POLLS_CARD_CHOICE_TEXT

		voteSwitch.layer.cornerRadius = 16.0
		voteSwitch.backgroundColor = UIColors.POLLS_CARD_CHOICE_SWITCH_OFF
		voteSwitch.tintColor = UIColors.POLLS_CARD_CHOICE_SWITCH_OFF
		voteSwitch.thumbTintColor = UIColor.whiteColor()
	}

	override func intrinsicContentSize() -> CGSize {
		return CGSize(
			width: UIViewNoIntrinsicMetric,
			height: UIDimensions.POLLS_CARD_CHOICE_HEIGHT)
	}

	@IBOutlet var choiceLabel: UILabel!
	@IBOutlet var voteSwitch: UISwitch!
}