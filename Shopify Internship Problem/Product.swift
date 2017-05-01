//
//  Product.swift
//  Shopify Internship Problem
//
//  Created by N on 2017-04-29.
//  Copyright © 2017 nkuuhe. All rights reserved.
//

import Foundation

struct Product: CustomStringConvertible {
	let title: String
	let price: Double
	let variant: String
	
	public init?(json: [String: Any]) {
		guard let title = json["title"] as? String,
			let price = json["price"] as? String,
			let variant = json["variant_title"] as? String
			else {
				return nil
		}
		
		self.title = title
		self.price = Double(price)!
		self.variant = variant
	}
	
	var description: String {
		return "Product Title: \(title)\n" +
			"Price: \(price)\n" +
		"Variant: \(variant)"
	}
}

