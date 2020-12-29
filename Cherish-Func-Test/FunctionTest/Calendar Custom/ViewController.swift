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
    @IBOutlet weak var showCardBtn: UIButton!
    @IBOutlet weak var eventCollectionView: UICollectionView!{
        didSet{
            eventCollectionView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    
    let formatter = DateFormatter()
    var status: Bool? = true
    var expandSection = [Bool]()
    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = ["A","B","C","D","E","F","G","H","J","K"]
        self.expandSection = [Bool](repeating: false, count: self.items.count)
        
        //MARK:- Set Delegate & Datasource
        calendar.delegate = self
        calendar.dataSource = self
        eventCollectionView.delegate = self
        eventCollectionView.dataSource = self
        
        //MARK: -xib Register
        self.eventCollectionView.register(EventCVC.nib(), forCellWithReuseIdentifier: EventCVC.identifier)
        cal_Style()
    }
    
    @IBAction func showCard(_ sender: Any) {
        if status == true{
            status = false
            self.eventCollectionView.reloadData()
            
        }else{
            status = true
            self.eventCollectionView.reloadData()
        }
        showCardBtn.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
    }
    
    @objc func handleExpandClose(){
        
    }
    func cal_Style() {
        /// 캘린더 헤더 부분
        calendar.headerHeight = 50
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0 /// 헤더 좌,우측 흐릿한 글씨 삭제
        calendar.locale = Locale(identifier: "ko_KR") /// 한국어로 변경
        calendar.appearance.headerDateFormat = "YYYY년 M월" /// 디폴트는 M월 YYYY년
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24)
        calendar.layer.cornerRadius = 20
        
        /// 캘린터 텍스트 색
        calendar.backgroundColor = .white /// 배경색
        calendar.appearance.weekdayTextColor = UIColor.darkGray ///요일 색
        calendar.appearance.headerTitleColor = UIColor.black ///년도, 월 색
        calendar.appearance.eventDefaultColor = UIColor.red // 이벤트 색
        calendar.appearance.selectionColor = UIColor.lightGray // 선택 된 날의 색
        calendar.appearance.todayColor = UIColor.darkGray // 오늘 색
        calendar.appearance.todaySelectionColor = UIColor.black // 오늘 선택 색
    }
}

//MARK: -FSCalendar protocols
extension ViewController: FSCalendarDelegate, FSCalendarDataSource{
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool){
        calendarHeight.constant = bounds.height
        self.view.layoutIfNeeded ()
    }
}

//MARK: -CollecitonView protocols
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if status == true{
            return 1
        }else{
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCVC.identifier, for: indexPath) as? EventCVC else{
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 20
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.expandSection[indexPath.row] = !self.expandSection[indexPath.row]
        self.eventCollectionView.reloadItems(at: collectionView.indexPathsForSelectedItems!)
    }
    
    //MARK: - Cell 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if status == true {
            return CGSize(width: collectionView.frame.width, height: 150)
        }else{
            return CGSize(width: collectionView.frame.width, height: 150)
        }
    }
    
    //MARK: - Cell간의 상하간격 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(eventCollectionView.contentOffset.y)
        if eventCollectionView.contentOffset.y > 0 {
            self.calendar.setScope(.week, animated: true)
        }else{
            self.calendar.setScope(.month, animated: true)
        }
        
    }
}

//    //MARK: - 마진
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
//    {
//        return UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
//    }


//extension ViewController: FSCalendarDelegate, FSCalendarDataSource {
//    //이벤트 표시 개수
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        if self.events.contains(date) {
//            return 1
//        } else {
//            return 0
//        }
//    }
//
//    // 날짜 선택 시 콜백 메소드
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        print(formatter.string(from: date) + " 선택됨")
//    }
//    // 날짜 선택 해제 시 콜백 메소드
//    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        print(formatter.string(from: date) + " 해제됨")
//    }
//}


