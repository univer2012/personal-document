//
//  ContentView.swift
//  OfficialTutorial2
//
//  Created by Mac on 2019/12/9.
//  Copyright © 2019 Mac. All rights reserved.
//

import SwiftUI
/*
下面的布局来自文章：[【译】WWDC2019之SwiftUI--SwiftUI基础教程](https://juejin.im/post/5cf5f4596fb9a07ede0b2fa1#heading-34)
*/
struct ContentView: View {
    var body: some View {
        VStack {
            MapView()
                .frame(height: 300)
            
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                
                Text("Turtle Rock")
                    .font(.title)
                
                HStack(alignment: .top) {
                    Text("Joshua Tree National Park")
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Text("California")
                        .font(.subheadline)
                }
            }
            .padding()
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
