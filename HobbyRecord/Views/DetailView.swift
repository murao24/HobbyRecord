//
//  DetailView.swift
//  HobbyRecord
//
//  Created by 村尾慶伸 on 2020/09/04.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct DetailView: View {

    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var detailVM: DetailViewModel
    var clManager: CLManager
    var hobbyVM: HobbyViewModel

    init(clManager: CLManager, hobbyVM: HobbyViewModel) {
        self.clManager = clManager
        self.hobbyVM = hobbyVM
        self.detailVM = DetailViewModel(date: clManager.selectedDate, hobbyVM: hobbyVM)
    }

    var body: some View {

        VStack {

            Text(D.getTextFromDate(date: self.clManager.selectedDate))
                .font(.system(size: 30))
                .foregroundColor(Color.primary.opacity(0.9))
                .padding(.top, 10)

            ScrollView(.vertical, showsIndicators: false) {
                if self.detailVM.hobbies.count != 0 {
                    ForEach(self.detailVM.hobbies, id: \.self) { hobby in
                        HobbyCell(hobby: hobby)
                    }
                } else {
                    Text("No Event")
                }
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height - 150)
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(25)
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
                        .foregroundColor(Color.primary.opacity(0.9))
                } else {

                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.primary.opacity(0.9))
                }

                Text(hobby.title)
                    .font(.headline)
                    .foregroundColor(Color.primary.opacity(0.9))
            }
            .padding(.bottom, 10)

            ForEach(hobby.details, id: \.self) { detail in
                
                Text("・" + detail)
                    .font(.subheadline)
                    .foregroundColor(Color.primary.opacity(0.9))
            }
            Divider()
        }
        .padding(.horizontal)
    }

}

struct HobbyCell_Previews: PreviewProvider {
    static var previews: some View {
        HobbyCell(hobby: testDatas[0])
    }
}
