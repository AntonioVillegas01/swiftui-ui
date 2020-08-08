//
//  LoadingView.swift
//  SwiftUiApp
//
//  Created by Marco Antonio García Villegas on 31/05/20.
//  Copyright © 2020 Marco Antonio García Villegas. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            LottieView(filename: "loading").frame(width: 200, height: 200)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
