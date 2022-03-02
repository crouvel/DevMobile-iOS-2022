//
//  SheetDetailView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct SheetDetailIncompleteView: View {
    var intent: SheetIntent
    @ObservedObject var viewModel: SheetCompleteViewModel
    @State var errorMessage: String = ""
    @State var showErrorMessage: Bool = false
    
    init(vm: SheetCompleteViewModel){
        self.intent = SheetIntent()
        self.viewModel = vm
        self.intent.addObserver(vm: self.viewModel)
    }
    
    var body: some View {
        NavigationView{
        VStack{
            VStack{
                Text("Cette fiche technique ne contient pas de progression, veuillez en ajouter une.")
                    .fontWeight(.bold)
                    .font(.system(size: 19))
                    .padding()
                Divider()
                NavigationLink(destination: CreateProgressionView(vm: self.viewModel)){
                    Text("- Ajouter une progression -")
                        .fontWeight(.bold)
                        .foregroundColor(.cyan)
                        .font(.system(size: 19))
                    EmptyView()
                }
                Text("Ou veuillez supprimer la fiche")
                    .fontWeight(.bold)
                    .italic()
                    .font(.system(size: 18))
                    .padding()
                Divider()
            }
        }.navigationViewStyle(StackNavigationViewStyle())
                
        .navigationBarHidden(true)
        
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
        .navigationTitle("\(viewModel.nomRecette)")
        .navigationBarBackButtonHidden(true)
        
    }
    
}

struct SheetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SheetDetailIncompleteView(vm: SheetCompleteViewModel(sheet:SheetComplete(nomRecette:"oui", idFiche: 555555, nomAuteur: "test", Nbre_couverts: 8, categorieRecette: "categorie", nomProgression: "")))
    }
}
