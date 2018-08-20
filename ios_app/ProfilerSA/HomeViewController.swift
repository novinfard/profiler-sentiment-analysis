//
//  HomeViewController.swift
//  ProfilerSA
//
//  Created by Soheil on 18/08/2018.
//  Copyright © 2018 Novinfard. All rights reserved.
//

import UIKit
import TwitterKit
import SwiftyJSON

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	// MARK: - Actions
	@IBAction func facebookPressed(_ sender: Any) {
	}
	
	@IBAction func twitterPressed(_ sender: Any) {
		if let session = TWTRTwitter.sharedInstance().sessionStore.session() {
			// user logged in before
			grabTweets(session: session)
		} else {
			// user need to login
			TWTRTwitter.sharedInstance().logIn(completion: { (session, error) in
				if (session != nil) {
					self.grabTweets(session: session)
				} else {
					print("error: \(error!.localizedDescription)")
				}
			})
		}
	}
	
	func grabTweets(session: TWTRAuthSession?) {
		guard let session = session else {return}
		
		let client = TWTRAPIClient()
		
		let userID = session.userID
//		let userID = "1339835893" //clinton
//		let userID = "25073877" // trump

		let timelineEndpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json"
		let params = ["user_id": userID, "exclude_replies": "false"]
		var clientError : NSError?
		
		let request = client.urlRequest(withMethod: "GET", urlString: timelineEndpoint, parameters: params, error: &clientError)
		
		client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
			if connectionError != nil {
				print("Error: \(connectionError!)")
			}
			
			if let data = data {
				var tweetsArray = Array<String>()
				let tweets = JSON(data)
				if let items = tweets.array {
					for item in items {
						if let tweet = item["text"].string {
							//									print(tweet)
							tweetsArray.append(tweet)
						}
					}
				}
				print(tweetsArray.joined(separator: ". "))
				
				UserDefaults.standard.set(tweetsArray.joined(separator: ". "), forKey: "predictionDocument")
				client.loadUser(withID: userID) { (user, error) -> Void in
					if let user = user {
						UserDefaults.standard.set(user.screenName, forKey: "personName")
						do {
							let data = try Data(contentsOf: URL(string: user.profileImageURL)!)
							UserDefaults.standard.setImage(image: UIImage(data: data), forKey: "personAvatar")
						} catch {
						
						}
					}
				}

				UserDefaults.standard.set("social", forKey: "predictionType")

				
				let storyboard = UIStoryboard(name: "Main", bundle: nil)
				let controller = storyboard.instantiateViewController(withIdentifier: "requestController") as! RequestViewController
				self.navigationController?.pushViewController(controller, animated: true)
			}
			
			
		}
		
	}
	
	@IBAction func instagramPressed(_ sender: Any) {
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
