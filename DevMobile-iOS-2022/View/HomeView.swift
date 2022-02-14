//
//  HomeView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 14/02/2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            Text("Home")
                .navigationTitle("Bienvenue !")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
