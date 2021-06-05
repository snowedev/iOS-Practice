//
//  main.swift
//  testWebtoon
//
//  Created by Wonseok Lee on 2021/06/04.
//
import Foundation
/*
 문제1.
let arr1 = [“조석1”, “조석2”, “조석3”]
let arr2 = [“조석1”, “조석4”, “조석5”]
arr1은 그대로 노출, arr2는 arr1과 동일한 string값을 제거하여 아래와 같이 노출하세요.

조석1, 조석2, 조석3 / 조석4, 조석5
*/
var arr1 = ["조석1", "조석2", "조석3"]
var arr2 = ["조석1", "조석4", "조석5"]

let new_arr1: [String] = arr1.map{
    if $0 != arr1.last {
        return $0+","
    }
    return $0
}

let new_arr2: [String] = arr2.filter{!arr1.contains($0)}.map{
    if $0 != arr2.last {
        return $0+","
    }
    return $0
}


print("\(new_arr1.reduce(""){$0+$1})"+" / "+"\(new_arr2.reduce(""){$0+$1})")


/*
 문제2.
오름차순이지만 연속적이지는 않은 [Int] 배열이 하나 있습니다. 이 배열의 크기는 1,000,000이상입니다.
그렇기 때문에 성능을 고려하여야 하는데, 어떤 int값이 주어지면 해당 int값이 배열 안에서 몇번째 index에 포함되어있는지 출력하는 알고리즘을 짜보세요.
만약 값이 없다면 -1을 출력하면 됩니다.
*/

//func findIdx(_ arr: [Int], _ num: Int) -> Int {
//    var test = arr
//
//    if (arr.count/2)  == 0 && test[arr.count/2] != num {
//        return -1
//    } else if test[arr.count/2] == num {
//        return (arr.count/2)
//    }
//    
//    // 중간값이 요청한 숫자보다 클 경우
//    if test[(arr.count)/2] > num {
//        test = Array(test[0..<(arr.count/2)])
//        findIdx(test, num)
//    } else {
//        // 중간값이 요청한 숫자보다 작을 경우
//        test = Array(test[(arr.count/2)...])
//        findIdx(test, num)
//    }
////     자기 자리를 찾았으면 return
////     끝까지 못찾았으면 -1
//}
