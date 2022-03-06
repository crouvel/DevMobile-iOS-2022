//
//  SheetDetailView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

//MARK: vue detail fiche incomplète
struct SheetDetailIncompleteView: View {
    var intent: SheetIntent
    @ObservedObject var viewModel: SheetCompleteViewModel
    @State var errorMessage: String = ""
    @State var showErrorMessage: Bool = false
    
    init(vm: SheetCompleteViewModel){
        self.intent = SheetIntent()
        self.viewModel = vm
    }
    
    private var deletionSheetState : DeleteSheetIntentState {
        return self.viewModel.deletionState
    }
    
    var body: some View {
        NavigationView{
            VStack{
                switch deletionSheetState {
                case .ready:
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
                        Button(action: {
                            SheetDAO.deleteSheet(idFiche: self.viewModel.sheet.idFiche, vm: self.viewModel)
                            //self.viewModel.creationStateIngredientList = .ready
                            /*ProgressionDAO.addProgressionSheet(nomProgression: referenceProgression, nomRecette: self.viewModel.nomRecette)*/
                        }){
                            Text("Supprimer la fiche")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .frame(alignment: .center)
                        }
                    }
                case .deleting(let string):
                    Text("Suppression de la fiche")
                        .foregroundColor(.black)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(2)
                case .deleted:
                    Text("La fiche technique a bien été supprimée !")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .italic()
                        .padding()
                    Divider()
                    Text("Vous pouvez désormais retourner à la liste principale des fiches complètes.")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .italic()
                        .padding()
                case .deletingError(let string):
                    Text("Erreur à la suppression de la fiche, veuillez réessayer ulérieurement")
                        .fontWeight(.bold)
                        .italic()
                    Divider()
                    Button(action: {
                        SheetCompleteIntent(vm: self.viewModel).deleted()
                    }){
                        Text("Ok")
                            .fontWeight(.bold)
                            .frame(alignment: .center)
                    }
                }
            }.navigationViewStyle(StackNavigationViewStyle())
            
                .navigationBarHidden(true)
            
                /*.onChange(of: viewModel.error){ error in
                    switch error {
                    case .NONE:
                        return
                        case .ARTISTNAME(let reason):
                         self.errorMessage = reason
                         self.showErrorMessage = true
                         case .TRACKNAME(let reason):
                         self.errorMessage = reason
                         self.showErrorMessage = true
                         case .COLLECTIONNAME(let reason):
                         self.errorMessage = reason
                         self.showErrorMessage = true
                    }
                }.alert("\(errorMessage)", isPresented: $showErrorMessage){
                    Button("Ok", role: .cancel){
                        showErrorMessage = false
                    }
                }*/
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
