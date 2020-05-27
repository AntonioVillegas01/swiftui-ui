//
//  UpdateStore.swift
//  SwiftUiApp
//
//  Created by Marco Antonio García Villegas on 23/05/20.
//  Copyright © 2020 Marco Antonio García Villegas. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
    @Published var updates: [Update] = updateDate
}
