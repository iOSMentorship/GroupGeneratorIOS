//
//  GroupGenerator.swift
//  GroupGenerator
//
//  Created by Kayode Oguntimehin on 12/03/2017.
//  Copyright © 2017 Kayode Oguntimehin. All rights reserved.
//

import UIKit

class PairModel {
    
    let pair: String
    
    init(pair: String) {
        self.pair = pair
    }
    
    public func ToString()-> String {
        return self.pair
    }
    
}

class GroupGenerator {
    
    public func GroupPeople(namesToGroup: [String], noPerGroup: Int) -> [PairModel] {
        var myResult = [PairModel]()
        var namesPassed: [String]  = namesToGroup
       
        let initialLength: Double = Double(namesToGroup.count);
        var entriesLength = namesToGroup.count
        
        let ceilVal = Int( ceil(initialLength/Double(noPerGroup)))
        
        for _ in 0..<ceilVal {
            
            if(entriesLength >= noPerGroup) {
                print("nopergrp"+String(noPerGroup))
                var pairings: String = ""
                for value in 0..<noPerGroup {
                    let randomNum:Int = Int(arc4random_uniform(UInt32(namesPassed.count)))
                    let val: String = namesPassed[randomNum]
                    namesPassed.remove(at: randomNum)
                    print(namesPassed)
                    if(value == 0) {
                        pairings += val
                    } else {
                        pairings += "," + val
                    }
                }
                myResult.append(PairModel(pair: pairings))
                entriesLength = entriesLength - noPerGroup
            } else if( entriesLength > 0) {
                var pairings: String = ""
                for value in 0..<entriesLength {
                    let val: String = namesPassed[value]
                    namesPassed.remove(at: value)
                    print(namesPassed)
                    if(value == 0) {
                        pairings = val
                    } else {
                        pairings = "," + val
                    }
                }
                myResult.append(PairModel(pair: pairings))
            }
        }
        
        return myResult
        
    }

}
