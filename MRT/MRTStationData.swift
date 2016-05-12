//
//  MRTStationData.swift
//  MRT
//
//  Created by Niki25672729 on 5/10/16.
//  Copyright © 2016 Niki. All rights reserved.
//

import Foundation
import ObjectMapper

struct MRTLine {
    var name: String?
    var stations: [Station]!
}

class Station: Mappable {
    var name: String?
    var lines: [String : String]?
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        name  <- map["name"]
        lines <- map["lines"]
    }
}

enum MRTStationsSourceErrorType: ErrorType {
    case FileNotFound
    case InvalidContent
}

struct MRTStationSource {
    let lines: [MRTLine]!
    
    init(contentsOfFile path: String) throws {
        guard let rawData = NSArray(contentsOfFile: path) as? [NSDictionary] else {
            throw MRTStationsSourceErrorType.FileNotFound
        }
        
        //LineName : [Station1, Station2, ...]
        var lineStationMap = [String : [Station]]()
        for stationDict in rawData {
            guard let station = Mapper<Station>().map(stationDict) else {
                throw MRTStationsSourceErrorType.InvalidContent
            }
            
            for lineName in station.lines!.keys {
                if lineStationMap[lineName] == nil {
                    lineStationMap[lineName] = []
                }
                lineStationMap[lineName]!.append(station)
            }
            
        }
        
        var _lines = [MRTLine]()
        for (lineName, stationsList) in lineStationMap {
            let line = MRTLine(name: lineName, stations: stationsList)
            _lines.append(line)
        }
        self.lines = _lines.sort { (lineA: MRTLine, lineB: MRTLine) -> Bool in
            return lineA.name < lineB.name
        }

    }
}