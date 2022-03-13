//
//  Welcome_View.swift
//  NASAinYourHand
//
//  Created by Javier Carrillo Gallego on 12/3/22.
//

import SwiftUI

struct Welcome_View: View {
    
    @State private var showText1: Bool = false
    @State private var showText2: Bool = false
    @State private var showText3: Bool = false
    @State private var allTextShowed: Bool = false
    @State private var animationFinished: Bool = false
    
    var body: some View {
        if animationFinished {
            TabsView()
        } else {
            ZStack{
                Image("apod", bundle: .main)
                    .resizable()
                    .scaleEffect(x: 1, y: 1, anchor: .center)
                    .ignoresSafeArea(.all)
                VisualEffectView(effect: UIBlurEffect(style: .dark))
                    .ignoresSafeArea(.all)
                VStack(alignment: .leading) {
                    if showText1 == true {
                        Text("Welcome to your favourite space browser app")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 4.0)))
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    }
                    if showText2 == true {
                        Text("now you can daily enjoy an astronomy picture")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.trailing)
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 4.0)))
                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                    }
                    if showText3 == true {
                        Text("and get to know the most hazardous asteroids.")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 4.0)))
                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                    }
                }
            }
            .onAppear {
                showText1 = true
            }
            .onTapGesture {
                if !allTextShowed {
                    withAnimation(.easeInOut(duration: 1)) {
                        if !showText1 {
                            showText1 = true
                        } else if showText1 && !showText2 {
                            showText2 = true
                        } else if showText1 && showText2 && !showText3 {
                            showText3 = true
                        } else if showText1 && showText2 && showText3 {
                            allTextShowed = true
                        }
                    }
                }
                if allTextShowed {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        animationFinished = true
                    }
                }
            }
        }
    }
}

struct Welcome_View_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 8", "iPhone 13 Pro Max", "iPhone 13 mini"], id:\.self) { device in
            Welcome_View()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
