//
//  TextViewController.swift
//  ProfilerSA
//
//  Created by Soheil on 18/08/2018.
//  Copyright © 2018 Novinfard. All rights reserved.
//

import UIKit

class TextViewController: UIViewController, UITextViewDelegate {
	@IBOutlet weak var textView: UITextView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		textView.delegate = self
        configStyle()
    }
	
	func configStyle() {
		textView.returnKeyType = .done
		textView.layer.borderColor = UIColor(red: 0.05, green: 0.08, blue: 0.15, alpha: 1).cgColor
		textView.layer.borderWidth = 0.34
	}
	
	// MARK: - UITextViewDelegate
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		if (text == "\n") {
			textView.resignFirstResponder()
		}
		return true
	}
	
	// MARK: - Actions
	@IBAction func predictPressed(_ sender: Any) {
		UserDefaults.standard.set(textView.text, forKey: "predictionDocument")
		UserDefaults.standard.set("text", forKey: "predictionType")
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let controller = storyboard.instantiateViewController(withIdentifier: "requestController") as! RequestViewController
		self.navigationController?.pushViewController(controller, animated: true)
	}
}
