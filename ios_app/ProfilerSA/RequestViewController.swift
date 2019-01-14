//
//  RequestViewController.swift
//  ProfilerSA
//
//  Created by Soheil on 18/08/2018.
//  Copyright © 2018 Novinfard. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import SwiftyJSON
import NaturalLanguage

class RequestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		addLoader()
		
		self.navigationItem.setHidesBackButton(true, animated:true)
		
		if UserDefaults.standard.string(forKey: "predictionType") == "celebrity" {
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
				MBProgressHUD.hide(for: self.view, animated: true)
				self.goToResult()
			}
		} else {
			sendPredictionRequest()
		}


	}
	
	func addLoader() {
		let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
		loadingNotification.mode = MBProgressHUDMode.indeterminate
		loadingNotification.label.text = "Loading"
	}
	
	func sendPredictionRequest() {
		guard let document = UserDefaults.standard.string(forKey: "predictionDocument") else {
			return
		}
		if let sentimentPredictor = try? NLModel(mlModel: EXT().model),
			let result = sentimentPredictor.predictedLabel(for: document) {
			UserDefaults.standard.set(getDoubleResult(from: result), forKey: "extResult")
		}
		
		if let sentimentPredictor = try? NLModel(mlModel: NEU().model),
			let result = sentimentPredictor.predictedLabel(for: document) {
			UserDefaults.standard.set(getDoubleResult(from: result), forKey: "neuResult")
		}
		
		if let sentimentPredictor = try? NLModel(mlModel: AGR().model),
			let result = sentimentPredictor.predictedLabel(for: document) {
			UserDefaults.standard.set(getDoubleResult(from: result), forKey: "agrResult")
		}
		
		if let sentimentPredictor = try? NLModel(mlModel: CON().model),
			let result = sentimentPredictor.predictedLabel(for: document) {
			UserDefaults.standard.set(getDoubleResult(from: result), forKey: "conResult")
		}
		
		if let sentimentPredictor = try? NLModel(mlModel: OPN().model),
			let result = sentimentPredictor.predictedLabel(for: document) {
			UserDefaults.standard.set(getDoubleResult(from: result), forKey: "opnResult")
		}
		
		self.goToResult()
		
	}
	
	private func getDoubleResult(from resultString: String) -> Double {
		if resultString == "y" {
			return 1
		} else {
			return 0
		}
	}
	
	func displayError() {
		let alert = UIAlertController(title: "Connection", message: "There is a connection error, try again later", preferredStyle:.alert)
		
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction!) in
			self.navigationController?.popViewController(animated: true)
		})
		present(alert, animated: true, completion: nil)
		return
	}
	
	func goToResult() {
		// push result controller
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let controller = storyboard.instantiateViewController(withIdentifier: "resultController") as! ResultViewController
		self.navigationController?.pushViewController(controller, animated: true)
	}

}
