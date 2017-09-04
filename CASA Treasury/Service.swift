//
//  DataModel.swift
//  CASA Treasury
//
//  Created by Donovan Cheung on 8/9/17.
//  Copyright © 2017 Donovan Cheung. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase

class Service {
	
	static let sharedInstance = Service()
	// Database References
	let rootRef = Database.database().reference().child("transactions").queryOrdered(byChild: "timestamp")
	
	// Initialization
	var allTransactions = [transaction]()
	var bankTransactions = [transaction]()
	var venmoTransactions = [transaction]()
	var cashTransactions = [transaction]()
	
	func runService(choice: String, completion: @escaping (Bool) -> ()) {
		DispatchQueue.global(qos: .userInteractive).async {
/*Database.database().reference()
.child("balance").observeSingleEvent(of: .value, with: { (snapshot) in
let balance = snapshot.value as? NSDictionary
let totalBalance = balance?["all"]
})*/

			self.rootRef.observeSingleEvent(of: .value, with: { snapshot in
				for snap in snapshot.children {
					let snapshotValue = (snap as! DataSnapshot).value as? NSDictionary
					let name = snapshotValue?["name"] as? String
					let details = snapshotValue?["details"] as? String
					let time = snapshotValue?["time"] as? String
					let date = snapshotValue?["date"] as? String
					let account = snapshotValue?["account"] as! String
					let amount = snapshotValue?["amount"] as? Double
					let timestamp = snapshotValue?["timestamp"] as? Int
					let eachTransaction = transaction(name: name, details: details, account: account, amount: amount, date: date, time: time, timestamp: timestamp)
					
					self.allTransactions.insert(eachTransaction, at: 0)
					if (choice == "bank" && account == "bank") {
						self.bankTransactions.insert(eachTransaction, at: 0)
					}
					else if (choice == "venmo" && account == "venmo") {
						self.venmoTransactions.insert(eachTransaction, at: 0)
					}
					else if (choice == "cash" && account == "cash") {
						self.cashTransactions.insert(eachTransaction, at: 0)
					}
				}
				completion(true)
			})
		}
	}
	
	func getAll() -> [transaction] {
		return self.allTransactions
	}
	
	func getBank() -> [transaction] {
		return self.bankTransactions
	}
	
	func getVenmo() -> [transaction] {
		return self.venmoTransactions
	}
	
	func getCash() -> [transaction] {
		return self.cashTransactions
	}
}


/*//
//  DataModel.swift
//  CASA Treasury
//
//  Created by Donovan Cheung on 8/9/17.
//  Copyright © 2017 Donovan Cheung. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase

class Service {
	
	static let sharedInstance = Service()
	// Database References
	let rootRef = Database.database().reference().child("transactions").queryOrdered(byChild: "timestamp")
	
	// Initialization
	var allTransactions = [transaction]()
	var bankTransactions = [transaction]()
	var venmoTransactions = [transaction]()
	var cashTransactions = [transaction]()
	var doneGrabbing = false
	
	func runService(choice: String, completion: @escaping (Bool) -> ()) {
		
		rootRef.observeSingleEvent(of: .value, with: { snapshot in
			for snap in snapshot.children {
				let snapshotValue = (snap as! DataSnapshot).value as? NSDictionary
				let name = snapshotValue?["name"] as? String
				let details = snapshotValue?["details"] as? String
				let time = snapshotValue?["time"] as? String
				let date = snapshotValue?["date"] as? String
				let account = snapshotValue?["account"] as! String
				let amount = snapshotValue?["amount"] as? Double
				let timestamp = snapshotValue?["timestamp"] as? Int
				let eachTransaction = transaction(name: name, details: details, account: account, amount: amount, date: date, time: time, timestamp: timestamp)
				
				self.allTransactions.insert(eachTransaction, at: 0)
				if (choice == "bank" && account == "bank") {
						self.bankTransactions.insert(eachTransaction, at: 0)
				}
				else if (choice == "venmo" && account == "venmo") {
					self.venmoTransactions.insert(eachTransaction, at: 0)
				}
				else if (choice == "cash" && account == "cash") {
					self.cashTransactions.insert(eachTransaction, at: 0)
				}
			}
			completion(true)
		})
	}
		
	func getAll() -> [transaction] {
		return self.allTransactions
	}
	
	func getBank() -> [transaction] {
		return self.bankTransactions
	}
	
	func getVenmo() -> [transaction] {
		return self.venmoTransactions
	}
	
	func getCash() -> [transaction] {
		return self.cashTransactions
	}
}*/
