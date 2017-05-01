//
//  DownloadManager.swift
//  Shopify Internship Problem
//
//  Created by N on 2017-04-27.
//  Copyright © 2017 nkuuhe. All rights reserved.
//

import Foundation

class DownloadManager {
	
	static let sharedInstance = DownloadManager()
	
	public func loadOrdersFromCloud(success: @escaping ([Order]) -> (),
	                     failure: @escaping (Error)->()) {
		
		let shopifyURL = URL(string: "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
		
		loadDataFromURL(url: shopifyURL!) { (data, error) in
			guard let json = try? JSONSerialization.jsonObject(with: data!) as! [String: Any] else {
				print("Serialization Error")
				failure(error!)
				return
			}
			
			guard let orders = json["orders"] as? [[String: Any]]
				else {
					print("Unable to retrieve orders from json")
					return
			}
			
			let downloadedOrders = orders.map {
				Order(json: $0)
			}
			
			success(downloadedOrders as! [Order])
		}
	}
	
	public func loadDataFromURL(url: URL, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
		let loadDataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let _ = error {
				completion(nil, error)
			} else if let response = response as? HTTPURLResponse {
				if response.statusCode != 200 {
					let statusError = NSError(domain: "com.nkuuhe",
					                          code: response.statusCode,
					                          userInfo: [NSLocalizedDescriptionKey: "HTTP status code has unexpected value."])
					completion(nil, statusError)
				} else {
					completion(data, nil)
				}
			}
		}
		loadDataTask.resume()
	}
	
}


