//
//  DataStore.swift
//  SwiftUiApp
//
//  Created by Marco Antonio García Villegas on 26/05/20.
//  Copyright © 2020 Marco Antonio García Villegas. All rights reserved.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        getPost()
    }
    
    
    func getPost(){
        Api().getPost { (posts) in
            self.posts = posts
        }
        
    }
    
}
