//
//  WelcomeViewController.swift
//  ProfilerSA
//
//  Created by Soheil on 18/08/2018.
//  Copyright © 2018 Novinfard. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
	@IBOutlet weak var startButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        configStyle()
    }
	
	func configStyle() {
		startButton.layer.cornerRadius = 8.0
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
