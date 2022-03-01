//
//  trackView.swift
//  Test_Cours_listUI
//
//  Created by m1 on 08/02/2022.
//

import SwiftUI

struct IngredientView: View {
    var intent: IngredientIntent
    @ObservedObject var viewModel: IngredientViewModel
    @State var errorMessage: String = ""
    @State var showErrorMessage: Bool = false
    
    init(vm: IngredientViewModel){
        self.intent = IngredientIntent()
        self.viewModel = vm
        self.intent.addObserver(vm: self.viewModel)
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("Nom de l'ingrédient : \(viewModel.libelle)")
                    .padding()
                    .frame(maxHeight: .infinity)
                /*TextField("", text: $viewModel.trackName)
                 .padding()
                 .frame(maxHeight: .infinity)*/
                
            }.fixedSize(horizontal: false, vertical: true)
            HStack{
                Text("Nom de l'auteur :")
                    .padding()
                    .frame(maxHeight: .infinity)
                /*TextField("", text: $viewModel.artistName)
                 .padding()
                 .frame(maxHeight: .infinity)
                 .onSubmit {
                 intent.intentToChange(artistName: viewModel.artistName)
                 }*/
            }.fixedSize(horizontal: false, vertical: true)
            
            HStack{
                Text("Nom de l'album :")
                    .padding()
                    .frame(maxHeight: .infinity)
                /*TextField("", text: $viewModel.collectionName)
                 .padding()
                 .frame(maxHeight: .infinity)*/
                
            }.fixedSize(horizontal: false, vertical: true)
        }
        .navigationTitle("\(viewModel.libelle)")
        .onChange(of: viewModel.error){ error in
            switch error {
            case .NONE:
                return
                /*case .ARTISTNAME(let reason):
                 self.errorMessage = reason
                 self.showErrorMessage = true
                 case .TRACKNAME(let reason):
                 self.errorMessage = reason
                 self.showErrorMessage = true
                 case .COLLECTIONNAME(let reason):
                 self.errorMessage = reason
                 self.showErrorMessage = true*/
            }
        }.alert("\(errorMessage)", isPresented: $showErrorMessage){
            Button("Ok", role: .cancel){
                showErrorMessage = false
            }
        }
    }
}

struct trackView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView(vm: IngredientViewModel(ingredient:Ingredient(libelle: "oui", idIngredient: 8888888, nomCategorie: "test")))
    }
}
