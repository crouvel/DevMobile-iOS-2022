//
//  MercurialView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 14/02/2022.
//

import SwiftUI

struct MercurialView: View {
    var body: some View {
        NavigationView{
            Text("Ici, vous pouvez créer, consulter ainsi que modifier vos ingrédients.")
                .navigationTitle("Mercurial")
        }
    }
}

struct MercurialView_Previews: PreviewProvider {
    static var previews: some View {
        MercurialView()
    }
}
