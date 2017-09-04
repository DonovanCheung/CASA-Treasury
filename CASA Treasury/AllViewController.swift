//
//  AllViewController.swift
//  
//
//  Created by Donovan Cheung on 8/7/17.
//
//

import UIKit
import Firebase

struct transaction {
	let name : String!
	let details: String!
	let account: String!
	let amount: Double!
	let date: String!
	let time: String!
	let timestamp: Int!
}

var nameToPass:String!
var amountToPass:String!
var accountToPass:String!
var detailsToPass:String!
var dateToPass:String!
var timeToPass:String!

class AllViewController: UITableViewController {
	
	// Database References
	let rootRef = Database.database().reference().child("transactions")
	
	// Initialization
	var allTransactions = [transaction]()
	var uniqueDateCount = 1
	var uniqueDateSet: NSMutableOrderedSet = []
	var numberOfTransactions = [Int]()
	var cellNumber = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem()
		/*
		Service.sharedInstance.runService(choice: "", completion: { (data) in
		if (data) {
		self.allTransactions = Service.sharedInstance.getAll()
		}
		DispatchQueue.main.async {
		self.getUniqueDateSet()
		self.getUniqueDateCount()
		self.getNumberOfTransactions()
		self.refresh()
		}
		})*/
		DispatchQueue.global(qos: .userInteractive).async {
			Service.sharedInstance.runService(choice: "", completion: { (data) in
				if (data) {
					self.allTransactions = Service.sharedInstance.getAll()
					// MAKE ALL TRANSACTION ARRAYS PUBLIC
					
				}
				DispatchQueue.main.async {
					self.getUniqueDateSet()
					self.getUniqueDateCount()
					self.getNumberOfTransactions()
					self.refresh()
					
				}
			})
		}
	}
	
	func refresh(){
		cellNumber = 0
		self.tableView.reloadData()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// Return the number of sections
		return uniqueDateCount
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// Return the number of rows
		if (numberOfTransactions.indices.contains(section)) {
			return numberOfTransactions[section]
		}
		else {
			return 0
		}
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if (self.uniqueDateSet.count - 1) >= section	{
			return self.uniqueDateSet[section] as? String
		}
		else {
			return ""
		}
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
		cell.nameLabel?.text = allTransactions[cellNumber].name + " - " + allTransactions[cellNumber].details
		
		let amountForLabel = allTransactions[cellNumber].amount
		cell.amountLabel?.text = convertAmount(doubleAmount: amountForLabel!)
		if (colorAmount(amount: amountForLabel!)) {
			cell.amountLabel?.textColor = UIColor.green
		}
		else {
			cell.amountLabel?.textColor = UIColor.red
		}
		
		cell.timeLabel?.text = allTransactions[cellNumber].time
		cellNumber += 1
		return cell
		// Configure the cell...
	}
	
	func getUniqueDateSet() -> () {
		for transaction in self.allTransactions {
			self.uniqueDateSet.add(transaction.date)
		}
	}
	
	func getUniqueDateCount() -> () {
		self.uniqueDateCount = self.uniqueDateSet.count
	}
	
	func getNumberOfTransactions() -> () {
		for date in self.uniqueDateSet {
			var count = 0
			for transaction in self.allTransactions {
				if (transaction.date == date as! String) {
					count += 1
				}
			}
			if (count > 0) {
				self.numberOfTransactions.append(count)
			}
		}
	}
		
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		// Get Cell Label
		let indexPath = tableView.indexPathForSelectedRow!
		let currentCell = tableView.cellForRow(at: indexPath)! as! TableViewCell
		let nameAndDetails = currentCell.nameLabel?.text
		
		let indexToEnd = nameAndDetails?.range(of:" - ")
		nameToPass = nameAndDetails?.substring(to: (indexToEnd?.lowerBound)!)
		detailsToPass = nameAndDetails?.substring(from: (indexToEnd?.upperBound)!)
		amountToPass = currentCell.amountLabel?.text
		//dateToPass = tableView.sectionName
		timeToPass = currentCell.timeLabel?.text
	}

	
	/*
	// Override to support conditional editing of the table view.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the specified item to be editable.
	return true
	}
	*/
	
	/*
	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
	if editingStyle == .delete {
	// Delete the row from the data source
	tableView.deleteRows(at: [indexPath], with: .fade)
	} else if editingStyle == .insert {
	// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	}
	}
	*/
	
	/*
	// Override to support rearranging the table view.
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
	
	}
	*/
	
	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the item to be re-orderable.
	return true
	}
	*/
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
}

/* Try storing data into the cell without actually displaying any of it
*/
