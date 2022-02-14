//
//  SheetView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 14/02/2022.
//

import SwiftUI

struct SheetView: View {
    var body: some View {
        NavigationView{
            Text("Ici, vous pouvez consulter ...")
                .navigationTitle("Fiches Techniques")
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
