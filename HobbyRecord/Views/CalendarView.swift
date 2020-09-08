//
//  ContentView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/08/28.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct CalendarView: View {

    @Binding var x: CGFloat
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var hobbyVM = HobbyViewModel()
    @State private var isAddHobbyView: Bool = false
    @State private var isDetailView: Bool = false

    // カレンダーの範囲
    var clManager = CLManager(
        calendar: Calendar.current,
        minmumDate: Date(),
        maximumDate: Date().addingTimeInterval(60*60*24*365*2))

    private var cellWidth: CGFloat {
        calculateCellWidth()
    }

    //今日を初期画面に表示するのは、scrollViewReader待ち
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 0) {
                    CustomNavbar(x: $x, isDetailView: self.$isDetailView, clManager: self.clManager, cellWidth: cellWidth)
                    CLViewController(clManager: self.clManager, hobbyVM: self.hobbyVM, isDetailView: self.$isDetailView)
                }
//                AddButton()
            }
            if isDetailView {
                DetailView(clManager: self.clManager, hobbyVM: self.hobbyVM)
                    .padding(.bottom, 30)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        .edgesIgnoringSafeArea(.top)
        .accentColor(Color.orange)
    }

    private func calculateCellWidth() -> CGFloat {
        let width = UIScreen.main.bounds.width
        return width / 7
    }

    private func AddButton() -> some View {
        Button(action: {
            self.isAddHobbyView.toggle()
        }) {
            Image(systemName: "plus")
                .font(.headline)
                .foregroundColor(Color.black)
                .frame(width: 60, height: 60)
                .background(Color.orange)
                .clipShape(Circle())
        }
        .padding(.bottom, 30)
        .padding(.trailing, 20)
        .sheet(isPresented: $isAddHobbyView) { AddHobbyView() }
    }

}

struct CustomNavbar: View {

    @Binding var x: CGFloat
    @Binding var isDetailView: Bool
    var clManager: CLManager
    private let dayOfTheWeek: [String] = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    var cellWidth: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()

            Button(action: {
                withAnimation {
                    self.x = 0
                }
            }) {

                Image("open-menu")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .padding(.leading, 18)

            HStack(spacing: 0) {
                ForEach(dayOfTheWeek, id: \.self) { row in
                    Text(row.uppercased())
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(self.dayOfTheWeekColor(row: row))
                        .frame(width: self.cellWidth, height: 20)
                }
            }
            .padding(.bottom, 10)
        }
        .frame(width: UIScreen.main.bounds.width, height: 110)
        .background(Color(UIColor.systemGray6).opacity(0.9))
        .onTapGesture {
            withAnimation {
                self.clManager.selectedDate = nil
                self.isDetailView = false
            }
        }
    }

    private func dayOfTheWeekColor(row: String) -> Color {
        switch row {
        case "sun":
            return Color.red
        case "sat":
            return Color.blue
        default:
            return Color.primary.opacity(0.9)
        }
    }
}

