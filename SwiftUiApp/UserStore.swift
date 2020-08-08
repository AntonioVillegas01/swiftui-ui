//
//  UserStore.swift
//  SwiftUiApp
//
//  Created by Marco Antonio García Villegas on 31/05/20.
//  Copyright © 2020 Marco Antonio García Villegas. All rights reserved.
//

import SwiftUI
import Combine

class UserStore: ObservableObject {
    @Published var isLogged: Bool = UserDefaults.standard.bool(forKey: "isLogged"){
        didSet{
            UserDefaults.standard.set(self.isLogged, forKey: "isLogged")
        }
    }
    @Published var showLogin = false
}
