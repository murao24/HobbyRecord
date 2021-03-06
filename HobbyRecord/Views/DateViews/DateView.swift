//
//  DetailView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/04.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct DateView: View {

    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var dateVM: DateViewModel
    @ObservedObject var hobbyVM: HobbyViewModel
    var date: Date

    init(date: Date, hobbyVM: HobbyViewModel) {
        self.date = date
        self.hobbyVM = hobbyVM
        self.dateVM = DateViewModel(date: date, hobbyVM: hobbyVM)
    }

    var body: some View {

        VStack(alignment: .center) {

            HStack(alignment: .center, spacing: 40) {

                ChangeDateButton(dateVM: dateVM, text: "chevron.compact.left")

                Text(D.getTextFromDate(date: self.dateVM.date))
                    .font(.system(size: 30))
                    .foregroundColor(Color.pr(9))

                ChangeDateButton(dateVM: dateVM, text: "chevron.compact.right")

            }
            .padding(.top, 10)

            List {

                if self.dateVM.hobbies.count != 0 {

                    ForEach(self.dateVM.hobbies, id: \.self) { hobby in

                        HStack {

                            HobbyCell(hobby: hobby)

                            NavigationLink(destination: DateDetailView(dateVM: self.dateVM, hobby: hobby, hobbyVM: self.hobbyVM)) {

                                EmptyView()
                            }
                        }
                    }
                    .onDelete(perform: rowRemove)
                } else {

                    Text("No Hobby Records".localized)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height - 170)
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(25)
    }

    private func rowRemove(offsets: IndexSet) {

        let hobby = self.dateVM.hobbies[offsets.first!]

        self.hobbyVM.removeRecord(hobby: hobby)
    }
}

struct HobbyCell: View {
    
    var hobby: Hobby
    
    var body: some View {

        VStack(alignment: .leading) {

            HStack(spacing: 10) {

                if hobby.icon != "" {

                    Image(hobby.icon)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.pr(9))
                } else {

                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.pr(9))
                }

                Text(hobby.title)
                    .font(.headline)
                    .foregroundColor(Color.pr(9))
                
                Spacer()
            }
            .padding(.bottom, 10)

            ForEach(hobby.details, id: \.self) { detail in

                if detail.count != 0 {

                    Text("・" + detail)
                        .font(.subheadline)
                        .foregroundColor(Color.pr(9))
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.75)
    }
}


struct ChangeDateButton: View {

    @ObservedObject var dateVM: DateViewModel
    var text: String
    private var timeInterval: TimeInterval {

        judgeTomorrowOrYesterday(text: text)
    }

    var body: some View {

        Button(action: {

            self.switchFunction()
        }) {
            Image(systemName: text)
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(Color.primary.opacity(0.5))
                .padding()
        }
    }

    private func switchFunction() {


        self.dateVM.date = self.dateVM.date.addingTimeInterval(timeInterval)
        self.dateVM.filterHobby()
    }

    private func judgeTomorrowOrYesterday(text: String) -> TimeInterval {

        if text == "chevron.compact.left" {
            return TimeInterval(-86400)
        } else {
            return TimeInterval(86400)
        }
    }

}
