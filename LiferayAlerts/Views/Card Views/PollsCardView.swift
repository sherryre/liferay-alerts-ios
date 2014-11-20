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
class PollsCardView: UIView {

	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override init(frame:CGRect) {
		super.init(frame: frame)
	}

	init(alert: Alert) {
		super.init()

		self.alert = alert

		var choices = getChoices()

		for (index, choice) in enumerate(choices) {
			addChoice(index, choice:choice)
		}
	}

	func getChoices() -> [PollsChoice] {
		var question: PollsQuestion = self.alert!.getPollsQuestion()
		var choices: [PollsChoice] = question.choices

		return choices
	}

	func addChoice(index: Int, choice: PollsChoice) {
		var view: PollsCardItemView = addChoiceView()
		addChoiceItemViewConstraints(view, index:CGFloat(index))

		view.backgroundColor = getChoiceBackgroundColor(index)
		view.choiceLabel.text = choice.description
	}

	func addChoiceView() -> PollsCardItemView {
		let nib: UINib = UINib(
			nibName: "PollsCardItemView", bundle: NSBundle.mainBundle())

		var view: PollsCardItemView = nib.instantiateWithOwner(
			nil, options: nil)[0] as PollsCardItemView

		view.setTranslatesAutoresizingMaskIntoConstraints(false)

		addSubview(view)

		return view
	}

	func getChoiceBackgroundColor(index: Int) -> UIColor {
		if ((index % 2) == 0) {
			return UIColor.yellowColor()
		}

		return UIColor.blueColor()
	}

	func addChoiceItemViewConstraints(view: UIView, index: CGFloat) {
		let leading = NSLayoutConstraint(item: view,
			attribute: NSLayoutAttribute.Leading,
			relatedBy: NSLayoutRelation.Equal, toItem: self,
			attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)

		let top = NSLayoutConstraint(item: view,
			attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal,
			toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0,
			constant: (80.0 * index))

		let trailing = NSLayoutConstraint(item: view,
			attribute: NSLayoutAttribute.Trailing,
			relatedBy: NSLayoutRelation.Equal, toItem: self,
			attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)

		view.addConstraint( NSLayoutConstraint(item: view,
			attribute:NSLayoutAttribute.Height,
			relatedBy:NSLayoutRelation.Equal,
			toItem:nil,
			attribute:NSLayoutAttribute.NotAnAttribute,
			multiplier:1.0,
			constant:80.0))

		self.addConstraints([leading, top, trailing])
	}

	override func intrinsicContentSize() -> CGSize {
		var choices = getChoices()
		var height: CGFloat = 80.0 * CGFloat(choices.count)

		return CGSize(width: UIViewNoIntrinsicMetric, height: height)
	}

	var alert: Alert?

}