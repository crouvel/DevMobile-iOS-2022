//
//  AddIngredientStepView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 01/03/2022.
//

import SwiftUI

//MARK: vue fin compléter fiche vide
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
                    Text("Rafraichissez la liste des fiches complètes et vous pouvez désormais la consulter.")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
            }
                //.navigationBarHidden(true)
        }.navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct FinishSheetCreationView_Previews: PreviewProvider {
    static var previews: some View {
        FinishSheetCreationView(/*nomProgression: "ok",*/ viewModel: SheetCompleteViewModel(sheet:SheetComplete(nomRecette:"oui", idFiche: 555555, nomAuteur: "test", Nbre_couverts: 8, categorieRecette: "categorie", nomProgression: "")))
    }
}
