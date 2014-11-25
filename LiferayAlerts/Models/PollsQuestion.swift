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
class PollsQuestion {

	init(jsonObj: [String: AnyObject]) {
		choices = [PollsChoice]()

		questionId = jsonObj[QUESTION_ID] as Int

		var choicesJsonArray: [[String: AnyObject]] =
			jsonObj[CHOICES] as [[String: AnyObject]]

		for choiceJsonObj in choicesJsonArray {
			var choice: PollsChoice = PollsChoice(jsonObj:choiceJsonObj)

			choices.append(choice)
		}
	}

	let CHOICES: String = "pollsChoices"
	let QUESTION_ID: String = "pollsQuestionId"

	var choices: [PollsChoice]
	var questionId: Int

}