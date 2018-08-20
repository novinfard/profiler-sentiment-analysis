//
//  CelebrityViewController.swift
//  ProfilerSA
//
//  Created by Soheil on 18/08/2018.
//  Copyright © 2018 Novinfard. All rights reserved.
//

import UIKit

class CelebrityViewController: UIViewController, UITableViewDelegate {
	@IBOutlet weak var tableView: UITableView!
	var celebrities = [Celebrity]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		fillData()

        tableView.delegate = self
		tableView.dataSource = self
    }
	
	func fillData() {
		let celeb1 = Celebrity(name: "Donald Trump", avatar: UIImage(named: "avatar_trump"), extResult: 1.0, neuResult: 1.0, agrResult: 0.0, conResult: 0.0, opnResult: 0.0)
		let celeb2 = Celebrity(name: "Hillary Clinton", avatar: UIImage(named: "avatar_clinton"), extResult: 0.0, neuResult: 0.0, agrResult: 0.0, conResult: 1.0, opnResult: 1.0)
		let celeb3 = Celebrity(name: "Rihanna", avatar: UIImage(named: "avatar_rihanna"), extResult: 1.0, neuResult: 0.0, agrResult: 1.0, conResult: 0.0, opnResult: 1.0)
		celebrities = [celeb1, celeb2, celeb3]
	}

}

// MARK: TableView DataSource
extension CelebrityViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return celebrities.count
	}
	
	func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "celebrityCell", for: indexPath) as! CelebrityTableViewCell
		let celebrityRow = celebrities[indexPath.row]
		
		cell.celebAvatar.image = celebrityRow.avatar
		cell.celebName.text = celebrityRow.name
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let celebrityRow = celebrities[indexPath.row]
		
		UserDefaults.standard.set(celebrityRow.extResult, forKey: "extResult")
		UserDefaults.standard.set(celebrityRow.neuResult, forKey: "neuResult")
		UserDefaults.standard.set(celebrityRow.agrResult, forKey: "agrResult")
		UserDefaults.standard.set(celebrityRow.conResult, forKey: "conResult")
		UserDefaults.standard.set(celebrityRow.opnResult, forKey: "opnResult")
		
		UserDefaults.standard.set(celebrityRow.name, forKey: "personName")
		UserDefaults.standard.setImage(image: celebrityRow.avatar, forKey: "personAvatar")
		
		UserDefaults.standard.set("celebrity", forKey: "predictionType")

		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let controller = storyboard.instantiateViewController(withIdentifier: "requestController") as! RequestViewController
//		present(controller, animated: true)
		navigationController?.pushViewController(controller, animated: true)
	}
	
//	func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: IndexPath) {
//		let cell = tableView.dequeueReusableCell(withIdentifier: "celebrityCell", for: indexPath) as! CelebrityTableViewCell
//		cell.backgroundColor = .white
//	}
	
}
