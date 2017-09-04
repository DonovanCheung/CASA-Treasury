//
//  DetailViewController.swift
//  CASA Treasury
//
//  Created by Donovan Cheung on 8/17/17.
//  Copyright © 2017 Donovan Cheung. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {
	let transactionRef = Database.database().reference().child("transactions")
	
	@IBOutlet weak var nameLabel: UILabel!

	@IBOutlet weak var amountLabel: UILabel!
	
	@IBOutlet weak var accountLabel: UILabel!
	
	@IBOutlet var dateLabel: UILabel!
	
	@IBOutlet weak var detailLabel: UILabel!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		nameLabel.text = nameToPass
		detailLabel.text = detailsToPass
		amountLabel.text = amountToPass
		if (amountToPass[amountToPass.startIndex] == "-") {
			amountLabel.textColor = UIColor.red

		}
		else {
			amountLabel.textColor = UIColor.green
		}
		dateLabel.text = timeToPass
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
