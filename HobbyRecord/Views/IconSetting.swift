//
//  IconSetting.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/14.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct IconSetting: View {

    @Binding var icon: String
    var kind: [String]

    let column = GridItem(.adaptive(minimum: 30, maximum: 50))


    var body: some View {


        LazyVGrid(columns: Array(repeating: column, count: 6), spacing: 30) {

            ForEach(kind, id: \.self) { item in

                Button(action: { self.icon = item }) {

                    ZStack(alignment: .bottom) {

                        Image(item)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.pr(9))

                        if self.icon == item {

                            Rectangle()
                                .frame(width: 25, height: 2.0, alignment: .bottom)
                                .foregroundColor(Color.orange)
                        }
                    }
                }
            }
        }
        .padding(.top, 10)
    }
}

