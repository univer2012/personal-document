//
//  SH3QiRootView.swift
//  SwiftUIDemo191203
//
//  Created by Mac on 2019/12/5.
//  Copyright © 2019 Mac. All rights reserved.
//
/*
 
 本demo来自：[用SwiftUI给视图添加动画](https://juejin.im/post/5dd66d8bf265da47ba2aa9f5)
 */
import SwiftUI
import UIKit

extension AnyTransition {
    static var moveAndFade: AnyTransition {
        AnyTransition.move(edge: .trailing)
    }
    
    static var moveAndFadeLeading: AnyTransition {
        AnyTransition.move(edge: .leading)
    }
    
    static var moveAndFadeUp: AnyTransition {
        AnyTransition.move(edge: .top)
    }
    
    static var moveAndFadeBottom: AnyTransition {
        AnyTransition.move(edge: .bottom)
    }
}


struct SH3QiRootView: View {
    
    @State private var changeAnimation = false
    private var offsetX1: CGFloat = 0.0
    private var offsetY1: CGFloat = 0.0
    private var offsetX2: CGFloat = 20.0
    private var offsetY2: CGFloat = 20.0
    
    private var cornerR1: CGFloat = 0.0
    private var cornerR2: CGFloat = 50.0
    
    private var foreColor1 = Color.blue
    private var foreColor2 = Color.white
    
    private var backColor1 = Color.gray
    private var backColor2 = Color.black
    
    @State private var showDetail = false
    @State private var showDetail2 = false
    @State private var showDetail3 = false
    @State private var showDetail4 = false
    @State private var showDetail5 = false
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        self.changeAnimation.toggle()
                    }
                }) {
                    Text("位置")
                        .offset(x: changeAnimation ? offsetX2 : offsetX1, y: changeAnimation ? offsetY2 : offsetY1)
                        .frame(width: 100.0, height: 100.0, alignment: .center)
                        .foregroundColor(changeAnimation ? foreColor2 : foreColor1)
                        .background(changeAnimation ? backColor2 : backColor1)
                        .opacity(changeAnimation ? 0.5 : 1.0)
                        .cornerRadius(changeAnimation ? cornerR2 : cornerR1)
                        .padding()
                        .rotationEffect(.degrees(changeAnimation ? 90 : 0))
                        .animation(.easeInOut(duration: 2.0))
                }
                
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        self.showDetail.toggle()
                    }
                }) {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .opacity(showDetail ? 0.5 : 1.0)
                        .scaleEffect(showDetail3 ? 1.5 : 1.0)
                        .padding()
                }
                
            }
            
            HStack {
                //easeInOut
                Button(action: {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        self.showDetail.toggle()
                    }
                }) {
                    Text("trailing")
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .scaleEffect(showDetail ? 1.5 : 1.0)
                        .padding()
                        .animation(.easeInOut(duration: 2.0))
                    
                }
                
                //spring
                Button(action: {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        self.showDetail2.toggle()
                    }
                }) {
                    Text("leading")
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail2 ? 90 : 0))
                        .scaleEffect(showDetail2 ? 1.5 : 1.0)
                        .padding()
                        .animation(.spring())
                    
                }
                
                
                //animation nil
                Button(action: {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        self.showDetail3.toggle()
                    }
                }) {
                    Text("top")
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail3 ? 90 : 0))
                        .scaleEffect(showDetail3 ? 1.5 : 1.0)
                        .padding()
                        .animation(.spring())
                    
                }
                
                //
                Button(action: {
                    withAnimation(.easeInOut(duration: 2.0)) {
                        self.showDetail4.toggle()
                    }
                }) {
                    Text("bottom")
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail4 ? 90 : 0))
                        .scaleEffect(showDetail3 ? 1.5 : 1.0)
                        .padding()
                        .animation(.spring())
                    
                }
            } //HStack
            
            
            if showDetail {
                SH2ContentView()
                    .transition(.moveAndFade)
            }
            
            if showDetail2 {
                SH2ContentView()
                    .transition(.moveAndFadeLeading)
            }
            
            if showDetail3 {
                SH2ContentView()
                    .transition(.moveAndFadeUp)
            }
            
            if showDetail4 {
                SH2ContentView()
                    .transition(.moveAndFadeBottom)
            }
            
            if showDetail5 {
                SH3Badge()
            }
            
        }
    }
}

struct SH3QiRootView_Previews: PreviewProvider {
    static var previews: some View {
        SH3QiRootView()
    }
}
