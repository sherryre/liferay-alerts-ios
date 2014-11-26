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
 * @author Silvio Santos
 */
class PollsChoiceContainerView: UIView {

	func setAlert(alert: Alert) {
		self.alert = alert
		self.question = alert.getPollsQuestion()

		for (index, choice) in enumerate(self.question!.choices) {
			_addChoice(index, choice:choice)
		}

		if (self.question!.isAnswered()) {
			userInteractionEnabled = false
		}
	}

	func voteChanged(choice: PollsChoice) {
		PollsVoteServiceUtil.addVote(
			alert!, questionId:question!.questionId, choiceId:choice.choiceId)

		alert!.setPollsVote(choice.choiceId)
	}

	override func intrinsicContentSize() -> CGSize {
		var choices = self.question!.choices

		var choiceHeight: CGFloat = UIDimensions.POLLS_CARD_CHOICE_HEIGHT
		var height: CGFloat = choiceHeight * CGFloat(choices.count)

		return CGSize(width: UIViewNoIntrinsicMetric, height: height)
	}

	private func _addChoice(index: Int, choice: PollsChoice) {
		var view: PollsChoiceView = _addChoiceView()
		_addChoiceViewConstraints(view, index:CGFloat(index))

		view.backgroundColor = _getChoiceBackgroundColor(index)
		view.setChoice(choice)
	}

	private func _addChoiceView() -> PollsChoiceView {
		let nib: UINib = UINib(
			nibName: "PollsChoiceView", bundle: NSBundle.mainBundle())

		var view: PollsChoiceView = nib.instantiateWithOwner(
			nil, options: nil)[0] as PollsChoiceView

		view.setTranslatesAutoresizingMaskIntoConstraints(false)

		addSubview(view)

		return view
	}

	private func _addChoiceViewConstraints(view: UIView, index: CGFloat) {
		let choiceHeight: CGFloat = UIDimensions.POLLS_CARD_CHOICE_HEIGHT
		let marginTop: CGFloat = choiceHeight * index

		let leading = NSLayoutConstraint(item: view,
			attribute: NSLayoutAttribute.Leading,
			relatedBy: NSLayoutRelation.Equal, toItem: self,
			attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)

		let top = NSLayoutConstraint(item: view,
			attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal,
			toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0,
			constant: marginTop)

		let trailing = NSLayoutConstraint(item: view,
			attribute: NSLayoutAttribute.Trailing,
			relatedBy: NSLayoutRelation.Equal, toItem: self,
			attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)

		view.addConstraint( NSLayoutConstraint(item: view,
			attribute: NSLayoutAttribute.Height,
			relatedBy: NSLayoutRelation.Equal,
			toItem: nil,
			attribute: NSLayoutAttribute.NotAnAttribute,
			multiplier: 1.0,
			constant: choiceHeight))

		self.addConstraints([leading, top, trailing])
	}

	private func _getChoiceBackgroundColor(index: Int) -> UIColor {
		if ((index % 2) == 0) {
			return UIColors.POLLS_CARD_CHOICE_BACKGROUND_1
		}

		return UIColors.POLLS_CARD_CHOICE_BACKGROUND_2
	}

	var question: PollsQuestion?
	var alert: Alert?

}