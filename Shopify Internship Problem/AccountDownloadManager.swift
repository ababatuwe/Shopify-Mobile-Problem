////
////  AccountDownloadManager.swift
////  Wallet App
////
////  Created by N on 2017-04-04.
////  Copyright © 2017 agaba. All rights reserved.
////
//
//import Foundation
//import Alamofire
//
//class AccountDownloadManager {
//	
//	static let sharedInstance = AccountDownloadManager()
//	
//	var accounts = [Account]()
//	
//	public func loadAccountsFromCloud(completion: ((Bool) -> ())?) {
//		download(success: { [weak self] (accounts) in
//			guard let strongSelf = self else { return }
//			
//			strongSelf.accounts = accounts
//			completion?(true)
//			
//			}, failure: { (error) in
//				print("Error: \(error)")
//				completion?(false)
//		})
//	}
//
//	
//	public func download(success: @escaping ([Account])->(),
//	                             failure: @escaping (Error)->()) {
//		var _accounts = [Account]()
//		
//		let url = "https://gist.githubusercontent.com/Shanjeef/3562ebc5ea794a945f723de71de1c3ed/raw/25da03b403ffa860dd68a9bfc84f562262ee5ca5/walletEndpoint"
//		
//		Alamofire.request(url).responseJSON { response in
//			
//			guard response.result.isSuccess else {
//				print("Error while fetching data \(String(describing: response.result.error))")
//				failure(response.result.error!)
//				return
//			}
//			
//			guard let responseJSON = response.result.value as? [String: Any],
//				let info = responseJSON["info"] as? [String: Any],
//				let cards = info["cards"] as? [[String: Any]]
//				else {
//					print("Invalid data received")
//					failure("Invalid data received" as! Error)
//					return
//			}
//			
//			for card in cards {
//				if let account = Account(from: card) {
//					_accounts.append(account)
//				}
//			}
//			success(_accounts)
//		}
//	}
//	
//	}
