//
//  Introduction_View.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 12/4/22.
//

import SwiftUI

struct Introduction_View: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text(NSLocalizedString("IntroductionView.title", comment: ""))
                .font(.title)
                .fontWeight(.bold)
                .padding()
            VStack(alignment: .leading) {
                HStack {
                    HStack(alignment: .center) {
                        Image(systemName: "text.below.photo")
                            .foregroundColor(Color(red: 136 / 255, green: 207 / 255, blue: 139 / 255))
                            .scaleEffect(2)
                            .padding()
                    }.frame(width: 70, height: 70, alignment: .center)
                    VStack(alignment: .leading) {
                        Text(NSLocalizedString("IntroductionView.firstItem.title", comment: ""))
                            .font(.callout)
                            .fontWeight(.bold)
                        Text(NSLocalizedString("IntroductionView.firstItem.subtitle", comment: ""))
                            .font(.body)
                            .foregroundColor(Color.gray)
                    }
                }.padding()
                HStack {
                    HStack (alignment: .center) {
                        Image(systemName: "aqi.medium")
                            .foregroundColor(Color.purple)
                            .scaleEffect(2)
                            .padding()
                    }.frame(width: 70, height: 70, alignment: .center)
                    VStack(alignment: .leading) {
                        Text(NSLocalizedString("IntroductionView.secondItem.title", comment: ""))
                            .font(.callout)
                            .fontWeight(.bold)
                        Text(NSLocalizedString("IntroductionView.secondItem.subtitle", comment: ""))
                            .font(.body)
                            .foregroundColor(Color.gray)
                    }
                }.padding()
                HStack {
                    HStack(alignment: .center) {
                        Image(systemName: "globe.asia.australia")
                            .foregroundColor(Color(red: 231 / 255, green: 69 / 255, blue: 53 / 255))
                            .scaleEffect(2.4)
                            .padding()
                    }.frame(width: 70, height: 70, alignment: .center)
                    VStack(alignment: .leading) {
                        Text(NSLocalizedString("IntroductionView.thirdItem.title", comment: ""))
                            .font(.callout)
                            .fontWeight(.bold)
                        Text(NSLocalizedString("IntroductionView.thirdItem.subtitle", comment: ""))
                            .font(.body)
                            .foregroundColor(Color.gray)
                    }
                }.padding()
            }
            RoundedRectangle(cornerRadius: 15)
                .frame(maxHeight: 50)
                .padding()
                .overlay(
                    Text(NSLocalizedString("IntroductionView.continueButton.title", comment: ""))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                )
                .foregroundColor(Color(red: 56 / 255, green: 119 / 255, blue: 237 / 255))
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
        }
    }
}

struct Introduction_View_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro Max", "iPhone 13 Pro"], id: \.self) { device in
            Introduction_View()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
