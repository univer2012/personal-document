//
//  SH2ListRow.swift
//  SwiftUIDemo191203
//
//  Created by Mac on 2019/12/5.
//  Copyright © 2019 Mac. All rights reserved.
//

import SwiftUI

struct SH2ListRow: View {
    var symbol: String
    var body: some View {
        NavigationLink(destination: SH2ListDetail(symbol: symbol)) {
            HStack {
                //图片
                Image(systemName: symbol)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Colors.randomElement())
                //分割
                Divider()
                Spacer()
                //文字
                Text(symbol)
                Spacer()
            }
        }
    }
}

struct SH2ListRow_Previews: PreviewProvider {
    static var previews: some View {
        SH2ListRow(symbol: "chevron.up")
    }
}
