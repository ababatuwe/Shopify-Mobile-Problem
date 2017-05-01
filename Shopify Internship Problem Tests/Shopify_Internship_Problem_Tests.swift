//
//  Shopify_Internship_Problem_Tests.swift
//  Shopify Internship Problem Tests
//
//  Created by N on 2017-04-27.
//  Copyright © 2017 nkuuhe. All rights reserved.
//

import XCTest
@testable import Shopify_Internship_Problem

class Shopify_Internship_Problem_Tests: XCTestCase {
	
	
	var downloadManager: DownloadManager!
	
	override func setUp() {
		downloadManager = DownloadManager.sharedInstance
	}
	
	
	func testDownloadData() {
		let expectation = self.expectation(description: "Testing Data download")
		
		let shopifyURL = URL(string: "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
		
		downloadManager.loadDataFromURL(url: shopifyURL!) { (data, error) in
			expectation.fulfill()
			XCTAssert(data != nil, "Download Manager not loading data")
		}
		waitForExpectations(timeout: 3, handler: nil)
	}
	
	func testDownloadOrders() {
		// given
		let expectation = self.expectation(description: "Expected load orders from cloud to fail")
		
		
		// then
		downloadManager.loadOrdersFromCloud(success: { (orders) in
			expectation.fulfill()
			XCTAssert(!orders.isEmpty, "Accounts Download failed")
		}, failure: { (error) in
			print("Error: \(error)")
		})

		
		// when
		waitForExpectations(timeout: 3, handler: nil)
		
	}
	
}
