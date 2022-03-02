//
//  AddIngredientStepView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 01/03/2022.
//

import SwiftUI

struct FinishSheetCreationView: View {
    //var nomProgression: String
    @ObservedObject var viewModel: SheetCompleteViewModel
    init(/*nomProgression: String,*/ viewModel: SheetCompleteViewModel){
        //self.nomProgression = nomProgression
        self.viewModel = viewModel
    }
    var body: some View {
        NavigationView{
            VStack{
            Text("La fiche technique \(viewModel.nomRecette) a bien été complétée !")
                .fontWeight(.bold)
                .foregroundColor(.green)
                .italic()
                .padding()
            Divider()
                NavigationLink(destination: HomeView()){
                    Text("Retour à l'accueil")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    EmptyView()
                }.padding()
                
            }.navigationTitle("Fiche complétée")
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct FinishSheetCreationView_Previews: PreviewProvider {
    static var previews: some View {
        FinishSheetCreationView(/*nomProgression: "ok",*/ viewModel: SheetCompleteViewModel(sheet:SheetComplete(nomRecette:"oui", idFiche: 555555, nomAuteur: "test", Nbre_couverts: 8, categorieRecette: "categorie", nomProgression: "")))
    }
}
