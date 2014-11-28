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
class PollsChoice {

	let CHECKED: String = "checked";
	let CHOICE_ID: String = "pollsChoiceId";
	let DESCRIPTION: String = "description";

	init(jsonObj: [String: AnyObject]) {
		if let checked = jsonObj[CHECKED] as Bool? {
			self.checked = checked
		}

		choiceId = jsonObj[CHOICE_ID] as Int
		description = jsonObj[DESCRIPTION] as String
	}
	
	func toJsonObject() -> [String: AnyObject] {
		var jsonObj: [String: AnyObject] = [
			CHECKED: checked,
			CHOICE_ID: choiceId,
			DESCRIPTION: description
		]

		return jsonObj
	}

	var checked: Bool = false
	var choiceId: Int
	var description: String

}
