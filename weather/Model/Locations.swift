//
//  Locations.swift
//  weather
//Program bol vytvoreny v rámci kurzu na portali skillmea.sk
//  Created by crow on 20/03/2023.
//

import Foundation

struct Locations: Identifiable {
    var id = UUID()
    var name: String
    var latitude: Double
    var longtitude: Double
}
