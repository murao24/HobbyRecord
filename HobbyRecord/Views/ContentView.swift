//
//  ContentVIew.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/08.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var hobbyVM = HobbyViewModel()
    @ObservedObject var favoriteHobbyVM = FavoriteHobbyViewModel()
    @State var isActionSheet: Bool = false
    @State var isDetailView: Bool = false
    @State var date: Date = Date()

    private var cellWidth: CGFloat {

        calculateCellWidth()
    }

    var body: some View {

        NavigationView {

            ZStack(alignment: .bottom) {

                VStack(spacing: 0) {

                    CustomNavbar(isActionSheet: $isActionSheet, cellWidth: cellWidth)

                    RootView(hobbyVM: hobbyVM, selectedDate: $date, isDetailView: $isDetailView)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200)
                    
                    Spacer()
                }
                .ignoresSafeArea()

                GeometryReader{ reader in

                    ReaderView(favoriteHobbyVM: self.favoriteHobbyVM, reader: reader)
                        .edgesIgnoringSafeArea(.all)
                }

                VStack {

                    Spacer()

                    CustomActionSheet(isActionSheet: $isActionSheet)
                        .offset(y: self.isActionSheet ? 0 : UIScreen.main.bounds.height)
                }
                .background((isActionSheet ? Color.bl(3) : Color.clear)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {

                    self.isActionSheet.toggle()
                    }
                )
                    .edgesIgnoringSafeArea(.bottom)

                VStack {

                    if isDetailView {

                        Spacer()

                        DateView(date: date, hobbyVM: self.hobbyVM)
                            .offset(y: isDetailView ? 0 : UIScreen.main.bounds.height)

                        Spacer()
                    }
                }
                .padding(.top, 60)
                .padding(.bottom, 20)
                .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                .background((isDetailView ? Color.bl(3) : Color.clear)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {

                    self.isDetailView.toggle()
                })
                    .edgesIgnoringSafeArea(.all)

            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .animation(.spring())
        }
        .accentColor(Color.orange)
    }

    private func calculateCellWidth() -> CGFloat {
        let width = UIScreen.main.bounds.width
        return width / 7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct CustomNavbar: View {

    @Binding var isActionSheet: Bool
    var height: CGFloat = { () -> CGFloat in

        var height: CGFloat = 0

        if UIDevice().userInterfaceIdiom == .phone {
            // Simulator iPhone 8
            switch UIScreen.main.nativeBounds.height {
            case 1334, 1920, 2208, 1024, 2048, 2224, 2160, 2388, 2732:

                height = 80
            case 2436, 1792, 2688:

                height = 110
            default:
                height = 110
            }
        }
        return height
    }()

    private let dayOfTheWeek: [String] = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    var cellWidth: CGFloat

    var body: some View {

        VStack(alignment: .trailing) {

            Spacer()

            Button(action: {

                self.isActionSheet.toggle()
            }) {

                Image(systemName: "gear")
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 18)
                    .foregroundColor(.orange)
            }

            HStack(spacing: 0) {

                ForEach(dayOfTheWeek, id: \.self) { row in

                    Text(row.uppercased().localized)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(self.dayOfTheWeekColor(row: row))
                        .frame(width: self.cellWidth, height: 20)
                }
            }
            .padding(.bottom, 10)
        }
        .frame(width: UIScreen.main.bounds.width, height: height)
        .background(Color(UIColor.systemGray6).opacity(0.9))
    }

    private func dayOfTheWeekColor(row: String) -> Color {
        switch row {
        case "sun":
            return Color.red
        case "sat":
            return Color.blue
        default:
            return Color.pr(9)
        }
    }
}
