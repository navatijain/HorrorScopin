//
//  Horoscope.swift
//  HorrorScopin
//
//  Created by Navati Jain on 2021-12-03.
//

import Foundation

struct Horoscope: Codable {
    var dateRange: String?
    var currentDate: String?
    var description: String?
    var compatibility: String?
    var mood: String?
    var luckyNumber: String?
    var luckyTime: String?
}
