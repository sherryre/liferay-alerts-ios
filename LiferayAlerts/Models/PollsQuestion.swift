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

	func isAnswered() -> Bool {
		for choice in choices {
			if (choice.checked) {
				return true
			}
		}

		return false
	}

	func setVote(choiceId: Int) {
		for choice in choices {
			if (choice.choiceId == choiceId) {
				choice.checked = true
			}
		}
	}

	func toJsonObject() -> [String: AnyObject] {
		var choicesJsonArray: [[String: AnyObject]] = [[String: AnyObject]]()

		for choice in choices {
			choicesJsonArray.append(choice.toJsonObject())
		}

		var jsonObj: [String: AnyObject] = [
			CHOICES: choicesJsonArray,
			QUESTION_ID: questionId
		]

		return jsonObj
	}

	let CHOICES: String = "pollsChoices"
	let QUESTION_ID: String = "pollsQuestionId"

	var choices: [PollsChoice]
	var questionId: Int

}