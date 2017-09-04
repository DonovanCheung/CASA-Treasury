//
//  AddViewController.swift
//  CASA Treasury
//
//  Created by Donovan Cheung on 8/11/17.
//  Copyright © 2017 Donovan Cheung. All rights reserved.
//

import UIKit
import Firebase

var date: Date!
var dateString: String!
var timeString: String!

class AddViewController: UITableViewController, UITextFieldDelegate{
	let rootRef = Database.database().reference()
	@IBOutlet weak var expenseOrIncome: UISegmentedControl!
	
	@IBOutlet weak var doneButton: UIBarButtonItem!

	@IBOutlet weak var dateTimeLabel: UILabel!
	
	@IBOutlet weak var categoryLabel: UILabel!
	@IBOutlet weak var accountLabel: UILabel!
	
	var timestamp: Double!
	func updateTimeDateLabel(date: String, time: String) -> () {
		dateTimeLabel.text = date + "  " + time
	}
	func retrieveDateTime(date: Date) -> () {
		timestamp = floor(date.timeIntervalSince1970)
		let calendar = Calendar.current
		let hour = calendar.component(.hour, from: date)
		let minute = calendar.component(.minute, from: date)
		let mon = calendar.component(.month, from: date)
		let day = calendar.component(.day, from: date)
		let year = calendar.component(.year, from: date)
		var month: String!
		dateString = ""
		timeString = ""
		
		switch (mon) {
		case 1:
			month = "January"
			break
		case 2:
			month = "February"
			break
		case 3:
			month = "March"
			break
		case 4:
			month = "April"
			break
		case 5:
			month = "May"
			break
		case 6:
			month = "June"
			break
		case 7:
			month = "July"
			break
		case 8:
			month = "August"
			break
		case 9:
			month = "September"
			break
		case 10:
			month = "October"
			break
		case 11:
			month = "November"
			break
		case 12:
			month = "December"
			break
		default:
			break
		}
		
		
		
		dateString = month + " " + (String(day)) + ", " + (String(year))
		
		if (hour > 12) {
			timeString = (String(hour%12)) + ":"
		}
		else if (hour > 0) {
			timeString = (String(hour)) + ":"
		}
		else {
			timeString = "12:"
		}
		
		if (minute < 10) {
			timeString = timeString + "0"
		}
		
		
		timeString = timeString + String(minute)
		if (hour >= 12) {
			timeString = timeString + " PM"
		}
		else {
			timeString = timeString + " AM"
		}
	}
	
	@IBAction func doneButton(_ sender: Any) {
		var accountChoice: String!
		switch (1) {
		//switch (AccountPickerViewController().accountPicker.) {
			case 0:
				accountChoice = "bank"
				break
			case 1:
				accountChoice = "venmo"
				break
			case 2:
				accountChoice = "cash"
				break
			default:
				break
		}
		
		
		
		/*if (DatePopupViewController().timeControl.selectedSegmentIndex == 1) {
			date = DatePopupViewController().datePicker.date
		}
		else {
			date = Date()
		}*/
		
		retrieveDateTime(date: date)

		
		if (expenseOrIncome.selectedSegmentIndex == 1) {
			amt = amt * -1
		}
		
		rootRef
			.child("transactions")
			.childByAutoId()
			.setValue(["name": nameField.text!,
			           "amount": Double(amt)/100,
			           "details": detailField.text!,
			           "summary": noteField.text!,
			           "date": dateString,
			           "time": time,
			           "timestamp": timestamp,
			           "account": accountChoice])
		
		
		//BankViewController.reloadData
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func unwindToAdd(segue:UIStoryboardSegue) {
	}
	
	@IBAction func cancelButton(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var amountField: UITextField!
	@IBOutlet weak var detailField: UITextField!
	@IBOutlet weak var noteField: UITextField!
	
	// Inputted Subtotal
	var amt: Int = 0
	
	
	// Developer Test Label
	//@IBOutlet weak var testLabel: UILabel!
	

	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		date = Date()
		/*retrieveDateTime(date: date)
		
		dateTimeLabel?.text = dateString + "  " + timeString*/
		amountField.delegate = self
		amountField.placeholder = updateAmount()
		
		
		
		// Check to enable Calculate Button whenever user inputs
		amountField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
		nameField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
		/*detailField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
		noteField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)*/
		
		
	}
	override func viewWillAppear(_ animated: Bool) {
		retrieveDateTime(date: date)
		updateTimeDateLabel(date: dateString, time: timeString)
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func editingChanged(_ textField: UITextField) {
		if textField.text?.characters.count == 1 {
			if textField.text?.characters.first == " " {
				textField.text = ""
				return
			}
		}
		guard
			let naF = nameField.text, !naF.isEmpty,
			let aF = amountField.text, !aF.isEmpty,
			let dF = detailField.text, !dF.isEmpty,
			let noF = noteField.text, !noF.isEmpty
			else {
				doneButton.isEnabled = false
				return
		}
		
		doneButton.isEnabled = true
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		
		if let digit = Int(string){
			amt = amt * 10 + digit
			
			if amt > 1_000_000_00{
				let alert = UIAlertController(title: "Please enter an amount less than one million", message: nil, preferredStyle: UIAlertControllerStyle.alert)
				
				alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
				
				present(alert, animated: true, completion: nil)
				
				amountField.text = ""
				
				amt = 0
			}
			else{
				amountField.text = updateAmount()
			}
		}
		
		if string == "" {
			amt = amt/10
			
			amountField.text = amt == 0 ? "" : updateAmount()
		}
		
		return false
	}
	
	func updateAmount() -> String? {
		let formatter = NumberFormatter()
		
		formatter.numberStyle = NumberFormatter.Style.currency
		
		let amount = Double(amt/100) + Double(amt%100)/100
		
		return formatter.string(from: NSNumber(value: amount))
	}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
/* Change amount so it doesn't include decimal*/
