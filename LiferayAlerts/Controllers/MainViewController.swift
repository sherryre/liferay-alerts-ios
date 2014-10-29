//
//  ViewController.swift
//  Liferay Alerts
//
//  Silvio Santos
//

import CoreData
import UIKit

class MainViewController: UIViewController, UITableViewDataSource,
	UITableViewDelegate {

	override init() {
		super.init(nibName:"MainViewController", bundle:nil)
	}

	required init(coder: NSCoder) {
		super.init(coder:coder)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		alerts = AlertDAO.get()

		initTopBar()
	}

	func initTopBar() {
		setTopBarGradient()

		divider.backgroundColor = UIColors.TOP_BAR_DIVIDER
		dividerHeight.constant = (1 / UIScreen.mainScreen().scale)

		tableView.tableHeaderView = UIView(frame:topBar!.frame)
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

	func tableView(
		tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
		-> UITableViewCell {

		var alert : Alert = alerts![indexPath.row]

		var cell: UITableViewCell = UITableViewCell()
		cell.textLabel.text = alert.getMessage()

		return cell
	}

	func tableView(
		tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath)
		-> CGFloat {

		return 51
	}

	func tableView(
		tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return alerts!.count
	}

	var alerts: [Alert]?

	@IBOutlet var dividerHeight: NSLayoutConstraint!
	@IBOutlet var divider: UIView!
	@IBOutlet var topBar: UIView!
	@IBOutlet var topBarLastAlert: UILabel!
	@IBOutlet var tableView: UITableView!
	@IBOutlet var userName: UILabel!

}
