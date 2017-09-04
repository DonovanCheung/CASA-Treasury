//
//  DatePopupViewController.swift
//  CASA Treasury
//
//  Created by Donovan Cheung on 8/22/17.
//  Copyright © 2017 Donovan Cheung. All rights reserved.
//

import UIKit

class DatePopupViewController: UIViewController {
	@IBOutlet weak var timeControl: UISegmentedControl!

	@IBAction func doneButton1(_ sender: Any) {
		if (timeControl.selectedSegmentIndex == 1) {
			date = datePicker.date
		}
		else {
			date = Date()
		}
		
		performSegue(withIdentifier: "unwindSegueToAddViewController", sender: self)
		
	}
	
	@IBAction func cancelButton1(_ sender: Any) {
		performSegue(withIdentifier: "unwindSegueToAddViewController", sender: self)
	}
	@IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
		
		datePicker.isEnabled = false
		timeControl.addTarget(self, action: #selector(timeControlChanged(_:)), for: .valueChanged)
		// Do any additional setup after loading the view.
    }
	
	func timeControlChanged(_ sender: UISegmentedControl) {
		if (timeControl.selectedSegmentIndex == 1) {
			datePicker.isUserInteractionEnabled = true
			datePicker.isEnabled = true
		}
		else {
			datePicker.isEnabled = false
			datePicker.isUserInteractionEnabled = false
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
