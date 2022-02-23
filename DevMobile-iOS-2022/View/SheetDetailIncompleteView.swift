//
//  SheetDetailView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct SheetDetailIncompleteView: View {
    var intent: SheetIntent
    @ObservedObject var viewModel: SheetIncompleteViewModel
    @State var errorMessage: String = ""
    @State var showErrorMessage: Bool = false
    
    init(vm: SheetIncompleteViewModel){
        self.intent = SheetIntent()
        self.viewModel = vm
        self.intent.addObserver(vm: self.viewModel)
    }

    var body: some View {
        VStack{
            HStack{
                Text("Intitulé")
                    .fontWeight(.bold)
                Text("\(viewModel.nomRecette)")
                    .frame(maxHeight: .infinity)
            }.fixedSize(horizontal: false, vertical: true)
            
            VStack{
                Text("Cette fiche technique ne contient pas de progression, veuillez en ajouter une")
                    .fontWeight(.bold)
                    .padding()
                Text("Ou veuillez supprimer la fiche")
                    .fontWeight(.bold)
            }
        }
        .navigationTitle("\(viewModel.nomRecette)")
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
    }}

struct SheetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SheetDetailIncompleteView(vm: SheetIncompleteViewModel(sheet:SheetIncomplete(nomRecette:"oui", idFiche: 555555, nomAuteur: "test", Nbre_couverts: 8, categorieRecette: "categorie")))
    }
}
