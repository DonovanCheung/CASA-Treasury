//
//  ViewController.swift
//  CASA Treasury
//
//  Created by Donovan Cheung on 8/6/17.
//  Copyright © 2017 Donovan Cheung. All rights reserved.
//

import UIKit
import Firebase

func colorAmount(amount: Double) -> (Bool) {
	if (amount < 0) {
		return false
	}
	else {
		return true
	}
}

func convertAmount(doubleAmount: Double) -> (String) {
	
	var stringAmount = ""
	if (doubleAmount < 0){
		stringAmount += "-"
	}
	else {
		stringAmount += "+"
	}
	stringAmount += "$" + String(abs(doubleAmount))
	
	if (doubleAmount == floor(doubleAmount)) {
		stringAmount += "0"
	}
	
	return stringAmount
}

class MasterViewController: UIViewController {
	let treasuryRef = Database.database().reference()
	
	@IBOutlet var segmentedControl: UISegmentedControl!
	
	@IBOutlet weak var menuButton: UIBarButtonItem!
	
	@IBOutlet weak var addButton: UIBarButtonItem!
	
	@IBAction func test(_ sender: Any) {
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view, typically from a nib.
		setupView()
		slideMenu()
		/*setupCamera()
		customizeNavBar()*/
		
		
	}
	
	func slideMenu() {
		if revealViewController() != nil {
			menuButton.target = revealViewController()
			menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
			revealViewController().rearViewRevealWidth = 220
			view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
		}
	}

	
	private func setupView() {
		setupSegmentedControl()
		updateView()
	}
	
	private func setupSegmentedControl() {
		// Configure Segmented Control
		segmentedControl.removeAllSegments()
		segmentedControl.insertSegment(withTitle: "All", at: 0, animated: false)
		segmentedControl.insertSegment(withTitle: "Bank", at: 1, animated: false)
		segmentedControl.insertSegment(withTitle: "Venmo", at: 2, animated: false)
		segmentedControl.insertSegment(withTitle: "Cash", at: 3, animated: false)
		segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
		
		// Select First Segment
		segmentedControl.selectedSegmentIndex = 0
	}
	
	func selectionDidChange(_ sender: UISegmentedControl) {
		updateView()
	}
	
	private lazy var AllViewController: AllViewController = {
		// Load Storyboard
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		
		// Instantiate View Controller
		var viewController = storyboard.instantiateViewController(withIdentifier: "AllViewController") as! AllViewController
		
		// Add View Controller as Child View Controller
		self.add(asChildViewController: viewController)
		
		return viewController
	}()
	
	private lazy var BankViewController: BankViewController = {
		// Load Storyboard
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		
		// Instantiate View Controller
		var viewController = storyboard.instantiateViewController(withIdentifier: "BankViewController") as! BankViewController
		
		// Add View Controller as Child View Controller
		self.add(asChildViewController: viewController)
		
		return viewController
	}()
	
	private lazy var VenmoViewController: VenmoViewController = {
		// Load Storyboard
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		
		// Instantiate View Controller
		var viewController = storyboard.instantiateViewController(withIdentifier: "VenmoViewController") as! VenmoViewController
		
		// Add View Controller as Child View Controller
		self.add(asChildViewController: viewController)
		
		return viewController
	}()
	
	private lazy var CashViewController: CashViewController = {
		// Load Storyboard
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		
		// Instantiate View Controller
		var viewController = storyboard.instantiateViewController(withIdentifier: "CashViewController") as! CashViewController
		
		// Add View Controller as Child View Controller
		self.add(asChildViewController: viewController)
		
		return viewController
	}()
	
	
	private func add(asChildViewController viewController: UIViewController) {
		// Add Child View Controller
		addChildViewController(viewController)
		
		// Add Child View as Subview
		view.addSubview(viewController.view)
		
		// Configure Child View
		viewController.view.frame = view.bounds
		viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		
		// Notify Child View Controller
		viewController.didMove(toParentViewController: self)
	}
	
	private func remove(asChildViewController viewController: UIViewController) {
		// Notify Child View Controller
		viewController.willMove(toParentViewController: nil)
		
		// Remove Child View From Superview
		viewController.view.removeFromSuperview()
		
		// Notify Child View Controller
		viewController.removeFromParentViewController()
	}
	
	private func updateView() {
		remove(asChildViewController: AllViewController)
		remove(asChildViewController: BankViewController)
		remove(asChildViewController: VenmoViewController)
		remove(asChildViewController: CashViewController)
		switch (segmentedControl.selectedSegmentIndex) {
			case 0:
				//remove(asChildViewController: BankViewController)
				add(asChildViewController: AllViewController)
				break
			case 1:
				//remove(asChildViewController: AllViewController)
				add(asChildViewController: BankViewController)
				break
			case 2:
				//remove(asChildViewController: AllViewController)
				add(asChildViewController: VenmoViewController)
				break
			case 3:
				//remove(asChildViewController: AllViewController)
				add(asChildViewController: CashViewController)
				break
			default:
				break
		}
	}
	
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	/*	@IBAction func sunnyDidTouch(_ sender: Any) {
	conditionRef.setValue("Sunny")
	}
	
	@IBAction func foggyDidTouch(_ sender: Any) {
	conditionRef.setValue("Foggy")
	}*/
	
	/*func slideMenu() {
	if revealViewController() != nil{
	menuButton.target = revealViewController()
	menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
	revealViewController().rearViewRevealWidth = 220
	
	/*revealViewController().rightViewRevealWidth = 160
	
	cameraButton.target = revealViewController()
	cameraButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))*/
	
	view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
	}
	}*/
	
	/*func setupCamera() {
	cameraButton.target = revealViewController()
	/*cameraButton.action = #selector(CameraViewController.show(_:sender:))*/
	
	view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
	}*/
	
	/*func customizeNavBar() {
	navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
	navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 255.0/255.0, green: 87.0/255.0, blue: 35.0/255.0, alpha: 1.0)
	navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
	}*/
}
