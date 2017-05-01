//
//  Order.swift
//  Shopify Internship Problem
//
//  Created by N on 2017-04-30.
//  Copyright © 2017 nkuuhe. All rights reserved.
//

import Foundation

struct Order {
	let currency: String
	let totalPrice: Double
	let totalPriceUSD: Double
	let totalWeight: Double
	var products: [Product]
	let timestamp: Date
	
	public init?(json: [String: Any]) {
		guard let currency = json["currency"] as? String else {
			print("Error parsing currency")
			return nil
		}
		guard let totalPrice = json["total_price"] as? String else {
			print("Error parsing total price")
			return nil
		}
		guard let totalPriceUSD = json["total_price_usd"] as? String else {
			print("Error parsing total price usd")
			return nil
		}
		guard let totalWeight = json["total_weight"] as? NSNumber else {
			print("Error parsing total weight")
			return nil
		}
		guard let products = json["line_items"] as? [[String: Any]] else {
			print("Error parsing line items")
			return nil
		}
		
		guard let updated_at = json["updated_at"] as? String else {
			print("error parsing time")
			return nil
		}
		
		
		
		self.timestamp = dateFormatter.date(from: updated_at)!
		self.currency = currency
		self.totalPrice = Double(totalPrice)!
		self.totalWeight = totalWeight.doubleValue
		self.totalPriceUSD = Double(totalPriceUSD)!
		
		self.products = [Product]()
		
		for product in products {
			if let newProduct = Product(json: product) {
				self.products.append(newProduct)
			}
		}
	}
	
	func productsWithName(name: String) -> [Product] {
		return products.filter { (product) -> Bool in
			product.title == name
		}
	}
	
	func revenueForProduct(name: String) -> Double {
		let products = productsWithName(name: name)
		
		return products.reduce(0) {
			$0 + $1.price
		}
	}
	
	
}

extension Order: CustomStringConvertible {
	var description: String {
		return "Currency: \(currency)\n" +
			"Total Price: \(totalPrice)\n" +
			"Total Price USD: \(totalPriceUSD)\n" +
			"Total Weight: \(totalWeight)\n" +
			"Date: \(timestamp)\n" +
			"Line Items: \(products)\n"
	}
}

