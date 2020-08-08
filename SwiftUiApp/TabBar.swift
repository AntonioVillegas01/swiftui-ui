//
//  TabBar.swift
//  SwiftUiApp
//
//  Created by Marco Antonio García Villegas on 23/05/20.
//  Copyright © 2020 Marco Antonio García Villegas. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home().tabItem{
                Image(systemName: "play.circle.fill")
                    .padding()
                Text("Home")
            }
            CourseList().tabItem{
                Image(systemName: "rectangle.stack.fill")
                Text("Cursos")
            }
            Buttons().tabItem{
                Image(systemName: "livephoto")
                Text("Botones")
            }
            
        }
      //  .edgesIgnoringSafeArea(.top)
        
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabBar().previewDevice("iPhone 11 Pro Max")
            .environmentObject(UserStore())
        }
    }
}
