//
//  BottomSheet.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/10.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct BottomSheet: View {

    @State private var isAddHobbyView: Bool = false
    @State private var isRecordHobbyView: Bool = false
    @State var date: Date = Date()

    private var favoriteHobbies: [Hobby] = [
        Hobby(date: "", title: "ハイキング", details: [""], icon: "hiking"),
        Hobby(date: "", title: "ピアノ", details: [""], icon: "piano"),
        Hobby(date: "", title: "トランプ", details: [""], icon: "tramp"),
        Hobby(date: "", title: "スマブラ", details: [""], icon: "game")
    ]

    var body: some View {

        VStack {

            VStack {

                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 50, height: 5)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .cornerRadius(15)
                    .padding()

                Text("Favorites")
                    .font(.title)
                    .foregroundColor(Color.primary.opacity(0.9))
                    .padding(.top, 20)

                // お気に入りのHobbyを追加するやつ
                ScrollView(.vertical, showsIndicators: false) {

                    ForEach(favoriteHobbies, id: \.id) { hobby in

                        Button(action: {

                            print(hobby)
                            self.isRecordHobbyView.toggle()
                        }) {

                            HStack {

                                Image(hobby.icon)
                                    .resizable()
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.primary.opacity(0.9))
                                Text(hobby.title)
                                    .foregroundColor(Color.primary.opacity(0.9))
                            }
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.9)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(20)
                            .sheet(isPresented: self.$isRecordHobbyView) {
                                RecordHobbyView(hobby: hobby)
                            }
                        }
                    }

                    HStack {

                        Button(action: {

                            self.isAddHobbyView.toggle()
                        }) {

                            Text("Add new one.")
                                .foregroundColor(Color.primary.opacity(0.9))
                                .padding()
                                .frame(width: UIScreen.main.bounds.width * 0.9)
                                .background(Color.orange.opacity(0.3))
                                .cornerRadius(20)
                        }
                    }
                    .sheet(isPresented: $isAddHobbyView) {
                        AddNewHobbyView() // desired full screen
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
                .padding()
            }
            .background(BlurView(style: .systemMaterial))
            .cornerRadius(15)
        }
    }
}
