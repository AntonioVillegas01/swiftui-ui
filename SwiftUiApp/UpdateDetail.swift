//
//  UpdateDetail.swift
//  SwiftUiApp
//
//  Created by Marco Antonio García Villegas on 23/05/20.
//  Copyright © 2020 Marco Antonio García Villegas. All rights reserved.
//

import SwiftUI

struct UpdateDetail: View {
    var update: Update = updateDate[1]
    
    var body: some View {
        List {
            VStack {
                Image(update.image)
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                Text(update.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationBarTitle(update.title)
        }
    .listStyle(PlainListStyle())
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail()
    }
}
