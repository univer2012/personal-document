//
//  SH2ListDetail.swift
//  SwiftUIDemo191203
//
//  Created by Mac on 2019/12/5.
//  Copyright © 2019 Mac. All rights reserved.
//

import SwiftUI

struct SH2ListDetail: View {
    var symbol: String
    
    var body: some View {
        VStack {
            
            Text("Image:").font(.headline)
            
            Spacer()
            
            Image(systemName: symbol)
                .foregroundColor(Colors.randomElement())
                .imageScale(.large)
                .scaleEffect(3)
                .padding(.bottom, 100)
            
            Divider()
            
            Text("Image Name:").font(.headline)
            Spacer()
            Text(symbol)
                .font(.largeTitle)
            Spacer()
        }
        .navigationBarTitle(symbol)
    }
}

struct SH2ListDetail_Previews: PreviewProvider {
    static var previews: some View {
        SH2ListDetail(symbol: "chevron.up")
    }
}
