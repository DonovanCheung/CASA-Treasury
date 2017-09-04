//
//  CameraViewController.swift
//  CASA Treasury
//
//  Created by Donovan Cheung on 8/20/17.
//  Copyright © 2017 Donovan Cheung. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	@IBOutlet weak var pickedImage: UIImageView!

	@IBAction func cameraButton(_ sender: Any) {
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
			let imagePicker = UIImagePickerController()
			imagePicker.delegate = self
			imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
			imagePicker.allowsEditing = false
			self.present(imagePicker, animated: true, completion: nil)
		}
	}
	
	@IBAction func photoLibraryButton(_ sender: Any) {
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
			let imagePicker = UIImagePickerController()
			imagePicker.delegate = self
			imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
			imagePicker.allowsEditing = true
			self.present(imagePicker, animated: true, completion: nil)
		}
	}
	
	
	@IBAction func saveButton(_ sender: Any) {
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
