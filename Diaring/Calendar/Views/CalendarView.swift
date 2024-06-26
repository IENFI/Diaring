//
//  CalendarView.swift
//  Diaring
//
//  Created by 하민영 on 5/16/24.
//

import SwiftUI

struct CalendarView: View {
    @State private var month: Date = Date()
    @StateObject var planModel = PlanViewModel()
    @State private var clickedCurrentMonthDates: Date?
    @StateObject var darkModeSettings = DarkModeSettingsViewModel()
    @State private var showingAddPlanView = false
    
    init(
        month: Date = Date(), // 현재 날짜로 초기화
        clickedCurrentMonthDates: Date? = nil // 옵셔널 값을 nil로 초기화
    ) {
        _month = State(initialValue: month)
        _clickedCurrentMonthDates = State(initialValue: clickedCurrentMonthDates)
    }
    
    var body: some View {
        VStack {
//            Spacer().frame(height: 30)
            headerView
            calendarGridView
//            Spacer()
            PlanListView(date: planModel.isClickedDate)
                .environmentObject(planModel)
//                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        }
        .listStyle(.plain)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Calendar")
        
        //        .navigationBarTitle("Calendar", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationLink {
                    AddPlan(date: planModel.isClickedDate)
                        .environmentObject(planModel)
                } label : {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(darkModeSettings.isDarkModeOn ? .white : .black)
                }
            }
        }
    }
    
    // MARK: - 헤더 뷰
    private var headerView: some View {
        VStack {
            HStack {
                yearMonthView
                
                Spacer()
                
//                Button(
//                    action: { },
//                    label: {
//                        Image(systemName: "list.bullet")
//                            .font(.title)
//                            .foregroundColor(.black)
//                    }
//                )
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 5)
            
            HStack {
                ForEach(Self.weekdaySymbols.indices, id: \.self) { symbol in
                    Text(Self.weekdaySymbols[symbol].uppercased())
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 5)
        }
    }
    
    // MARK: - 연월 표시
    private var yearMonthView: some View {
        HStack(alignment: .center, spacing: 20) {
            Button(
                action: {
                    changeMonth(by: -1)
                },
                label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(canMoveToPreviousMonth() ? darkModeSettings.isDarkModeOn ? Color.white : Color.black : . gray)
                }
            )
            .disabled(!canMoveToPreviousMonth())
            
            Text(month, formatter: Self.calendarHeaderDateFormatter)
                .font(.title.bold())
            
            Button(
                action: {
                    changeMonth(by: 1)
                },
                label: {
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .foregroundColor(canMoveToNextMonth() ? darkModeSettings.isDarkModeOn ? Color.white : Color.black : .gray)
                }
            )
            .disabled(!canMoveToNextMonth())
        }
    }
    
    // MARK: - 날짜 그리드 뷰
    private var calendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
        let lastDayOfMonthBefore = numberOfDays(in: previousMonth())
        let numberOfRows = Int(ceil(Double(daysInMonth + firstWeekday) / 7.0))
        // 현재 달력의 필요한 행의 수
        let visibleDaysOfNextMonth = numberOfRows * 7 - (daysInMonth + firstWeekday)
        
        return LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            ForEach(-firstWeekday ..< daysInMonth + visibleDaysOfNextMonth, id: \.self) { index in
                Group {
                    if index > -1 && index < daysInMonth {
                        let date = getDate(for: index)
                        let day = Calendar.current.component(.day, from: date)
                        let clicked = clickedCurrentMonthDates == date
                        let isToday = date.formattedCalendarDayDate == today.formattedCalendarDayDate
                        let hasDate = planModel.hasPlans(for: date)
                        
                        CellView(day: day, clicked: clicked, isToday: isToday, hasDate: hasDate)
                    } else if let prevMonthDate = Calendar.current.date(
                        byAdding: .day,
                        value: index + lastDayOfMonthBefore,
                        to: previousMonth()
                    ) {
                        let day = Calendar.current.component(.day, from: prevMonthDate)
                        
                        CellView(day: day, isCurrentMonthDay: false)
                    }
                }
                .onTapGesture {
                    if 0 <= index && index < daysInMonth {
                        let date = getDate(for: index)
                        clickedCurrentMonthDates = date
                        planModel.Click(by: date)
                    }
                }
            }
        }
    }
}

// MARK: - 일자 셀 뷰
private struct CellView: View {
    private var day: Int
    private var clicked: Bool
    private var isToday: Bool
    private var isCurrentMonthDay: Bool
    private var hasDate: Bool
    @StateObject var darkModeSettings = DarkModeSettingsViewModel()
    
    private var textColor: Color {
        if clicked {
            return darkModeSettings.isDarkModeOn ? Color.black : Color.white
        } else if isCurrentMonthDay {
            return darkModeSettings.isDarkModeOn ? Color.white : Color.black
        } else {
            return Color.gray
        }
    }
    private var backgroundColor: Color {
        if clicked {
            return darkModeSettings.isDarkModeOn ? Color.white : Color.black
        } else if isToday {
            return Color.gray
        } else {
            return darkModeSettings.isDarkModeOn ? Color.black : Color.white
        }
    }
    
    fileprivate init(
        day: Int,
        clicked: Bool = false,
        isToday: Bool = false,
        isCurrentMonthDay: Bool = true,
        hasDate: Bool = false
    ) {
        self.day = day
        self.clicked = clicked
        self.isToday = isToday
        self.isCurrentMonthDay = isCurrentMonthDay
        self.hasDate = hasDate
    }
    
    fileprivate var body: some View {
        VStack {
            Circle()
                .fill(backgroundColor)
                .overlay(Text(String(day)))
                .foregroundColor(textColor)
            
            Spacer()
            
            if hasDate {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.yellow)
                    .frame(width: 10, height: 10)
            } else {
                Spacer()
                    .frame(height: 10)
            }
        }
        .frame(height: 45)
    }
}

private extension CalendarView {
    var today: Date {
        let now = Date()
        let components = Calendar.current.dateComponents([.year, .month, .day], from: now)
        return Calendar.current.date(from: components)!
    }
    
    static let calendarHeaderDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.MM"
        return formatter
    }()
    
    static let weekdaySymbols: [String] = Calendar.current.shortWeekdaySymbols
}

private extension CalendarView {
    /// 특정 해당 날짜
    func getDate(for index: Int) -> Date {
        let calendar = Calendar.current
        guard let firstDayOfMonth = calendar.date(
            from: DateComponents(
                year: calendar.component(.year, from: month),
                month: calendar.component(.month, from: month),
                day: 1
            )
        ) else {
            return Date()
        }
        
        var dateComponents = DateComponents()
        dateComponents.day = index
        
        let timeZone = TimeZone.current
        let offset = Double(timeZone.secondsFromGMT(for: firstDayOfMonth))
        dateComponents.second = Int(offset)
        
        let date = calendar.date(byAdding: dateComponents, to: firstDayOfMonth) ?? Date()
        return date
    }
    
    /// 해당 월에 존재하는 일자 수
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
        /*
         Calendar.current.range(of: .day, in: .month, for: date)를 호출하여 주어진 날짜가 속한 월의 일 수를 가져옵니다. 이것은 Range<Int>? 형식의 옵셔널 값을 반환합니다. Range<Int>는 해당 월의 첫 번째 날과 마지막 날의 일 수를 나타냅니다.
         만약 해당 월에 날짜가 없거나, 오류가 발생한다면 옵셔널 값은 nil이 됩니다.
         ?? 0는 nil 병합 연산자를 사용하여, 옵셔널 값이 nil일 경우를 대비하여 기본값으로 0을 반환합니다.
         */
    }
    
    /// 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
        // 주어진 날짜가 속한 월의 첫 번째 요일(요일의 숫자 형태로, 예를 들어 일요일은 1, 월요일은 2 등)을 반환
    }
    
    /// 이전 월 마지막 일자
    func previousMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
        
        return previousMonth
    }
    
    /// 월 변경
    func changeMonth(by value: Int) {
        self.month = adjustedMonth(by: value)
    }
    
    /// 이전 월로 이동 가능한지 확인
    func canMoveToPreviousMonth() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let targetDate = calendar.date(byAdding: .month, value: -6, to: currentDate) ?? currentDate
        
        if adjustedMonth(by: -1) < targetDate {
            return false
        }
        return true
    }
    
    /// 다음 월로 이동 가능한지 확인
    func canMoveToNextMonth() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let targetDate = calendar.date(byAdding: .month, value: 6, to: currentDate) ?? currentDate
        
        if adjustedMonth(by: 1) > targetDate {
            return false
        }
        return true
    }
    
    /// 변경하려는 월 반환
    func adjustedMonth(by value: Int) -> Date {
        if let newMonth = Calendar.current.date(byAdding: .month, value: value, to: month) {
            return newMonth
        }
        return month
    }
}

extension Date {
    static let calendarDayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy dd"
        return formatter
    }()
    
    var formattedCalendarDayDate: String {
        return Date.calendarDayDateFormatter.string(from: self)
    }
}

#Preview {
    NavigationView {
        CalendarView()
    }
}
