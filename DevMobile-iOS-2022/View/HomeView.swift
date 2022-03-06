//
//  HomeView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 14/02/2022.
//

import SwiftUI

//MARK: VUE ACCUEIL
struct HomeView: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Ici, vous pouvez gérer vos fiches techniques, gérer un mercurial, et consulter les ingrédients allergènes.")
                    .fontWeight(.semibold)
                    .padding()
                Divider()
                Image("cooking")
                    .resizable()
                    .scaledToFit()
            }
            .navigationTitle("Bienvenue ! 🧑‍🍳")
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

