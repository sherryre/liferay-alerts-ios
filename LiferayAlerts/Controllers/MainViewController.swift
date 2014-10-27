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
	@IBOutlet weak var tableView: UITableView!

}

