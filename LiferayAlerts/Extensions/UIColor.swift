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
extension UIColor {

	convenience init(rgb: NSString) {
		var rgb: NSString = rgb

		if (rgb.hasPrefix("#")) {
			rgb = rgb.substringFromIndex(1)
		}

		var red, green, blue, alpha : NSString

		if (rgb.length == 6) {
			alpha = "FF"
			red = rgb.substringWithRange(NSMakeRange(0, 2))
			green = rgb.substringWithRange(NSMakeRange(2, 2))
			blue = rgb.substringWithRange(NSMakeRange(4, 2))
		}
		else if (rgb.length == 8) {
			alpha = rgb.substringWithRange(NSMakeRange(0, 2))
			red = rgb.substringWithRange(NSMakeRange(2, 2))
			green = rgb.substringWithRange(NSMakeRange(4, 2))
			blue = rgb.substringWithRange(NSMakeRange(6, 2))
		}
		else {
			self.init()

			return
		}

		var a: UInt32 = 0
		var r: UInt32 = 0
		var g: UInt32 = 0
		var b: UInt32 = 0

		NSScanner(string:alpha).scanHexInt(&a)
		NSScanner(string:red).scanHexInt(&r)
		NSScanner(string:green).scanHexInt(&g)
		NSScanner(string:blue).scanHexInt(&b)

		if ((r == g) && (g == b)) {
			self.init(white:(CGFloat(r) / 255), alpha:(CGFloat(a) / 255))
		}
		else {
			self.init(
				red:(CGFloat(r) / 255), green:(CGFloat(g) / 255),
				blue:(CGFloat(b) / 255), alpha:(CGFloat(a) / 255))
		}
	}

}