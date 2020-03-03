//
//  UserData.swift
//  OfficialTutorial4
//
//  Created by Mac on 2019/12/9.
//  Copyright © 2019 Mac. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    let didChange = PassthroughSubject<UserData, Never>()
    
    var showFavoritesOnly = false {
        didSet {
            didChange.send(self)
        }
    }
    var landmarks = landmarkData {
        didSet {
            didChange.send(self)
        }
    }
}
