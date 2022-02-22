//
//  ContentView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 14/02/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView{
           HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Accueil")
                }
            SheetView(viewModel: SheetListViewModel())
                .tabItem{
                    Image(systemName: "folder")
                    Text("Fiches Techniques")
                }
            MercurialView(viewModel: IngredientListViewModel())
                .tabItem{
                    Image(systemName: "leaf.fill")
                    Text("Mercurial")
                }
            Text("Allergènes")
                .tabItem{
                    Image(systemName: "allergens")
                    Text("Allergènes")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
