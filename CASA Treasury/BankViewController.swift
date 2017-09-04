//
//  BankViewController.swift
//  CASA Treasury
//
//  Created by Donovan Cheung on 8/7/17.
//  Copyright © 2017 Donovan Cheung. All rights reserved.
//

import UIKit
import Firebase

/*struct bank: transaction {
	account = "bank"
}*/

class BankViewController: UITableViewController {
	
	// Database References
	
	// Initialization
	var transactions = [transaction]()
	var uniqueDateCount = 1
	var uniqueDateSet: NSMutableOrderedSet = []
	var numberOfTransactions = [Int]()
	var cellNumber = 0
		
	override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
		DispatchQueue.global(qos: .userInteractive).async {
			Service.sharedInstance.runService(choice: "bank", completion: { (data) in
				if (data) {
					self.transactions = Service.sharedInstance.getBank()
				}
				DispatchQueue.main.async {
					self.getUniqueDateSet()
					self.getUniqueDateCount()
					self.getNumberOfTransactions()
					self.refresh()
				}
			})
		}
		/*DispatchQueue.global(qos: .userInteractive).async {
			self.bankRef.observeSingleEvent(of: .value, with: { snapshot in
				for snap in snapshot.children {
					let snapshotValue = (snap as! DataSnapshot).value as? NSDictionary
					let name = snapshotValue?["name"] as? String
					let details = snapshotValue?["details"] as? String
					let time = snapshotValue?["time"] as? String
					let date = snapshotValue?["date"] as? String
					let amount = snapshotValue?["amount"] as? Double
					let timestamp = snapshotValue?["timestamp"] as? Int
		
					self.transactions.insert(transaction(name: name, details: details, account: "bank", amount: amount, date: date, time: time, timestamp: timestamp), at: 0)
					self.uniqueDateSet.add(date!)
				}
				self.uniqueDateCount = self.uniqueDateSet.count
				for date in self.uniqueDateSet {
					var count = 0
					for transaction in self.transactions {
						if (transaction.date == date as! String) {
							count += 1
						}
					}
					self.numberOfTransactions.append(count)
				}
				self.numberOfTransactions = self.numberOfTransactions.reversed()
			})
			DispatchQueue.main.async {
				self.refresh()
			}
		}*/
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
		cell.nameLabel?.text = transactions[cellNumber].name + " - " + transactions[cellNumber].details
		
		let amountForLabel = transactions[cellNumber].amount
		cell.amountLabel?.text = convertAmount(doubleAmount: amountForLabel!)
		if (colorAmount(amount: amountForLabel!)) {
			cell.amountLabel?.textColor = UIColor.green
		}
		else {
			cell.amountLabel?.textColor = UIColor.red
		}
		
		cell.timeLabel?.text = transactions[cellNumber].time
		cellNumber += 1
		return cell
		// Configure the cell...
    }
	
	func getUniqueDateSet() -> () {
		for transaction in self.transactions {
			self.uniqueDateSet.add(transaction.date)
		}
	}
	
	func getUniqueDateCount() -> () {
		self.uniqueDateCount = self.uniqueDateSet.count
	}
	
	func getNumberOfTransactions() -> () {
		for date in self.uniqueDateSet {
			var count = 0
			for transaction in self.transactions {
				if (transaction.date == date as! String) {
					count += 1
				}
			}
			if (count > 0) {
				self.numberOfTransactions.append(count)
			}
		}
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
