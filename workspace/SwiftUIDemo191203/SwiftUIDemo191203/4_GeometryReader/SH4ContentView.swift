//
//  SH4ContentView.swift
//  SwiftUIDemo191203
//
//  Created by Mac on 2019/12/5.
//  Copyright © 2019 Mac. All rights reserved.
//

import SwiftUI

struct SH4ContentView: View {
    var body: some View {
//        VStack {
//            Text("Hello There!")
//            MyRectangle()
//        }
//        .frame(width: 150, height: 100)
//        .border(Color.black)
        
        HStack {
            Text("SwiftUI")
                .foregroundColor(.black).font(.title).padding(15)
                .background(RoundedCorners(color: .green, tr: 30, bl: 30))
                .opacity(0.5)

            Text("Lab")
            .foregroundColor(.black).font(.title).padding(15)
            .background(RoundedCorners(color: .blue, tl: 30, br: 30))
            .opacity(0.5)
        }
        .padding(20).border(Color.gray).shadow(radius: 3)
        
    }
}


struct RoundedCorners: View {
    var color: Color = .black
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height
                
                // We make sure the redius does not exceed the bounds dimensions
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                }
                .fill(self.color)
        }
    }
}



struct MyRectangle: View {
    var body : some View {
        GeometryReader { grometry in
            Rectangle()
                .path(in: CGRect(x: grometry.size.width + 5, y: 0, width: grometry.size.width / 2.0, height: grometry.size.height / 2.0))
                .fill(Color.blue)
        }
    }
}

struct SH4ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //横屏的方法，解决方案来自：
        //https://stackoverflow.com/questions/56625931/how-can-i-preview-a-device-in-landscape-mode-in-swiftui
        SH4ContentView()
            .previewLayout(.fixed(width: 568, height: 320))//iPhone SE landscape
    }
}
