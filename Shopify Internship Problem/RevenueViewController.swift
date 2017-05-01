//
//  RevenueViewController.swift
//  Shopify Internship Problem
//
//  Created by N on 2017-04-27.
//  Copyright © 2017 nkuuhe. All rights reserved.
//

import UIKit

class RevenueViewController: UIViewController {
	
	@IBOutlet weak var itemsSoldLabel: UILabel!
	@IBOutlet weak var percentageRevenueLabel: UILabel!
	@IBOutlet weak var totalRevenueLabel: UILabel!
	@IBOutlet weak var productNameLabel: UILabel!
	
	var orders: [Order] = []
	let downloadManager = DownloadManager.sharedInstance
	
	override func awakeFromNib() {
		super.awakeFromNib()
		downloadOrders()
	}
	
	func downloadOrders() {
		downloadManager.loadOrdersFromCloud(success: { [weak self] (orders) in
			self?.orders = orders
			
			DispatchQueue.main.async {
				self?.updateLabels()
			}
			
		}) { (error) in
			print(error)
		}
	}
	
	var itemsSold: Int {
		return orders.reduce(0) {
			$0 + $1.productsWithName(name: "Aerodynamic Cotton Keyboard").count
		}
	}
	
	var totalRevenue: Double {
		return orders.reduce(0) {
			$0 + $1.totalPrice
		}
	}
	
	var percentageOfRevenue: Double {
		let productRevenue = orders.reduce(0) {
			$0 + $1.revenueForProduct(name: "Aerodynamic Cotton Keyboard")
		}
		
		return (productRevenue / totalRevenue) * 100
	}
	
	func updateLabels() {
		itemsSoldLabel.text = "\(itemsSold)"
		totalRevenueLabel.text = "$\(totalRevenue)"
		percentageRevenueLabel.text = String(format: "%.2f", percentageOfRevenue) + "%"
	}
	
	
	
}
