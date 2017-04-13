//
//  SGH0808FlightData.swift
//  SwiftDemo160801
//
//  Created by huangaengoln on 16/8/8.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

import Foundation


struct SGH0808FlightData {
    let summary: String
    let flightNr: String
    let gateNr: String
    let departingFrom: String
    let arrivingTo: String
    let weatherImageName: String
    let showWeatherEffects: Bool
    let isTakingOff: Bool
    let flightStatus: String
}
let londonToParis = SGH0808FlightData(
    summary: "01 Apr 2015 09:42",
    flightNr: "ZY 2014",
    gateNr: "T1 A33",
    departingFrom: "LGW",
    arrivingTo: "CDG",
    weatherImageName: "bg-snowy",
    showWeatherEffects: true,
    isTakingOff: true,
    flightStatus: "Boarding")

let parisToRome = SGH0808FlightData(
    summary: "01 Apr 2015 17:05",
    flightNr: "AE 1107",
    gateNr: "045",
    departingFrom: "CDG",
    arrivingTo: "FCO",
    weatherImageName: "bg-sunny",
    showWeatherEffects: false,
    isTakingOff: false,
    flightStatus: "Delayed")












