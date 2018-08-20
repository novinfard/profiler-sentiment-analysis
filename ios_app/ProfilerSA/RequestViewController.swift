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

class RequestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		addLoader()
		
		self.navigationItem.setHidesBackButton(true, animated:true)
		
		if UserDefaults.standard.string(forKey: "predictionType") == "celebrity" {
//		if UserDefaults.standard.string(forKey: "predictionType") != "" {
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
		let requestedParams = ["text": UserDefaults.standard.string(forKey: "predictionDocument")!]
		let url = URL(string: "http://localhost:8080")
		Alamofire.request(url!, method: .post, parameters: requestedParams)
		Alamofire.request(url!, method: .post, parameters: requestedParams).responseJSON { response in
			MBProgressHUD.hide(for: self.view, animated: true)
			// error handling
			guard case let .failure(error) = response.result else {
				// successful
				 print(response)
				guard let jsonData = response.data else {
					self.displayError()
					return
				}
				do {
					let json = try JSON(data: jsonData)
					print(json)
					if json["ext"].exists() {
						UserDefaults.standard.set(json["ext"].double, forKey: "extResult")
						UserDefaults.standard.set(json["neu"].double, forKey: "neuResult")
						UserDefaults.standard.set(json["agr"].double, forKey: "agrResult")
						UserDefaults.standard.set(json["con"].double, forKey: "conResult")
						UserDefaults.standard.set(json["opn"].double, forKey: "opnResult")
						
						self.goToResult()
					} else {
						self.displayError()
					}
				} catch _ as NSError {
					self.displayError()
				}
				return
			}
			if error is AFError {
				self.displayError()
			} else if error is URLError {
				self.displayError()
			}
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
