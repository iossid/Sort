//
//  Sort.swift
//  Sort
//
//  Created by Sid on 5/7/16.
//  Copyright © 2016 Sid. All rights reserved.
//

import Foundation

func generateTestInts(count: Int) -> [Int] {
    var nums = Array<Int>()
    for _ in 0...count-1 {
        nums.append(Int(arc4random_uniform(100)))
    }
    return nums
}

func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func bubbleSort(nums: [Int]) -> [Int] {
    let startDate = NSDate()
    
    var nums = nums
    for _ in 0 ..< nums.count - 1 {
        for j in (nums.count - 1).stride(to: 0, by: -1) {
            if nums[j] < nums[j-1] {
                swapTwoInts(&nums[j], &nums[j-1])
            }
        }
    }
    
    let endDate = NSDate()
    print(#function + ": " + String(format: "%.6f", endDate.timeIntervalSinceDate(startDate)))
    
    return nums
}

func selectionSort(nums: [Int]) -> [Int] {
    let startDate = NSDate()
    
    var nums = nums
    for i in 0 ..< nums.count - 1 {
        var currentMin: Int = nums[i]
        var currentMinIndex: Int = i
        for j in i + 1 ..< nums.count {
            if nums[j] < currentMin {
                currentMin = nums[j]
                currentMinIndex = j
            }
        }
        swapTwoInts(&nums[i], &nums[currentMinIndex])
    }
    
    let endDate = NSDate()
    print(#function + ": " + String(format: "%.6f", endDate.timeIntervalSinceDate(startDate)))
    
    return nums
}

func insertionSort(nums: [Int]) -> [Int] {
    let startDate = NSDate()
    
    var nums = nums
    for i in 1 ..< nums.count {
        let temporaryNumI = nums[i]
        var j: Int = i-1
        while (j >= 0 && nums[j] > temporaryNumI) {
            nums[j+1] = nums[j]
            j -= 1
        }
        if j < i-1 {
            nums[j+1] = temporaryNumI
        }
    }
    
    let endDate = NSDate()
    print(#function + ": " + String(format: "%.6f", endDate.timeIntervalSinceDate(startDate)))
    
    return nums
}

func mergeSort(nums: [Int]) -> [Int] {
    let startDate = NSDate()
    
    var nums = nums
    mergeSplit(&nums, start: 0, end: nums.count)
    
    let endDate = NSDate()
    print(#function + ": " + String(format: "%.6f", endDate.timeIntervalSinceDate(startDate)))
    
    return nums
}

func mergeSplit(inout nums: [Int], start: Int, end: Int) {
    let length = end - start
    if length < 2 {
        return
    }
    let middle: Int = start + length / 2
    mergeSplit(&nums, start: start, end: middle)
    mergeSplit(&nums, start: middle, end: end)
    let result = mergeNums(&nums, start: start, middle: middle, end: end)
    copyInts(result, to: &nums, start: start, end: end)
}

func mergeNums(inout nums: [Int], start: Int,middle: Int, end: Int) -> [Int] {
    let length = end - start
    var result = Array<Int>(count: length, repeatedValue: 0)
    var i = start
    var j = middle
    for k in 0 ..< length {
        if i < middle && (j >= end || nums[i] <= nums[j]) {
            result[k] = nums[i]
            i += 1
        } else {
            result[k] = nums[j]
            j += 1
        }
    }
    return result
}

func copyInts(from: [Int], inout to:[Int], start: Int, end: Int) {
    for i in 0 ..< end - start {
        to[start+i] = from[i]
    }
}

func quickSort(nums: [Int]) -> [Int] {
    let startDate = NSDate()
    
    var nums = nums
    quickSortRecursive(&nums, low: 0, high: nums.count-1)
    
    let endDate = NSDate()
    print(#function + ": " + String(format: "%.6f", endDate.timeIntervalSinceDate(startDate)))
    
    return nums
}

func quickSortRecursive(inout nums: [Int], low: Int, high: Int) {
    if high <= low {
        return
    }
    let p = quickSortPartition(&nums, low: low, high: high)
    quickSortRecursive(&nums, low: low, high: p-1)
    quickSortRecursive(&nums, low: p+1, high: high)
}

func quickSortPartition(inout nums: [Int], low: Int, high: Int) -> Int {
    var p = low
    let pivot = nums[high]
    for i in low ..< high {
        if nums[i] <= pivot {
            if i != p {
                swapTwoInts(&nums[i], &nums[p])
            }
            p += 1
        }
    }
    if p != high {
        swapTwoInts(&nums[p], &nums[high])
    }
    return p
}