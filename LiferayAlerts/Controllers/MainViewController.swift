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
class MainViewController: UIViewController, UICollectionViewDataSource,
	UICollectionViewDelegate {

	override init() {
		super.init(nibName:"MainViewController", bundle:nil)
	}

	required init(coder: NSCoder) {
		super.init(coder:coder)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		alerts = AlertDAO.get()

		initCollectionView()
		initTopBar()
	}

	func initCollectionView() {
		var background: UIImage = UIImage(named:"background")!
		collectionView.backgroundColor = UIColor(patternImage:background)

		var nib: UINib = UINib(nibName:"TextCardViewCell", bundle:nil)
		collectionView.registerNib(
			nib, forCellWithReuseIdentifier:"TextCardViewCellId")

		var layout: UICollectionViewFlowLayout =
			collectionView.collectionViewLayout as UICollectionViewFlowLayout

		var top = topBar.frame.height
		layout.sectionInset = UIEdgeInsetsMake(top, 0, 0, 0);
		layout.minimumLineSpacing = 0
	}

	func initTopBar() {
		setTopBarGradient()

		divider.backgroundColor = UIColors.TOP_BAR_DIVIDER
		dividerHeight.constant = (1 / UIScreen.mainScreen().scale)

		topBarLastAlert.textColor = UIColors.TOP_BAR_LAST_ALERT
		userName.textColor = UIColors.TOP_BAR_USER_NAME
		userName.shadowColor = UIColors.TOP_BAR_USER_NAME_SHADOW
	}

	func setTopBarGradient() {
		var colors: [CGColor] = [
			(UIColors.TOP_BAR_BACKGROUND).CGColor,
			(UIColors.TOP_BAR_BACKGROUND_CENTER).CGColor,
			(UIColors.TOP_BAR_BACKGROUND).CGColor
		]

		var frame: CGRect = topBar!.frame
		var startPoint: CGPoint = CGPointMake(0, 0.5)
		var endPoint: CGPoint = CGPointMake(1, 0.5)

		var gradient: CAGradientLayer = GradientUtil.createGradient(
			colors, frame:frame, startPoint:startPoint, endPoint:endPoint)

		topBar.layer.insertSublayer(gradient, atIndex:0)
	}

	func collectionView(collectionView: UICollectionView,
		cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

		var alert : Alert = alerts![indexPath.row]

		var cell: TextCardViewCell =
			collectionView.dequeueReusableCellWithReuseIdentifier(
			"TextCardViewCellId", forIndexPath:indexPath) as TextCardViewCell

		cell.textLabel.text = alert.getMessage()

		return cell
	}

	func collectionView(collectionView: UICollectionView,
		layout: UICollectionViewLayout, sizeForItemAtIndexPath: NSIndexPath)
		-> CGSize {

		var width: CGFloat = collectionView.frame.width;

		return CGSize(width:width, height:60)
	}

	func collectionView(collectionView: UICollectionView,
		numberOfItemsInSection section: Int) -> Int {

		return alerts!.count
	}

	var alerts: [Alert]?

	@IBOutlet var collectionView: UICollectionView!
	@IBOutlet var dividerHeight: NSLayoutConstraint!
	@IBOutlet var divider: UIView!
	@IBOutlet var topBar: UIView!
	@IBOutlet var topBarLastAlert: UILabel!
	@IBOutlet var userName: UILabel!

}
