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
* @author Josiane Bezerra
*/
extension UIView {

	func setFrameConstraints(equalsToView view: UIView) {
		let superview = self.superview as UIView!

		if (superview == nil || !superview.isEqual(view)) {
			return
		}

		let bottom = NSLayoutConstraint(item: self,
			attribute: NSLayoutAttribute.Bottom,
			relatedBy: NSLayoutRelation.Equal, toItem: view,
			attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)

		let leading = NSLayoutConstraint(item: self,
			attribute: NSLayoutAttribute.Leading,
			relatedBy: NSLayoutRelation.Equal, toItem: view,
			attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)

		let top = NSLayoutConstraint(item: self,
			attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal,
			toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1,
			constant: 0)

		let trailing = NSLayoutConstraint(item: self,
			attribute: NSLayoutAttribute.Trailing,
			relatedBy: NSLayoutRelation.Equal, toItem: view,
			attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)

		view.addConstraints([bottom, leading, top, trailing])
	}

	func setWidthConstraint(width: CGFloat) {
		self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
			"H:[self(\(width))]", options: NSLayoutFormatOptions(0),
			metrics: nil, views: ["self": self]))
	}

}
