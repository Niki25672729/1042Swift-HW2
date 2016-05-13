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
        let jsonContent = try! String(contentsOfFile: path)
        
        guard let rawData = Mapper<Station>().mapArray(jsonContent) else {
            throw MRTStationsSourceErrorType.InvalidContent
        }
        
        //LineName : [Station1, Station2, ...]
        var lineStationMap = [String : [Station]]()
        for stationDict in rawData {
            for lineName in stationDict.lines!.keys {
                if lineStationMap[lineName] == nil {
                    lineStationMap[lineName] = []
                }
                lineStationMap[lineName]!.append(stationDict)
            }
            
        }
        
        var _lines = [MRTLine]()
        for (lineName, stationslist) in lineStationMap {
            let stationsList = stationslist.sort({ (StationA: Station, StationB: Station) -> Bool in
                return StationA.lines![lineName] < StationB.lines![lineName]
            })
            let line = MRTLine(name: lineName, stations: stationsList)
            _lines.append(line)
        }
        self.lines = _lines.sort { (lineA: MRTLine, lineB: MRTLine) -> Bool in
            return lineA.name < lineB.name
        }
    }
}