//
//  Functions.swift
//  Wallet App
//
//  Created by N on 2017-03-21.
//  Copyright © 2017 agaba. All rights reserved.
//

import Foundation

let dateFormatter: DateFormatter = {
	let formatter = DateFormatter()
	formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
	formatter.locale = Locale(identifier: "en_US_POSIX")
	formatter.timeZone = TimeZone(secondsFromGMT: 0)
	return formatter
}()
