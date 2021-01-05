//
//  ViewController.swift
//  FunctionTest
//
//  Created by 이원석 on 2020/12/28.
//

import UIKit
import FSCalendar

class ViewController: UIViewController {
    
    //MARK: -IBOutlet
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    @IBOutlet weak var calendarView: UIView!{
        didSet{
            calendarView.layer.cornerRadius = 20.0
        }
    }
    
    let formatter = DateFormatter()
    var status: Bool? = true
    var expandSection = [Bool]()
    var items = [String]()
    var events = [Date]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.expandSection = [Bool](repeating: false, count: self.items.count)
        //MARK:- Set Delegate & Datasource
        calendar.delegate = self
        calendar.dataSource = self
        cal_Style()
    }
    
    //    @IBAction func showCard(_ sender: Any) {
    //        if status == true{
    //            status = false
    //            self.calendar.setScope(.week, animated: true)
    //            self.eventCollectionView.reloadData()
    //
    //        }else{
    //            status = true
    //            self.calendar.setScope(.month, animated: true)
    //            self.eventCollectionView.reloadData()
    //        }
    //    }
    var dateComponents = DateComponents()
    let calendarCurrent = Calendar.current
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()


    @IBAction func moveToNext(_ sender: Any) {
        self.moveCurrentPage(moveUp: true)
    }
    @IBAction func moveToPrev(_ sender: Any) {
        self.moveCurrentPage(moveUp: false)
    }
    
    
    private func moveCurrentPage(moveUp: Bool) {
        dateComponents.month = moveUp ? 1 : -1
        self.currentPage = calendarCurrent.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
    }
    
    
    func cal_Style() {
        /// 캘린더 헤더 부분
        calendar.headerHeight = 50
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0 /// 헤더 좌,우측 흐릿한 글씨 삭제
        calendar.locale = Locale(identifier: "ko_KR") /// 한국어로 변경
        calendar.appearance.headerDateFormat = "YYYY년 M월" /// 디폴트는 M월 YYYY년
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24)
        //        calendar.layer.cornerRadius = 20
        
        /// 캘린터 텍스트 색
        calendar.backgroundColor = .white /// 배경색
        calendar.appearance.weekdayTextColor = UIColor.darkGray ///요일 색
        calendar.appearance.headerTitleColor = UIColor.black ///년도, 월 색
        calendar.appearance.eventDefaultColor = .customgreen // 이벤트 색
        calendar.appearance.eventSelectionColor = .customred // 이벤트 색
        calendar.appearance.selectionColor = UIColor.lightGray // 선택 된 날의 색
        
        
        calendar.appearance.todayColor = .darkGray // 오늘 색
        calendar.appearance.todaySelectionColor = .none // 오늘 선택 색
        
        
        // Month 폰트 설정
        calendar.appearance.headerTitleFont = UIFont(name: "System", size: 16)
        
        // day 폰트 설정
        calendar.appearance.titleFont = UIFont(name: "System", size: 14)
        //
        //        // 캘린더에 이번달 날짜만 표시하기 위함
        //        mainCalendar.placeholderType = .none
        
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        let SHB = formatter.date(from: "2021-01-06")
        let love = formatter.date(from: "2021-01-26")
        events = [SHB!, love!]
    }
}

//MARK: -FSCalendar protocols
extension ViewController: FSCalendarDelegate, FSCalendarDataSource{
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool){
        calendarHeight.constant = bounds.height
        self.view.layoutIfNeeded ()
    }
    //이벤트 표시 개수
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.events.contains(date) {
            return 1
        } else {
            return 0
        }
    }
    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(formatter.string(from: date) + " 선택됨")
    }
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(formatter.string(from: date) + " 해제됨")
    }
    
}


