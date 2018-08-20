//
//  ViewController.swift
//  testApp
//
//  Created by Soheil on 09/08/2018.
//  Copyright © 2018 Novinfard. All rights reserved.
//

import UIKit
import AeroGearHttp
import AeroGearOAuth2

class ViewController: UIViewController {
	
	var http = Http()
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.http = Http()
		// Do any additional setup after loading the view, typically from a nib.
		predicate()
	}
	
	func predicate() {
		let googleConfig = GoogleConfig(
			clientId: "288491652819-vuoiudlmlik6gosen5ho5kfi7cm5kqi0.apps.googleusercontent.com",
			scopes: ["https://www.googleapis.com/auth/cloud-platform"])
		// If you want to use embedded web view uncomment
		//googleConfig.isWebView = true
		// Workaround issue on Keychain https://forums.developer.apple.com/message/23323
		let gdModule = OAuth2Module(config: googleConfig, session: UntrustedMemoryOAuth2Session(accountId: "ACCOUNT_FOR_CLIENTID_\(googleConfig.clientId)"))
		
//		let gdModule = AccountManager.addGoogleAccount(config: googleConfig)
		self.http.authzModule = gdModule
		self.performRequest("https://ml.googleapis.com/v1/projects/personality-detection/models/svm_gs_ext/version/NEU:predict", parameters: self.parametersForPredicate())
	}
	
	func performRequest(_ url: String, parameters: [String: AnyObject]?) {
		self.http.request(method: .post, path: url, parameters: parameters, completionHandler: { (response, error) in
			if (error != nil) {
				self.presentAlert("Error", message: error!.localizedDescription)
			} else {
				self.presentAlert("Success", message: "Successfully uploaded!")
			}
		})
	}
	
	func presentAlert(_ title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}

	func parametersForPredicate() -> [String: AnyObject] {
		
//		"name=NEU&deploymentUri=gs://personality-detection-mlengine&runtimeVersion=1.9&framework=SCIKIT_LEARN&pythonVersion=2.7"
		return ["This is test": " " as AnyObject]
	}

}

