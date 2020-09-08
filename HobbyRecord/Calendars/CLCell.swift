//
//  CLCell.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/03.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct CLCell: View {

    var clDate: CLDate
    var color: Color

    var body: some View {
        VStack {
            Text(clDate.getText())
                .foregroundColor(color)
                .font(.system(size: 18))
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            if self.clDate.hobbyies.count != 0 {
                HStack {
                    ForEach(self.clDate.hobbyies, id: \.self) { hobby in
                        VStack {
                            if hobby.icon != "" {
                                Image(hobby.icon)
                                    .renderingMode(.template)
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(Color.primary.opacity(0.8))
                            } else {
                                Image(systemName: "questionmark.circle")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(Color.primary.opacity(0.9))
                            }
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(.top, 5)
    }
}
