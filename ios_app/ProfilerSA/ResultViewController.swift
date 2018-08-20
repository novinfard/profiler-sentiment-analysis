//
//  ResultViewController.swift
//  ProfilerSA
//
//  Created by Soheil on 18/08/2018.
//  Copyright © 2018 Novinfard. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
	@IBOutlet weak var avatarImageView: UIImageView!
	@IBOutlet weak var userNameLabel: UILabel!
	@IBOutlet weak var extImageView: UIImageView!
	@IBOutlet weak var neuImageView: UIImageView!
	@IBOutlet weak var agrImageView: UIImageView!
	@IBOutlet weak var conImageView: UIImageView!
	@IBOutlet weak var opnImageView: UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		loadResult()
		configStyle()
    }
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		// reset data
		UserDefaults.standard.set("", forKey: "predictionDocument")
		
		UserDefaults.standard.set(0.0, forKey: "extResult")
		UserDefaults.standard.set(0.0, forKey: "neuResult")
		UserDefaults.standard.set(0.0, forKey: "agrResult")
		UserDefaults.standard.set(0.0, forKey: "conResult")
		UserDefaults.standard.set(0.0, forKey: "opnResult")
		
		UserDefaults.standard.set("", forKey: "personName")
		UserDefaults.standard.setImage(image: UIImage(named: "avatar_default"), forKey: "personAvatar")
	}
	
	func loadResult() {
		if UserDefaults.standard.string(forKey: "personName") != "" {
			userNameLabel.text = UserDefaults.standard.string(forKey: "personName")
		}
		
		if let image = UserDefaults.standard.imageForKey(key: "personAvatar") {
			avatarImageView.image = image
		} else {
			avatarImageView.image = UIImage(contentsOfFile: "https://pbs.twimg.com/profile_images/995406066883203073/pTU77eQP_normal.jpg")
		}
		
		let arrowUp = UIImage(named: "arrow_up")
		let arrowDown =  UIImage(named: "arrow_down")
		
		if UserDefaults.standard.double(forKey: "extResult") == 0.0 {
			extImageView.image = arrowDown
		} else {
			extImageView.image = arrowUp
		}
		
		if UserDefaults.standard.double(forKey: "neuResult") == 0.0 {
			neuImageView.image = arrowDown
		} else {
			neuImageView.image = arrowUp
		}

		if UserDefaults.standard.double(forKey: "agrResult") == 0.0 {
			agrImageView.image = arrowDown
		} else {
			agrImageView.image = arrowUp
		}

		if UserDefaults.standard.double(forKey: "conResult") == 0.0 {
			conImageView.image = arrowDown
		} else {
			conImageView.image = arrowUp
		}

		if UserDefaults.standard.double(forKey: "opnResult") == 0.0 {
			opnImageView.image = arrowDown
		} else {
			opnImageView.image = arrowUp
		}

	}
	
	func configStyle() {
		self.navigationItem.hidesBackButton = true
		let newBackButton = UIBarButtonItem(title: "Home", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ResultViewController.back(sender:)))
		self.navigationItem.leftBarButtonItem = newBackButton
	}
	
	@objc func back(sender: UIBarButtonItem) {
		navigationController?.popToRootViewController(animated: true)
	}

}
