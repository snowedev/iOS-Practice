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
그렇기 때문에 성능을 고려하여야 하는데, 어떤 int값이 주어지면 해당 int값이 배열 안에서 몇번째 index에 포함되어있는지 출력하는 함수를 작성해보세요.
만약 값이 없다면 -1을 출력하면 됩니다.
*/

func findIdx(_ arr: [Int], _ target: Int) {
    var start = 0
    var end = arr.count - 1
    
    while start <= end {
        let mid = (start+end)/2
        if arr[mid] == target {
            print(mid)
            break
        } else if arr[mid] <= target {
            start = mid + 1
        } else {
            end = mid - 1
        }
    }
}

findIdx([1,3,5,6,10,15,16,19,20,22], 19)

/*
 이분탐색법
 
 [1, 2, 3, 4, 5, 6]에서 4의 위치를 찾고자 한다면, 배열의 중간에 위치한 3이라는 값과 4를 비교한다.
 4는 3보다 크다. 따라서 3의 왼쪽에 위치하는 값들은 탐색할 이유가 없어진다. 3의 오른쪽에 있는 값들을 대상으로 탐색을 다시 시도한다.
 이제 [4, 5, 6] 중에 다시 중간값인 5와 타겟 넘버 4를 비교한다. 4는 5보다 작다. 따라서 5의 오른쪽에 있는 값들은 필요가 없다.
 이제 4만이 남게 되고 4와 4를 비교하면 값이 일치한다. 해당 인덱스를 반환한다.
 */

