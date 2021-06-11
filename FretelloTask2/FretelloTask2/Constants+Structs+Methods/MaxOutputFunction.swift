//
//  MaxOutputFunction.swift
//  FretelloTask2
//
//  Created by Decagon on 09/06/2021.
//

import Foundation
import UIKit

public func maxAverageBPM (exercisesArr: [[Int]]) -> Int {
    var arrayOfAverages = [Double]()
    var avgNums: Double = 0.0
    var arrayOfHighestNums = [Double]()
    var percentageAvg = [Int]()
    var highestNum: Double = 0.0
    var percentage: Double = 0.0
    
    for i in 0..<exercisesArr.count {
        for _ in 0..<exercisesArr[i].count {
            var sum = 0.0
            for val in exercisesArr[i] {
                sum += Double(val)
            }
            avgNums = sum / Double((exercisesArr[i].count))
        }
        arrayOfAverages.append(avgNums)
    }
    
    for i in 1..<exercisesArr.count {
        for _ in 1..<exercisesArr[i].count {
            highestNum = Double(exercisesArr[i].max() ?? 0)
        }
        arrayOfHighestNums.append(highestNum)
    }
    for i in 0..<arrayOfHighestNums.count {
        percentage = (arrayOfHighestNums[i] * 100) / arrayOfAverages[i]
        percentageAvg.append(Int(percentage))
    }
    let result = percentageAvg.max() ?? 0
    return result
}

