//
//  CategoryPickerViewController.swift
//  CASA Treasury
//
//  Created by Donovan Cheung on 8/22/17.
//  Copyright © 2017 Donovan Cheung. All rights reserved.
//

import UIKit

class CategoryPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

	@IBOutlet weak var categoryPicker: UIPickerView!
	
	let pickerData = ["Membership","Retreat","Gas Reimbursement","Party Supplies","Culture Show","Other"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		categoryPicker.dataSource = self
		categoryPicker.delegate = self
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerData.count
	}
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return pickerData[row]
	}
 
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		AddViewController().categoryLabel.text = pickerData[row]
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
