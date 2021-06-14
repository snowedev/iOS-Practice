//
//  PublicFunc.swift
//  CommonlyUsedStorage
//
//  Created by Wonseok Lee on 2021/06/14.
//

import Foundation

/*
 게시글이나 공지같은거 작성할때 서버 시간과 현재 시간을 비교해서
 10분전 , 1시간전 등 작성된 시간을 계산해주는 함수
 60초전이면 방금전
 60분전이면 00분전
 24시간 전이면 몇시간 전을 표기하는 함수입니다.
*/
public func slicingDate(date : String) -> String
{
    var message : String = "" // 최종 결과값 담기위한 변수
    
    let UTCDate = Date()
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(secondsFromGMT: 32400)
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

    let defaultTimeZoneStr = formatter.string(from: UTCDate)
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd HH:mm:ss"
    format.locale = Locale(identifier: "ko_KR")
    // 한국 시각기준으로 측정합니다.
    
//    let currentDate = Date()
    
    guard let tempDate = format.date(from: date) else {return ""}
    let krTime = format.date(from: defaultTimeZoneStr)
    
    let articleDate = format.string(from: tempDate)
    let useTime = Int(krTime!.timeIntervalSince(tempDate))
    
    if useTime < 60
    {
        message = "방금 전"
    }
    else if useTime < 3600
    {
        message = String(useTime/60) + "분 전"
    }
    else if useTime < 86400
    {
        message = String(useTime/3600) + "시간 전"
    }
    else
    {
        let timeArray = articleDate.components(separatedBy: " ")
        let dateArray = timeArray[0].components(separatedBy: "-")
   
        message = dateArray[1] + "월 " + dateArray[2] + "일"
    }
    return message
}
